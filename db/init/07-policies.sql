\connect forum_example;

/* 
Row Level Security (RLS) allows us to specify access to data on a row level instead of a table level.
*/
alter table app_public.person enable row level security;
alter table app_public.post enable row level security;

create policy select_person on app_public.person for select
    using (true);

create policy select_post on app_public.post for select
    using (true);

create policy update_person on app_public.person for update to forum_person
    using (id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);

create policy delete_person on app_public.person for delete to forum_person
    using (id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);

create policy insert_post on app_public.post for insert to forum_person
    with check(author_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);

create policy update_post on app_public.post for update to forum_person
    using (author_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);

create policy delete_post on app_public.post for delete to forum_person
    using (author_id = nullif(current_setting('jwt.claims.person_id', true), '')::integer);


