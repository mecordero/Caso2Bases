CREATE DEFINER=`root`@`localhost` PROCEDURE `aprob_horas_extras`(IN id_empleados int,IN fecha date ,IN aprob char, IN correccion time)
BEGIN
	IF(aprob = 'N' and (Select id_empleado from horas_extras WHERE id_empleados =id_empleado)  is not null) THEN
		UPDATE marcas m 
		SET m.marca_salida= correccion
		WHERE m.id_empleado = id_empleados
			  and m.fecha = fecha ;
END IF;
END