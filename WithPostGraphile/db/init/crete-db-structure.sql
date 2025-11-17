create table kcm.contact (
  id               integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name       text not null check (char_length(first_name) < 80),
  last_name        text check (char_length(last_name) < 80),
  email            VARCHAR(255) NULL UNIQUE,
  phone            VARCHAR(30) NULL UNIQUE, 
  userId           integer references kcm_private.users(id) on delete cascade,
  about            text,
  created_at       timestamp default now()
);

comment on table kcm.contact is 'A contact record.';
comment on column kcm.contact.id is 'The primary unique identifier for the contact.';
comment on column kcm.contact.first_name is 'The person’s first name.';
comment on column kcm.contact.last_name is 'The person’s last name.';
comment on column kcm.contact.about is 'A short description about the contact.';
comment on column kcm.contact.created_at is 'The time this contact was created.';