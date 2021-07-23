\connect forum_example;

insert into public.user 
    (username) 
values
    ('Michael'),
    ('Anna Marie'),
    ('Chai');

insert into public.post 
    (title, body, author_id) 
values
    ('First post example', 'Lorem ipsum dolor sit amet', 1),
    ('Second post example', 'Consectetur adipiscing elit', 2),
    ('Third post example', 'Aenean blandit felis sodales', 3);