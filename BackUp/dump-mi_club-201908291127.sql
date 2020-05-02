-- MariaDB dump 10.17  Distrib 10.4.5-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: mi_club
-- ------------------------------------------------------
-- Server version	10.4.5-MariaDB

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
-- Table structure for table `cuotas`
--

DROP TABLE IF EXISTS `cuotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cuotas` (
  `id_cuota` int(11) NOT NULL AUTO_INCREMENT,
  `id_socio` int(11) DEFAULT NULL,
  `fecha_pago` date DEFAULT NULL,
  `importe_cuota` decimal(8,2) DEFAULT NULL,
  `anotaciones` text DEFAULT NULL,
  PRIMARY KEY (`id_cuota`),
  KEY `id_socio` (`id_socio`),
  CONSTRAINT `cuotas_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socios` (`id_socio`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuotas`
--

LOCK TABLES `cuotas` WRITE;
/*!40000 ALTER TABLE `cuotas` DISABLE KEYS */;
INSERT INTO `cuotas` VALUES (1,1,'2010-12-25',100.00,' El cliente tiene las cuentas saldadas'),(2,2,NULL,0.00,' El cliente no paga'),(3,3,'2010-12-25',50.00,' El cliente tiene las cuentas saldadas'),(4,4,'2010-12-25',40.00,' El cliente tiene las cuentas saldadas'),(5,5,'2010-12-25',30.00,' El cliente tiene las cuentas saldadas'),(6,6,'2010-12-25',5.00,' El cliente debe dinero'),(7,7,'2010-12-25',4.00,' El cliente debe dinero'),(8,8,'2010-12-25',2.00,' El cliente debe dinero'),(9,1,'2010-12-25',15.00,'El cliente tiene dinero'),(10,10,'2010-12-25',120.00,'Cliente solvente');
/*!40000 ALTER TABLE `cuotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socios`
--

DROP TABLE IF EXISTS `socios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socios` (
  `id_socio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(15) DEFAULT NULL,
  `apellidos` varchar(25) DEFAULT NULL,
  `dni` varchar(9) DEFAULT NULL,
  `domicilio` varchar(50) DEFAULT NULL,
  `localidad` varchar(30) DEFAULT NULL,
  `tipo_socio` enum('A','B','C') DEFAULT NULL,
  `fecha_alta` date DEFAULT NULL,
  `fecha_baja` date DEFAULT NULL,
  `paga_ult_recibo` set('S','N') DEFAULT NULL,
  `anotaciones` blob DEFAULT NULL,
  PRIMARY KEY (`id_socio`),
  KEY `dni` (`dni`),
  KEY `apellidos` (`apellidos`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socios`
--

LOCK TABLES `socios` WRITE;
/*!40000 ALTER TABLE `socios` DISABLE KEYS */;
INSERT INTO `socios` VALUES (1,'Oscar','De la Cuesta ','12660481','La direcion','Palencia','A','2010-11-25','2010-12-20','S','Este cliente soy yo'),(2,'Joel','Morta','78546754','C Gandia','Valencia','C','2010-11-25',NULL,'N','Este cliente es un moroso'),(3,'Pedro','Anero','124342340','C Buenos aires','Barcelona','B','2010-12-01','2010-12-20','S','Cliente habitual'),(4,'Ana','Rodriguez','34343444','C Serrano','Madrid','B','2010-12-01','2010-12-20','S','Solo veranos'),(5,'Luis','Serrit','12776043','C Las brisas','Santander','C','2010-11-25','2010-12-25','S','Invierno'),(6,'Maria','Arcona','33176043','C Asador','Santander','C',NULL,NULL,'S','Epoca de Verano'),(7,'Jose','Coma','12773343','C Valverde','Palencia','A','2010-11-25','2010-12-25','S','No es un cliente habitual'),(8,'Marcos','Garcia','12224343','C Los pedernales','Palencia','A','2010-11-25','2010-12-25','S','Le gusta el senderismo'),(9,'Beatriz','Arconada','12324343','C Los Girasoles','Palencia','B','2010-11-25','2010-12-25','S','Posee tarjeta de descuento'),(10,'Veronica','Artea','54124343','C lobro','Palencia','A','2010-11-25','2010-12-25','S','Cliente bastante formal');
/*!40000 ALTER TABLE `socios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'mi_club'
--
