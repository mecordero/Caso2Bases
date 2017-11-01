CREATE DEFINER=`root`@`localhost` FUNCTION `horas_trabajadas`(id_empleado INT,fecha date) RETURNS time
BEGIN
	DECLARE horas_trabajadas TIME;
	DECLARE minutos_entrada INT;
    DECLARE horasalida TIME;
	DECLARE horaentrada TIME; 
	DECLARE marca_entrada TIME;
    DECLARE temp INT;
    SET marca_entrada= (SELECT m.marca_entrada
    BEGIN
    FROM empleado e
    JOIN marcas m on m.id_empleado = e.id_empleado
	WHERE m.fecha = fecha and e.id_empleado = id_empleado);
    
    SET minutos_entrada =
    (SELECT MINUTE(m.marca_entrada)
    BEGIN
    FROM empleado e
    JOIN marcas m on m.id_empleado = e.id_empleado
	WHERE m.fecha = fecha and e.id_empleado = id_empleado);
    
    SET horasalida = (
    SELECT he.hora_salida
	FROM marcas m
	inner join horarios_empleados he
	on he.id_empleado = m.id_empleado
	and nombreDia(m.fecha) = he.nombre
	where he.id_empleado = id_empleado and m.fecha= fecha);
    
    SET horaentrada = (
    SELECT he.hora_entrada
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
	
    SET horas_trabajadas=(SELECT TIMEDIFF(sec_to_time(HOUR(m.marca_salida)*3600) , sec_to_time(HOUR(m.marca_entrada)*3600)) 'Horas normales laboradas'
    FROM empleado e
    JOIN marcas m on e.id_empleado = m.id_empleado
    WHERE e.id_empleado = id_empleado and m.fecha = fecha);
    
	IF (SELECT MINUTE(m.marca_salida)
    BEGIN
    FROM empleado e
    JOIN marcas m on m.id_empleado = e.id_empleado
	WHERE m.fecha = fecha and e.id_empleado = id_empleado) < 30 THEN
		SET horas_trabajadas=TIMEDIFF(horas_trabajadas, '01:00:00');
	ELSE IF (minutos_entrada) > 30 and marca_entrada> horaentrada THEN
		SET horas_trabajadas=TIMEDIFF(horas_trabajadas, '01:00:00');
	ELSE
		 SET horas_trabajadas= ADDTIME(horas_trabajadas, '01:00:00');
    END IF;
    END IF;
    
    ELSE
	SET horas_trabajadas=(SELECT TIMEDIFF(he.hora_salida , sec_to_time(HOUR(m.marca_entrada)*3600)) 'Horas normales laboradas'
    FROM marcas m
    JOIN horarios_empleados he on m.id_empleado = he.id_empleado   
	and nombreDia(m.fecha) = he.nombre  
    WHERE m.id_empleado = id_empleado and fecha= m.fecha);
    
    	IF(minutos_entrada) > 30 and marca_entrada > horaentrada THEN
		SET horas_trabajadas=TIMEDIFF(horas_trabajadas, '01:00:00');
	
        END IF;
    
    END IF;
#VERIFICAR SI TRABAJO MAS DE 30 MINUTOS EN LA HORA DE LLEGADA Y EN LA HORA DE SALIDA
	SET horas_trabajadas = sec_to_time(HOUR(horas_trabajadas)*3600);
RETURN horas_trabajadas;
END