SELECT
cid,
REPLACE(cid, '-', '') AS cid,
cntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('USA', 'US') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'N/A'
	 ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101
WHERE REPLACE(cid, '-', '') NOT IN 
(
SELECT cst_key FROM silver.crm_cust_info
);

SELECT cst_key
FROM silver.crm_cust_info;

SELECT DISTINCT cntry AS old_cntry,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) IN ('USA', 'US') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'N/A'
	 ELSE TRIM(cntry)
END AS cntry
FROM bronze.erp_loc_a101;

SELECT *
FROM silver.erp_loc_a101
