# packages <- c(
#   'purrr', 'dplyr', 'reticulate', 'stringr',
#   'lubridate', 'usethis', 'roxygen2', 'devtools'
# )
#
# walk(packages, install.packages)
# walk(packages, usethis::use_package)

library(ndexr)

for (i in 1:10000) {
  message(i)
  tryCatch(run_reddit_submissions(limit = 10, sleep = 5), 
           error = function(err) {
             message(err)
           })
}