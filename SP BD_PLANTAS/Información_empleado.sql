CREATE DEFINER=`root`@`localhost` PROCEDURE `Información_empleado`(IN no_departamento int)
BEGIN
    SELECT * 
    FROM empleado e
    INNER JOIN departamento d on d.id_departamento = e.id_departamento
    WHERE d.id_departamento = no_departamento;
END