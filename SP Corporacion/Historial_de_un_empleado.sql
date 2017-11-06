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
-- Description:	Recibe 1 parametro, el id del empleado
-- =============================================
CREATE PROCEDURE Historial_de_un_empleado
	-- Add the parameters for the stored procedure here
	@id as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT e.id_empleado, hp.salario_bruto , hp.salario_neto, hp.fecha
	From EMPLEADO e inner join HISTORIAL_PLANILLAS hp on e.id_empleado = hp.id_empleado
	where e.id_empleado = @id
END
GO
