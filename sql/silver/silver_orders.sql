USE Olist;

IF OBJECT_ID('silver.orders', 'U' ) IS NOT NULL
	DROP TABLE silver.orders;

SELECT
	t1.order_id,
	t1.customer_id,
	t1.order_status,
	TRY_CAST(t1.order_purchase_timestamp AS DATETIME) AS order_purchase_timestamp,
	TRY_CAST(t1.order_approved_at AS DATETIME) AS order_approved_at,
	TRY_CAST(t1.order_delivered_carrier_date AS DATETIME) AS order_delivered_carrier_date,
	TRY_CAST(t1.order_delivered_customer_date AS DATETIME) AS order_delivered_customer_date,
	TRY_CAST(t1.order_estimated_delivery_date AS DATETIME) AS order_estimated_delivery_date
INTO silver.orders
FROM bronze.orders AS t1


SELECT COUNT(*) AS TotalLinhas FROM silver.orders; 

SELECT TOP 5 * FROM silver.orders;

SELECT 
	SUM(CASE WHEN t1.order_approved_at IS NULL THEN 1 ELSE 0 END) AS NulosAprovados,
	SUM(CASE WHEN t1.order_delivered_carrier_date IS NULL THEN 1 ELSE 0 END) AS NulosTransportadora,
	SUM(CASE WHEN t1.order_delivered_customer_date IS NULL THEN 1 ELSE 0 END) AS NulosEntregues
FROM silver.orders AS t1;
