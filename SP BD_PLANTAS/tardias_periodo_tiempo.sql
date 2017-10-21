DELIMITER $$
CREATE PROCEDURE tardias_periodo_tiempo(IN FechaInicio date, IN FechaFin date)
BEGIN
SELECT m.id_empleado, m.fecha, m.marca_entrada, he.hora_entrada
FROM marcas m
inner join horarios_empleados he
on he.id_empleado = m.id_empleado
	and nombreDia(m.fecha) = he.nombre
where m.marca_entrada > he.hora_entrada
	and m.fecha between FechaInicio and FechaFin;
END$$
DELIMITER ;


