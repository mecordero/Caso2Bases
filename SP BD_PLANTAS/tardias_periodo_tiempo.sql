DELIMITER $$
CREATE PROCEDURE tardias_periodo_tiempo(IN FechaInicio date, IN FechaFin date)
BEGIN
SELECT m.id_empleado, count(*)
FROM marcas m
inner join horarios_empleados he
on he.id_empleado = m.id_empleado
	and nombreDia(m.fecha) = he.nombre
where m.marca_entrada > he.hora_entrada
	and m.fecha between FechaInicio and FechaFin
group by m.id_empleado;
END$$
DELIMITER ;


CALL `bd_planta`.`tardias_periodo_tiempo`('2017-01-01','2017-8-31');
