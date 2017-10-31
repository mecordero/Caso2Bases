CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `feriados_pagados` AS
    SELECT 
        `m`.`fecha` AS `fecha`, `m`.`id_empleado` AS `id_empleado`
    FROM
        (`marcas` `m`
        JOIN `feriado` `f` ON ((`f`.`fecha` = `m`.`fecha`)))
    WHERE
        (`f`.`pagado` = 'Y')