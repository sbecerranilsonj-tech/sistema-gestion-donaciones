-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: sistema_gestion_donaciones
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- ============================================
-- SISTEMA DE GESTION DE DONACIONES
-- Script Completo
-- ============================================

DROP DATABASE IF EXISTS sistema_gestion_donaciones;
CREATE DATABASE sistema_gestion_donaciones;
USE sistema_gestion_donaciones;

SET FOREIGN_KEY_CHECKS = 0;
--
-- Table structure for table `asignacion_voluntario_entrega`
--

DROP TABLE IF EXISTS `asignacion_voluntario_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignacion_voluntario_entrega` (
  `id_entrega` int(11) NOT NULL,
  `id_voluntario` int(11) NOT NULL,
  PRIMARY KEY (`id_entrega`,`id_voluntario`),
  KEY `id_voluntario` (`id_voluntario`),
  CONSTRAINT `asignacion_voluntario_entrega_ibfk_1` FOREIGN KEY (`id_entrega`) REFERENCES `entrega_donacion` (`id_entrega`),
  CONSTRAINT `asignacion_voluntario_entrega_ibfk_2` FOREIGN KEY (`id_voluntario`) REFERENCES `voluntario` (`id_voluntario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignacion_voluntario_entrega`
--

LOCK TABLES `asignacion_voluntario_entrega` WRITE;
/*!40000 ALTER TABLE `asignacion_voluntario_entrega` DISABLE KEYS */;
/*!40000 ALTER TABLE `asignacion_voluntario_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditoria_sistema`
--

DROP TABLE IF EXISTS `auditoria_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_sistema` (
  `id_auditoria` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `accion` varchar(200) DEFAULT NULL,
  `tabla_afectada` varchar(100) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id_auditoria`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `auditoria_sistema_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario_sistema` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_sistema`
--

LOCK TABLES `auditoria_sistema` WRITE;
/*!40000 ALTER TABLE `auditoria_sistema` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria_sistema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campania`
--

DROP TABLE IF EXISTS `campania`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campania` (
  `id_campania` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `estado` varchar(30) NOT NULL,
  PRIMARY KEY (`id_campania`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campania`
--

LOCK TABLES `campania` WRITE;
/*!40000 ALTER TABLE `campania` DISABLE KEYS */;
INSERT INTO `campania` VALUES (1,'Colecta Invierno','','2025-03-30','2025-03-31','Planificada'),(2,'Donación Escolar 2026','Útiles escolares para niños de bajos recursos','2026-03-01','2026-06-30','Activa'),(3,'Ayuda Médica Solidaria','Apoyo para tratamientos médicos urgentes','2026-02-01','2026-12-31','Activa'),(4,'Navidad con Amor','Entrega de juguetes en Navidad','2026-11-01','2026-12-25','Planificada'),(5,'Comedor Comunitario','Alimentos para familias vulnerables','2026-01-15','2026-08-30','Activa'),(6,'Abrigo para el Sur','Ropa de invierno para zonas altoandinas','2026-05-01','2026-07-31','Planificada'),(7,'Construyendo Esperanza','Mejoramiento de viviendas precarias','2026-04-01','2026-10-30','Activa'),(8,'Agua para Todos','Instalación de sistemas de agua potable','2026-03-10','2026-09-15','Activa'),(9,'Educación Digital','Donación de laptops para estudiantes','2026-02-20','2026-07-20','Activa'),(10,'Salud Rural','Campañas médicas en zonas rurales','2026-06-01','2026-11-01','Planificada'),(11,'Alimenta una Sonrisa','Canastas básicas para familias necesitadas','2026-01-10','2026-05-30','Finalizada'),(12,'Reforestando Perú','Plantación de árboles en zonas afectadas','2026-03-15','2026-12-01','Activa'),(13,'Emergencia por Lluvias','Apoyo a damnificados por lluvias intensas','2026-02-05','2026-04-30','Finalizada'),(14,'Becas Universitarias','Fondo para estudiantes destacados','2026-01-01','2026-12-31','Activa'),(15,'Apoyo a Adultos Mayores','Asistencia médica y alimentaria','2026-03-01','2026-09-30','Activa'),(16,'Inclusión Social','Programas de capacitación laboral','2026-04-01','2026-08-31','Planificada'),(17,'Ayuda Animal','Rescate y alimentación de animales abandonados','2026-02-15','2026-06-15','Activa'),(18,'Iluminando Comunidades','Instalación de paneles solares rurales','2026-05-01','2026-12-31','Planificada'),(19,'Salud Mental Juvenil','Terapias psicológicas gratuitas','2026-03-01','2026-10-01','Activa'),(20,'Deporte y Juventud','Implementos deportivos para colegios','2026-02-01','2026-07-01','Cancelada'),(21,'Solidaridad Amazónica','Apoyo a comunidades amazónicas vulnerables','2026-01-20','2026-09-20','Activa');
/*!40000 ALTER TABLE `campania` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_recurso_donado`
--

DROP TABLE IF EXISTS `categoria_recurso_donado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria_recurso_donado` (
  `id_categoria_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`id_categoria_recurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_recurso_donado`
--

LOCK TABLES `categoria_recurso_donado` WRITE;
/*!40000 ALTER TABLE `categoria_recurso_donado` DISABLE KEYS */;
/*!40000 ALTER TABLE `categoria_recurso_donado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunidad_vulnerable`
--

DROP TABLE IF EXISTS `comunidad_vulnerable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunidad_vulnerable` (
  `id_comunidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `ubicacion` varchar(200) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `cantidad_beneficiarios` int(11) DEFAULT NULL,
  `id_pais` int(11) NOT NULL,
  PRIMARY KEY (`id_comunidad`),
  KEY `id_pais` (`id_pais`),
  CONSTRAINT `comunidad_vulnerable_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id_pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunidad_vulnerable`
--

LOCK TABLES `comunidad_vulnerable` WRITE;
/*!40000 ALTER TABLE `comunidad_vulnerable` DISABLE KEYS */;
/*!40000 ALTER TABLE `comunidad_vulnerable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_donacion_recurso`
--

DROP TABLE IF EXISTS `detalle_donacion_recurso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_donacion_recurso` (
  `id_detalle_donacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_donacion` int(11) NOT NULL,
  `id_recurso` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id_detalle_donacion`),
  KEY `id_donacion` (`id_donacion`),
  KEY `id_recurso` (`id_recurso`),
  CONSTRAINT `detalle_donacion_recurso_ibfk_1` FOREIGN KEY (`id_donacion`) REFERENCES `donacion` (`id_donacion`),
  CONSTRAINT `detalle_donacion_recurso_ibfk_2` FOREIGN KEY (`id_recurso`) REFERENCES `recurso_donado` (`id_recurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_donacion_recurso`
--

LOCK TABLES `detalle_donacion_recurso` WRITE;
/*!40000 ALTER TABLE `detalle_donacion_recurso` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalle_donacion_recurso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donacion`
--

DROP TABLE IF EXISTS `donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donacion` (
  `id_donacion` int(11) NOT NULL AUTO_INCREMENT,
  `id_donante` int(11) NOT NULL,
  `id_campania` int(11) DEFAULT NULL,
  `tipo_donacion` varchar(30) NOT NULL,
  `estado_donacion` varchar(30) NOT NULL,
  `fecha_donacion` date NOT NULL,
  `monto` decimal(10,2) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`id_donacion`),
  KEY `id_donante` (`id_donante`),
  KEY `id_campania` (`id_campania`),
  CONSTRAINT `donacion_ibfk_1` FOREIGN KEY (`id_donante`) REFERENCES `donante` (`id_donante`),
  CONSTRAINT `donacion_ibfk_2` FOREIGN KEY (`id_campania`) REFERENCES `campania` (`id_campania`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donacion`
--

LOCK TABLES `donacion` WRITE;
/*!40000 ALTER TABLE `donacion` DISABLE KEYS */;
INSERT INTO `donacion` VALUES (31,1,1,'Monetaria','Confirmada','2026-03-01',500.00,'Apoyo para útiles escolares'),(32,2,2,'Monetaria','Confirmada','2026-03-02',1500.00,'Donación institucional'),(33,3,3,'Monetaria','Pendiente','2026-03-03',300.00,'Apoyo tratamiento médico'),(34,4,4,'En especie','Completada','2026-03-05',NULL,'Entrega de juguetes'),(35,5,5,'Monetaria','Confirmada','2026-03-06',750.00,'Donación comedor'),(36,6,6,'En especie','Confirmada','2026-03-07',NULL,'Entrega de ropa de abrigo'),(37,7,7,'Servicios','Confirmada','2026-03-08',NULL,'Voluntariado construcción'),(38,8,8,'Monetaria','Confirmada','2026-03-09',2000.00,'Proyecto agua potable'),(39,9,9,'Monetaria','Pendiente','2026-03-10',1000.00,'Donación equipos tecnológicos'),(40,10,10,'Servicios','Completada','2026-03-12',NULL,'Atención médica voluntaria'),(41,11,11,'Monetaria','Confirmada','2026-03-13',400.00,'Canastas básicas'),(42,12,12,'Monetaria','Confirmada','2026-03-14',2500.00,'Reforestación'),(43,13,13,'Monetaria','Cancelada','2026-03-15',800.00,'Emergencia por lluvias'),(44,14,14,'Monetaria','Confirmada','2026-03-16',3000.00,'Becas universitarias'),(45,15,15,'En especie','Confirmada','2026-03-17',NULL,'Entrega de alimentos'),(46,16,16,'Servicios','Pendiente','2026-03-18',NULL,'Capacitación laboral'),(47,17,17,'Monetaria','Confirmada','2026-03-19',600.00,'Rescate animal'),(48,18,18,'Monetaria','Confirmada','2026-03-20',4500.00,'Instalación paneles solares'),(49,19,19,'Monetaria','Completada','2026-03-21',900.00,'Apoyo psicológico'),(50,20,20,'En especie','Confirmada','2026-03-22',NULL,'Implementos deportivos'),(51,21,21,'Monetaria','Confirmada','2026-03-23',1200.00,'Apoyo comunidades amazónicas'),(52,22,2,'Monetaria','Pendiente','2026-03-24',2000.00,'Tratamientos médicos'),(53,23,3,'En especie','Confirmada','2026-03-25',NULL,'Juguetes navideños'),(54,24,4,'Monetaria','Confirmada','2026-03-26',5000.00,'Apoyo comedor'),(55,25,5,'Servicios','Confirmada','2026-03-27',NULL,'Voluntariado invierno'),(56,26,6,'Monetaria','Confirmada','2026-03-28',1800.00,'Mejoramiento viviendas'),(57,27,7,'Monetaria','Cancelada','2026-03-29',2200.00,'Sistema de agua'),(58,28,8,'Monetaria','Confirmada','2026-03-30',3200.00,'Donación laptops');
/*!40000 ALTER TABLE `donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donante`
--

DROP TABLE IF EXISTS `donante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donante` (
  `id_donante` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `tipo_donante` varchar(30) NOT NULL,
  `id_pais` int(11) NOT NULL,
  `fecha_registro` date NOT NULL,
  PRIMARY KEY (`id_donante`),
  KEY `id_pais` (`id_pais`),
  CONSTRAINT `donante_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `pais` (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donante`
--

LOCK TABLES `donante` WRITE;
/*!40000 ALTER TABLE `donante` DISABLE KEYS */;
INSERT INTO `donante` VALUES (1,'Carlos Mendoza','carlos.mendoza@gmail.com','987654321','Lima','Persona Natural',6,'2026-01-10'),(2,'Fundación Esperanza','contacto@esperanza.org','912345678','Arequipa','Institucion',6,'2026-01-15'),(3,'Municipalidad de Lima','contacto@munilima.gob.pe','901122334','Lima','Gobierno',6,'2026-02-01'),(4,'Corporación Vida','info@corporacionvida.com','967812345','Buenos Aires','Empresa',1,'2026-02-05'),(5,'Lucía Fernández','lucia.fernandez@gmail.com','934567890','Córdoba','Persona Natural',1,'2026-02-08'),(6,'Empresa Solidaria SAC','info@solidaria.com','945612378','Santiago','Empresa',2,'2026-02-10'),(7,'ONG Manos Unidas','contacto@manosunidas.org','923456789','Valparaíso','Institucion',2,'2026-02-12'),(8,'Juan Pérez','juan.perez@gmail.com','956789123','Bogotá','Persona Natural',3,'2026-02-15'),(9,'Alcaldía de Medellín','contacto@medellin.gov.co','934567812','Medellín','Gobierno',3,'2026-02-18'),(10,'Asociación Luz','contacto@asociacionluz.org','989234567','Ciudad de México','Institucion',5,'2026-02-20'),(11,'Roberto García','roberto.garcia@gmail.com','978123456','Guadalajara','Persona Natural',5,'2026-02-22'),(12,'Grupo Solidario','info@gruposolidario.com','901234567','Madrid','Empresa',4,'2026-03-01'),(13,'Fundación Futuro','contacto@fundacionfuturo.org','923987654','Barcelona','Institucion',4,'2026-03-03'),(14,'Andrea Castillo','andrea.castillo@gmail.com','990123456','São Paulo','Persona Natural',8,'2026-03-05'),(15,'Empresa Horizonte','info@horizonte.com.br','945765432','Rio de Janeiro','Empresa',8,'2026-03-07'),(16,'Daniel Morales','daniel.morales@gmail.com','956654321','Quito','Persona Natural',9,'2026-03-10'),(17,'Municipio de Guayaquil','contacto@guayaquil.gob.ec','967543210','Guayaquil','Gobierno',9,'2026-03-12'),(18,'Inversiones Global Corp','info@globalcorp.com','989321098','Nueva York','Empresa',15,'2026-03-15'),(19,'Patricia León','patricia.leon@gmail.com','978432109','Miami','Persona Natural',15,'2026-03-18'),(20,'Fundación Canadá Solidaria','contacto@canadasolidaria.org','912345111','Toronto','Institucion',16,'2026-03-20'),(21,'Gobierno de Ontario','contacto@ontario.ca','934561111','Ottawa','Gobierno',16,'2026-03-22'),(22,'ONG Sonrisa Global','contacto@sonrisa.fr','945671111','París','Institucion',17,'2026-03-25'),(23,'Élite Empresarial','info@elite.fr','956781111','Lyon','Empresa',17,'2026-03-27'),(24,'Marco Rossi','marco.rossi@gmail.com','967891111','Roma','Persona Natural',18,'2026-03-28'),(25,'Solidarity UK','info@solidarity.uk','978901111','Londres','Empresa',24,'2026-03-29'),(26,'Fundación Sakura','contacto@sakura.jp','989011111','Tokio','Institucion',21,'2026-03-30'),(27,'Helping Hands AU','info@helpinghands.au','900123456','Sídney','Institucion',23,'2026-04-01'),(28,'Berlin Corporate Aid','info@berlin-aid.de','911234567','Berlín','Empresa',19,'2026-04-02');
/*!40000 ALTER TABLE `donante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrega_donacion`
--

DROP TABLE IF EXISTS `entrega_donacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrega_donacion` (
  `id_entrega` int(11) NOT NULL AUTO_INCREMENT,
  `id_donacion` int(11) NOT NULL,
  `id_comunidad` int(11) NOT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_entrega` date DEFAULT NULL,
  `id_estado_entrega` int(11) NOT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id_entrega`),
  KEY `id_donacion` (`id_donacion`),
  KEY `id_comunidad` (`id_comunidad`),
  KEY `id_estado_entrega` (`id_estado_entrega`),
  CONSTRAINT `entrega_donacion_ibfk_1` FOREIGN KEY (`id_donacion`) REFERENCES `donacion` (`id_donacion`),
  CONSTRAINT `entrega_donacion_ibfk_2` FOREIGN KEY (`id_comunidad`) REFERENCES `comunidad_vulnerable` (`id_comunidad`),
  CONSTRAINT `entrega_donacion_ibfk_3` FOREIGN KEY (`id_estado_entrega`) REFERENCES `estado_entrega` (`id_estado_entrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrega_donacion`
--

LOCK TABLES `entrega_donacion` WRITE;
/*!40000 ALTER TABLE `entrega_donacion` DISABLE KEYS */;
/*!40000 ALTER TABLE `entrega_donacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_entrega`
--

DROP TABLE IF EXISTS `estado_entrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estado_entrega` (
  `id_estado_entrega` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  PRIMARY KEY (`id_estado_entrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_entrega`
--

LOCK TABLES `estado_entrega` WRITE;
/*!40000 ALTER TABLE `estado_entrega` DISABLE KEYS */;
/*!40000 ALTER TABLE `estado_entrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pais` (
  `id_pais` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id_pais`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'Argentina'),(2,'Chile'),(3,'Colombia'),(4,'España'),(5,'México'),(6,'Perú'),(7,'Uruguay'),(8,'Brasil'),(9,'Ecuador'),(10,'Bolivia'),(11,'Paraguay'),(12,'Venezuela'),(13,'Costa Rica'),(14,'Panamá'),(15,'Estados Unidos'),(16,'Canadá'),(17,'Francia'),(18,'Italia'),(19,'Alemania'),(20,'Portugal'),(21,'Japón'),(22,'Corea del Sur'),(23,'Australia'),(24,'Reino Unido'),(25,'Suiza'),(26,'Países Bajos'),(27,'Bélgica'),(28,'Suecia'),(29,'Noruega'),(30,'Dinamarca');
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recurso_donado`
--

DROP TABLE IF EXISTS `recurso_donado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recurso_donado` (
  `id_recurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `unidad_medida` varchar(50) DEFAULT NULL,
  `id_categoria_recurso` int(11) NOT NULL,
  PRIMARY KEY (`id_recurso`),
  KEY `id_categoria_recurso` (`id_categoria_recurso`),
  CONSTRAINT `recurso_donado_ibfk_1` FOREIGN KEY (`id_categoria_recurso`) REFERENCES `categoria_recurso_donado` (`id_categoria_recurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recurso_donado`
--

LOCK TABLES `recurso_donado` WRITE;
/*!40000 ALTER TABLE `recurso_donado` DISABLE KEYS */;
/*!40000 ALTER TABLE `recurso_donado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol_usuario`
--

DROP TABLE IF EXISTS `rol_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol_usuario` (
  `id_rol` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol_usuario`
--

LOCK TABLES `rol_usuario` WRITE;
/*!40000 ALTER TABLE `rol_usuario` DISABLE KEYS */;
INSERT INTO `rol_usuario` VALUES (1,'Administrador'),(2,'Institucion Donante'),(3,'Persona Natural'),(4,'Comunidad');
/*!40000 ALTER TABLE `rol_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_sistema`
--

DROP TABLE IF EXISTS `usuario_sistema`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario_sistema` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `usuario` (`usuario`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuario_sistema_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol_usuario` (`id_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_sistema`
--

LOCK TABLES `usuario_sistema` WRITE;
/*!40000 ALTER TABLE `usuario_sistema` DISABLE KEYS */;
INSERT INTO `usuario_sistema` VALUES (1,'Administrador','admin','nilson1234',1,1);
/*!40000 ALTER TABLE `usuario_sistema` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voluntario`
--

DROP TABLE IF EXISTS `voluntario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voluntario` (
  `id_voluntario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT NULL,
  PRIMARY KEY (`id_voluntario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voluntario`
--

LOCK TABLES `voluntario` WRITE;
/*!40000 ALTER TABLE `voluntario` DISABLE KEYS */;
/*!40000 ALTER TABLE `voluntario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-02-12 10:59:47
