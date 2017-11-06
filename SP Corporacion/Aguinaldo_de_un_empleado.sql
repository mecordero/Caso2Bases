-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Juan Jose Araya Castro
-- Create date: 5/11/2017
-- Description:	Recibe 1 parametro, el id del empleado y si ya esta calculado solo lo selecciona de la tabla de aguinaldo en caso de no ser asi lo calcula y no lo guarda
-- =============================================
CREATE PROCEDURE Aguinaldo_de_un_empleado 
	-- Add the parameters for the stored procedure here
	@id as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists (select * from AGUINALDO where AGUINALDO.id_empleado = @id)
		select @id, AGUINALDO.monto
		from AGUINALDO
		where AGUINALDO.id_empleado = @id
	else
		select @id, sum(hp.salario_bruto) - (9.17/sum(hp.salario_bruto)) as Aguinaldo
		from EMPLEADO E inner join HISTORIAL_PLANILLAS HP on E.id_empleado = hp.id_empleado
		where E.id_empleado = @id and (hp.fecha between dateadd(month,-12,getdate()) and GETDATE())
		group by E.id_empleado, e.id_planta
END
GO
