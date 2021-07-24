\connect forum_example;

create table app_public.person (
    id serial primary key,
    first_name text not null check (char_length(first_name) < 80),
    last_name text check (char_length(first_name) < 80),
    about text,
    created_date timestamp default current_timestamp
);

comment on table forum_example.person is 'A user of the forum.';
comment on column forum_example.person.id is 'The primary unique identifier for the person.';
comment on column forum_example.person.first_name is 'The person’s first name.';
comment on column forum_example.person.last_name is 'The person’s last name.';
comment on column forum_example.person.about is 'A short description about the user, written by the user.';
comment on column forum_example.person.created_at is 'The time this person was created.';
