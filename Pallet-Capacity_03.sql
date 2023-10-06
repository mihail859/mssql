SELECT TOP (1000) [Id]
      ,[Name]
      ,[Quantity]
      ,[BoxCapacity]
      ,[PalletCapacity]
	  ,CEILING(CEILING(Quantity*1.0/BoxCapacity)*1.0/PalletCapacity) AS PalletCAPACITY
  FROM [Demo].[dbo].[Products]
