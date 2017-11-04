CREATE DEFINER=`root`@`localhost` PROCEDURE `Monto_ganado_periodo`(IN id_empleado INT,IN fecha1 date, IN fecha2 date)
BEGIN
	
    SELECT SUM(hp.salario_neto)
	FROM empleado e
	inner join historial_planillas hp on hp.id_empleado = e.id_empleado
	where e.id_empleado= id_empleado
	and hp.fecha between fecha1 and fecha2
	group by e.id_empleado;
    
END