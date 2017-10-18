DELIMITER $$
CREATE PROCEDURE simuladorMarcas(IN FechaInicio date, IN FechaFin date)
BEGIN
SET @fechaloop := FechaInicio;
WHILE @fechaloop <= FechaFin DO

	IF (#Si no es es un feriado no pagado
    SELECT count(*)
    FROM feriado
    WHERE fecha = @fechaloop and pagado = 'N'
    ) = 0
    THEN #entonces se insertan todas las marcas de los trabajadores
    INSERT INTO marcas
    SELECT e.id_empleado, @fechaloop, '09:00:00', '12:00:00'
    FROM empleado e
    WHERE e.id_empleado <> -1;
    END IF;
    SET @fechaloop = @fechaloop + INTERVAL 1 DAY;
END WHILE;
END$$
DELIMITER ;

CALL `bd_planta`.`simuladorMarcas`('2017-01-01', '2017-01-10');
select * FROM marcas;

#delete from marcas;