INSERT INTO silver.crm_cust_info (
	cst_id, 
	cst_key, 
	cst_firstname, 
	cst_lastname,
	cst_material_status, 
	cst_gndr, 
	cst_create_date)

SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN TRIM(UPPER(cst_material_status)) = 'S' THEN 'Single'
	 WHEN TRIM(UPPER(cst_material_status)) = 'M' THEN 'Married'
	 ELSE 'N/A'
END cst_material_status,
CASE WHEN TRIM(UPPER(cst_gndr)) = 'F' THEN 'Female'
	 WHEN TRIM(UPPER(cst_gndr)) = 'M' THEN 'Male'
	 ELSE 'N/A'
END cst_gndr,
cst_create_date
FROM (
SELECT 
*,
ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
FROM bronze.crm_cust_info
) t
WHERE flag_last = 1
AND cst_id IS NOT NULL
