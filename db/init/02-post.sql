\connect forum_example;

/* Tables & Types */

create type app_public.post_topic as enum (
    'discussion',
    'inspiration',
    'help',
    'showcase'
);

create table app_public.post (
    id serial primary key,
    author_id integer not null references app_public.person(id),
    headline text not null check (char_length(headline) < 200),
    body text,
    topic app_public.post_topic,
    created_at timestamp default now(),
    updated_at timestamp default now()
);


comment on table app_public.post is 'A forum post written by a user.';
comment on column app_public.post.id is 'The primary key for the post.';
comment on column app_public.post.headline is 'The title written by the user.';
comment on column app_public.post.author_id is 'The id of the author user.';
comment on column app_public.post.topic is 'The topic this has been posted in.';
comment on column app_public.post.body is 'The main body text of our post.';
comment on column app_public.post.created_at is 'The time this post was created.';
comment on column app_public.post.updated_at is 'The time this post was updated.';

/* Functions */

create function app_public.post_summary(
        post app_public.post,
        length int default 50,
        omission text default '...'
    ) 
returns text as $$
    select case
        when post.body is null then null
        else substr(post.body, 0, length) || omission
    end
$$ language sql stable;

comment on function app_public.post_summary(forum_example.post, int, text) is 'A truncated version of the body for summaries.';

create function app_public.person_latest_post(person app_public.person)
returns app_public.post as $$
    select post.* 
    from app_public.post as post
    where post.author_id = person.id
    order by created_at desc
    limit 1
$$ language sql stable;

comment on function app_public.person_latest_post(app_public.person) is 'Get’s the latest post written by the person.';

create function app_public.search_posts(search text)
returns setof app_public.post as $$
    select post.*
    from app_public.post as post
    where position(search in post.headline) > 0
    or position(search in post.body) > 0
$$ language sql stable;


comment on function app_public.search_posts(text) is 'Returns posts containing a given search term.';
