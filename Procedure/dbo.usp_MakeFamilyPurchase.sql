create or alter procedure dbo.usp_MakeFamilyPurchase
	@FamilySurName varchar(255)
as
begin
	declare @FamilyID int = (select f.ID from dbo.Family as f where f.SurName = @FamilySurName)
	declare @FamilyBasketSum decimal(18, 2) = (select sum(b.[Value]) from dbo.Basket as b where b.ID_Family = @FamilyID)

	if @FamilyID is not null
	begin
		update f
		set BudgetValue = BudgetValue - isnull(@FamilyBasketSum, 0)
		from dbo.Family as f
		where f.ID = @FamilyID
	end
	else print('Family not exist')
end