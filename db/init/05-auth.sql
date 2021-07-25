\connect forum_example;

create type app_public.jwt_token as (
    role text,
    person_id integer,
    exp bigint
);

/* Functions */

create function app_public.authenticate(
    email text,
    password text
)
returns app_public.jwt_token as $$
    declare account app_private.person_account;
    begin 
        select a.* into account
        from app_private.person_account as a
        where a.email = $1;

        if account.password_hash = crypt(password, account.password_hash)
        then
            return ('forum_person', account.person_id, extract(epoch from (now() + interval '2 days')))::app_public.jwt_token;
        else
            return null;
        end if;
    end;
$$ language plpgsql strict security definer;

comment on function app_public.authenticate(text, text) is 'Creates a JWT token that will securely identify a person and give them certain permissions. This token expires in 2 days.';