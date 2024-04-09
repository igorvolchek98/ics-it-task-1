if object_id('dbo.SKU') is null
begin
	create table dbo.SKU(
		ID int primary key identity,
		Code as concat('s', cast(ID as varchar(255))),
		[Name] varchar(255),
		constraint UK_SKU_Code unique (Code)
	)
end

if object_id('dbo.Family') is null
begin
	create table dbo.Family(
		ID int primary key identity,
		SurName varchar(255),
		BudgetValue decimal(18, 2)
	)
end

if object_id('dbo.Basket') is null
begin
	create table dbo.Basket(
		ID int primary key identity,
		ID_SKU int,
		ID_Family int,
		Quantity int,
		[Value] decimal(18, 2),
		PurchaseDate date default cast(getdate() as date),
		DiscountValue decimal(18, 2),
		constraint FK_Basket_ID_SKU_SKU foreign key(ID_SKU) references dbo.SKU(ID),
		constraint FK_Basket_ID_Family_Family foreign key(ID_Family) references dbo.Family(ID),
		constraint CK_Basket_Quantity check(Quantity >= 0),
		constraint CK_Basket_Value check([Value] >= 0)
	)
end