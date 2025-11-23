create schema kcm_private;

CREATE TABLE kcm_private.users (
    id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    email VARCHAR(255) NOT NULL UNIQUE
);

create schema kcm;

create type kcm.contact_status as enum (
  'active',
  'archived'
);

create table kcm.contact (
  id               integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  first_name       text not null check (char_length(first_name) < 80),
  last_name        text check (char_length(last_name) < 80),
  email            varchar(255) null unique,
  phone            varchar(30) null unique, 
  status           kcm.contact_status not null default 'active',
  userId           integer references kcm_private.users(id) on delete cascade,
  about            text,
  created_at       timestamp default now(),
  updated_at       timestamp default now()
);

comment on table kcm.contact is 'A contact record.';
comment on column kcm.contact.id is 'The primary unique identifier for the contact.';
comment on column kcm.contact.first_name is 'The person’s first name.';
comment on column kcm.contact.last_name is 'The person’s last name.';
comment on column kcm.contact.about is 'A short description about the contact.';
comment on column kcm.contact.created_at is 'The time this contact was created.';

create function kcm.contact_full_name(contact kcm.contact) returns text as $$
  select contact.first_name || ' ' || contact.last_name
$$ language sql stable;

comment on function kcm.contact_full_name(kcm.contact) is 'A contact’s full name which is a concatenation of their first and last name.';

create function kcm.search_contacts(search text) returns setof kcm.contact as $$
  select contact.*
  from kcm.contact as contact
  where position(lower(search) in lower(contact.first_name || ' ' || contact.last_name)) > 0 or position(search in contact.email) > 0
$$ language sql stable;

comment on function kcm.search_contacts(text) is 'Returns contacts containing a given search term.';

create function kcm_private.set_updated_at() returns trigger as $$
begin
  new.updated_at := current_timestamp;
  return new;
end;
$$ language plpgsql;

create trigger contact_updated_at before update
  on kcm.contact
  for each row
  execute procedure kcm_private.set_updated_at();