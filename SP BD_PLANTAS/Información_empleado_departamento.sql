CREATE DEFINER=`root`@`localhost` PROCEDURE `Información_empleado_departamento`(IN no_departamento int)
BEGIN
	SELECT e.id_empleado as 'Id empleado' , e.id_planta as 'Planta',  e.nombre as 'Nombre', e.apellidos as 'Apellidos',  e.fecha_ingreso 'Ingreso',
    e.fecha_salida as 'Fecha Salida', a1.nombre as 'Supervisor',   d.nombre as 'Departamento' , te.nombre 'Tipo de empleado'
    FROM empleado e
    join empleado a1 on e.id_supervisor = a1.id_empleado
    join departamento d on d.id_departamento = e.id_departamento
	join tipo_empleado te on te.id_tipo = e.id_tipo 

    WHERE e.id_departamento = no_departamento;
END
