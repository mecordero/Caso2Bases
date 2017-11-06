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
-- Description:	Recibe 3 parametros id de la planta, fecha de inicio, fecha de fin
-- =============================================
CREATE PROCEDURE Total_neto_y_obligaciones_en_un_periodo
	-- Add the parameters for the stored procedure here
	@id as int,
	@inicio as date,
	@fin as date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT @id, sum(hp.salario_neto) as [Salario Neto], 9.17/sum(hp.salario_bruto) as Obligaciones
	FROM HISTORIAL_PLANILLAS hp
	where @id = hp.id_planta and (hp.fecha between @inicio and @fin)
	group by hp.id_planta
END
GO
