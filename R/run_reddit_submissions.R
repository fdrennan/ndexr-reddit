# run_reddit_submissions
#' @export run_reddit_submissions
run_reddit_submissions <- function( subreddit = 'all', 
                                    limit = 100, 
                                    sleep = 1) {
  con <- connection_postgres()
  on.exit({dbDisconnect(con)})
  reddit_con <- connection_reddit()
  # debug(reddit_crawl_submissions)
  
  # browser()
  
  submissions_list <- iterate(reddit_con$subreddit(subreddit)$new(limit = limit))
  
  map(submissions_list, names)
  
  types_to_keep <- c("character", "logical", "integer")
  
  data <- 
    map(
      names(submissions_list[[1]]),
      function(index_name) {
        map_dfr(
          submissions_list,
          function(single_submission) {
            response <- tryCatch(expr = {
              submission_data <- single_submission[[index_name]]
              if (inherits(submission_data, types_to_keep)) {
                tibble(
                  id = glue("{single_submission$created_utc}-{single_submission$id}"),
                  column_name = index_name,
                  value = single_submission[[index_name]]
                )
              }
            }, error = function(err) {
              NULL
            })
            response
          }
        )
      }
    )
  
  data <- discard(data, ~ nrow(..1) == 0)
  
  
  data <- map(
    types_to_keep,
    function(type_name) {
      type_data <- keep(
        data,
        ~ map_chr(..1, typeof)[[3]] == type_name
      )
    }
  )
  
  data <- map(data, bind_rows)
  
  names(data) <- paste0("submission_", types_to_keep)
  
  iwalk(
    data, 
    function(data_to_append, table_name) {
      message(glue("Inserting {table_name}"))
      if (!dbExistsTable(conn = con, name = table_name)) {
        dbCreateTable(conn = con, name = table_name, fields = data_to_append)
      }
      dbAppendTable(conn = con, name = table_name, value = data_to_append)
    }
  )
  
  data
  # reddit_response <- reddit_crawl_submissions(reddit_con, subreddit = subreddit, limit = limit)
  # reddit_data <- clean_reddit_data(reddit_response)
  # 
  # # dbRemoveTable(conn = con, name = "submissions")

  # 
  # dbxUpsert(con, "submissions", reddit_data, where_cols=c("unique_id"))
  # print(reddit_data)
  # message(glue("Sleeping for {sleep} seconds"))
  # Sys.sleep(sleep)
}

run_reddit_submissions(limit = 10, sleep = 5)