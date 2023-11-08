-- MySQL dump 10.13  Distrib 5.6.50, for Linux (x86_64)
--
-- Host: localhost    Database: heroku_d23e98632d70552
-- ------------------------------------------------------
-- Server version	5.6.50-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `administrador`
--

DROP TABLE IF EXISTS `administrador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `administrador` (
  `idAdmin` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) DEFAULT NULL,
  `clave` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idAdmin`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `administrador`
--

LOCK TABLES `administrador` WRITE;
/*!40000 ALTER TABLE `administrador` DISABLE KEYS */;
INSERT INTO `administrador` VALUES (1,'sa','sa','sa');
/*!40000 ALTER TABLE `administrador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `curso` (
  `idCurso` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(128) DEFAULT NULL,
  `nombre` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idCurso`)
) ENGINE=InnoDB AUTO_INCREMENT=395 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cursosmxsolicitudrn`
--

DROP TABLE IF EXISTS `cursosmxsolicitudrn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursosmxsolicitudrn` (
  `idCursosmXsolicitudRN` bigint(20) NOT NULL AUTO_INCREMENT,
  `fkSolicitudRN` bigint(20) DEFAULT NULL,
  `fkCurso` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idCursosmXsolicitudRN`),
  KEY `fkSolicitudRN` (`fkSolicitudRN`),
  KEY `fkCurso` (`fkCurso`),
  CONSTRAINT `cursosmxsolicitudrn_ibfk_1` FOREIGN KEY (`fkSolicitudRN`) REFERENCES `solicitudrn` (`fkSolicitud`),
  CONSTRAINT `cursosmxsolicitudrn_ibfk_2` FOREIGN KEY (`fkCurso`) REFERENCES `curso` (`idCurso`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cursosrnxsolicitudrn`
--

DROP TABLE IF EXISTS `cursosrnxsolicitudrn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursosrnxsolicitudrn` (
  `idCursosrnXsolicitudRN` bigint(20) NOT NULL AUTO_INCREMENT,
  `fkSolicitudRN` bigint(20) DEFAULT NULL,
  `fkCurso` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idCursosrnXsolicitudRN`),
  KEY `fkSolicitudRN` (`fkSolicitudRN`),
  KEY `fkCurso` (`fkCurso`),
  CONSTRAINT `cursosrnxsolicitudrn_ibfk_1` FOREIGN KEY (`fkSolicitudRN`) REFERENCES `solicitudrn` (`fkSolicitud`),
  CONSTRAINT `cursosrnxsolicitudrn_ibfk_2` FOREIGN KEY (`fkCurso`) REFERENCES `curso` (`idCurso`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `cursoxperiodo`
--

DROP TABLE IF EXISTS `cursoxperiodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cursoxperiodo` (
  `idCursoPeriodo` bigint(20) NOT NULL AUTO_INCREMENT,
  `fkCurso` bigint(20) DEFAULT NULL,
  `fkPeriodo` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idCursoPeriodo`),
  KEY `fkCurso` (`fkCurso`),
  KEY `fkPeriodo` (`fkPeriodo`),
  CONSTRAINT `cursoxperiodo_ibfk_1` FOREIGN KEY (`fkCurso`) REFERENCES `curso` (`idCurso`),
  CONSTRAINT `cursoxperiodo_ibfk_2` FOREIGN KEY (`fkPeriodo`) REFERENCES `periodo` (`idPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=465 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `formulario`
--

DROP TABLE IF EXISTS `formulario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formulario` (
  `idFormulario` bigint(20) NOT NULL AUTO_INCREMENT,
  `fechaVencimiento` datetime DEFAULT NULL,
  `nombre` varchar(64) DEFAULT NULL,
  `fkPeriodo` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`idFormulario`),
  KEY `fkPeriodo` (`fkPeriodo`),
  CONSTRAINT `formulario_ibfk_1` FOREIGN KEY (`fkPeriodo`) REFERENCES `periodo` (`idPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `periodo`
--

DROP TABLE IF EXISTS `periodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `periodo` (
  `idPeriodo` bigint(20) NOT NULL AUTO_INCREMENT,
  `semestre` int(11) DEFAULT NULL,
  `periodo` date DEFAULT NULL,
  PRIMARY KEY (`idPeriodo`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `planestudios`
--

DROP TABLE IF EXISTS `planestudios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `planestudios` (
  `idPlanEstudios` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idPlanEstudios`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `sede`
--

DROP TABLE IF EXISTS `sede`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sede` (
  `idSede` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idSede`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sede`
--

LOCK TABLES `sede` WRITE;
/*!40000 ALTER TABLE `sede` DISABLE KEYS */;
INSERT INTO `sede` VALUES (1,'Cartago'),(2,'San José'),(3,'Limón'),(4,'San Carlos'),(5,'Alajuela');
/*!40000 ALTER TABLE `sede` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitud`
--

DROP TABLE IF EXISTS `solicitud`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solicitud` (
  `idSolicitud` bigint(20) NOT NULL AUTO_INCREMENT,
  `carnet` int(11) DEFAULT NULL,
  `nombreCompleto` varchar(256) DEFAULT NULL,
  `fkPlanEstudios` bigint(20) DEFAULT NULL,
  `fkFormulario` bigint(20) DEFAULT NULL,
  `fkSede` bigint(20) DEFAULT NULL,
  `comentario` varchar(256) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `razon` varchar(256) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  `notificado` bit(1) DEFAULT NULL,
  `comentarioEncargado` varchar(128) DEFAULT NULL,
  `token` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`idSolicitud`),
  KEY `fkPlanEstudios` (`fkPlanEstudios`),
  KEY `fkFormulario` (`fkFormulario`),
  KEY `fkSede` (`fkSede`),
  CONSTRAINT `solicitud_ibfk_1` FOREIGN KEY (`fkPlanEstudios`) REFERENCES `planestudios` (`idPlanEstudios`),
  CONSTRAINT `solicitud_ibfk_2` FOREIGN KEY (`fkFormulario`) REFERENCES `formulario` (`idFormulario`),
  CONSTRAINT `solicitud_ibfk_3` FOREIGN KEY (`fkSede`) REFERENCES `sede` (`idSede`)
) ENGINE=InnoDB AUTO_INCREMENT=305 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `solicitudreq`
--

DROP TABLE IF EXISTS `solicitudreq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solicitudreq` (
  `fkSolicitud` bigint(20) DEFAULT NULL,
  `fkCursoLevantar` bigint(20) DEFAULT NULL,
  `fkCursoMatricular` bigint(20) DEFAULT NULL,
  KEY `fkSolicitud` (`fkSolicitud`),
  KEY `fkCursoLevantar` (`fkCursoLevantar`),
  KEY `fkCursoMatricular` (`fkCursoMatricular`),
  CONSTRAINT `solicitudreq_ibfk_1` FOREIGN KEY (`fkSolicitud`) REFERENCES `solicitud` (`idSolicitud`),
  CONSTRAINT `solicitudreq_ibfk_2` FOREIGN KEY (`fkCursoLevantar`) REFERENCES `curso` (`idCurso`),
  CONSTRAINT `solicitudreq_ibfk_3` FOREIGN KEY (`fkCursoMatricular`) REFERENCES `curso` (`idCurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Table structure for table `solicitudrn`
--

DROP TABLE IF EXISTS `solicitudrn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `solicitudrn` (
  `fkSolicitud` bigint(20) DEFAULT NULL,
  `nivelRN` int(11) DEFAULT NULL,
  KEY `fkSolicitud` (`fkSolicitud`),
  CONSTRAINT `solicitudrn_ibfk_1` FOREIGN KEY (`fkSolicitud`) REFERENCES `solicitud` (`idSolicitud`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;



--
-- Dumping routines for database 'heroku_d23e98632d70552'
--
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarAdministrador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarAdministrador`(
    IN p_idAdmin BIGINT,
    IN p_nombre VARCHAR(128),
    IN p_clave VARCHAR(128),
    IN p_email VARCHAR(128)
)
BEGIN
    UPDATE Administrador
    SET nombre = p_nombre, clave = p_clave, email = p_email
    WHERE idAdmin = p_idAdmin;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarCurso`(
    IN p_idCurso BIGINT,
    IN p_codigoNuevo VARCHAR(128),
    IN p_nombre VARCHAR(128)
)
BEGIN
    DECLARE cursoCount INT;

    -- Verificar si ya existe un curso con el mismo código nuevo
    SELECT COUNT(*) INTO cursoCount
    FROM Curso
    WHERE codigo = p_codigoNuevo AND idCurso <> p_idCurso;

    IF cursoCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ya existe un curso con el mismo código nuevo';
    ELSE
        UPDATE Curso
        SET codigo = p_codigoNuevo, nombre = p_nombre
        WHERE idCurso = p_idCurso;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarCursoMXsolicitudRN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarCursoMXsolicitudRN`(
    IN p_idCursosmXsolicitudRN BIGINT,
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de actualizar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        UPDATE cursosmXsolicitudRN
        SET fkSolicitudRN = p_fkSolicitudRN,
            fkCurso = p_fkCurso
        WHERE idCursosmXsolicitudRN = p_idCursosmXsolicitudRN;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarCursoXsolicitudRN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarCursoXsolicitudRN`(
    IN p_idCursosrnXsolicitudRN BIGINT,
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de actualizar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        UPDATE cursosrnXsolicitudRN
        SET fkSolicitudRN = p_fkSolicitudRN,
            fkCurso = p_fkCurso
        WHERE idCursosrnXsolicitudRN = p_idCursosrnXsolicitudRN;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarEstadoSolicitud` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarEstadoSolicitud`(
    IN p_idSolicitud BIGINT,
    IN p_estado BIT,
    IN p_comentarioEncargado VARCHAR(256)
)
BEGIN
    -- Verificar si el comentario del encargado es nulo
    IF p_comentarioEncargado IS NULL THEN
        SET p_comentarioEncargado = 'Revisado'; -- Valor predeterminado si el comentario es nulo
    END IF;

    -- Actualizar la solicitud con los nuevos valores de estado y comentario del encargado
    UPDATE Solicitud
    SET estado = p_estado,
        comentarioEncargado = p_comentarioEncargado
    WHERE idSolicitud = p_idSolicitud;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarFormulario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarFormulario`(
    IN p_idFormulario BIGINT,
    IN p_fechaVencimiento DATETIME,
    IN p_nombre VARCHAR(64),
    IN p_semestre INT,
    IN p_año INT
)
BEGIN
    DECLARE v_idPeriodo BIGINT;

    -- Verificar si el período ya existe o insertarlo
    SET v_idPeriodo = (SELECT idPeriodo FROM Periodo WHERE semestre = p_semestre AND YEAR(periodo) = p_año);

    IF v_idPeriodo IS NULL THEN
        -- Insertar el nuevo período
        INSERT INTO Periodo (semestre, periodo) VALUES (p_semestre, STR_TO_DATE(CONCAT(p_año, '-12-31'), '%Y-%m-%d'));
        SET v_idPeriodo = LAST_INSERT_ID();
    END IF;

    -- Actualizar el formulario con el nuevo período
    UPDATE Formulario
    SET fechaVencimiento = p_fechaVencimiento, nombre = p_nombre, fkPeriodo = v_idPeriodo
    WHERE idFormulario = p_idFormulario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarNotificacion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarNotificacion`(IN p_idSolicitud INT)
BEGIN
    UPDATE solicitud
    SET notificado = 1
    WHERE idSolicitud = p_idSolicitud;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarPlanEstudios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarPlanEstudios`(
    IN p_idPlanEstudios BIGINT,
    IN p_nombre VARCHAR(128)
)
BEGIN
    UPDATE PlanEstudios
    SET nombre = p_nombre
    WHERE idPlanEstudios = p_idPlanEstudios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarSede` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarSede`(
    IN p_idSede BIGINT,
    IN p_nombre VARCHAR(128)
)
BEGIN
    UPDATE Sede
    SET nombre = p_nombre
    WHERE idSede = p_idSede;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ActualizarSolicitudNotificado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ActualizarSolicitudNotificado`(
    IN p_idSolicitud BIGINT,
    IN p_notificado BIT
)
BEGIN
    -- Actualizar el estado "notificado" de la solicitud
    UPDATE Solicitud
    SET notificado = p_notificado
    WHERE idSolicitud = p_idSolicitud;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CloseAllConnections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `CloseAllConnections`()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE connection_id INT;
  DECLARE cur CURSOR FOR SELECT ID FROM information_schema.processlist WHERE ID <> CONNECTION_ID();
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO connection_id;
    IF done = 1 THEN
      LEAVE read_loop;
    END IF;
    SET @sql = CONCAT('KILL ', connection_id);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END LOOP;
  CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarCurso`(
    IN p_idCurso BIGINT
)
BEGIN
    DECLARE cursosrnXsolicitudRNCount INT;
    DECLARE cursosmXsolicitudRNCount INT;
    DECLARE solicitudReqCount INT;
    DECLARE cursoXperiodoCount INT;

    -- Verificar si hay registros asociados al curso
    SELECT COUNT(*) INTO cursosrnXsolicitudRNCount
    FROM cursosrnXsolicitudRN
    WHERE fkCurso = p_idCurso;

    SELECT COUNT(*) INTO cursosmXsolicitudRNCount
    FROM cursosmXsolicitudRN
    WHERE fkCurso = p_idCurso;

    SELECT COUNT(*) INTO solicitudReqCount
    FROM SolicitudReq
    WHERE fkCursoLevantar = p_idCurso OR fkCursoMatricular = p_idCurso;

    SELECT COUNT(*) INTO cursoXperiodoCount
    FROM cursoXperiodo
    WHERE fkCurso = p_idCurso;

    IF cursosrnXsolicitudRNCount > 0 OR cursosmXsolicitudRNCount > 0 OR solicitudReqCount > 0 OR cursoXperiodoCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el curso debido a registros asociados';
    ELSE
        DELETE FROM Curso
        WHERE idCurso = p_idCurso;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarCursoMXsolicitudRN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarCursoMXsolicitudRN`(
    IN p_idCursosmXsolicitudRN BIGINT
)
BEGIN
    DELETE FROM cursosmXsolicitudRN
    WHERE idCursosmXsolicitudRN = p_idCursosmXsolicitudRN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarCursoXsolicitudRN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarCursoXsolicitudRN`(
    IN p_idCursosrnXsolicitudRN BIGINT
)
BEGIN
    DELETE FROM cursosrnXsolicitudRN
    WHERE idCursosrnXsolicitudRN = p_idCursosrnXsolicitudRN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarFormulario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarFormulario`(
    IN p_idFormulario BIGINT
)
BEGIN
    -- Verificar si hay solicitudes asociadas a este formulario
    IF NOT EXISTS (SELECT 1 FROM Solicitud WHERE fkFormulario = p_idFormulario) THEN
        -- No hay solicitudes asociadas, eliminar el formulario
        DELETE FROM Formulario WHERE idFormulario = p_idFormulario;
    ELSE
        -- Hay solicitudes asociadas, no se puede eliminar
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el formulario ya que tiene solicitudes asociadas.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarFormularioYPeriodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarFormularioYPeriodo`(
    IN p_idFormulario BIGINT
)
BEGIN
    DECLARE v_periodoID BIGINT;

    -- Verificar si hay solicitudes asociadas al formulario
    IF EXISTS (SELECT * FROM Solicitud WHERE fkFormulario = p_idFormulario) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el formulario porque tiene solicitudes asociadas.';
    ELSE
        -- Obtener el ID del período asociado al formulario
        SELECT fkPeriodo INTO v_periodoID
        FROM Formulario
        WHERE idFormulario = p_idFormulario;

        -- Eliminar el formulario
        DELETE FROM Formulario WHERE idFormulario = p_idFormulario;

        -- Eliminar el período asociado si no tiene más formularios
        IF NOT EXISTS (SELECT * FROM Formulario WHERE fkPeriodo = v_periodoID) THEN
            DELETE FROM Periodo WHERE idPeriodo = v_periodoID;
        END IF;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarPeriodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarPeriodo`(
    IN p_idPeriodo INT
)
BEGIN
    DECLARE v_formulariosAsociados INT;
    SET v_formulariosAsociados = (
        SELECT COUNT(*)
        FROM Formulario
        WHERE fkPeriodo = p_idPeriodo
    );

    IF v_formulariosAsociados = 0 THEN
        DELETE FROM Periodo WHERE idPeriodo = p_idPeriodo;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el periodo, hay formularios asociados a él.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarPlanEstudios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarPlanEstudios`(
    IN p_idPlanEstudios BIGINT
)
BEGIN
    DECLARE solicitudCount INT;

    -- Verificar si hay solicitudes asociadas al plan de estudios
    SELECT COUNT(*) INTO solicitudCount
    FROM Solicitud
    WHERE fkPlanEstudios = p_idPlanEstudios;

    IF solicitudCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar el plan de estudios debido a solicitudes asociadas';
    ELSE
        DELETE FROM PlanEstudios
        WHERE idPlanEstudios = p_idPlanEstudios;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarSede` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarSede`(
    IN p_idSede BIGINT
)
BEGIN
    DECLARE sedeCount INT;

    -- Verificar si hay solicitudes asociadas a la sede
    SELECT COUNT(*) INTO sedeCount
    FROM Solicitud
    WHERE fkSede = p_idSede;

    IF sedeCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se puede eliminar la sede debido a solicitudes asociadas';
    ELSE
        DELETE FROM Sede
        WHERE idSede = p_idSede;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarSolicitudReq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarSolicitudReq`(
    IN p_carnet INT,
    IN p_token VARCHAR(128)
)
BEGIN
    DECLARE v_idSolicitud BIGINT;

    -- Buscar el ID de solicitud con el carnet y el token proporcionados
    SELECT idSolicitud INTO v_idSolicitud
    FROM Solicitud
    WHERE carnet = p_carnet AND token = p_token;

    IF v_idSolicitud IS NOT NULL THEN

        -- Eliminar registro en SolicitudReq
        DELETE FROM SolicitudReq WHERE fkSolicitud = v_idSolicitud;

        -- Eliminar registro en Solicitud
        DELETE FROM Solicitud WHERE idSolicitud = v_idSolicitud;

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se encontró una solicitud con el carnet y token proporcionados.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `EliminarSolicitudRNYRegistros` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `EliminarSolicitudRNYRegistros`(
    IN p_carnet INT,
    IN p_token VARCHAR(128)
)
BEGIN
    DECLARE v_fkSolicitudRN BIGINT;

    SELECT idSolicitud INTO v_fkSolicitudRN
    FROM Solicitud
    WHERE carnet = p_carnet AND token = p_token;

    IF v_fkSolicitudRN IS NOT NULL THEN


        -- Eliminar registros de cursosrnXsolicitudRN
        DELETE FROM cursosrnXsolicitudRN WHERE fkSolicitudRN = v_fkSolicitudRN;

        -- Eliminar registros de cursosmXsolicitudRN
        DELETE FROM cursosmXsolicitudRN WHERE fkSolicitudRN = v_fkSolicitudRN;

        -- Eliminar solicitudRN
        DELETE FROM SolicitudRN WHERE fkSolicitud = v_fkSolicitudRN;

        -- Eliminar solicitud
        DELETE FROM Solicitud WHERE idSolicitud = v_fkSolicitudRN;

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No se encontró una solicitud con el carnet y token especificados.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetEmails` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `GetEmails`()
BEGIN
    SELECT * FROM administrador LIMIT 3;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarAdministrador` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarAdministrador`(
    IN p_nombre VARCHAR(128),
    IN p_clave VARCHAR(128),
    IN p_email VARCHAR(128)
)
BEGIN
    INSERT INTO Administrador (nombre, clave, email)
    VALUES (p_nombre, p_clave, p_email);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarCurso`(
    IN p_codigo VARCHAR(128),
    IN p_nombre VARCHAR(128)
)
BEGIN
    DECLARE cursoCount INT;

    -- Verificar si ya existe un curso con el mismo código
    SELECT COUNT(*) INTO cursoCount
    FROM Curso
    WHERE codigo = p_codigo;

    IF cursoCount > 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ya existe un curso con el mismo código';
    ELSE
        INSERT INTO Curso (codigo, nombre)
        VALUES (p_codigo, p_nombre);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCursoMXsolicitudRN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarCursoMXsolicitudRN`(
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de insertar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        INSERT INTO cursosmXsolicitudRN(fkSolicitudRN, fkCurso)
        VALUES (p_fkSolicitudRN, p_fkCurso);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCursosDesdeJSON` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarCursosDesdeJSON`(
    IN p_periodo DATE,
    IN p_semestre INT,
    IN p_jsonCursos TEXT
    -- Formato -> "codigo Curso,Nombre curso ; COD CUR,NOM CUR ; ..."
)
BEGIN
    DECLARE v_periodoID BIGINT;
    DECLARE v_cursoCodigo VARCHAR(255);
    DECLARE v_cursoNombre VARCHAR(255);
    -- Verificar si ya existe un período con el mismo semestre y año
    SELECT idPeriodo INTO v_periodoID
        FROM Periodo
        WHERE semestre = p_semestre AND YEAR(periodo) = YEAR(p_periodo);

    IF v_periodoID IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No existe este período.';
    ELSE

    SET @p_jsonCursos = TRIM(BOTH '[]' FROM p_jsonCursos); -- Eliminar corchetes si existen

    WHILE LENGTH(p_jsonCursos) > 0 DO

            -- Extraer un par [COD CURSO, Nombre Curso] de p_jsonCursos
            SET v_cursoCodigo = SUBSTRING_INDEX(SUBSTRING_INDEX(p_jsonCursos, ';', 1), ',', 1);
            SET v_cursoNombre = SUBSTRING_INDEX(SUBSTRING_INDEX(p_jsonCursos, ';', 1), ',', -1);

            -- Eliminar el par procesado de p_jsonCursos
            SET p_jsonCursos = SUBSTRING(p_jsonCursos, LENGTH(SUBSTRING_INDEX(p_jsonCursos, ';', 1)) + 3);


            -- Verificar si el curso existe
            SET @v_cursoId = NULL;
            SELECT idCurso INTO @v_cursoId
            FROM Curso
            WHERE codigo = v_cursoCodigo;

            IF @v_cursoId IS NULL THEN
                -- Insertar el curso
                INSERT INTO Curso(codigo, nombre)
                VALUES (v_cursoCodigo, v_cursoNombre);
                SET @v_cursoId = LAST_INSERT_ID(); -- Obtener el ID del curso recién insertado
            END IF;

            -- Insertar la relación en cursoXperiodo
            INSERT INTO cursoXperiodo(fkCurso, fkPeriodo)
            VALUES (@v_cursoId, v_periodoID);

        END WHILE;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarCursoXsolicitudRN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarCursoXsolicitudRN`(
    IN p_fkSolicitudRN BIGINT,
    IN p_fkCurso BIGINT
)
BEGIN
    -- Verificar si el curso existe antes de insertar
    DECLARE cursoExistente INT;
    SET cursoExistente = (SELECT COUNT(*) FROM Curso WHERE idCurso = p_fkCurso);

    IF cursoExistente > 0 THEN
        INSERT INTO cursosrnXsolicitudRN(fkSolicitudRN, fkCurso)
        VALUES (p_fkSolicitudRN, p_fkCurso);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El curso no existe.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarFormularioConPeriodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarFormularioConPeriodo`(
    IN p_fechaVencimiento DATETIME,
    IN p_nombre VARCHAR(64),
    IN p_semestre INT,
    IN p_periodo DATE
)
BEGIN
    DECLARE v_periodoID BIGINT;

    -- Verificar si ya existe un período con el mismo semestre y año
    SELECT idPeriodo INTO v_periodoID
    FROM Periodo
    WHERE semestre = p_semestre AND YEAR(periodo) = YEAR(p_periodo);

    IF v_periodoID IS NOT NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Ya existe un formulario para este período.';
    ELSE
        -- Insertar el nuevo período
        INSERT INTO Periodo(semestre, periodo)
        VALUES (p_semestre, p_periodo);

        SET v_periodoID = LAST_INSERT_ID();

        -- Insertar el nuevo formulario
        INSERT INTO Formulario(fechaVencimiento, nombre, fkPeriodo)
        VALUES (p_fechaVencimiento, p_nombre, v_periodoID);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarPeriodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarPeriodo`(
    IN p_year DATE,
    IN p_semestre VARCHAR(255)
)
BEGIN
    DECLARE v_periodoExist INT;
    SET v_periodoExist = (
        SELECT COUNT(*)
        FROM Periodo
        WHERE YEAR(periodo) = YEAR(p_year) AND semestre = p_semestre
    );

    IF v_periodoExist = 0 THEN
        INSERT INTO Periodo(periodo, semestre)
        VALUES (p_year, p_semestre);
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El periodo ya existe.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarPlanEstudios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarPlanEstudios`(
    IN p_nombre VARCHAR(128)
)
BEGIN
    INSERT INTO PlanEstudios (nombre)
    VALUES (p_nombre);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarSede` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarSede`(
    IN p_nombre VARCHAR(128)
)
BEGIN
    INSERT INTO Sede (nombre)
    VALUES (p_nombre);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarSolicitudReq` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarSolicitudReq`(
    IN p_carnet INT,
    IN p_nombreCompleto VARCHAR(256),
    IN p_fkPlanEstudios BIGINT,
    IN p_email VARCHAR(128),
    IN p_token VARCHAR(128),
    IN p_comentario VARCHAR(256),
    IN p_fkFormulario BIGINT,
    IN p_fkSede BIGINT,
    IN p_razon VARCHAR(128),
    IN p_fkCursoLevantar BIGINT,
    IN p_fkCursoMatricular BIGINT
)
BEGIN

    START TRANSACTION;

    -- Insertar en la tabla solicitud
    INSERT INTO Solicitud(carnet, nombreCompleto, fkPlanEstudios, email, fkFormulario, fkSede, comentario, token, estado, notificado, comentarioEncargado, razon)
    VALUES (p_carnet, p_nombreCompleto, p_fkPlanEstudios, p_email, p_fkFormulario, p_fkSede, p_comentario, p_token, 0, 0, '', p_razon);

    -- Obtener el ID de la solicitud recién insertada
    SET @lastSolicitudID = LAST_INSERT_ID();

    -- Insertar en la tabla solicitudReq utilizando la herencia
    INSERT INTO SolicitudReq(fkSolicitud, fkCursoLevantar, fkCursoMatricular)
    VALUES (@lastSolicitudID, p_fkCursoLevantar, p_fkCursoMatricular);

    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarSolicitudRnConCursos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `InsertarSolicitudRnConCursos`(
    IN p_carnet INT,
    IN p_nombreCompleto VARCHAR(256),
    IN v_fkPlanEstudios BIGINT,
    IN p_email VARCHAR(128),
    IN p_token VARCHAR(128),
    IN p_comentario VARCHAR(256),
    IN p_fkFormulario BIGINT,
    IN p_fkSede BIGINT,
    IN p_razon VARCHAR(128),
    IN p_nivelRn INT,
    IN p_cursosMXRNString VARCHAR(500), -- Formato: ["id1","id2","id3"...]
    IN p_cursosRNString VARCHAR(500) -- Formato: ["id1","id2","id3"...]

)
BEGIN
    DECLARE v_fkFormularioExist INT;
    DECLARE v_idSolicitud BIGINT;
    DECLARE v_cursoID INT;
    DECLARE v_elementos INT;
    DECLARE v_elementos2 INT;
    DECLARE i INT DEFAULT 0;
    DECLARE j INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION ROLLBACK;

    SET v_fkFormularioExist = (SELECT COUNT(*) FROM Formulario WHERE idFormulario = p_fkFormulario);

    IF v_fkFormularioExist > 0 THEN


        START TRANSACTION;

-- Insertar en la tabla solicitud
        INSERT INTO Solicitud(carnet, nombreCompleto, fkPlanEstudios, email, fkFormulario, fkSede, comentario, token, estado, notificado, comentarioEncargado, razon)
        VALUES (p_carnet, p_nombreCompleto, v_fkPlanEstudios, p_email, p_fkFormulario, p_fkSede, p_comentario, p_token, 0, 0, '', p_razon);

        SET v_idSolicitud = LAST_INSERT_ID();

        -- Insertar en la tabla solicitudRN
        INSERT INTO SolicitudRN(fkSolicitud, nivelRN)
        VALUES (v_idSolicitud, p_nivelRn);

        -- Insertar en la tabla cursosrnXsolicitudRN

-- Eliminar los corchetes "[" y "]" del parámetro
        SET p_cursosRNString = TRIM(BOTH '[]' FROM p_cursosRNString);
        -- Contar los elementos separados por comas
        SET v_elementos2 = LENGTH(p_cursosRNString) - LENGTH(REPLACE(p_cursosRNString, ',', '')) + 1;


        WHILE i < v_elementos2 DO

                SET v_cursoID = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(p_cursosRNString, ',', i + 1), ',', -1) AS UNSIGNED);

                IF EXISTS (SELECT * FROM Curso WHERE idCurso = v_cursoID) THEN
                    INSERT INTO cursosrnXsolicitudRN(fkSolicitudRN, fkCurso)
                    VALUES (v_idSolicitud, v_cursoID);
                END IF;

                SET i = i + 1;
            END WHILE;

        -- Insertar en la tabla cursosmXsolicitudRN

        -- Eliminar los corchetes "[" y "]" del parámetro
        SET p_cursosMXRNString = TRIM(BOTH '[]' FROM p_cursosMXRNString);

        -- Contar los elementos separados por comas
        SET v_elementos = LENGTH(p_cursosMXRNString) - LENGTH(REPLACE(p_cursosMXRNString, ',', '')) + 1;

        WHILE j < v_elementos DO

                SET v_cursoID = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(p_cursosMXRNString, ',', j + 1), ',', -1) AS UNSIGNED);

                IF EXISTS (SELECT * FROM Curso WHERE idCurso = v_cursoID) THEN
                    INSERT INTO cursosmXsolicitudRN(fkSolicitudRN, fkCurso)
                    VALUES (v_idSolicitud, v_cursoID);
                END IF;

                SET j = j + 1;
            END WHILE;

        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'El plan de estudios no existe o el formulario asociado no existe.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LeerPeriodoEspecifico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `LeerPeriodoEspecifico`(
    IN p_idPeriodo BIGINT
)
BEGIN
    SELECT * FROM Periodo WHERE idPeriodo = p_idPeriodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LeerPeriodos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `LeerPeriodos`()
BEGIN
    SELECT * FROM Periodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarCursos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ListarCursos`()
BEGIN
    SELECT idCurso, codigo, nombre
    FROM Curso;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarPlanesEstudios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ListarPlanesEstudios`()
BEGIN
    SELECT idPlanEstudios, nombre
    FROM PlanEstudios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ListarSedes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ListarSedes`()
BEGIN
    SELECT idSede, nombre
    FROM Sede;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerAdministradorPorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerAdministradorPorID`(
    IN p_idAdmin BIGINT
)
BEGIN
    SELECT idAdmin, nombre, email
    FROM Administrador
    WHERE idAdmin = p_idAdmin;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerCursoPorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerCursoPorID`(
    IN p_idCurso BIGINT
)
BEGIN
    SELECT idCurso, codigo, nombre
    FROM Curso
    WHERE idCurso = p_idCurso;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerCursosMXsolicitudRNDeSolicitudId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerCursosMXsolicitudRNDeSolicitudId`(
    IN p_fkSolicitudRN BIGINT
)
BEGIN
    SELECT C.codigo AS codigo_curso, C.nombre AS nombre_curso
    FROM cursosmXsolicitudRN AS CMX
             JOIN Curso AS C ON CMX.fkCurso = C.idCurso
    WHERE CMX.fkSolicitudRN = p_fkSolicitudRN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerCursosXsolicitudRNDeSolicitudId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerCursosXsolicitudRNDeSolicitudId`(
    IN p_fkSolicitudRN BIGINT
)
BEGIN
    SELECT C.codigo, C.nombre
    FROM cursosrnXsolicitudRN AS CXSRN
             INNER JOIN Curso AS C ON CXSRN.fkCurso = C.idCurso
    WHERE CXSRN.fkSolicitudRN = p_fkSolicitudRN;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerNombreDeCurso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `obtenerNombreDeCurso`(IN cursoID INT)
BEGIN
  SELECT nombre FROM curso WHERE idCurso = cursoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerPlanEstudiosPorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerPlanEstudiosPorID`(
    IN p_idPlanEstudios BIGINT
)
BEGIN
    SELECT idPlanEstudios, nombre
    FROM PlanEstudios
    WHERE idPlanEstudios = p_idPlanEstudios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerResultados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerResultados`()
BEGIN
    SELECT
        S.nombreCompleto,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' -- caso de error
        END AS estadoTexto,
        CM.nombre AS nombreCursoMatricular,
        CL.nombre AS nombreCursoLevantar,
        S.email
    FROM SolicitudReq SR
    INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
    LEFT JOIN Curso CM ON SR.fkCursoMatricular = CM.idCurso
    LEFT JOIN Curso CL ON SR.fkCursoLevantar = CL.idCurso
    UNION
    SELECT
        S.nombreCompleto,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' -- caso de error
        END AS estadoTexto,
        CMN.nombre AS nombreCursoMatricular,
        CLN.nombre AS nombreCursoLevantar,
        S.email
    FROM SolicitudRN SRN
    INNER JOIN Solicitud S ON SRN.fkSolicitud = S.idSolicitud
    LEFT JOIN Curso CMN ON SRN.fkCursoMatricular = CMN.idCurso
    LEFT JOIN Curso CLN ON SRN.fkCursoLevantar = CLN.idCurso;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerResultadosNormal` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerResultadosNormal`()
BEGIN
    SELECT
        S.nombreCompleto,
        S.idSolicitud,
        S.carnet,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' -- caso de error
        END AS estadoTexto,
        CM.nombre AS nombreCursoMatricular,
        CL.nombre AS nombreCursoLevantar,
        CL.codigo AS codigo, 
        SE.nombre AS Sede,
        PE.nombre AS PlanEstudio,
        S.email,
        S.razon,
        S.comentario,
        S.ComentarioEncargado
    FROM SolicitudReq SR
    INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
    LEFT JOIN Curso CM ON SR.fkCursoMatricular = CM.idCurso
    LEFT JOIN Sede SE ON S.fkSede = SE.idSede
    LEFT JOIN planestudios PE ON  S.fkPlanEstudios = PE.idPlanEstudios
    LEFT JOIN Curso CL ON SR.fkCursoLevantar = CL.idCurso;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerResultadosNormalId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerResultadosNormalId`(
    IN formularioId INT
)
BEGIN
    SELECT
        S.nombreCompleto,
        S.idSolicitud,
        S.carnet,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' -- caso de error
        END AS estadoTexto,
        CM.nombre AS nombreCursoMatricular,
        CL.nombre AS nombreCursoLevantar,
        CL.codigo AS codigo, 
        SE.nombre AS Sede,
        PE.nombre AS PlanEstudio,
        S.email,
        S.razon,
        S.comentario,
        S.ComentarioEncargado
    FROM SolicitudReq SR
    INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
    LEFT JOIN Curso CM ON SR.fkCursoMatricular = CM.idCurso
    LEFT JOIN Sede SE ON S.fkSede = SE.idSede
    LEFT JOIN planestudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
    LEFT JOIN Curso CL ON SR.fkCursoLevantar = CL.idCurso
    WHERE S.fkFormulario = formularioId; -- Filtrar por el ID de formulario proporcionado
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerResultadosRN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerResultadosRN`()
BEGIN
    SELECT
        S.nombreCompleto,
        S.idSolicitud,
        S.carnet,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' -- caso de error
        END AS estadoTexto,
        SE.nombre AS Sede,
        PE.nombre AS PlanEstudio,
        S.email,
        S.comentario,
        S.razon,
        S.ComentarioEncargado
    FROM SolicitudRN SR
    INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
    LEFT JOIN Sede SE ON S.fkSede = SE.idSede
    LEFT JOIN planestudios PE ON  S.fkPlanEstudios = PE.idPlanEstudios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerResultadosRNId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerResultadosRNId`(
    IN formularioId INT
)
BEGIN
    SELECT
        S.nombreCompleto,
        S.idSolicitud,
        S.carnet,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' -- caso de error
        END AS estadoTexto,
        SE.nombre AS Sede,
        PE.nombre AS PlanEstudio,
        S.email,
        S.razon,
        S.comentario,
        S.ComentarioEncargado
    FROM SolicitudRN SR
    INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
    LEFT JOIN Sede SE ON S.fkSede = SE.idSede
    LEFT JOIN planestudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
    WHERE S.fkFormulario = formularioId; -- Filtrar por el ID de formulario proporcionado
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerSedePorID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerSedePorID`(
    IN p_idSede BIGINT
)
BEGIN
    SELECT idSede, nombre
    FROM Sede
    WHERE idSede = p_idSede;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerSolicitudesRNDeFormulario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerSolicitudesRNDeFormulario`(IN p_idFormulario BIGINT)
BEGIN
    SELECT
        SRN.*,
        S.carnet,
        S.nombreCompleto,
        PE.nombre AS nombrePlanEstudios,
        SE.nombre AS nombreSede,
        S.comentario,
        S.comentarioEncargado,
        S.email,
        S.razon,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'Desconocida' -- Manejo de otros valores de estado si es necesario
        END AS estadoTexto,
        S.notificado
    FROM SolicitudRN SRN
    INNER JOIN Solicitud S ON SRN.fkSolicitud = S.idSolicitud
    INNER JOIN PlanEstudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
    INNER JOIN Sede SE ON S.fkSede = SE.idSede
    WHERE S.fkFormulario = p_idFormulario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerSolicitudReqCarnet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerSolicitudReqCarnet`(
    IN p_carnet INT
)
BEGIN
    SELECT
        SR.*,
        S.carnet,
        S.nombreCompleto,
        PE.nombre AS nombrePlanEstudios,
        SE.nombre AS nombreSede,
        S.comentario,
        S.email,
        S.fkFormulario,
        F.nombre,
		CM.nombre AS nombreCursoMatricular,
        CL.nombre AS nombreCursoLevantar,
        CL.codigo AS codigo, 
         CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' 
        END AS estado,
         CASE
            WHEN S.notificado = 0 THEN 'No se ha notificado'
            WHEN S.notificado = 1 THEN 'se ha notificado'
            ELSE 'ERROR'
        END AS notificacion,
		S.razon
    FROM SolicitudReq SR
             INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
             INNER JOIN PlanEstudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
             INNER JOIN Sede SE ON S.fkSede = SE.idSede
             LEFT JOIN Curso CM ON SR.fkCursoMatricular = CM.idCurso
             LEFT JOIN Curso CL ON SR.fkCursoLevantar = CL.idCurso
             INNER JOIN formulario F ON S.fkFormulario = F.idFormulario
    WHERE S.idSolicitud IN (SELECT idSolicitud FROM Solicitud WHERE carnet = p_carnet);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerSolicitudReqDeFormulario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerSolicitudReqDeFormulario`(IN p_idFormulario BIGINT)
BEGIN
    SELECT
        SR.*,
        S.carnet,
        S.nombreCompleto,
        PE.nombre AS nombrePlanEstudios,
        SE.nombre AS nombreSede,
        S.comentario,
        S.comentarioEncargado,
        S.email,
        S.razon,
        CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' --      caso de error
        END AS estadoTexto,
        S.notificado,
        CM.nombre AS nombreCursoMatricular,
        CL.nombre AS nombreCursoLevantar
    FROM SolicitudReq SR
    INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
    INNER JOIN PlanEstudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
    INNER JOIN Sede SE ON S.fkSede = SE.idSede
    LEFT JOIN Curso CM ON SR.fkCursoMatricular = CM.idCurso
    LEFT JOIN Curso CL ON SR.fkCursoLevantar = CL.idCurso
    WHERE S.fkFormulario = p_idFormulario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerSolicitudReqDeSolicitud` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerSolicitudReqDeSolicitud`(
    IN p_idSolicitud BIGINT
)
BEGIN
    SELECT
        SR.*,
        S.carnet,
        S.nombreCompleto,
        PE.nombre AS nombrePlanEstudios,
        SE.nombre AS nombreSede,
        S.comentario,
        S.email,
        S.razon,
        S.estado,
        S.notificado
    FROM SolicitudReq SR
             INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
             INNER JOIN PlanEstudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
             INNER JOIN Sede SE ON S.fkSede = SE.idSede
    WHERE S.idSolicitud = p_idSolicitud;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerSolicitudRNCarnet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerSolicitudRNCarnet`(
    IN p_carnet INT
)
BEGIN
    SELECT
        SR.*,
        S.carnet,
        S.fkFormulario,
        S.nombreCompleto,
        PE.nombre AS nombrePlanEstudios,
        SE.nombre AS nombreSede,
        S.comentario,
        S.email,
        F.nombre,
         CASE
            WHEN S.estado = 0 THEN 'Rechazada'
            WHEN S.estado = 1 THEN 'Aprobada'
            ELSE 'ERROR' 
        END AS estado,
         CASE
            WHEN S.notificado = 0 THEN 'No se ha notificado'
            WHEN S.notificado = 1 THEN 'se ha notificado'
            ELSE 'ERROR'
        END AS notificacion,
		S.razon
    FROM SolicitudRN SR
             INNER JOIN Solicitud S ON SR.fkSolicitud = S.idSolicitud
             INNER JOIN PlanEstudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
             INNER JOIN Sede SE ON S.fkSede = SE.idSede
             INNER JOIN formulario F ON S.fkFormulario = F.idFormulario
    WHERE S.idSolicitud IN (SELECT idSolicitud FROM Solicitud WHERE carnet = p_carnet);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerSolicitudRNDeSolicitud` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `ObtenerSolicitudRNDeSolicitud`(
    IN p_idSolicitud BIGINT
)
BEGIN
    SELECT
        SRN.*,
        S.carnet,
        S.nombreCompleto,
        PE.nombre AS nombrePlanEstudios,
        SE.nombre AS nombreSede,
        S.comentario,
        S.email,
        S.razon,
        S.estado,
        S.notificado
    FROM SolicitudRN SRN
             INNER JOIN Solicitud S ON SRN.fkSolicitud = S.idSolicitud
             INNER JOIN PlanEstudios PE ON S.fkPlanEstudios = PE.idPlanEstudios
             INNER JOIN Sede SE ON S.fkSede = SE.idSede
    WHERE S.idSolicitud = p_idSolicitud;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SeleccionarFormularioPorId` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `SeleccionarFormularioPorId`(
    IN p_idFormulario BIGINT
)
BEGIN
    SELECT
        F.*,
        P.semestre,
        YEAR(P.periodo) AS año
    FROM Formulario F
             INNER JOIN Periodo P ON F.fkPeriodo = P.idPeriodo
    WHERE F.idFormulario = p_idFormulario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SeleccionarFormularios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `SeleccionarFormularios`()
BEGIN
    SELECT f.idFormulario AS FormularioID, f.nombre , f.fechaVencimiento, p.semestre
    FROM formulario f
    JOIN periodo p ON f.fkPeriodo = p.idPeriodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SeleccionarFormulariosConPeriodo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `SeleccionarFormulariosConPeriodo`()
BEGIN
    SELECT
        F.idFormulario,
        F.fechaVencimiento,
        F.nombre AS nombreFormulario,
        P.semestre,
        YEAR(P.periodo) AS año
    FROM Formulario F
             INNER JOIN Periodo P ON F.fkPeriodo = P.idPeriodo;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerificarCredenciales` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `VerificarCredenciales`(
    IN p_email VARCHAR(128),
    IN p_clave VARCHAR(128)
)
BEGIN
    DECLARE adminCount INT;

    SELECT COUNT(*) INTO adminCount
    FROM Administrador
    WHERE email = p_email AND clave = p_clave;

    IF adminCount = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Credenciales inválidas';
    ELSE
        SELECT idAdmin, nombre, email
        FROM Administrador
        WHERE email = p_email AND clave = p_clave;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `VerificarTokenUnico` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`b7af72ef51bc8c`@`%` PROCEDURE `VerificarTokenUnico`(
    IN p_token VARCHAR(128)
)
BEGIN
    DECLARE v_tokenCount INT;

    -- Contar cuántas solicitudes tienen el mismo token
    SELECT COUNT(*) INTO v_tokenCount
    FROM Solicitud
    WHERE token = p_token;

    IF v_tokenCount = 0 THEN
        SELECT 'Token es único en la tabla Solicitud.' AS mensaje;
    ELSE
        SELECT 'Token ya existe en la tabla Solicitud.' AS mensaje;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-07  4:47:00
