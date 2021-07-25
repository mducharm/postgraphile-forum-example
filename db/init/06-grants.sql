\connect forum_example;

-- grant usage: allows the roles to know the schema exists
grant usage on schema app_public to forum_anon, forum_person;

grant select on table app_public.person to forum_anon, forum_person;
grant update, delete on table app_public.person to forum_person;

grant select on table app_public.post to forum_anon, forum_person;
grant insert, update, delete on table app_public.post to forum_person;
grant usage on sequence app_public.post_id_seq to forum_person;

grant execute on function app_public.person_full_name(app_public.person) to forum_anon, forum_person;
grant execute on function app_public.post_summary(app_public.post, integer, text) to forum_anon, forum_person;
grant execute on function app_public.person_latest_post(app_public.person) to forum_anon, forum_person;
grant execute on function app_public.search_posts(text) to forum_anon, forum_person;
grant execute on function app_public.authenticate(text, text) to forum_anon, forum_person;
grant execute on function app_public.current_person() to forum_anon, forum_person;

grant execute on function app_public.register_person(text, text, text, text) to forum_anon;
