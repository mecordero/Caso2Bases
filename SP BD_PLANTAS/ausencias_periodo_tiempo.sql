DELIMITER $$
CREATE PROCEDURE ausencias_periodo_tiempo(IN FechaInicio date, IN FechaFin date)
BEGIN
#necesito la tabla de fechas de inicio a fin

CREATE TEMPORARY TABLE IF NOT EXISTS Fechas (fecha date);


SET @fechaloop := FechaInicio;
WHILE @fechaloop <= FechaFin DO 
	#si no es un dia feriado
	IF(SELECT COUNT(*)
		FROM feriado f
        where f.fecha = @fechaloop) = 0
	THEN
		INSERT INTO Fechas values (@fechaloop);
    END IF;
	SET @fechaloop = @fechaloop + INTERVAL 1 DAY;
END WHILE;

select he.id_empleado, count(*)
from Fechas f
inner join horarios_empleados he
on he.nombre = nombreDia(f.fecha)
left join marcas m
on m.fecha = f.fecha 
and m.id_empleado = he.id_empleado
where he.trabajado = 'Y'
and m.id_empleado is NULL
group by he.id_empleado;
drop table Fechas;
END$$
DELIMITER ;

CALL ausencias_periodo_tiempo('2017-01-01','2017-8-31');