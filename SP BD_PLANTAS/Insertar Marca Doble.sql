DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarMarcaDoble`(IN idEmpleado int,IN fechaM date,IN marcaEntrada time,IN marcaSalida time)
BEGIN
	IF 
	(SELECT count(*)
	FROM marcas
	WHERE idEmpleado = id_empleado and fechaM = fecha) = 0
	THEN
	INSERT INTO marcas (id_empleado,fecha,marca_entrada,marca_salida)
	VALUES (idEmpleado, fechaM, marcaEntrada, marcaSalida);
	END IF;
END$$
DELIMITER ;

#CALL `bd_planta`.`insertarMarcaDoble`(2, '2017-08-17', '09:00:00', '12:00:00');
