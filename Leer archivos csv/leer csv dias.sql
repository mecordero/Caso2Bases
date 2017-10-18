LOAD DATA LOCAL INFILE "C:/Users/Meli/Documents/TEC/2017 2do Sem/Bases 1/Caso 2/Planta 1 - DIAS.csv"
INTO TABLE bd_planta.dias
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(id_dia,nombre,trabajado,hora_entrada,hora_salida,id_calendario);

SELECT * FROM bd_planta.dias;