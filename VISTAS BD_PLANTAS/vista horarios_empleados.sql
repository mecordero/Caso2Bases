
CREATE VIEW horarios_empleados AS 
#vista de empleados con horarios
SELECT e.id_empleado, d.nombre, d.trabajado,d.hora_entrada, d.hora_salida
FROM empleado e
inner join planilla p 
on p.id_planilla = e.id_planilla
inner join dias d
on d.id_calendario = p.id_calendario;


