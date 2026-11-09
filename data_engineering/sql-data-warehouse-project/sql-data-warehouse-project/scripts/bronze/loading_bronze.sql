use bronze;

select 'Trucating table bronze.crm_cust_info';
truncate table bronze.crm_cust_info;
load data local infile
'D:/My_projects/data_engineering/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
into table bronze.crm_cust_info
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;
select 'Data loaded to bronze.crm_cust_info';

select count(*) from bronze.crm_cust_info;

select 'Trucating table bronze.crm_prd_info';
truncate table bronze.crm_prd_info;
load data local infile
'D:/My_projects/data_engineering/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
into table bronze.crm_prd_info
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;
select 'Data loaded to bronze.crm_prd_info';

select count(*) from bronze.crm_prd_info;

select 'Trucating table bronze.crm_sales_details';
truncate table bronze.crm_sales_details;
load data local infile
'D:/My_projects/data_engineering/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
into table bronze.crm_sales_details
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;
select 'Data loaded to bronze.crm_sales_details';

select count(*) from bronze.crm_sales_details;

select 'Trucating table bronze.erp_cust_az12';
truncate table bronze.erp_cust_az12;
load data local infile
'D:/My_projects/data_engineering/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
into table bronze.erp_cust_az12
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;
select 'Data loaded to bronze.erp_cust_az12';

select count(*) from bronze.erp_cust_az12;

select 'Trucating table bronze.crm_cust_info';
select 'Trucating table bronze.crm_cust_info';
truncate table bronze.erp_loc_a101;
load data local infile
'D:/My_projects/data_engineering/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
into table bronze.erp_loc_a101
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;
select 'Data loaded to bronze.erp_loc_a101';

select count(*) from bronze.erp_loc_a101;

select 'Trucating table bronze.erp_px_cat_g1v2';
truncate table bronze.erp_px_cat_g1v2;
load data local infile
'D:/My_projects/data_engineering/sql-data-warehouse-project/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
into table bronze.erp_px_cat_g1v2
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 lines;
select 'Data loaded to bronze.erp_px_cat_g1v2';

select count(*) from bronze.erp_px_cat_g1v2;
