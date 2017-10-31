CREATE DEFINER=`root`@`localhost` FUNCTION `Planillas`(id_empleado INT) RETURNS int(11)
BEGIN
	DECLARE fecha_pago DATE; DECLARE dias DATE; DECLARE horas TIME;DECLARE horas_extras TIME;
	DECLARE salario_bruto decimal(19,6);DECLARE salario_hora decimal(19,6);DECLARE obligaciones decimal(19,6);
    DECLARE salario_neto decimal(19,6);DECLARE salario_hora_extra decimal(19,6);
    DECLARE horas_dobles int;
    
    SET fecha_pago= (SELECT c.fecha_pago
	FROM empleado e
	JOIN planilla p on e.id_planilla = p.id_planilla
	JOIN calendario c on c.id_calendario = p.id_calendario
	WHERE id_empleado = e.id_empleado);
	SET horas='00:00:00';
	
    IF (tipo(id_empleado))='S' THEN
    SET dias= (date_sub(fecha_pago, INTERVAL 8 DAY));
    WHILE fecha_pago >= dias 
    DO
     	SET horas =  ADDTIME(horas,COALESCE(horas_trabajadas(id_empleado,dias),0)) ;
		SET dias = dias + INTERVAL 1 DAY;
	END WHILE;
    
    ELSE IF(tipo(id_empleado))='Q' THEN
	SET dias= (date_sub(fecha_pago, INTERVAL 15 DAY));
	WHILE fecha_pago >= dias 
    DO
     	SET horas =  ADDTIME(horas,COALESCE(horas_trabajadas(id_empleado,dias),0)) ;
		SET dias = dias + INTERVAL 1 DAY;
	END WHILE;
    
    ELSE 
	SET dias= (date_sub(fecha_pago, INTERVAL 30 DAY));
	WHILE fecha_pago >= dias 
    DO
     	SET horas =  ADDTIME(horas,COALESCE(horas_trabajadas(id_empleado,dias),0)) ;
		SET dias = dias + INTERVAL 1 DAY;
	END WHILE;
    END IF;
    END IF;
#el monto total de horas laboradas por el pago que se hace por hora (salario bruto)
    SET salario_hora =(
    SELECT p.salario_hora
    FROM empleado e
    JOIN planilla p on p.id_planilla = e.id_planilla
    WHERE e.id_empleado = id_empleado);
    
    SET salario_hora_extra = (
    SELECT p.salario_hora_extra
    FROM empleado e
    JOIN planilla p on p.id_planilla = e.id_planilla
    WHERE e.id_empleado = id_empleado);
    
#Horas_extras   
	SET horas_extras = (SELECT SUM(he.Horas_extras)
						FROM horas_extras he
						WHERE id_empleado= he.id_empleado
                        and he.fecha between dias -INTERVAL 1 DAY and fecha_pago+ INTERVAL 1 DAY
                        GROUP BY he.id_empleado);
	SET horas_dobles  = (
    SELECT count(fp.fecha)
    FROM feriados_pagados fp
    WHERE id_empleado=fp.id_empleado 
    and fp.fecha between dias -INTERVAL 1 DAY and fecha_pago+ INTERVAL 1 DAY
    group by fp.id_empleado) ;
    
	SET salario_bruto = (SELECT HOUR(horas) * salario_hora+ (SELECT HOUR(horas_extras) * salario_hora_extra));
#(salario bruto), menos el 9,17% PREGUNTAR de obligaciones sociales (Obligaciones)
# y el resultado de la resta de estos rubros (Salario neto).
	SET obligaciones = (SELECT HOUR(horas) * (9.17));
	SET salario_neto = salario_bruto - obligaciones;

    
RETURN horas_dobles;
END