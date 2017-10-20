DELIMITER $$
CREATE FUNCTION nombreDia(fecha date)
RETURNS varchar(15)
DETERMINISTIC

BEGIN
	DECLARE numDia int;
    DECLARE nombreDia varchar(15);
	SET numDia = DAYOFWEEK(fecha);
	IF numDia = 1
		THEN SET nombreDia = 'Domingo';
	ELSEIF numDia = 2
		THEN SET nombreDia := 'Lunes';
	ELSEIF numDia = 3
		THEN SET nombreDia := 'Martes';
	ELSEIF numDia = 4
		THEN SET nombreDia := 'Miércoles';
	ELSEIF numDia = 5
		THEN SET nombreDia := 'Jueves';
	ELSEIF numDia = 6
		THEN SET nombreDia := 'Viernes';
	ELSEIF numDia = 7
		THEN SET nombreDia := 'Sábado';
	END IF;
    
    RETURN nombreDia;
END$$
DELIMITER ;

