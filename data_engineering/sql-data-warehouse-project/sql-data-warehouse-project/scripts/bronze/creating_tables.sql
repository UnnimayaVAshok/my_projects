use bronze;

select 'Dropping table bronze.crm_cust_info';
drop table if exists bronze.crm_cust_info;
select 'Creating table bronze.crm_cust_info';
create table bronze.crm_cust_info(
	cst_id int,
	cst_key varchar(50),
    cst_firstname varchar(50),
    cst_lastname varchar(50),
    cst_marital_status varchar(20),
    cst_gndr varchar(20),
    cst_create_date date
);
select 'Created table bronze.crm_cust_info';

select 'Dropping table bronze.crm_prd_info';
drop table if exists bronze.crm_prd_info;
select 'Creating table bronze.crm_prd_info';
create table bronze.crm_prd_info(
	prd_id int,
    prd_key varchar(50),
    prd_nm varchar(50),
    prd_cost int,
    prd_line varchar(20),
    prd_start_dt date,
    prd_end_dt date
);
select 'Created table bronze.crm_prd_info';

select 'Dropping table bronze.crm_sales_details';
drop table if exists bronze.crm_sales_details;
select 'Creating table bronze.crm_sales_details';
create table bronze.crm_sales_details(
	sales varchar(50),
    sls_prd_key varchar(50),
    sls_cust_id int,
    sls_order_dt int,
    sls_ship_dt int,
    sls_due_dt int,
    sls_sales int,
    sls_quantity int,
    sls_price int
);
select 'Created table bronze.crm_sales_details';

select 'Dropping table bronze.erp_cust_az12';
drop table if exists bronze.erp_cust_az12;
select 'Creating table bronze.erp_cust_az12';
create table bronze.erp_cust_az12(
	cid varchar(50),
    bdate date,
    gen varchar(20)
);
select 'Created table bronze.erp_cust_az12';

select 'Dropping table bronze.erp_loc_a101';
drop table if exists bronze.erp_loc_a101;
select 'Creating table bronze.erp_loc_a101';
create table bronze.erp_loc_a101(
	cid varchar(50),
    cntry varchar(50)
);
select 'Created table bronze.erp_loc_a101';

select 'Droppping table bronze.erp_px_cat_g1v2';
drop table if exists bronze.erp_px_cat_g1v2;
select 'Creating table bronze.erp_px_cat_g1v2';
create table bronze.erp_px_cat_g1v2(
	id varchar(50),
    cat varchar(50),
    subcat varchar(50),
    maintenance varchar(50)
);
select 'Created table bronze.erp_px_cat_g1v2';