CREATE DEFINER=`root`@`localhost` PROCEDURE `total_horas_laboradas`(IN id_empleado INT,IN fecha date,OUT horasalida time)
BEGIN	

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
	
    SELECT e.id_empleado, TIMEDIFF(m.marca_salida , m.marca_entrada) 'Horas normales laboradas'
    FROM empleado e
    JOIN marcas m on e.id_empleado = m.id_empleado
    WHERE e.id_empleado = id_empleado and m.fecha = fecha;
    
    ELSE
	SELECT m.id_empleado,TIMEDIFF(he.hora_salida , m.marca_entrada) 'Horas normales laboradas'
    FROM marcas m
    JOIN horarios_empleados he on m.id_empleado = he.id_empleado   
	and nombreDia(m.fecha) = he.nombre  
    WHERE m.id_empleado = id_empleado and fecha= m.fecha ;
    END IF;
END