DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarMarca`(IN idEmpleado int,OUT resultado int,IN fechaM date,IN marca time,IN tipo int)
BEGIN
	IF (tipo) = 1
    THEN
		IF 
		(SELECT count(*)
		FROM marcas
		WHERE idEmpleado = id_empleado and fechaM = fecha) = 0
		THEN
		INSERT INTO marcas (id_empleado,fecha,marca_entrada)
		VALUES (idEmpleado, fechaM, marca);
        SET resultado = 1;
		END IF;
	ELSEIF (tipo) = 2
    THEN
		IF 
		(SELECT count(*)
		FROM marcas m
		WHERE m.id_empleado = idEmpleado and m.fecha = fechaM and marca_salida is NULL) = 1
        THEN 
        UPDATE marcas m
        SET marca_salida = marca
        WHERE m.id_empleado = idEmpleado and m.fecha = fechaM and marca_salida is NULL;
        SET resultado = 1;
        END IF;
	END IF;
END$$
DELIMITER ;
