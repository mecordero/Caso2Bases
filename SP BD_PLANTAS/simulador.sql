DELIMITER $$
CREATE PROCEDURE simuladorMarcas(IN FechaInicio date, IN FechaFin date, 
IN probAusencia int,IN probExtra int, IN probTarde int)
BEGIN
SET @fechaloop := FechaInicio;
WHILE @fechaloop <= FechaFin DO
	IF (#Si no es es un feriado no pagado
    SELECT count(*)
    FROM feriado f
    WHERE f.fecha = @fechaloop and f.pagado = 'N'
    ) = 0
    THEN
		CALL simuladorMarcasUnDia(@fechaloop, probAusencia, probExtra, probTarde);
	END IF;
    SET @fechaloop = @fechaloop + INTERVAL 1 DAY;
END WHILE;
END$$
DELIMITER ;