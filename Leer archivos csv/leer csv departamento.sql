LOAD DATA LOCAL INFILE "C:/Users/Meli/Documents/TEC/2017 2do Sem/Bases 1/Caso 2/Planta 1 - DEPARTAMENTO.csv"
INTO TABLE bd_planta.departamento
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(id_departamento,nombre);

SELECT * FROM bd_planta.departamento;

