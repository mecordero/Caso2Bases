DELIMITER $$
CREATE PROCEDURE empleados_de_supervisor(IN IdSupervisor int)
BEGIN
SELECT e.id_empleado, e.nombre, e.apellidos
FROM empleado e
where e.id_supervisor = IdSupervisor;
END$$
DELIMITER ;
