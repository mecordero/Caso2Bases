DELIMITER $$
CREATE PROCEDURE simuladorMarcasUnDia(IN Fecha date, 
IN probAusencia int,IN probExtra int, IN probTarde int)
BEGIN

#variables
DECLARE id int;
DECLARE ID_calendario int;
DECLARE trabajado char;
DECLARE entrada time;
DECLARE salida time;

DECLARE done INT DEFAULT FALSE;

#cursor
DECLARE myCursor CURSOR FOR 
	SELECT t.id_empleado, t.id_calendario, t.trabajado, t.hora_entrada, t.hora_salida
    FROM Temporal t;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

IF (#Si no es es un feriado no pagado
    SELECT count(*)
    FROM feriado f
    WHERE f.fecha = Fecha and f.pagado = 'N'
    ) = 0
THEN

CREATE TEMPORARY TABLE IF NOT EXISTS Temporal AS
(SELECT e.id_empleado, c.id_calendario, d.trabajado, d.hora_entrada, d.hora_salida
FROM empleado e
inner join planilla p
on p.id_planilla = e.id_planilla
inner join calendario c
on c.id_calendario = p.id_calendario
inner join dias d
on d.id_calendario = c.id_calendario
   and nombreDia(Fecha) = d.nombre);

#abrir cursor
OPEN myCursor;

employee_loop: LOOP
	FETCH myCursor INTO id, ID_calendario, trabajado, entrada, salida;
    IF done THEN
	  CLOSE myCursor;
      LEAVE employee_loop;
    END IF;
    #aqui codigo del empleado
    
    #verifica si el dia es laboral para ese empleado
    SET @nombreDia = nombreDia(Fecha);
	IF (trabajado) = 'Y'
	THEN 
    
    #verifica si va a aisistir o no
    SET @aus = FLOOR(RAND() * (100));
	IF(@aus) > probAusencia
	THEN #No falta
    
    #minutos tarde
    SET @tar = FLOOR(RAND() * 100);
	IF (@tar)<probTarde THEN
		SET @tar = FLOOR(RAND() * 40) + 10;
	ELSE 
		SET @tar = 0;
	END IF;
	
    #minutos extra
    SET @ext = FLOOR(RAND() * 100);
	IF (@ext)<probExtra THEN
		SET @ext = FLOOR(RAND() * 150) + 30;
	ELSE
		SET @ext = 0;
	END IF;
    
    #inserta la marca
	CALL insertarMarcaDoble(id, Fecha, entrada+ INTERVAL @tar MINUTE, salida+ INTERVAL @ext MINUTE);
    
    END IF;
    END IF;
    
    
END LOOP;
END IF;
DROP TABLE Temporal;
END$$
DELIMITER ;
