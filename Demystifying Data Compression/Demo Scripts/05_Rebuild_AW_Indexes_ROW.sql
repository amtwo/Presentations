USE AdventureWorks2014_ROW
GO

/*
SELECT 'ALTER TABLE [' + s.name + '].[' + t.name + '] REBUILD WITH (DATA_COMPRESSION=ROW);'
FROM sys.objects t
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.indexes i ON i.object_id = t.object_id
WHERE i.type = 0  --Just heaps
AND t.type IN ('U','V')
ORDER BY s.name, t.name;
--
SELECT 'ALTER INDEX [' + i.name + '] ON [' + s.name + '].[' + t.name + '] REBUILD WITH (DATA_COMPRESSION=ROW);'
FROM sys.objects t
JOIN sys.schemas s ON t.schema_id = s.schema_id
JOIN sys.indexes i ON i.object_id = t.object_id
WHERE i.type NOT IN (0,3) --Exclude heaps & XML indexes
AND t.type IN ('U','V')
ORDER BY s.name, t.name;
--*/

CREATE OR ALTER PROCEDURE Rebuild_AW_Indexes 
    AS
ALTER TABLE [dbo].[DatabaseLog] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER TABLE [Production].[ProductProductPhoto] REBUILD WITH (DATA_COMPRESSION=ROW);
--
--
ALTER INDEX [PK_AWBuildVersion_SystemInformationID] ON [dbo].[AWBuildVersion] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_DatabaseLog_DatabaseLogID] ON [dbo].[DatabaseLog] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ErrorLog_ErrorLogID] ON [dbo].[ErrorLog] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Department_DepartmentID] ON [HumanResources].[Department] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Department_Name] ON [HumanResources].[Department] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Employee_BusinessEntityID] ON [HumanResources].[Employee] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Employee_OrganizationNode] ON [HumanResources].[Employee] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Employee_OrganizationLevel_OrganizationNode] ON [HumanResources].[Employee] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Employee_LoginID] ON [HumanResources].[Employee] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Employee_NationalIDNumber] ON [HumanResources].[Employee] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Employee_rowguid] ON [HumanResources].[Employee] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_EmployeeDepartmentHistory_BusinessEntityID_StartDate_DepartmentID] ON [HumanResources].[EmployeeDepartmentHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_EmployeeDepartmentHistory_DepartmentID] ON [HumanResources].[EmployeeDepartmentHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_EmployeeDepartmentHistory_ShiftID] ON [HumanResources].[EmployeeDepartmentHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_EmployeePayHistory_BusinessEntityID_RateChangeDate] ON [HumanResources].[EmployeePayHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_JobCandidate_JobCandidateID] ON [HumanResources].[JobCandidate] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_JobCandidate_BusinessEntityID] ON [HumanResources].[JobCandidate] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Shift_ShiftID] ON [HumanResources].[Shift] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Shift_Name] ON [HumanResources].[Shift] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Shift_StartTime_EndTime] ON [HumanResources].[Shift] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Address_AddressID] ON [Person].[Address] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Address_rowguid] ON [Person].[Address] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Address_AddressLine1_AddressLine2_City_StateProvinceID_PostalCode] ON [Person].[Address] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Address_StateProvinceID] ON [Person].[Address] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_AddressType_AddressTypeID] ON [Person].[AddressType] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_AddressType_rowguid] ON [Person].[AddressType] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_AddressType_Name] ON [Person].[AddressType] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_BusinessEntity_BusinessEntityID] ON [Person].[BusinessEntity] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_BusinessEntity_rowguid] ON [Person].[BusinessEntity] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_BusinessEntityAddress_BusinessEntityID_AddressID_AddressTypeID] ON [Person].[BusinessEntityAddress] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_BusinessEntityAddress_rowguid] ON [Person].[BusinessEntityAddress] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_BusinessEntityAddress_AddressID] ON [Person].[BusinessEntityAddress] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_BusinessEntityAddress_AddressTypeID] ON [Person].[BusinessEntityAddress] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_BusinessEntityContact_BusinessEntityID_PersonID_ContactTypeID] ON [Person].[BusinessEntityContact] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_BusinessEntityContact_rowguid] ON [Person].[BusinessEntityContact] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_BusinessEntityContact_PersonID] ON [Person].[BusinessEntityContact] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_BusinessEntityContact_ContactTypeID] ON [Person].[BusinessEntityContact] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ContactType_ContactTypeID] ON [Person].[ContactType] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ContactType_Name] ON [Person].[ContactType] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_CountryRegion_CountryRegionCode] ON [Person].[CountryRegion] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_CountryRegion_Name] ON [Person].[CountryRegion] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_EmailAddress_BusinessEntityID_EmailAddressID] ON [Person].[EmailAddress] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_EmailAddress_EmailAddress] ON [Person].[EmailAddress] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Password_BusinessEntityID] ON [Person].[Password] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Person_BusinessEntityID] ON [Person].[Person] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Person_LastName_FirstName_MiddleName] ON [Person].[Person] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Person_rowguid] ON [Person].[Person] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_PersonPhone_BusinessEntityID_PhoneNumber_PhoneNumberTypeID] ON [Person].[PersonPhone] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_PersonPhone_PhoneNumber] ON [Person].[PersonPhone] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_PhoneNumberType_PhoneNumberTypeID] ON [Person].[PhoneNumberType] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_StateProvince_StateProvinceID] ON [Person].[StateProvince] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_StateProvince_Name] ON [Person].[StateProvince] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_StateProvince_StateProvinceCode_CountryRegionCode] ON [Person].[StateProvince] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_StateProvince_rowguid] ON [Person].[StateProvince] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_vStateProvinceCountryRegion] ON [Person].[vStateProvinceCountryRegion] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_BillOfMaterials_ProductAssemblyID_ComponentID_StartDate] ON [Production].[BillOfMaterials] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_BillOfMaterials_BillOfMaterialsID] ON [Production].[BillOfMaterials] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_BillOfMaterials_UnitMeasureCode] ON [Production].[BillOfMaterials] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Culture_CultureID] ON [Production].[Culture] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Culture_Name] ON [Production].[Culture] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Document_DocumentNode] ON [Production].[Document] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [UQ__Document__F73921F763026E5E] ON [Production].[Document] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Document_DocumentLevel_DocumentNode] ON [Production].[Document] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Document_rowguid] ON [Production].[Document] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Document_FileName_Revision] ON [Production].[Document] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Illustration_IllustrationID] ON [Production].[Illustration] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Location_LocationID] ON [Production].[Location] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Location_Name] ON [Production].[Location] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Product_ProductID] ON [Production].[Product] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Product_ProductNumber] ON [Production].[Product] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Product_Name] ON [Production].[Product] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Product_rowguid] ON [Production].[Product] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductCategory_ProductCategoryID] ON [Production].[ProductCategory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ProductCategory_Name] ON [Production].[ProductCategory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ProductCategory_rowguid] ON [Production].[ProductCategory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductCostHistory_ProductID_StartDate] ON [Production].[ProductCostHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductDescription_ProductDescriptionID] ON [Production].[ProductDescription] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ProductDescription_rowguid] ON [Production].[ProductDescription] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductDocument_ProductID_DocumentNode] ON [Production].[ProductDocument] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductInventory_ProductID_LocationID] ON [Production].[ProductInventory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductListPriceHistory_ProductID_StartDate] ON [Production].[ProductListPriceHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductModel_ProductModelID] ON [Production].[ProductModel] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ProductModel_Name] ON [Production].[ProductModel] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ProductModel_rowguid] ON [Production].[ProductModel] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductModelIllustration_ProductModelID_IllustrationID] ON [Production].[ProductModelIllustration] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductModelProductDescriptionCulture_ProductModelID_ProductDescriptionID_CultureID] ON [Production].[ProductModelProductDescriptionCulture] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductPhoto_ProductPhotoID] ON [Production].[ProductPhoto] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductProductPhoto_ProductID_ProductPhotoID] ON [Production].[ProductProductPhoto] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductReview_ProductReviewID] ON [Production].[ProductReview] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_ProductReview_ProductID_Name] ON [Production].[ProductReview] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductSubcategory_ProductSubcategoryID] ON [Production].[ProductSubcategory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ProductSubcategory_Name] ON [Production].[ProductSubcategory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ProductSubcategory_rowguid] ON [Production].[ProductSubcategory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ScrapReason_ScrapReasonID] ON [Production].[ScrapReason] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ScrapReason_Name] ON [Production].[ScrapReason] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_TransactionHistory_TransactionID] ON [Production].[TransactionHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_TransactionHistory_ProductID] ON [Production].[TransactionHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_TransactionHistory_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_TransactionHistoryArchive_TransactionID] ON [Production].[TransactionHistoryArchive] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_TransactionHistoryArchive_ProductID] ON [Production].[TransactionHistoryArchive] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_TransactionHistoryArchive_ReferenceOrderID_ReferenceOrderLineID] ON [Production].[TransactionHistoryArchive] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_UnitMeasure_UnitMeasureCode] ON [Production].[UnitMeasure] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_UnitMeasure_Name] ON [Production].[UnitMeasure] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_vProductAndDescription] ON [Production].[vProductAndDescription] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_WorkOrder_WorkOrderID] ON [Production].[WorkOrder] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_WorkOrder_ScrapReasonID] ON [Production].[WorkOrder] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_WorkOrder_ProductID] ON [Production].[WorkOrder] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_WorkOrderRouting_WorkOrderID_ProductID_OperationSequence] ON [Production].[WorkOrderRouting] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_WorkOrderRouting_ProductID] ON [Production].[WorkOrderRouting] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ProductVendor_ProductID_BusinessEntityID] ON [Purchasing].[ProductVendor] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_ProductVendor_UnitMeasureCode] ON [Purchasing].[ProductVendor] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_ProductVendor_BusinessEntityID] ON [Purchasing].[ProductVendor] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_PurchaseOrderDetail_PurchaseOrderID_PurchaseOrderDetailID] ON [Purchasing].[PurchaseOrderDetail] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_PurchaseOrderDetail_ProductID] ON [Purchasing].[PurchaseOrderDetail] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_PurchaseOrderHeader_PurchaseOrderID] ON [Purchasing].[PurchaseOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_PurchaseOrderHeader_VendorID] ON [Purchasing].[PurchaseOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_PurchaseOrderHeader_EmployeeID] ON [Purchasing].[PurchaseOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ShipMethod_ShipMethodID] ON [Purchasing].[ShipMethod] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ShipMethod_Name] ON [Purchasing].[ShipMethod] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_ShipMethod_rowguid] ON [Purchasing].[ShipMethod] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Vendor_BusinessEntityID] ON [Purchasing].[Vendor] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Vendor_AccountNumber] ON [Purchasing].[Vendor] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_CountryRegionCurrency_CountryRegionCode_CurrencyCode] ON [Sales].[CountryRegionCurrency] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_CountryRegionCurrency_CurrencyCode] ON [Sales].[CountryRegionCurrency] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_CreditCard_CreditCardID] ON [Sales].[CreditCard] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_CreditCard_CardNumber] ON [Sales].[CreditCard] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Currency_CurrencyCode] ON [Sales].[Currency] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Currency_Name] ON [Sales].[Currency] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_CurrencyRate_CurrencyRateID] ON [Sales].[CurrencyRate] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_CurrencyRate_CurrencyRateDate_FromCurrencyCode_ToCurrencyCode] ON [Sales].[CurrencyRate] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Customer_CustomerID] ON [Sales].[Customer] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Customer_rowguid] ON [Sales].[Customer] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Customer_AccountNumber] ON [Sales].[Customer] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Customer_TerritoryID] ON [Sales].[Customer] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_PersonCreditCard_BusinessEntityID_CreditCardID] ON [Sales].[PersonCreditCard] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID] ON [Sales].[SalesOrderDetail] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesOrderDetail_rowguid] ON [Sales].[SalesOrderDetail] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_SalesOrderDetail_ProductID] ON [Sales].[SalesOrderDetail] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesOrderHeader_SalesOrderID] ON [Sales].[SalesOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesOrderHeader_rowguid] ON [Sales].[SalesOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesOrderHeader_SalesOrderNumber] ON [Sales].[SalesOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_SalesOrderHeader_CustomerID] ON [Sales].[SalesOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_SalesOrderHeader_SalesPersonID] ON [Sales].[SalesOrderHeader] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesOrderHeaderSalesReason_SalesOrderID_SalesReasonID] ON [Sales].[SalesOrderHeaderSalesReason] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesPerson_BusinessEntityID] ON [Sales].[SalesPerson] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesPerson_rowguid] ON [Sales].[SalesPerson] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesPersonQuotaHistory_BusinessEntityID_QuotaDate] ON [Sales].[SalesPersonQuotaHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesPersonQuotaHistory_rowguid] ON [Sales].[SalesPersonQuotaHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesReason_SalesReasonID] ON [Sales].[SalesReason] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesTaxRate_SalesTaxRateID] ON [Sales].[SalesTaxRate] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesTaxRate_StateProvinceID_TaxType] ON [Sales].[SalesTaxRate] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesTaxRate_rowguid] ON [Sales].[SalesTaxRate] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesTerritory_TerritoryID] ON [Sales].[SalesTerritory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesTerritory_Name] ON [Sales].[SalesTerritory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesTerritory_rowguid] ON [Sales].[SalesTerritory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SalesTerritoryHistory_BusinessEntityID_StartDate_TerritoryID] ON [Sales].[SalesTerritoryHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SalesTerritoryHistory_rowguid] ON [Sales].[SalesTerritoryHistory] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_ShoppingCartItem_ShoppingCartItemID] ON [Sales].[ShoppingCartItem] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_ShoppingCartItem_ShoppingCartID_ProductID] ON [Sales].[ShoppingCartItem] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SpecialOffer_SpecialOfferID] ON [Sales].[SpecialOffer] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SpecialOffer_rowguid] ON [Sales].[SpecialOffer] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_SpecialOfferProduct_SpecialOfferID_ProductID] ON [Sales].[SpecialOfferProduct] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_SpecialOfferProduct_rowguid] ON [Sales].[SpecialOfferProduct] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_SpecialOfferProduct_ProductID] ON [Sales].[SpecialOfferProduct] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [PK_Store_BusinessEntityID] ON [Sales].[Store] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [AK_Store_rowguid] ON [Sales].[Store] REBUILD WITH (DATA_COMPRESSION=ROW);
ALTER INDEX [IX_Store_SalesPersonID] ON [Sales].[Store] REBUILD WITH (DATA_COMPRESSION=ROW);
GO

EXEC AdventureWorks2014_ROW.dbo.Rebuild_AW_Indexes;
GO