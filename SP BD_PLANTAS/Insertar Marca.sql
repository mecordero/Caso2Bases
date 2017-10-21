DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarMarca`(IN idEmpleado int,OUT resultado int,IN fechaM date,IN marca time,IN tipo int)
BEGIN
	DECLARE nombre_dia varchar(15);
    SET nombre_dia = nombreDia(fechaM);
    IF (SELECT d.trabajado FROM empleado e 
		INNER JOIN planilla p on p.id_planilla = e.id_planilla
        INNER JOIN dias d on d.id_calendario = p.id_calendario
        WHERE d.nombre = nombre_dia AND e.id_empleado = idEmpleado) = 'N' THEN 
		SET resultado = 0;
	ELSEIF (tipo) = 1 THEN
		IF (SELECT count(*) FROM feriado f WHERE fechaM = f.fecha) = 0
        OR (SELECT f.pagado FROM feriado f WHERE fechaM = f.fecha) = 'Y'
        AND (SELECT count(*) FROM marcas WHERE idEmpleado = id_empleado and fechaM = fecha) = 0 THEN 
			INSERT INTO marcas (id_empleado,fecha,marca_entrada)
			VALUES (idEmpleado, fechaM, marca);
			SET resultado = 1;
		END IF;
	ELSEIF (tipo) = 2 THEN
		IF (SELECT count(*) FROM marcas m WHERE m.id_empleado = idEmpleado and 
        m.fecha = fechaM and marca_salida is NULL) = 1 THEN 
			UPDATE marcas m
			SET marca_salida = marca
			WHERE m.id_empleado = idEmpleado and m.fecha = fechaM and marca_salida is NULL;
			SET resultado = 1;
        END IF;
	END IF;
END$$
DELIMITER ;