-- MariaDB dump 10.17  Distrib 10.4.10-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: prohabitat
-- ------------------------------------------------------
-- Server version	10.4.10-MariaDB-1:10.4.10+maria~eoan-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `edificios`
--

DROP TABLE IF EXISTS `edificios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edificios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `cp` varchar(5) DEFAULT NULL,
  `poblacion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edificios`
--

LOCK TABLES `edificios` WRITE;
/*!40000 ALTER TABLE `edificios` DISABLE KEYS */;
INSERT INTO `edificios` VALUES (1,'MIQUEL VIVES','CALLE MIQUEL VIVES 87','08222','TERRASSA');
/*!40000 ALTER TABLE `edificios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entsal`
--

DROP TABLE IF EXISTS `entsal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entsal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idinquilino` int(11) DEFAULT NULL,
  `idpiso` int(11) DEFAULT NULL,
  `estado` varchar(10) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `lgas` int(11) DEFAULT NULL,
  `lluz` int(11) DEFAULT NULL,
  `lagua` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_es_inq` (`idinquilino`),
  KEY `FK_es_pis` (`idpiso`),
  CONSTRAINT `FK_es_inq` FOREIGN KEY (`idinquilino`) REFERENCES `inquilinos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_es_pis` FOREIGN KEY (`idpiso`) REFERENCES `pisos` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entsal`
--

LOCK TABLES `entsal` WRITE;
/*!40000 ALTER TABLE `entsal` DISABLE KEYS */;
/*!40000 ALTER TABLE `entsal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `facturas`
--

DROP TABLE IF EXISTS `facturas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facturas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(30) DEFAULT NULL,
  `fechaf` date DEFAULT NULL,
  `importe` decimal(15,2) DEFAULT NULL,
  `fdes` date DEFAULT NULL,
  `fhas` date DEFAULT NULL,
  `lant` int(11) DEFAULT NULL,
  `lact` int(11) DEFAULT NULL,
  `periodo` varchar(30) DEFAULT NULL,
  `idservicio` int(11) DEFAULT NULL,
  `idpiso` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_fac_serv` (`idservicio`),
  KEY `FK_fac_pis` (`idpiso`),
  CONSTRAINT `FK_fac_pis` FOREIGN KEY (`idpiso`) REFERENCES `pisos` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_fac_serv` FOREIGN KEY (`idservicio`) REFERENCES `servicios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `facturas`
--

LOCK TABLES `facturas` WRITE;
/*!40000 ALTER TABLE `facturas` DISABLE KEYS */;
INSERT INTO `facturas` VALUES (1,'FE19137029642005','2019-11-10',28.53,'2019-09-05','2019-11-04',3489,3500,'5 Bimestre',3,1);
/*!40000 ALTER TABLE `facturas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inquilinos`
--

DROP TABLE IF EXISTS `inquilinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inquilinos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(50) DEFAULT NULL,
  `nick` varchar(25) DEFAULT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `telefono` varchar(12) DEFAULT NULL,
  `mail` varchar(100) DEFAULT NULL,
  `pax` decimal(3,1) DEFAULT NULL,
  `comentario` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inquilinos`
--

LOCK TABLES `inquilinos` WRITE;
/*!40000 ALTER TABLE `inquilinos` DISABLE KEYS */;
INSERT INTO `inquilinos` VALUES (1,'Juan Ignacio','Garcia Contreras','juancho','54122321O','654123987','juancho@mail.com',1.0,'Se a comportado correctamente'),(2,'Jose Miguel','Hernandez Garcia','josemi','41789652H','632789123','josemiguel@gmail.com',1.0,'Buen tipo,  a pagado siempre'),(3,'Gonzalo','Tadeo Jhons','gonza','35987456P','652987451','gonzalo@mail.com',1.0,'Dejo los grifos mal'),(4,'Hernan','Perez Nuñes','pernu','21392004M','635784852','herper@gmail.com',1.0,'Nunca debe nada'),(5,'Jason','Salazar Pérez','jason','35845127K','612123456','jasape@gmail.es',1.0,'Sin comentarios'),(6,'Osvaldo','Contreras','gruñon','123654987Ñ','612123456','gruon@gmail.com',1.5,'Tiene mucha mala ostia');
/*!40000 ALTER TABLE `inquilinos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pisos`
--

DROP TABLE IF EXISTS `pisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pisos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idEdificio` int(11) DEFAULT NULL,
  `planta` varchar(5) DEFAULT NULL,
  `puerta` varchar(5) DEFAULT NULL,
  `escalera` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pis_edi` (`idEdificio`),
  CONSTRAINT `FK_pis_edi` FOREIGN KEY (`idEdificio`) REFERENCES `edificios` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pisos`
--

LOCK TABLES `pisos` WRITE;
/*!40000 ALTER TABLE `pisos` DISABLE KEYS */;
INSERT INTO `pisos` VALUES (1,1,'3','6','1');
/*!40000 ALTER TABLE `pisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicios`
--

DROP TABLE IF EXISTS `servicios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `servicio` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicios`
--

LOCK TABLES `servicios` WRITE;
/*!40000 ALTER TABLE `servicios` DISABLE KEYS */;
INSERT INTO `servicios` VALUES (1,'LUZ'),(2,'AGUA'),(3,'GAS');
/*!40000 ALTER TABLE `servicios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `todo_facturas`
--

DROP TABLE IF EXISTS `todo_facturas`;
/*!50001 DROP VIEW IF EXISTS `todo_facturas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `todo_facturas` (
  `id` tinyint NOT NULL,
  `numero` tinyint NOT NULL,
  `fechaf` tinyint NOT NULL,
  `importe` tinyint NOT NULL,
  `fdes` tinyint NOT NULL,
  `fhas` tinyint NOT NULL,
  `lant` tinyint NOT NULL,
  `lact` tinyint NOT NULL,
  `periodo` tinyint NOT NULL,
  `servicio` tinyint NOT NULL,
  `idpiso` tinyint NOT NULL,
  `escalera` tinyint NOT NULL,
  `puerta` tinyint NOT NULL,
  `planta` tinyint NOT NULL,
  `edificio` tinyint NOT NULL,
  `edi_dir` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `todo_pisos`
--

DROP TABLE IF EXISTS `todo_pisos`;
/*!50001 DROP VIEW IF EXISTS `todo_pisos`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `todo_pisos` (
  `id` tinyint NOT NULL,
  `planta` tinyint NOT NULL,
  `puerta` tinyint NOT NULL,
  `escalera` tinyint NOT NULL,
  `nom_edificio` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) DEFAULT NULL,
  `psw` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'prohabitat'
--

--
-- Final view structure for view `todo_facturas`
--

/*!50001 DROP TABLE IF EXISTS `todo_facturas`*/;
/*!50001 DROP VIEW IF EXISTS `todo_facturas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `todo_facturas` AS select `facturas`.`id` AS `id`,`facturas`.`numero` AS `numero`,`facturas`.`fechaf` AS `fechaf`,`facturas`.`importe` AS `importe`,`facturas`.`fdes` AS `fdes`,`facturas`.`fhas` AS `fhas`,`facturas`.`lant` AS `lant`,`facturas`.`lact` AS `lact`,`facturas`.`periodo` AS `periodo`,`servicios`.`servicio` AS `servicio`,`facturas`.`idpiso` AS `idpiso`,`pisos`.`escalera` AS `escalera`,`pisos`.`puerta` AS `puerta`,`pisos`.`planta` AS `planta`,`edificios`.`nombre` AS `edificio`,`edificios`.`direccion` AS `edi_dir` from (((`facturas` left join `servicios` on(`facturas`.`idservicio` = `servicios`.`id`)) left join `pisos` on(`facturas`.`idpiso` = `pisos`.`id`)) left join `edificios` on(`pisos`.`idEdificio` = `edificios`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `todo_pisos`
--

/*!50001 DROP TABLE IF EXISTS `todo_pisos`*/;
/*!50001 DROP VIEW IF EXISTS `todo_pisos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_unicode_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `todo_pisos` AS select `pisos`.`id` AS `id`,`pisos`.`planta` AS `planta`,`pisos`.`puerta` AS `puerta`,`pisos`.`escalera` AS `escalera`,`edificios`.`nombre` AS `nom_edificio` from (`pisos` left join `edificios` on(`pisos`.`idEdificio` = `edificios`.`id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-11-26 16:01:15
