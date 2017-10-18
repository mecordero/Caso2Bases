-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema BD_PLANTA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BD_PLANTA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_PLANTA` DEFAULT CHARACTER SET utf8 ;
USE `BD_PLANTA` ;

-- -----------------------------------------------------
-- Table `BD_PLANTA`.`DEPARTAMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`DEPARTAMENTO` (
  `id_departamento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NULL,
  PRIMARY KEY (`id_departamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`TIPO_EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`TIPO_EMPLEADO` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NULL,
  PRIMARY KEY (`id_tipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`CALENDARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`CALENDARIO` (
  `id_calendario` INT NOT NULL AUTO_INCREMENT,
  `tipo` CHAR(1) NULL,
  `fecha_pago` DATE NULL,
  PRIMARY KEY (`id_calendario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`PLANILLA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`PLANILLA` (
  `id_planilla` INT NOT NULL AUTO_INCREMENT,
  `salario_hora` DECIMAL(19,6) NULL,
  `salario_hora_extra` DECIMAL(19,6) NULL,
  `cantidad_horas_semanal` INT NULL,
  `id_calendario` INT NOT NULL,
  `salario_bruto` DECIMAL(19,6) NULL,
  `salario_neto` DECIMAL(19,6) NULL,
  PRIMARY KEY (`id_planilla`),
  CONSTRAINT `fk_TIPO_EMPLEADO_CALENDARIO1`
    FOREIGN KEY (`id_calendario`)
    REFERENCES `BD_PLANTA`.`CALENDARIO` (`id_calendario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`EMPLEADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`EMPLEADO` (
  `id_empleado` INT NOT NULL AUTO_INCREMENT,
  `id_planta` INT NULL,
  `nombre` VARCHAR(15) NULL,
  `apellidos` VARCHAR(30) NULL,
  `fecha_ingreso` DATE NULL,
  `fecha_salida` DATE NULL,
  `id_supervisor` INT NULL,
  `id_departamento` INT NULL,
  `id_tipo` INT NULL,
  `id_planilla` INT NULL,
  PRIMARY KEY (`id_empleado`),
  CONSTRAINT `fk_EMPLEADO_EMPLEADO1`
    FOREIGN KEY (`id_supervisor`)
    REFERENCES `BD_PLANTA`.`EMPLEADO` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_DEPARTAMENTO1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `BD_PLANTA`.`DEPARTAMENTO` (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_TIPO_EMPLEADO1`
    FOREIGN KEY (`id_tipo`)
    REFERENCES `BD_PLANTA`.`TIPO_EMPLEADO` (`id_tipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLEADO_PLANILLA2`
    FOREIGN KEY (`id_planilla`)
    REFERENCES `BD_PLANTA`.`PLANILLA` (`id_planilla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`DIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`DIAS` (
  `id_dia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(15) NULL,
  `trabajado` CHAR(1) BINARY NULL,
  `hora_entrada` TIME(0) NULL,
  `hora_salida` TIME(0) NULL,
  `id_calendario` INT NOT NULL,
  PRIMARY KEY (`id_dia`),
  CONSTRAINT `fk_DIAS_CALENDARIO1`
    FOREIGN KEY (`id_calendario`)
    REFERENCES `BD_PLANTA`.`CALENDARIO` (`id_calendario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`FERIADO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`FERIADO` (
  `fecha` DATE NOT NULL,
  `pagado` CHAR(1) BINARY NULL,
  PRIMARY KEY (`fecha`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`MARCAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`MARCAS` (
  `id_empleado` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `marca_entrada` TIME(0) NULL,
  `marca_salida` TIME(0) NULL,
  PRIMARY KEY (`id_empleado`, `fecha`),
  CONSTRAINT `fk_MARCAS_EMPLEADO1`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `BD_PLANTA`.`EMPLEADO` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_PLANTA`.`HISTORIAL_PLANILLAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_PLANTA`.`HISTORIAL_PLANILLAS` (
  `id_planilla` INT NOT NULL,
  `fecha` DATE NULL,
  `id_empleado` INT NOT NULL,
  `salario_bruto` DECIMAL(19,6) NULL,
  `salario_neto` DECIMAL(19,6) NULL,
  PRIMARY KEY (`id_planilla`),
  CONSTRAINT `fk_HISTORIAL_PLANILLAS_PLANILLA1`
    FOREIGN KEY (`id_planilla`)
    REFERENCES `BD_PLANTA`.`PLANILLA` (`id_planilla`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_HISTORIAL_PLANILLAS_EMPLEADO2`
    FOREIGN KEY (`id_empleado`)
    REFERENCES `BD_PLANTA`.`EMPLEADO` (`id_empleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;