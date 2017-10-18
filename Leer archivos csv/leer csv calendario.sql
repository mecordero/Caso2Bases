LOAD DATA LOCAL INFILE "C:/Users/Meli/Documents/TEC/2017 2do Sem/Bases 1/Caso 2/Planta 1 - CALENDARIO.csv"
INTO TABLE bd_planta.calendario
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(id_calendario,tipo,fecha_pago);

SELECT * FROM bd_planta.calendario;