\connect forum_example;

/* Schemas */
create schema app_public;
create schema app_private;

/* Functions */

create function app_private.set_updated_at()
returns trigger as $$
    begin 
        new.updated_at := current_timestamp;
        return new;
    end;
$$ language plpgsql;