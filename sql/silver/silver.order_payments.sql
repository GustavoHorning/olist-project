USE Olist;




IF OBJECT_ID('silver.order_payments', 'U') IS NOT NULL
	DROP TABLE silver.order_payments;



	SELECT
		order_id,
		payment_sequential,
		payment_type,
		payment_installments,
		payment_value
	INTO silver.order_payments
	FROM bronze.order_payments
	WHERE payment_value > 0


	SELECT COUNT(*) AS TotalLinhas 
	FROM bronze.order_payments;

	SELECT COUNT(*) AS TotalLinhas 
	FROM silver.order_payments;

	SELECT * FROM silver.order_payments
	WHERE payment_value = 0;