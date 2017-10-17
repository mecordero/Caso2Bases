LOAD DATA LOCAL INFILE "C:/Users/Meli/Desktop/Planta 1 - TIPO_EMPLEADO.csv"
INTO TABLE bd_planta.tipo_empleado
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(id_tipo,nombre);

SELECT * FROM bd_planta.tipo_empleado;
