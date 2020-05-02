-- MariaDB dump 10.17  Distrib 10.4.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: gescitas
-- ------------------------------------------------------
-- Server version	10.4.12-MariaDB-1:10.4.12+maria~eoan-log

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
-- Table structure for table `ci_sessions`
--

DROP TABLE IF EXISTS `ci_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT 0,
  `data` blob NOT NULL,
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ci_sessions`
--


--
-- Table structure for table `citas`
--

DROP TABLE IF EXISTS `citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `citas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idcliente` int(11) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `color` varchar(10) NOT NULL DEFAULT '#9a5680',
  `textcolor` varchar(10) NOT NULL DEFAULT '#000000',
  `editable` bit(1) DEFAULT b'0',
  `pago` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  KEY `FK_cli_ci` (`idcliente`),
  CONSTRAINT `FK_cli_ci` FOREIGN KEY (`idcliente`) REFERENCES `clientes` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citas`
--

LOCK TABLES `citas` WRITE;
/*!40000 ALTER TABLE `citas` DISABLE KEYS */;
INSERT INTO `citas` VALUES (1,1,'CITA 1','PROBANDO CITA 1','2020-03-16 10:30:00','2020-03-16 11:00:00','#9a5680','#000000','\0','\0'),(2,1,'CITA 2','2ª PRUEBA','2020-03-17 16:00:00','2020-03-17 16:30:00','#9a5680','#000000','\0','\0'),(3,1,'CITA 3','PRUEBA ERRONEA','2020-03-17 16:30:00','2020-03-17 17:00:00','#9a5680','#000000','\0','\0'),(5,1,'CITA 5','PRUEBA ERRONEA','2020-03-17 17:30:00','2020-03-17 18:00:00','#9a5680','#000000','\0','\0'),(28,4,'Daniel','otra mas','2020-03-20 08:00:00','2020-03-20 08:30:00','#9a5680','#000000','\0','\0'),(30,4,'Daniel','otra mas','2020-03-20 15:00:00','2020-03-20 15:30:00','#9a5680','#000000','\0','\0'),(31,4,'Daniel','erg','2020-03-20 00:00:00','2020-03-21 00:00:00','#9a5680','#000000','\0','\0'),(32,4,'Daniel','otro dia','2020-03-17 13:00:00','2020-03-17 13:30:00','#9a5680','#000000','\0','\0'),(34,4,'Daniel','prueba refresh','2020-03-18 07:00:00','2020-03-18 07:30:00','#9a5680','#000000','\0','\0'),(35,4,'Daniel','prueba refresh','2020-03-16 06:00:00','2020-03-16 06:30:00','#9a5680','#000000','\0','\0'),(36,4,'Daniel','dfg','2020-03-19 08:00:00','2020-03-19 08:30:00','#9a5680','#000000','\0','\0'),(37,4,'Daniel','prirj','2020-03-19 11:30:00','2020-03-19 12:00:00','#9a5680','#000000','\0','\0'),(38,4,'Daniel','zxfdg','2020-03-19 06:30:00','2020-03-19 07:00:00','#9a5680','#000000','\0','\0'),(39,4,'Daniel','Prueba ;-)','2020-03-18 08:30:00','2020-03-18 09:00:00','#9a5680','#000000','\0','\0'),(40,4,'Daniel','probando','2020-03-10 06:30:00','2020-03-10 07:00:00','#9a5680','#000000','\0','\0'),(41,4,'Daniel','otra m,as','2020-03-09 08:30:00','2020-03-09 09:00:00','#9a5680','#000000','\0','\0'),(43,4,'Daniel','xzcgdfsh','2020-03-02 10:00:00','2020-03-02 10:30:00','#9a5680','#000000','\0','\0'),(44,4,'Daniel','Walterius Genio!!','2020-03-19 16:00:00','2020-03-19 16:15:00','#9a5680','#000000','\0','\0'),(45,4,'Daniel','Genio otra vez?','2020-03-19 16:45:00','2020-03-19 17:00:00','#9a5680','#000000','\0','\0'),(46,4,'Daniel','a ver si ahora si','2020-03-19 17:15:00','2020-03-19 17:30:00','#9a5680','#000000','\0','\0'),(47,4,'Daniel','adf','2020-03-19 17:30:00','2020-03-19 17:45:00','#9a5680','#000000','\0','\0'),(49,4,'Daniel','dsfh','2020-03-19 16:30:00','2020-03-19 16:45:00','#9a5680','#000000','\0','\0'),(51,4,'Daniel','Ahora si funciona','2020-03-19 17:45:00','2020-03-19 18:00:00','#9a5680','#000000','\0','\0'),(53,4,'Daniel','probando 3 slots','2020-03-17 18:15:00','2020-03-17 19:00:00','#9a5680','#000000','\0','\0'),(55,4,'Daniel','Probando nueva semana','2020-03-24 16:15:00','2020-03-24 16:30:00','#9a5680','#000000','\0','\0'),(56,4,'Daniel','Prueba 2 semana nueva','2020-03-26 16:30:00','2020-03-26 17:00:00','#9a5680','#000000','\0','\0'),(57,3,'admin','Este es el admin','2020-03-24 17:15:00','2020-03-24 17:30:00','#9a5680','#000000','\0','\0'),(58,1,'JUAN','Este es juan','2020-03-26 17:30:00','2020-03-26 17:45:00','#9a5680','#000000','\0','\0'),(59,1,'JUAN','Doble turno','2020-03-24 18:30:00','2020-03-24 19:00:00','#9a5680','#000000','\0','\0'),(60,2,'PEDRO','Este es otro','2020-03-24 16:45:00','2020-03-24 17:00:00','#9a5680','#000000','\0','\0'),(63,5,'juan','Soy pepita','2020-03-24 18:00:00','2020-03-24 18:15:00','#9a5680','#000000','\0','\0'),(64,10,'Max','Estoy fatal','2020-03-26 16:00:00','2020-03-26 16:30:00','#9a5680','#000000','\0','\0');
/*!40000 ALTER TABLE `citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) DEFAULT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `dni` varchar(10) DEFAULT NULL,
  `mail` varchar(200) DEFAULT NULL,
  `psw` varchar(50) DEFAULT NULL,
  `dir` varchar(200) DEFAULT NULL,
  `cp` varchar(200) DEFAULT NULL,
  `localidad` varchar(100) DEFAULT NULL,
  `provincia` varchar(100) DEFAULT NULL,
  `tel1` varchar(15) DEFAULT NULL,
  `tel2` varchar(15) DEFAULT NULL,
  `comentario` text DEFAULT NULL,
  `nivel` int(11) NOT NULL DEFAULT 2 COMMENT 'Nivel de Acceso 1=Admin 2=USR Normal',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'JUAN','GARCIA PERALTA','54123654A','juan@mail.com','81dc9bdb52d04dc20036dbd8313ed055','calle de la amargura 32','54321','ALGUNA','OTRA','612123123',NULL,'PAGADOR',2),(2,'PEDRO','PEREZ NUÑEZ','74123123B','pedro@mail.com','81dc9bdb52d04dc20036dbd8313ed055','calle malavida 28','54321','ALGUNA','OTRA','612123123',NULL,'PAGADOR',2),(3,'admin',NULL,NULL,'admin@gmail.com','81dc9bdb52d04dc20036dbd8313ed055',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(4,'Daniel','Perez','40123123-R','pepo@mail.com','81dc9bdb52d04dc20036dbd8313ed055','Mi Calle Nro 43, 1º 3ª','08411','San Isidro','La quica','654123123','965321987','Probando ..........',2),(5,'juan','Perez','123456988','wal@mail.com','81dc9bdb52d04dc20036dbd8313ed055','mi calle 21','12345','el mundo','una de tantas','612123123','','probando',2),(9,'Manolo','Ordoñes','12345678','manolo@mail.com','81dc9bdb52d04dc20036dbd8313ed055','Calle manolistas 7824, 2º A','00000','El Matador','Torrealta','123123123','','',2),(10,'Max','Graneros','123654987Ñ','max@mail.com','81dc9bdb52d04dc20036dbd8313ed055','Calle Abierta 872','11111','Miranda','Aire Libre','612123123','','',2);
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hisnotas`
--

DROP TABLE IF EXISTS `hisnotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hisnotas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idcliente` int(11) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `idcita` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cit_his` (`idcita`),
  CONSTRAINT `FK_cit_his` FOREIGN KEY (`idcita`) REFERENCES `citas` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hisnotas`
--

LOCK TABLES `hisnotas` WRITE;
/*!40000 ALTER TABLE `hisnotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `hisnotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'gescitas'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-24 20:34:08
