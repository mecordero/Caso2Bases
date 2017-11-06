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
-- Description:	Recibe 2 fecha de inicio, fecha de fin y devuelve los 10 mejores empleados pagados en ese periodo
-- =============================================
CREATE PROCEDURE Top_10_pagados_en_un_periodo
	-- Add the parameters for the stored procedure here
	@inicio as date,
	@fin as date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select top 10 hp.id_empleado, sum(hp.salario_neto) as [Salario Neto]
	from HISTORIAL_PLANILLAS hp
	where hp.fecha between @inicio and @fin
	group by hp.id_empleado
END
GO