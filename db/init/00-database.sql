\connect forum_example;

create table public.user (
    id serial primary key,
    username text,
    created_date timestamp default current_timestamp
);

comment on table public.user is 'forum users.'

create table public.post (
    id serial primary key,
    title text, 
    body text,
    created_date timestamp default current_timestamp
    author_id integer not null references public.user(id)
);

comment on table public.post is 'forum posts.'