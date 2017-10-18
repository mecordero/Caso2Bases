LOAD DATA LOCAL INFILE "C:/Users/Meli/Documents/TEC/2017 2do Sem/Bases 1/Caso 2/Planta 1 - EMPLEADO.csv"
INTO TABLE bd_planta.empleado
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(id_empleado,id_planta,nombre,apellidos,fecha_ingreso,fecha_salida,id_supervisor,id_departamento,id_tipo,id_planilla);

SELECT * FROM bd_planta.empleado;


