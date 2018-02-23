SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ListaSufixo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`ListaSufixo` (
  `idListaSufixo` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`idListaSufixo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ListaGrupo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`ListaGrupo` (
  `idListaGrupo` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(20) NOT NULL ,
  PRIMARY KEY (`idListaGrupo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entidade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Entidade` (
  `idEntidade` INT NOT NULL AUTO_INCREMENT ,
  `IdListaGrupo_Entidade` INT NOT NULL ,
  `IdListaSufixo_Entidade` INT NOT NULL ,
  `primeiroNome` VARCHAR(50) NOT NULL ,
  `sobreNome` VARCHAR(50) NULL ,
  `ultimoNome` VARCHAR(50) NULL ,
  `apelido` VARCHAR(50) NULL ,
  `website` VARCHAR(200) NULL ,
  `flagEntidadeJuridica` BIT NOT NULL ,
  PRIMARY KEY (`idEntidade`) ,
  INDEX `IdListaSufixo_idx` (`IdListaSufixo_Entidade` ASC) ,
  INDEX `IdListaGrupo_idx` (`IdListaGrupo_Entidade` ASC) ,
  CONSTRAINT `IdListaSufixo`
    FOREIGN KEY (`IdListaSufixo_Entidade` )
    REFERENCES `mydb`.`ListaSufixo` (`idListaSufixo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdListaGrupo`
    FOREIGN KEY (`IdListaGrupo_Entidade` )
    REFERENCES `mydb`.`ListaGrupo` (`idListaGrupo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Estado` (
  `idEstado` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`idEstado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cidade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Cidade` (
  `idCidade` INT NOT NULL AUTO_INCREMENT ,
  `idEstado` INT NULL ,
  `nome` VARCHAR(50) NULL ,
  PRIMARY KEY (`idCidade`) ,
  INDEX `idEstado_idx` (`idEstado` ASC) ,
  CONSTRAINT `idEstado`
    FOREIGN KEY (`idEstado` )
    REFERENCES `mydb`.`Estado` (`idEstado` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereco`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Endereco` (
  `idEndereco` INT NOT NULL AUTO_INCREMENT ,
  `idEntidade_Endereco` INT NOT NULL ,
  `idCidade_Endereco` INT NOT NULL ,
  `rua` VARCHAR(200) NOT NULL ,
  `numero` INT NOT NULL ,
  `complemento` VARCHAR(15) NOT NULL ,
  `bairro` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`idEndereco`) ,
  INDEX `idEntidade_idx` (`idEntidade_Endereco` ASC) ,
  INDEX `idCidade_idx` (`idCidade_Endereco` ASC) ,
  CONSTRAINT `idEntidade`
    FOREIGN KEY (`idEntidade_Endereco` )
    REFERENCES `mydb`.`Entidade` (`idEntidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCidade`
    FOREIGN KEY (`idCidade_Endereco` )
    REFERENCES `mydb`.`Cidade` (`idCidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ListaTipoTelefone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`ListaTipoTelefone` (
  `idListaTipoTelefone` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(30) NOT NULL ,
  PRIMARY KEY (`idListaTipoTelefone`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefone`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Telefone` (
  `idTelefone` INT NOT NULL AUTO_INCREMENT ,
  `idEntidade_Telefone` INT NOT NULL ,
  `idListaTipoTelefone_Telefone` INT NOT NULL ,
  `numero` VARCHAR(10) NOT NULL ,
  `ddd` VARCHAR(3) NOT NULL ,
  PRIMARY KEY (`idTelefone`) ,
  INDEX `idEntidade_idx` (`idEntidade_Telefone` ASC) ,
  INDEX `idListaTipoTelefone_idx` (`idListaTipoTelefone_Telefone` ASC) ,
  CONSTRAINT `idEntidade_Telefone`
    FOREIGN KEY (`idEntidade_Telefone` )
    REFERENCES `mydb`.`Entidade` (`idEntidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idListaTipoTelefone_Telefone`
    FOREIGN KEY (`idListaTipoTelefone_Telefone` )
    REFERENCES `mydb`.`ListaTipoTelefone` (`idListaTipoTelefone` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Email`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `mydb`.`Email` (
  `idEmail` INT NOT NULL ,
  `idEntidade_Email` INT NOT NULL ,
  `endereco` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`idEmail`) ,
  INDEX `idEntidade_idx` (`idEntidade_Email` ASC) ,
  CONSTRAINT `idEntidade_Email`
    FOREIGN KEY (`idEntidade_Email` )
    REFERENCES `mydb`.`Entidade` (`idEntidade` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
