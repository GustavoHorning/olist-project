USE Olist;




IF OBJECT_ID('silver.order_items', 'U') IS NOT NULL
	DROP TABLE silver.order_items;


SELECT 
	order_id, 
	order_item_id, 
	product_id, 
	seller_id, 
	TRY_CAST(shipping_limit_date AS DATETIME) AS shipping_limit_date, 
	price, 
	freight_value
INTO silver.order_items
FROM bronze.order_items;

SELECT 
	COUNT(*) AS TotalLinhaS
FROM silver.order_items;


SELECT TOP 5
	*
FROM silver.order_items;

