USE Olist;




IF OBJECT_ID('silver.sellers', 'U') IS NOT NULL
	DROP TABLE silver.sellers;


SELECT
	seller_id, 
	RIGHT('00000' + CAST(seller_zip_code_prefix AS VARCHAR(10)), 5) AS seller_zip_code_prefix, 
	UPPER(seller_city) AS seller_city, 
	UPPER(seller_state) AS seller_state
INTO silver.sellers
FROM bronze.sellers;



SELECT COUNT(*) AS TotalLinhas FROM silver.sellers;

SELECT TOP 5 *
FROM silver.sellers
ORDER BY LEN(seller_zip_code_prefix);