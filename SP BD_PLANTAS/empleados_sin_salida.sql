DELIMITER $$
CREATE PROCEDURE empleados_sin_salida(IN FechaInicio date, IN FechaFin date)
BEGIN
SELECT m.id_empleado, m.fecha, m.marca_salida
FROM marcas m
where m.marca_salida is NULL
	and m.fecha between FechaInicio and FechaFin;
END$$
DELIMITER ;
