EXEC bronze.load_bronze

GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '=========================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=========================================';

		PRINT '-----------------------------------------';
		PRINT 'Loading CRM Table';
		PRINT '-----------------------------------------';

		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'>>Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\acmin\Desktop\專案\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Druation: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + 'second' 


		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\acmin\Desktop\專案\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Druation: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + 'second' 



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\acmin\Desktop\專案\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Druation: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + 'second' 



		PRINT '-----------------------------------------';
		PRINT 'Loading ERP Table';
		PRINT '-----------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\acmin\Desktop\專案\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Druation: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + 'second' 



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\acmin\Desktop\專案\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Druation: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + 'second' 



		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\acmin\Desktop\專案\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Druation: ' + CAST(DATEDIFF(second, @start_time, @end_time)AS NVARCHAR) + 'second' 

	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST  (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State' + CAST  (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================';
	END CATCH
END
