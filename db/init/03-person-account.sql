\connect forum_example;

create table app_private.person_account (
    person_id integer primary key references app_public.person(id) on delete cascade,
    email text not null unique check (email ~* '^.+@.+\..+$'),
    password_hash text not null
);


comment on table app_private.person_account is 'Private information about a person’s account.';
comment on column app_private.person_account.person_id is 'The id of the person associated with this account.';
comment on column app_private.person_account.email is 'The email address of the person.';
comment on column app_private.person_account.password_hash is 'An opaque hash of the person’s password.';

create extension if not exists "pgcrypto"; -- comes with postgres 

create function app_public.register_person(
    first_name text,
    last_name text,
    email text,
    password text
)
returns app_public.person as $$
    declare person app_public.person;
    begin
        insert into app_public.person 
            (first_name, last_name)
        values
            (first_name, last_name)
        returning * into person;

        insert into app_private.person_account
            (person_id, email, password_hash)
        values
            (person.id, email, crypt(password, gen_salt('bf')));
        
        return person;
    end;
$$ language plpgsql strict security definer;

-- strict: won't call function with null inputs
-- security definer: executed with privileges of user who created it

comment on function app_public.register_person(text, text, text, text) is 'Registers a single user and creates an account in our forum.';


