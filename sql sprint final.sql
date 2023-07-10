-- usuario: user_sprint
-- password: sprint_modulo5

-- MySQL Workbench Forward Engineering


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sprint
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sprint
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sprint` DEFAULT CHARACTER SET utf8mb3 ;
USE `sprint` ;

-- -----------------------------------------------------
-- Table `sprint`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(15) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sprint`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint`.`proveedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre_legal` VARCHAR(45) NOT NULL,
  `nombre_corporativo` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sprint`.`contactos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint`.`contactos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `proveedores_id` INT NOT NULL,
  PRIMARY KEY (`id`, `proveedores_id`),
  INDEX `fk_contactos_proveedores_idx` (`proveedores_id` ASC) VISIBLE,
  CONSTRAINT `fk_contactos_proveedores`
    FOREIGN KEY (`proveedores_id`)
    REFERENCES `sprint`.`proveedores` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sprint`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `precio` INT NOT NULL,
  `stock` INT NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `color` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sprint`.`proveedores_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint`.`proveedores_has_productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_docto` INT NOT NULL,
  `proveedores_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_proveedores_has_productos_productos1_idx` (`productos_id` ASC) VISIBLE,
  INDEX `fk_proveedores_has_productos_proveedores1_idx` (`proveedores_id` ASC) VISIBLE,
  CONSTRAINT `fk_proveedores_has_productos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `sprint`.`productos` (`id`),
  CONSTRAINT `fk_proveedores_has_productos_proveedores1`
    FOREIGN KEY (`proveedores_id`)
    REFERENCES `sprint`.`proveedores` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sprint`.`clientes_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sprint`.`clientes_has_productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_docto` INT NOT NULL,
  `clientes_id` INT NOT NULL,
  `productos_id` INT NOT NULL,
  INDEX `fk_clientes_has_productos_productos1_idx` (`productos_id` ASC) VISIBLE,
  INDEX `fk_clientes_has_productos_clientes1_idx` (`clientes_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_clientes_has_productos_clientes1`
    FOREIGN KEY (`clientes_id`)
    REFERENCES `sprint`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_productos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `sprint`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;







-- Inserción de proveedores
INSERT INTO proveedores (nombre_legal, nombre_corporativo, correo, categoria)
VALUES
    ('Juan Pérez', 'ElectroCorp', 'juanperez@example.com', 'Electrónica'),
    ('María Gómez', 'FashionStyle', 'mariagomez@example.com', 'Moda'),
    ('Carlos Rodríguez', 'HogarIdeal', 'carlosrodriguez@example.com', 'Hogar y Decoración'),
    ('Ana Martínez', 'SportFit', 'anamartinez@example.com', 'Deportes y Fitness'),
    ('Luis Sánchez', 'AlimentosDeliciosos', 'luissanchez@example.com', 'Alimentación');

-- Inserción de contactos
INSERT INTO `sprint`.`contactos` (`nombre`, `telefono`, `proveedores_id`) VALUES
('Juan Pérez', '+56912345678', 1),
('María Gómez', '+56923456789', 1),
('Pedro Rodríguez', '+56934567890', 2),
('Carolina López', '+56945678901', 3),
('Luis Torres', '+56956789012', 4),
('Ana Martínez', '+56967890123', 4),
('Diego Herrera', '+56978901234', 4),
('Valentina Silva', '+56989012345', 5);


-- Inserción de clientes
INSERT INTO `sprint`.`clientes` (`nombre`, `apellido`, `direccion`) VALUES
('Alejandra', 'González', 'Calle 123'),
('Juan', 'López', 'Avenida Principal 456'),
('María', 'Rodríguez', 'Calle Secundaria 789'),
('Pedro', 'Fernández', 'Avenida Central 101'),
('Carolina', 'Torres', 'Calle Principal 234');

INSERT INTO productos (nombre, precio, stock, categoria, color)
VALUES
    ('iPhone 13 Pro', 1299, 20, 'Teléfonos móviles', 'Gris grafito'),
    ('MacBook Pro 2022', 1999, 15, 'Laptops', 'Plata'),
    ('Samsung QLED 4K', 1199, 10, 'Televisores', 'Negro'),
    ('Canon EOS R5', 3499, 8, 'Cámaras digitales', 'Negro'),
    ('AirPods Pro', 249, 30, 'Accesorios de audio', 'Blanco'),
    ('iPad Pro', 999, 18, 'Tabletas', 'Gris espacial'),
    ('Bose SoundLink Revolve+', 299, 12, 'Altavoces Bluetooth', 'Negro'),
    ('Apple Watch Series 7', 399, 25, 'Smartwatches', 'Azul eléctrico'),
    ('PlayStation 5', 499, 5, 'Consolas de videojuegos', 'Blanco'),
    ('Epson EcoTank ET-4760', 499, 7, 'Impresoras', 'Negro'),
    ('iPhone 14 Pro', 1599, 5, 'Teléfonos móviles', 'Gris grafito');


-- Inserción de datos en la tabla "proveedores_has_productos"
INSERT INTO `sprint`.`proveedores_has_productos` (`numero_docto`, `proveedores_id`, `productos_id`) VALUES
(12345, 1, 1),
(23456, 2, 2),
(34567, 3, 3),
(45678, 4, 4),
(56789, 5, 5),
(67890, 1, 6),
(78901, 2, 7),
(89012, 3, 8),
(90123, 4, 9),
(12345, 5, 11);

-- Inserción de datos en la tabla "clientes_has_productos"
INSERT INTO `sprint`.`clientes_has_productos` (`numero_docto`, `clientes_id`, `productos_id`) VALUES
(54321, 1, 1),
(65432, 2, 2),
(76543, 3, 3),
(87654, 4, 4),
(98765, 5, 5),
(09876, 1, 6),
(10987, 2, 7),
(21098, 3, 8),
(32109, 4, 9),
(43210, 5, 10);



-- SQL Querys

-- Cuál es la categoría de productos que más se repite.
SELECT categoria, COUNT(*) AS repeticiones
FROM productos
GROUP BY categoria
ORDER BY repeticiones DESC
LIMIT 1;


-- Cuáles son los productos con mayor stock
SELECT *
FROM productos
ORDER BY stock DESC
LIMIT 5;

-- Qué color de producto es más común en nuestra tienda.
SELECT color, COUNT(*) AS cantidad
FROM productos
GROUP BY color
ORDER BY cantidad DESC
LIMIT 1;


-- Cual o cuales son los proveedores con menor stock de productos.
SELECT p.id, p.nombre_corporativo, (
    SELECT SUM(stock)
    FROM productos
    WHERE id IN (
        SELECT productos_id
        FROM proveedores_has_productos
        WHERE proveedores_id = p.id
    )
) AS total_stock
FROM proveedores p
ORDER BY total_stock ASC
LIMIT 1;


-- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
UPDATE productos
SET categoria = 'Electrónica y computación'
WHERE id = (
    SELECT productos_id
    FROM (
        SELECT productos_id, COUNT(*) AS cantidad
        FROM clientes_has_productos
        GROUP BY productos_id
        ORDER BY cantidad DESC
        LIMIT 1
    ) AS subquery
);