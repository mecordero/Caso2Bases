DELIMITER $$
CREATE  PROCEDURE insertarMarca(IN idEmpleado int,IN fechaM date,IN marca time,IN tipo char)
BEGIN
	IF (tipo) = 'E'
    THEN
		IF 
		(SELECT count(*)
		FROM marcas
		WHERE idEmpleado = id_empleado and fechaM = fecha) = 0
		THEN
		INSERT INTO marcas (id_empleado,fecha,marca_entrada)
		VALUES (idEmpleado, fechaM, marca);
		END IF;
	ELSEIF (tipo) = 'S'
    THEN
		IF 
		(SELECT count(*)
		FROM marcas m
		WHERE m.id_empleado = idEmpleado and m.fecha = fechaM and marca_salida is NULL) = 1
        THEN 
        UPDATE marcas m
        SET marca_salida = marca
        WHERE m.id_empleado = idEmpleado and m.fecha = fechaM and marca_salida is NULL;
        END IF;
	END IF;
END$$
DELIMITER ;

#CALL `bd_planta`.`insertarMarca`(3, '2017-10-27', '21:00:00', 'S');

