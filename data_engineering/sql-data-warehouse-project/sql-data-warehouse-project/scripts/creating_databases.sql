-- droping database if it exists and creating database

drop database if exists DataWarehouse;
select 'Dropped database DataWarehouse';
create database DataWarehouse;
select 'Created database DataWarehouse';
use DataWarehouse;

-- droping schema if it exists and creating schema

select 'Dropped schema bronze';
drop schema if exists bronze;
select 'Created schema bronze';
create schema bronze;


select 'Dropped schema silver'; 
drop schema if exists silver;
select 'Created schema silver';
create schema silver;

select 'Droppped schema gold';
drop schema if exists gold;
select 'Created schema gold';
create schema gold;