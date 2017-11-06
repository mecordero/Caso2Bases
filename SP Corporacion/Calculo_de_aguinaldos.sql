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
-- Description:	No recibe parametros, calcula todos y los agrega a la tabla "Aguinaldo"
-- =============================================
CREATE PROCEDURE Calculo_de_aguinaldos
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	insert into AGUINALDO
	select E.id_empleado, e.id_planta, sum(hp.salario_bruto) - (9.17/sum(hp.salario_bruto)) as Aguinaldo
		   from EMPLEADO E inner join HISTORIAL_PLANILLAS HP on E.id_empleado = hp.id_empleado
		   where hp.fecha between dateadd(month,-12,getdate()) and GETDATE()
		   group by E.id_empleado, e.id_planta
END
GO

