-- Create UUID extension
create extension if not exists "uuid-ossp";

-- Table customers
create table customers (
  id uuid primary key default uuid_generate_v4(), 
  name varchar(100), 
  address text, 
  phone varchar(20), 
  email varchar(100)
);

-- Table account_types
create table account_types (
  id uuid primary key default uuid_generate_v4(), 
  name varchar(50)
);

-- Table accounts
create table accounts (
  id uuid primary key default uuid_generate_v4(), 
  account_number varchar(20) unique, 
  balance numeric(15, 2), 
  customer_id uuid, 
  account_type_id uuid, 
  foreign key (customer_id) references customers(id) on delete cascade, 
  foreign key (account_type_id) references account_types(id) on delete cascade
);

-- Table transaction_types
create table transaction_types (
  id uuid primary key default uuid_generate_v4(), 
  name varchar(50)
);

-- Table transactions
create table transactions (
  id uuid primary key default uuid_generate_v4(), 
  transaction_date timestamp, 
  amount numeric(15, 2), 
  account_id uuid, 
  transaction_type_id uuid, 
  foreign key (account_id) references accounts(id) on delete cascade, 
  foreign key (transaction_type_id) references transaction_types(id) on delete cascade
);

-- Create customer
insert into customers (id, name, address, phone, email) 
values 
  (
    '4fe4c464-0fe1-4b86-97f4-884809068024', 
    'John Doe', '123 Elm Street', '123-456-7890', 
    'john.doe@example.com'
  );

-- Create account_type
insert into account_types (id, name) 
values 
  (
    '9362185c-a762-4cdc-a8e8-efca6d0c9882', 
    'Savings'
  );

-- Create account
insert into accounts (
  id, account_number, balance, customer_id, 
  account_type_id
) 
values 
  (
    '4ec3638c-06f4-43b7-b3dd-42e20749d58b', 
    'ACC123456', 1000.00, '4fe4c464-0fe1-4b86-97f4-884809068024', 
    '9362185c-a762-4cdc-a8e8-efca6d0c9882'
  );

-- Create transaction_type
insert into transaction_types (id, name) 
values 
  (
    '54af0699-ff09-423f-a777-6c3feb41a0c2', 
    'Deposit'
  );

-- Create transaction
insert into transactions (
  id, transaction_date, amount, account_id, 
  transaction_type_id
) 
values 
  (
    '75c9d151-54ae-4ac9-9431-54b7dee681be', 
    '2024-08-01 10:00:00', 500.00, '4ec3638c-06f4-43b7-b3dd-42e20749d58b', 
    '54af0699-ff09-423f-a777-6c3feb41a0c2'
  );

-- Read customers
select 
  * 
from 
  customers;

-- Read accounts
select 
  * 
from 
  accounts a 
where 
  customer_id = '4fe4c464-0fe1-4b86-97f4-884809068024';

-- Read transactions
select 
  * 
from 
  transactions t 
where 
  account_id = '4ec3638c-06f4-43b7-b3dd-42e20749d58b';

-- Update account
update 
  accounts 
set 
  balance = 1200.00 
where 
  id = '4ec3638c-06f4-43b7-b3dd-42e20749d58b';

-- Update customer
update 
  customers 
set 
  email = 'john.newemail@example.com' 
where 
  id = '4fe4c464-0fe1-4b86-97f4-884809068024';

-- Delete account
delete from 
  accounts 
where 
  id = '4ec3638c-06f4-43b7-b3dd-42e20749d58b';

-- Delete customer
delete from 
  customers 
where 
  id = '4fe4c464-0fe1-4b86-97f4-884809068024';
