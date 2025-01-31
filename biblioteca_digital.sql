-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para biblioteca_digital
DROP DATABASE IF EXISTS `biblioteca_digital`;
CREATE DATABASE IF NOT EXISTS `biblioteca_digital` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `biblioteca_digital`;

-- Volcando estructura para tabla biblioteca_digital.autores
DROP TABLE IF EXISTS `autores`;
CREATE TABLE IF NOT EXISTS `autores` (
  `id_autor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `nacionalidad` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.autores: ~3 rows (aproximadamente)
DELETE FROM `autores`;
INSERT INTO `autores` (`id_autor`, `nombre`, `nacionalidad`) VALUES
	(1, 'Gabriel García Márquez', 'Colombiano'),
	(2, 'Isaac Newton', 'Inglés'),
	(3, 'Leonardo da Vinci', 'Italiano');

-- Volcando estructura para tabla biblioteca_digital.categorias
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE IF NOT EXISTS `categorias` (
  `id_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_categoria`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.categorias: ~5 rows (aproximadamente)
DELETE FROM `categorias`;
INSERT INTO `categorias` (`id_categoria`, `nombre`) VALUES
	(5, 'Arte'),
	(2, 'Ciencia'),
	(1, 'Ficción'),
	(3, 'Historia'),
	(4, 'Tecnología');

-- Volcando estructura para tabla biblioteca_digital.detalles_prestamos
DROP TABLE IF EXISTS `detalles_prestamos`;
CREATE TABLE IF NOT EXISTS `detalles_prestamos` (
  `id_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `id_prestamo` int(11) NOT NULL,
  `id_libro` int(11) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_prestamo` (`id_prestamo`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `detalles_prestamos_ibfk_1` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamos` (`id_prestamo`) ON DELETE CASCADE,
  CONSTRAINT `detalles_prestamos_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.detalles_prestamos: ~2 rows (aproximadamente)
DELETE FROM `detalles_prestamos`;
INSERT INTO `detalles_prestamos` (`id_detalle`, `id_prestamo`, `id_libro`) VALUES
	(1, 1, 1),
	(2, 2, 3);

-- Volcando estructura para tabla biblioteca_digital.editoriales
DROP TABLE IF EXISTS `editoriales`;
CREATE TABLE IF NOT EXISTS `editoriales` (
  `id_editorial` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  PRIMARY KEY (`id_editorial`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.editoriales: ~3 rows (aproximadamente)
DELETE FROM `editoriales`;
INSERT INTO `editoriales` (`id_editorial`, `nombre`) VALUES
	(3, 'Editorial Planeta'),
	(2, 'HarperCollins'),
	(1, 'Penguin Random House');

-- Volcando estructura para tabla biblioteca_digital.favoritos
DROP TABLE IF EXISTS `favoritos`;
CREATE TABLE IF NOT EXISTS `favoritos` (
  `id_usuario` int(11) NOT NULL,
  `id_libro` int(11) NOT NULL,
  PRIMARY KEY (`id_usuario`,`id_libro`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `favoritos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `favoritos_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.favoritos: ~0 rows (aproximadamente)
DELETE FROM `favoritos`;

-- Volcando estructura para tabla biblioteca_digital.historial_lecturas
DROP TABLE IF EXISTS `historial_lecturas`;
CREATE TABLE IF NOT EXISTS `historial_lecturas` (
  `id_historial` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_libro` int(11) NOT NULL,
  `fecha_lectura` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_historial`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `historial_lecturas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `historial_lecturas_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.historial_lecturas: ~0 rows (aproximadamente)
DELETE FROM `historial_lecturas`;

-- Volcando estructura para tabla biblioteca_digital.libros
DROP TABLE IF EXISTS `libros`;
CREATE TABLE IF NOT EXISTS `libros` (
  `id_libro` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(255) NOT NULL,
  `id_editorial` int(11) DEFAULT NULL,
  `año_publicacion` year(4) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `cantidad_disponible` int(11) DEFAULT 1,
  `url_pdf` varchar(255) DEFAULT NULL,
  `url_portada` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_libro`),
  UNIQUE KEY `isbn` (`isbn`),
  KEY `id_editorial` (`id_editorial`),
  CONSTRAINT `libros_ibfk_1` FOREIGN KEY (`id_editorial`) REFERENCES `editoriales` (`id_editorial`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.libros: ~3 rows (aproximadamente)
DELETE FROM `libros`;
INSERT INTO `libros` (`id_libro`, `titulo`, `id_editorial`, `año_publicacion`, `isbn`, `descripcion`, `cantidad_disponible`, `url_pdf`, `url_portada`) VALUES
	(1, 'Cien años de soledad', 1, '1967', '9780307474728', NULL, 5, NULL, NULL),
	(2, 'Principia Mathematica', 2, '0000', '9780262510879', NULL, 2, NULL, NULL),
	(3, 'El Código Da Vinci', 3, '2003', '9780307474278', NULL, 4, NULL, NULL);

-- Volcando estructura para tabla biblioteca_digital.libros_autores
DROP TABLE IF EXISTS `libros_autores`;
CREATE TABLE IF NOT EXISTS `libros_autores` (
  `id_libro` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL,
  PRIMARY KEY (`id_libro`,`id_autor`),
  KEY `id_autor` (`id_autor`),
  CONSTRAINT `libros_autores_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON DELETE CASCADE,
  CONSTRAINT `libros_autores_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autores` (`id_autor`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.libros_autores: ~3 rows (aproximadamente)
DELETE FROM `libros_autores`;
INSERT INTO `libros_autores` (`id_libro`, `id_autor`) VALUES
	(1, 1),
	(2, 2),
	(3, 3);

-- Volcando estructura para tabla biblioteca_digital.libros_categorias
DROP TABLE IF EXISTS `libros_categorias`;
CREATE TABLE IF NOT EXISTS `libros_categorias` (
  `id_libro` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  PRIMARY KEY (`id_libro`,`id_categoria`),
  KEY `id_categoria` (`id_categoria`),
  CONSTRAINT `libros_categorias_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON DELETE CASCADE,
  CONSTRAINT `libros_categorias_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.libros_categorias: ~3 rows (aproximadamente)
DELETE FROM `libros_categorias`;
INSERT INTO `libros_categorias` (`id_libro`, `id_categoria`) VALUES
	(1, 1),
	(2, 2),
	(3, 5);

-- Volcando estructura para tabla biblioteca_digital.metodos_pago
DROP TABLE IF EXISTS `metodos_pago`;
CREATE TABLE IF NOT EXISTS `metodos_pago` (
  `id_metodo_pago` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_metodo_pago`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.metodos_pago: ~0 rows (aproximadamente)
DELETE FROM `metodos_pago`;

-- Volcando estructura para tabla biblioteca_digital.multas
DROP TABLE IF EXISTS `multas`;
CREATE TABLE IF NOT EXISTS `multas` (
  `id_multa` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `estado` enum('pendiente','pagado') DEFAULT 'pendiente',
  PRIMARY KEY (`id_multa`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `multas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.multas: ~0 rows (aproximadamente)
DELETE FROM `multas`;

-- Volcando estructura para tabla biblioteca_digital.prestamos
DROP TABLE IF EXISTS `prestamos`;
CREATE TABLE IF NOT EXISTS `prestamos` (
  `id_prestamo` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `fecha_prestamo` date DEFAULT curdate(),
  `fecha_devolucion` date NOT NULL,
  `estado` enum('activo','devuelto','vencido') DEFAULT 'activo',
  PRIMARY KEY (`id_prestamo`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `prestamos_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.prestamos: ~2 rows (aproximadamente)
DELETE FROM `prestamos`;
INSERT INTO `prestamos` (`id_prestamo`, `id_usuario`, `fecha_prestamo`, `fecha_devolucion`, `estado`) VALUES
	(1, 3, '2025-01-31', '2024-02-15', 'activo'),
	(2, 2, '2025-01-31', '2024-02-10', 'activo');

-- Volcando estructura para tabla biblioteca_digital.reseñas
DROP TABLE IF EXISTS `reseñas`;
CREATE TABLE IF NOT EXISTS `reseñas` (
  `id_reseña` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_libro` int(11) NOT NULL,
  `calificacion` int(11) DEFAULT NULL CHECK (`calificacion` between 1 and 5),
  `comentario` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_reseña`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_libro` (`id_libro`),
  CONSTRAINT `reseñas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  CONSTRAINT `reseñas_ibfk_2` FOREIGN KEY (`id_libro`) REFERENCES `libros` (`id_libro`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.reseñas: ~0 rows (aproximadamente)
DELETE FROM `reseñas`;

-- Volcando estructura para tabla biblioteca_digital.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.roles: ~3 rows (aproximadamente)
DELETE FROM `roles`;
INSERT INTO `roles` (`id_rol`, `nombre`) VALUES
	(1, 'Administrador'),
	(2, 'Bibliotecario'),
	(3, 'Lector');

-- Volcando estructura para tabla biblioteca_digital.usuarios
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `email` (`email`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla biblioteca_digital.usuarios: ~3 rows (aproximadamente)
DELETE FROM `usuarios`;
INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `contraseña`, `id_rol`, `estado`) VALUES
	(1, 'Juan Pérez', 'juan@email.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 1, 'activo'),
	(2, 'María Gómez', 'maria@email.com', 'c6ba91b90d922e159893f46c387e5dc1b3dc5c101a5a4522f03b987177a24a91', 2, 'activo'),
	(3, 'Carlos Ruiz', 'carlos@email.com', '5efc2b017da4f7736d192a74dde5891369e0685d4d38f2a455b6fcdab282df9c', 3, 'activo');

-- Volcando estructura para vista biblioteca_digital.vista_historial_prestamos
DROP VIEW IF EXISTS `vista_historial_prestamos`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_historial_prestamos` (
	`usuario` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`libro` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`fecha_prestamo` DATE NULL,
	`fecha_devolucion` DATE NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista biblioteca_digital.vista_libros_disponibles
DROP VIEW IF EXISTS `vista_libros_disponibles`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_libros_disponibles` (
	`id_libro` INT(11) NOT NULL,
	`titulo` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`categoria` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`cantidad_disponible` INT(11) NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista biblioteca_digital.vista_multas_pendientes
DROP VIEW IF EXISTS `vista_multas_pendientes`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_multas_pendientes` (
	`id_multa` INT(11) NOT NULL,
	`usuario` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`monto` DECIMAL(10,2) NOT NULL,
	`estado` ENUM('pendiente','pagado') NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para vista biblioteca_digital.vista_prestamos_activos
DROP VIEW IF EXISTS `vista_prestamos_activos`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_prestamos_activos` (
	`id_prestamo` INT(11) NOT NULL,
	`usuario` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`libro` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`fecha_prestamo` DATE NULL,
	`fecha_devolucion` DATE NOT NULL
) ENGINE=MyISAM;

-- Volcando estructura para vista biblioteca_digital.vista_reseñas
DROP VIEW IF EXISTS `vista_reseñas`;
-- Creando tabla temporal para superar errores de dependencia de VIEW
CREATE TABLE `vista_reseñas` (
	`id_reseña` INT(11) NOT NULL,
	`usuario` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`libro` VARCHAR(1) NOT NULL COLLATE 'utf8mb4_general_ci',
	`calificacion` INT(11) NULL,
	`comentario` TEXT NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Volcando estructura para procedimiento biblioteca_digital.historial_prestamos_usuario
DROP PROCEDURE IF EXISTS `historial_prestamos_usuario`;
DELIMITER //
CREATE PROCEDURE `historial_prestamos_usuario`(IN id_usuario INT)
BEGIN
    SELECT p.id_prestamo, l.titulo, p.fecha_prestamo, p.fecha_devolucion, p.estado
    FROM prestamos p
    JOIN detalles_prestamos dp ON p.id_prestamo = dp.id_prestamo
    JOIN libros l ON dp.id_libro = l.id_libro
    WHERE p.id_usuario = id_usuario
    ORDER BY p.fecha_prestamo DESC;
END//
DELIMITER ;

-- Volcando estructura para procedimiento biblioteca_digital.insertar_libro
DROP PROCEDURE IF EXISTS `insertar_libro`;
DELIMITER //
CREATE PROCEDURE `insertar_libro`(
    IN titulo VARCHAR(255), 
    IN id_editorial INT, 
    IN año_publicacion YEAR, 
    IN isbn VARCHAR(20), 
    IN cantidad_disponible INT
)
BEGIN
    INSERT INTO libros (titulo, id_editorial, año_publicacion, isbn, cantidad_disponible) 
    VALUES (titulo, id_editorial, año_publicacion, isbn, cantidad_disponible);
END//
DELIMITER ;

-- Volcando estructura para procedimiento biblioteca_digital.insertar_usuario
DROP PROCEDURE IF EXISTS `insertar_usuario`;
DELIMITER //
CREATE PROCEDURE `insertar_usuario`(IN nombre VARCHAR(100), IN email VARCHAR(100), IN contraseña VARCHAR(255), IN id_rol INT)
BEGIN
    INSERT INTO usuarios (nombre, email, contraseña, id_rol, estado) VALUES (nombre, email, SHA2(contraseña, 256), id_rol, 'activo');
END//
DELIMITER ;

-- Volcando estructura para procedimiento biblioteca_digital.registrar_devolucion
DROP PROCEDURE IF EXISTS `registrar_devolucion`;
DELIMITER //
CREATE PROCEDURE `registrar_devolucion`(
    IN id_prestamo INT
)
BEGIN
    -- Actualizar estado del préstamo a 'devuelto'
    UPDATE prestamos SET estado = 'devuelto' WHERE id_prestamo = id_prestamo;
    
    -- Restaurar el stock del libro
    UPDATE libros 
    SET cantidad_disponible = cantidad_disponible + 1 
    WHERE id_libro IN (SELECT id_libro FROM detalles_prestamos WHERE id_prestamo = id_prestamo);
END//
DELIMITER ;

-- Volcando estructura para procedimiento biblioteca_digital.registrar_multa
DROP PROCEDURE IF EXISTS `registrar_multa`;
DELIMITER //
CREATE PROCEDURE `registrar_multa`(
    IN id_usuario INT, 
    IN monto DECIMAL(10,2)
)
BEGIN
    INSERT INTO multas (id_usuario, monto, estado) VALUES (id_usuario, monto, 'pendiente');
END//
DELIMITER ;

-- Volcando estructura para procedimiento biblioteca_digital.registrar_prestamo
DROP PROCEDURE IF EXISTS `registrar_prestamo`;
DELIMITER //
CREATE PROCEDURE `registrar_prestamo`(
    IN id_usuario INT, 
    IN id_libro INT, 
    IN fecha_devolucion DATE
)
BEGIN
    DECLARE stock_actual INT;
    
    -- Verificar si hay stock disponible
    SELECT cantidad_disponible INTO stock_actual FROM libros WHERE id_libro = id_libro;
    
    IF stock_actual <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay stock disponible para este libro.';
    ELSE
        -- Insertar préstamo
        INSERT INTO prestamos (id_usuario, fecha_devolucion) VALUES (id_usuario, fecha_devolucion);
        -- Obtener el ID del préstamo recién insertado
        INSERT INTO detalles_prestamos (id_prestamo, id_libro) 
        VALUES (LAST_INSERT_ID(), id_libro);
        -- Reducir stock del libro
        UPDATE libros SET cantidad_disponible = cantidad_disponible - 1 WHERE id_libro = id_libro;
    END IF;
END//
DELIMITER ;

-- Volcando estructura para disparador biblioteca_digital.after_insert_prestamo
DROP TRIGGER IF EXISTS `after_insert_prestamo`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_insert_prestamo
AFTER INSERT ON detalles_prestamos
FOR EACH ROW
BEGIN
    UPDATE libros SET cantidad_disponible = cantidad_disponible - 1 WHERE id_libro = NEW.id_libro;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador biblioteca_digital.after_update_multa
DROP TRIGGER IF EXISTS `after_update_multa`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_update_multa
AFTER UPDATE ON multas
FOR EACH ROW
BEGIN
    IF NEW.estado = 'pagado' THEN
        INSERT INTO historial_pagos (id_usuario, id_multa, fecha_pago)
        VALUES (NEW.id_usuario, NEW.id_multa, NOW());
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador biblioteca_digital.after_update_prestamo
DROP TRIGGER IF EXISTS `after_update_prestamo`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER after_update_prestamo
AFTER UPDATE ON prestamos
FOR EACH ROW
BEGIN
    IF NEW.estado = 'devuelto' THEN
        UPDATE libros 
        SET cantidad_disponible = cantidad_disponible + 1
        WHERE id_libro IN (SELECT id_libro FROM detalles_prestamos WHERE id_prestamo = NEW.id_prestamo);
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador biblioteca_digital.before_insert_prestamo
DROP TRIGGER IF EXISTS `before_insert_prestamo`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER before_insert_prestamo
BEFORE INSERT ON detalles_prestamos
FOR EACH ROW
BEGIN
    DECLARE stock_actual INT;
    SELECT cantidad_disponible INTO stock_actual FROM libros WHERE id_libro = NEW.id_libro;
    IF stock_actual <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay stock disponible para este libro.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador biblioteca_digital.before_insert_reseña
DROP TRIGGER IF EXISTS `before_insert_reseña`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER before_insert_reseña
BEFORE INSERT ON reseñas
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM reseñas WHERE id_usuario = NEW.id_usuario AND id_libro = NEW.id_libro) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ya has reseñado este libro.';
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_historial_prestamos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_historial_prestamos` AS SELECT u.nombre AS usuario, l.titulo AS libro, p.fecha_prestamo, p.fecha_devolucion
FROM prestamos p
JOIN usuarios u ON p.id_usuario = u.id_usuario
JOIN detalles_prestamos dp ON p.id_prestamo = dp.id_prestamo
JOIN libros l ON dp.id_libro = l.id_libro ;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_libros_disponibles`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_libros_disponibles` AS SELECT l.id_libro, l.titulo, c.nombre AS categoria, l.cantidad_disponible
FROM libros l
JOIN libros_categorias lc ON l.id_libro = lc.id_libro
JOIN categorias c ON lc.id_categoria = c.id_categoria
WHERE l.cantidad_disponible > 0 ;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_multas_pendientes`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_multas_pendientes` AS SELECT m.id_multa, u.nombre AS usuario, m.monto, m.estado
FROM multas m
JOIN usuarios u ON m.id_usuario = u.id_usuario
WHERE m.estado = 'pendiente' ;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_prestamos_activos`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_prestamos_activos` AS SELECT p.id_prestamo, u.nombre AS usuario, l.titulo AS libro, p.fecha_prestamo, p.fecha_devolucion
FROM prestamos p
JOIN usuarios u ON p.id_usuario = u.id_usuario
JOIN detalles_prestamos dp ON p.id_prestamo = dp.id_prestamo
JOIN libros l ON dp.id_libro = l.id_libro
WHERE p.estado = 'activo' ;

-- Eliminando tabla temporal y crear estructura final de VIEW
DROP TABLE IF EXISTS `vista_reseñas`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vista_reseñas` AS select `r`.`id_reseña` AS `id_reseña`,`u`.`nombre` AS `usuario`,`l`.`titulo` AS `libro`,`r`.`calificacion` AS `calificacion`,`r`.`comentario` AS `comentario` from ((`reseñas` `r` join `usuarios` `u` on(`r`.`id_usuario` = `u`.`id_usuario`)) join `libros` `l` on(`r`.`id_libro` = `l`.`id_libro`));

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
