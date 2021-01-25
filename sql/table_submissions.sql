create table submissions
(
    unique_id                   text primary key,
    allow_live_comments         boolean,
    archived                    boolean,
    author                      text,
    author_flair_type           text,
    author_fullname             text,
    author_patreon_flair        boolean,
    author_premium              boolean,
    can_gild                    boolean,
    can_mod_post                boolean,
    clicked                     boolean,
    comment_limit               double precision,
    comment_sort                text,
    contest_mode                boolean,
    created                     double precision,
    downs                       double precision,
    edited                      boolean,
    fullname                    text,
    gilded                      double precision,
    hidden                      boolean,
    hide_score                  boolean,
    id                          text,
    is_crosspostable            boolean,
    is_meta                     boolean,
    is_original_content         boolean,
    is_reddit_media_domain      boolean,
    is_robot_indexable          boolean,
    is_self                     boolean,
    is_video                    boolean,
    locked                      boolean,
    media_only                  boolean,
    name                        text,
    no_follow                   boolean,
    num_comments                double precision,
    num_crossposts              double precision,
    over_18                     boolean,
    parent_whitelist_status     text,
    permalink                   text,
    pinned                      boolean,
    pwls                        double precision,
    quarantine                  boolean,
    saved                       boolean,
    score                       double precision,
    selftext                    text,
    send_replies                boolean,
    shortlink                   text,
    spoiler                     boolean,
    stickied                    boolean,
    "STR_FIELD"                 text,
    subreddit                   text,
    subreddit_id                text,
    subreddit_name_prefixed     text,
    subreddit_subscribers       double precision,
    subreddit_type              text,
    thumbnail                   text,
    title                       text,
    total_awards_received       double precision,
    ups                         double precision,
    upvote_ratio                double precision,
    url                         text,
    visited                     boolean,
    whitelist_status            text,
    wls                         double precision
);

alter table submissions
    owner to unicorn_user;
