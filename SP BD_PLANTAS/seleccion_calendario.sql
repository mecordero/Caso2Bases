CREATE DEFINER=`root`@`localhost` PROCEDURE `seleccion_calendario`(IN tipo_calendario INT,IN supervisor INT)
BEGIN
	SELECT e.id_empleado, e.id_supervisor,e.id_tipo,e.id_planilla,
    p.salario_hora,p.id_calendario,p.salario_hora_extra,p.cantidad_horas_semanal,p.salario_bruto,
    p.salario_neto
    FROM empleado e
    JOIN planilla p on e.id_planilla = p.id_planilla
    JOIN calendario c on p.id_calendario = c.id_calendario
    WHERE c.id_calendario = tipo_calendario and 
		  e.id_supervisor = supervisor
	;
END
