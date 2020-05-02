-- MariaDB dump 10.17  Distrib 10.4.4-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: HostelGes
-- ------------------------------------------------------
-- Server version	10.4.4-MariaDB

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
-- Table structure for table `carta`
--

DROP TABLE IF EXISTS `carta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto` varchar(50) DEFAULT NULL,
  `precio` decimal(8,2) DEFAULT NULL,
  `existe` tinyint(1) DEFAULT NULL,
  `imagen` blob DEFAULT NULL,
  `idPertenece` int(11) DEFAULT NULL,
  `idIVA` int(11) DEFAULT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_CAR_per` (`idPertenece`),
  KEY `fk_CAR_IVA` (`idIVA`),
  KEY `fk_CAR_Cat` (`idCategoria`),
  CONSTRAINT `fk_CAR_Cat` FOREIGN KEY (`idCategoria`) REFERENCES `carta_categorias` (`id`),
  CONSTRAINT `fk_CAR_IVA` FOREIGN KEY (`idIVA`) REFERENCES `iva` (`id`),
  CONSTRAINT `fk_CAR_per` FOREIGN KEY (`idPertenece`) REFERENCES `carta_pertenece` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carta`
--

LOCK TABLES `carta` WRITE;
/*!40000 ALTER TABLE `carta` DISABLE KEYS */;
INSERT INTO `carta` VALUES (8,'PATATAS FRITAS',1.50,1,NULL,1,2,6),(9,'CHORIPAN',3.50,1,NULL,4,3,11),(10,'PIZZA ROMANA',5.00,1,NULL,3,3,10),(11,'PAELLA',3.00,1,NULL,1,3,10),(12,'COCA COLA',1.00,1,NULL,2,3,1),(13,'AGUA 1/2',0.75,1,NULL,2,3,1),(14,'CARAJILLO',1.25,1,NULL,2,2,2),(15,'CAFE SOLO',1.00,1,NULL,2,1,2);
/*!40000 ALTER TABLE `carta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carta_categorias`
--

DROP TABLE IF EXISTS `carta_categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carta_categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carta_categorias`
--

LOCK TABLES `carta_categorias` WRITE;
/*!40000 ALTER TABLE `carta_categorias` DISABLE KEYS */;
INSERT INTO `carta_categorias` VALUES (1,'BEBIDAS SIN ALCOHOL'),(2,'CAFES'),(3,'CERVEZAS'),(4,'VINOS'),(5,'COKTELERIA'),(6,'TAPAS'),(7,'PRIMEROS'),(8,'SEGUNDOS'),(9,'PLATOS COMBINADOS'),(10,'PLATOS'),(11,'BOCADILLOS');
/*!40000 ALTER TABLE `carta_categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carta_pertenece`
--

DROP TABLE IF EXISTS `carta_pertenece`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carta_pertenece` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pertenece` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carta_pertenece`
--

LOCK TABLES `carta_pertenece` WRITE;
/*!40000 ALTER TABLE `carta_pertenece` DISABLE KEYS */;
INSERT INTO `carta_pertenece` VALUES (1,'COCINA'),(2,'BARRA'),(3,'PIZZERIA'),(4,'BARBACOA');
/*!40000 ALTER TABLE `carta_pertenece` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comandas`
--

DROP TABLE IF EXISTS `comandas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comandas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unidades` int(11) DEFAULT NULL,
  `preparado` tinyint(1) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `notas` varchar(254) DEFAULT NULL,
  `devuelto` tinyint(1) DEFAULT NULL,
  `motivoDev` varchar(254) DEFAULT NULL,
  `idCarta` int(11) DEFAULT NULL,
  `idFormaPago` int(11) NOT NULL,
  `idMesa` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_COM_mesa` (`idMesa`),
  KEY `fk_COM_Carta` (`idFormaPago`),
  KEY `fk_COM_Car` (`idCarta`),
  CONSTRAINT `fk_COM_Car` FOREIGN KEY (`idCarta`) REFERENCES `carta` (`id`),
  CONSTRAINT `fk_COM_mesa` FOREIGN KEY (`idMesa`) REFERENCES `mesas` (`id`),
  CONSTRAINT `fk_com_FPago` FOREIGN KEY (`idFormaPago`) REFERENCES `formaPAgo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comandas`
--

LOCK TABLES `comandas` WRITE;
/*!40000 ALTER TABLE `comandas` DISABLE KEYS */;
/*!40000 ALTER TABLE `comandas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formaPAgo`
--

DROP TABLE IF EXISTS `formaPAgo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formaPAgo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pago` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formaPAgo`
--

LOCK TABLES `formaPAgo` WRITE;
/*!40000 ALTER TABLE `formaPAgo` DISABLE KEYS */;
INSERT INTO `formaPAgo` VALUES (1,'EFECTIVO'),(2,'TARGETA');
/*!40000 ALTER TABLE `formaPAgo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `iva`
--

DROP TABLE IF EXISTS `iva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `iva` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iva` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iva`
--

LOCK TABLES `iva` WRITE;
/*!40000 ALTER TABLE `iva` DISABLE KEYS */;
INSERT INTO `iva` VALUES (1,7),(2,18),(3,21);
/*!40000 ALTER TABLE `iva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mesas`
--

DROP TABLE IF EXISTS `mesas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mesas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nMesa` int(11) DEFAULT NULL,
  `fechaCreacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `cubiertos` int(11) DEFAULT NULL,
  `fechaCierre` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `descuento` int(11) DEFAULT NULL,
  `cerrada` tinyint(1) DEFAULT NULL,
  `idUsuario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_MESA_Usu` (`idUsuario`),
  CONSTRAINT `fk_MESA_Usu` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesas`
--

LOCK TABLES `mesas` WRITE;
/*!40000 ALTER TABLE `mesas` DISABLE KEYS */;
/*!40000 ALTER TABLE `mesas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `puesto`
--

DROP TABLE IF EXISTS `puesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `puesto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `puesto`
--

LOCK TABLES `puesto` WRITE;
/*!40000 ALTER TABLE `puesto` DISABLE KEYS */;
INSERT INTO `puesto` VALUES (1,'ADMIN'),(2,'CAJERO'),(3,'BARRA'),(4,'COCINA'),(5,'CAMARERO');
/*!40000 ALTER TABLE `puesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `USR` varchar(20) DEFAULT NULL,
  `PSW` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `tel` varchar(10) DEFAULT NULL,
  `notas` varchar(254) DEFAULT NULL,
  `permisos` varchar(20) DEFAULT NULL,
  `idPuesto` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_USU_Puesto` (`idPuesto`),
  CONSTRAINT `fk_USU_Puesto` FOREIGN KEY (`idPuesto`) REFERENCES `puesto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'walex','1234','wal@walex.com','DWP','612345789','Very Good!!',NULL,1),(2,'alex','1234','al@alex.com','ALC','698745123','So Good!!',NULL,1),(3,'Pepe','1234','pepe@gmail.com','Jose','693258741','Mister Camarero',NULL,5),(4,'Paco','1234','paco@gmail.com','Francisco','614785239','El Cocinitas',NULL,4);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'HostelGes'
--
