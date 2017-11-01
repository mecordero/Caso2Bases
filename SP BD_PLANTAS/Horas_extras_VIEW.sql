CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `horas_extras` AS
    SELECT 
        `he`.`id_empleado` AS `id_empleado`,
        `m`.`fecha` AS `fecha`,
        TIMEDIFF(`m`.`marca_salida`, `he`.`hora_salida`) AS `Horas_extras`
    FROM
        (`horarios_empleados` `he`
        JOIN `marcas` `m` ON (((`m`.`id_empleado` = `he`.`id_empleado`)
            AND (NOMBREDIA(`m`.`fecha`) = `he`.`nombre`))))
    WHERE
        (`he`.`hora_salida` < `m`.`marca_salida`)