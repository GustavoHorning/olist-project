USE Olist;

IF OBJECT_ID('silver.customers', 'U' ) IS NOT NULL
	DROP TABLE silver.customers;

SELECT 
	customer_id, 
	customer_unique_id, 
	RIGHT('00000' + CAST(customer_zip_code_prefix AS VARCHAR(10)), 5) AS customer_zip_code_prefix, 
	UPPER(customer_city) AS customer_city, 
	UPPER(customer_state) AS customer_state
INTO silver.customers
FROM bronze.customers;

SELECT COUNT(*) FROM silver.customers;

SELECT TOP 20
*
FROM silver.customers
ORDER BY LEN(customer_zip_code_prefix);