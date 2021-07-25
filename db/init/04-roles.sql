\connect forum_example;

create role forum_postgraphile login password 'change_this';

create role forum_anon;
grant forum_anon to forum_postgraphile;

create role forum_person;
grant forum_person to forum_postgraphile;
