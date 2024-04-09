create or alter trigger dbo.tr_Basket_insert_update on dbo.Basket
after insert
as
begin
	select 
		i.ID
		,count(*) over(partition by i.ID_SKU) as QuantityOfSKU
	into #InsertedRecords
	from inserted as i

	update b
	set DiscountValue = [Value] * 0.05
	from dbo.Basket as b
	where b.ID in(select ir.ID from #InsertedRecords as ir where ir.QuantityOfSKU >= 2)

	update b
	set DiscountValue = 0
	from dbo.Basket as b
	where b.ID in(select ir.ID from #InsertedRecords as ir where ir.QuantityOfSKU = 1)
end