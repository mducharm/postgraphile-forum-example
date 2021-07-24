\connect forum_example;

/* Tables & Types */

create table app_public.person (
    id serial primary key,
    first_name text not null check (char_length(first_name) < 80),
    last_name text check (char_length(first_name) < 80),
    about text,
    created_at timestamp default current_timestamp,
    updated_at timestamp default now() -- same as current_timestamp
);

comment on table app_public.person is 'A user of the forum.';
comment on column app_public.person.id is 'The primary unique identifier for the person.';
comment on column app_public.person.first_name is 'The person’s first name.';
comment on column app_public.person.last_name is 'The person’s last name.';
comment on column app_public.person.about is 'A short description about the user, written by the user.';
comment on column app_public.person.created_at is 'The time this person was created.';
comment on column app_public.person.updated_at is 'The time this person was updated.';

/* Functions */

create function app_public.person_full_name(person app_public.person)
returns text as $$
    select person.first_name || ' ' || person.last_name
$$ language sql stable;

-- note: stable keyword signifies that this function does not mutate the database.

comment on function app_public.person_full_name(app_public.person) is 'A person’s full name which is a concatenation of their first and last name.';

/* Triggers */

