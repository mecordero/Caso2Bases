DELIMITER //
CREATE PROCEDURE dadosDeBaja
(IN FechaInicio date, IN FechaFin date)
BEGIN
  SELECT *
  FROM empleado
  WHERE fecha_salida between FechaInicio and FechaFin;
END //
DELIMITER ;

#CALL dadosDeBaja('2015-07-08','2017-09-08');
