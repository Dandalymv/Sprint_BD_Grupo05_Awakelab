-- MySQL Script generated by MySQL Workbench
-- Tue Oct  5 20:00:52 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Sprint_Final_Grupo05
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Sprint_Final_Grupo05
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Sprint_Final_Grupo05` DEFAULT CHARACTER SET utf8 ;
USE `Sprint_Final_Grupo05` ;

-- -----------------------------------------------------
-- Table `Sprint_Final_Grupo05`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint_Final_Grupo05`.`clientes` (
  `idcliente` INT NOT NULL,
  `nombre` VARCHAR(30) NULL,
  `apellido` VARCHAR(30) NULL,
  `direccion` VARCHAR(50) NULL,
  PRIMARY KEY (`idcliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint_Final_Grupo05`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint_Final_Grupo05`.`categorias` (
  `idcategoria` INT NOT NULL,
  `nombre` VARCHAR(30) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint_Final_Grupo05`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint_Final_Grupo05`.`proveedores` (
  `idproveedor` INT NOT NULL,
  `nombre_repr_leg` VARCHAR(30) NULL,
  `nombre_corp` VARCHAR(30) NULL,
  `telefono1` INT NULL,
  `telefono2` INT NULL,
  `nombre_contacto` VARCHAR(30) NULL,
  `idcategoria` INT NULL,
  `email` VARCHAR(50) NULL,
  PRIMARY KEY (`idproveedor`),
  INDEX `FK_categoria_idx` (`idcategoria` ASC) VISIBLE,
  CONSTRAINT `FK_categoria_prov`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `Sprint_Final_Grupo05`.`categorias` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint_Final_Grupo05`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint_Final_Grupo05`.`productos` (
  `idproducto` INT NOT NULL,
  `nombre_prod` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `idcategoria` INT NOT NULL,
  `color` VARCHAR(20) NULL,
  `stock` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `FK_categoria_idx` (`idcategoria` ASC) VISIBLE,
  CONSTRAINT `FK_categoria_prod`
    FOREIGN KEY (`idcategoria`)
    REFERENCES `Sprint_Final_Grupo05`.`categorias` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sprint_Final_Grupo05`.`producto_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Sprint_Final_Grupo05`.`producto_proveedor` (
  `idproducto` INT NOT NULL,
  `idproveedor` INT NOT NULL,
  PRIMARY KEY (`idproducto`, `idproveedor`),
  INDEX `FK_proveedor_idx` (`idproveedor` ASC) VISIBLE,
  CONSTRAINT `FK_producto`
    FOREIGN KEY (`idproducto`)
    REFERENCES `Sprint_Final_Grupo05`.`productos` (`idproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_proveedor`
    FOREIGN KEY (`idproveedor`)
    REFERENCES `Sprint_Final_Grupo05`.`proveedores` (`idproveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/*Insertar 5 proveedores*/
insert into proveedores (idproveedor, nombre_repr_leg, nombre_corp,email,
telefono1,telefono2,idcategoria,nombre_contacto)
values 
('1', 'Juan Perez', 'Chino Tools', 'maeillanes@hotmail.com','98564589', '58566995', 100, 'Isabel Castillo'),
('2', 'Carlos Silva', 'Makita', 'osabarca@hotmail.com', '98521458', '58566995', 101, 'Lorena Chavez'),
('3', 'Ximena Puga', 'Black&Decker', 'cabrigo@garmendia.cl','89457812', '58566995',102, 'Patricio Estrella'),
('4', 'Pedro Correa', 'Bauker',  'Sb.nashxo.sk8@hotmail.com','45788912', '58566995', 103,'Marcelo Rios'),
('5', 'Juan Correa', 'Stanley', 'jl.nashxo.sk34@hotmail.com','75124578', '58566995', 104, 'Andres Sito')
;
/*Creamos tabla categorias para hacer la relacion*/
insert into categorias (idcategoria, nombre)
values (100, 'frenos'), (101, 'neumaticos'), (102, 'luces'), (103, 'lubricantes'), (104, 'motor');

/*Insertar 5 clientes*/
insert into clientes values 
('1', 'Juan', 'Perez', 'ALAMEDA 530'),
('2', 'Carlos', 'Silva', 'PROVIDENCIA 564' ),
('3', 'Ximena', 'Puga', 'EL GOLF 50'),
('4', 'Pedro', 'Correa',  'RENATO SANCHEZ 434'),
('5', 'juan', 'Correa', 'ISIDORA GOYENECHEA 770');


/*Insertar 10 productos*/
insert into productos values 
(1,'pastillas','60000',100,'negro',10),
(2,'calipers de freno','30000',100,'rosa',15),
(3,'valvulas','120000',100,'dorado',6),
(4,'neumaticos','85000',101,'negro',20),
(5,'foco','70000',102,'negro',8),
(6,'led','100000',102,'azul',30),
(7,'aceite diferencial','40000',103,'negro',50),
(8,'aceite motor','55000',103,'verde',10),
(9,'aceite caja','60000',103,'rojo',10),
(10,'pistones','90000',104,'negro',20)
;

/* - Cuál es la categoría de productos que más se repite. */
select idcategoria, count(*) from productos group by idcategoria limit 1;

/*- Cuáles son los productos con mayor stock*/
select nombre_prod, idproducto, stock from productos 
where stock = (select max(stock) from productos);

select nombre_prod, idproducto, stock 
from productos order by stock desc limit 3;

/*- Qué color de producto es más común en nuestra tienda.*/
select color, count(*) from productos group by color limit 1;

/*- Cual o cuales son los proveedores con menor stock de productos.*/
select nombre_prod, idproducto, stock from productos 
where stock = (select min(stock) from productos);  /*Primero buscamos el producto con menos stock*/
select idproveedor from producto_proveedor where idproducto = 3; /*Identificado el producto, buscamos el id del proveedor*/
select nombre_corp from proveedores where idproveedor in (2,3); /*Acá se responde a la pregunta del enunciado*/

/*- Cambien la categoría de productos más popular por ‘Electrónica y computación’.*/
describe categorias;
select idcategoria, count(*) from productos group by idcategoria limit 1;
update categorias set nombre = 'Electrónica y computación' 
where idcategoria = 100;
select * from categorias;

insert into producto_proveedor 
values (1,1),(2,1),(3,2),(1,3),(1,2),(2,2),(3,3),(4,3),(5,4),(6,4),(7,5),(8,5),(9,5),(10,5);

