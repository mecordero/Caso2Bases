DELIMITER //
CREATE PROCEDURE dadosDeBaja
(IN FechaInicio date, IN FechaFin date)
BEGIN
  SELECT e.id_empleado, e.nombre, e.apellidos, e.fecha_salida
  FROM empleado e
  WHERE fecha_salida  IS NOT NULL AND fecha_salida between FechaInicio and FechaFin;
END //
DELIMITER ;

#CALL dadosDeBaja('2015-07-08','2017-09-08');
