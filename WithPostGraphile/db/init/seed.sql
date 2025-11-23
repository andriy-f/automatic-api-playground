
INSERT INTO kcm.user (first_name, last_name) VALUES
    ('John', 'Smith');

INSERT INTO kcm.user (first_name, last_name) VALUES
    ('Jane', 'Smith');

-- Generate contact data
INSERT INTO kcm.contact (first_name, last_name, email, phone, userId, about) VALUES
    ('Jake', 'Doe', 'john.doe@example.com', '123-456-7890', (select id from kcm.user where first_name = 'John' and last_name = 'Smith'), 'Friend from work');

INSERT INTO kcm.contact (first_name, last_name, email, phone, userId, about) VALUES
    ('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', (select id from kcm.user where first_name = 'John' and last_name = 'Smith'), 'Colleague at office');