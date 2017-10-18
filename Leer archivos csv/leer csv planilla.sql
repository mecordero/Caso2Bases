LOAD DATA LOCAL INFILE "C:/Users/Meli/Documents/TEC/2017 2do Sem/Bases 1/Caso 2/Planta 1 - PLANILLA.csv"
INTO TABLE bd_planta.planilla
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(id_planilla,salario_hora,salario_hora_extra,cantidad_horas_semanal,id_calendario,salario_bruto,salario_neto);

SELECT * FROM bd_planta.planilla;