CREATE DEFINER=`root`@`localhost` PROCEDURE `feriados_trabajados_pagados`(IN id_empleado int)
BEGIN
	SELECT m.fecha
    FROM marcas m
    JOIN feriado f on f.fecha= m.fecha
    WHERE m.id_empleado = id_empleado and f.pagado = 'Y';
END