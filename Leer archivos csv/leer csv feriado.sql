LOAD DATA LOCAL INFILE "C:/Users/Meli/Documents/TEC/2017 2do Sem/Bases 1/Caso 2/Planta 1 - FERIADO.csv"
INTO TABLE bd_planta.feriado
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(fecha,pagado);

SELECT * FROM bd_planta.feriado;

