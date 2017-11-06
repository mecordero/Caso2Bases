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
-- Description:	Recibe 2 sea organizado por plata(1) o cantidad de empleados(2) y si es "ASC" o "DESC"
-- =============================================
CREATE PROCEDURE Planta_CE_MTSB_PSB
	-- Add the parameters for the stored procedure here
	@Org as int,
	@AscDes as nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @Org = 1 and @AscDes = 'ASC'
	SELECT hp.id_planta,COUNT(hp.id_empleado) as [Cantidad de empleados], sum(hp.salario_bruto) as [Total de Salario Bruto], avg(hp.salario_bruto) as [Promedio de Salario Bruto]
	FROM HISTORIAL_PLANILLAS hp
	group by hp.id_planta
	order by 1 asc
	else if @Org = 2 and @AscDes = 'ASC'
	SELECT hp.id_planta,COUNT(hp.id_empleado) as [Cantidad de empleados], sum(hp.salario_bruto) as [Total de Salario Bruto], avg(hp.salario_bruto) as [Promedio de Salario Bruto]
	FROM HISTORIAL_PLANILLAS hp
	group by hp.id_planta
	order by 2 asc
	else if @Org = 1 and @AscDes = 'DESC'
	SELECT hp.id_planta,COUNT(hp.id_empleado) as [Cantidad de empleados], sum(hp.salario_bruto) as [Total de Salario Bruto], avg(hp.salario_bruto) as [Promedio de Salario Bruto]
	FROM HISTORIAL_PLANILLAS hp
	group by hp.id_planta
	order by 1 desc
	else if @Org = 2 and @AscDes = 'DESC'
	SELECT hp.id_planta,COUNT(hp.id_empleado) as [Cantidad de empleados], sum(hp.salario_bruto) as [Total de Salario Bruto], avg(hp.salario_bruto) as [Promedio de Salario Bruto]
	FROM HISTORIAL_PLANILLAS hp
	group by hp.id_planta
	order by 2 desc
	

END
GO
