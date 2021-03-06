CREATE DEFINER=`root`@`localhost` FUNCTION `horas_trabajadas`(id_empleado INT,fecha date) RETURNS time
BEGIN
	DECLARE horas_trabajadas TIME;
	
    DECLARE horasalida TIME;
    SET horasalida = (
    SELECT he.hora_salida
	FROM marcas m
	inner join horarios_empleados he
	on he.id_empleado = m.id_empleado
	and nombreDia(m.fecha) = he.nombre
	where he.id_empleado = id_empleado and m.fecha= fecha);
    
    IF(SELECT m.marca_salida
    BEGIN
    FROM empleado e
    JOIN marcas m on m.id_empleado = e.id_empleado
	WHERE m.fecha = fecha and e.id_empleado = id_empleado)< horasalida THEN
	
    SET horas_trabajadas=(SELECT TIMEDIFF(m.marca_salida , m.marca_entrada) 'Horas normales laboradas'
    FROM empleado e
    JOIN marcas m on e.id_empleado = m.id_empleado
    WHERE e.id_empleado = id_empleado and m.fecha = fecha);
    
    ELSE
	SET horas_trabajadas=(SELECT TIMEDIFF(he.hora_salida , m.marca_entrada) 'Horas normales laboradas'
    FROM marcas m
    JOIN horarios_empleados he on m.id_empleado = he.id_empleado   
	and nombreDia(m.fecha) = he.nombre  
    WHERE m.id_empleado = id_empleado and fecha= m.fecha);
    END IF;
RETURN horas_trabajadas;
END