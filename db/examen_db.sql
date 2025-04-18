-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: examen_db
-- ------------------------------------------------------
-- Server version	8.0.41

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

--
-- Table structure for table `archivos`
--

DROP TABLE IF EXISTS `archivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `archivos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `fecha_creacion` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `archivos`
--

LOCK TABLES `archivos` WRITE;
/*!40000 ALTER TABLE `archivos` DISABLE KEYS */;
/*!40000 ALTER TABLE `archivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colaboradores`
--

DROP TABLE IF EXISTS `colaboradores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `colaboradores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `rfc` varchar(13) NOT NULL,
  `domicilio_fiscal` text,
  `curp` varchar(18) NOT NULL,
  `nss` varchar(11) NOT NULL,
  `fecha_inicio_laboral` date NOT NULL,
  `tipo_contrato` varchar(255) NOT NULL,
  `departamento` varchar(255) NOT NULL,
  `puesto` varchar(255) NOT NULL,
  `salario_diario` decimal(10,2) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `clave_entidad` varchar(10) NOT NULL,
  `estado` varchar(100) NOT NULL,
  `eliminado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colaboradores`
--

LOCK TABLES `colaboradores` WRITE;
/*!40000 ALTER TABLE `colaboradores` DISABLE KEYS */;
INSERT INTO `colaboradores` VALUES (1,'karina Pérez','kari@correo.com','PERJ800101XXX','grwgthyg','PERJ800101HDFGRL09','123-45-6789','2020-02-02','Temporal','Finanzas','Analista Financiero',1000.00,30000.00,'22','Querétaro',1),(2,'Luis Torres','luis.torres@mail.com','TOLU900405QH9','Calle 2, Colonia 2','TOLU900405HJCZRS09','23456789012','2021-06-15','Temporal','Recursos Humanos','Reclutador',1000.00,30000.00,'14','Jalisco',0),(3,'Mariana López','mariana.lopez@mail.com','LOMM920712JI0','Calle 3, Monterrey','LOMM920712MNLRRR02','34567890123','2022-01-10','Permanente','Operaciones','Coordinadora Operativa',950.00,28500.00,'19','Nuevo León',0),(4,'Jorge Martínez','jorge.mtz@mail.com','MAJJ870101DF9','Calle 4, Puebla','MAJJ870101PBLRDR03','45678901234','2019-09-20','Temporal','Logística','Auxiliar de Almacén',800.00,24000.00,'21','Puebla',0),(5,'Carmen Salas','carmen.salas@mail.com','SACR930812XA1','Calle 5, León','SACR930812GTRLRS04','56789012345','2020-11-30','Permanente','Marketing','Diseñadora Gráfica',1100.00,33000.00,'11','Guanajuato',0),(6,'David Ortega','david.ortega@mail.com','ORDA910305CC7','Calle 6, Cancún','ORDA910305QRRLRR05','67890123456','2021-07-01','Temporal','Ventas','Ejecutivo de Ventas',950.00,28500.00,'23','Quintana Roo',0),(7,'Laura Ramos','laura.ramos@mail.com','RALU880223SS3','Calle 7, Mérida','RALU880223YRRRLU06','78901234567','2023-02-17','Permanente','Atención al Cliente','Agente Telefónico',900.00,27000.00,'31','Yucatán',0),(8,'Tomás García','tomas.garcia@mail.com','GATO840915VV6','Calle 8, Tijuana','GATO840915BNLRRS07','89012345678','2018-08-25','Permanente','Producción','Supervisor de Línea',1300.00,39000.00,'02','Baja California',0),(9,'Erika Sánchez','erika.sanchez@mail.com','SAER860610JJ3','Calle 9, Querétaro','SAER860610QTRRRS08','90123456789','2020-10-05','Permanente','Calidad','Analista de Calidad',1050.00,31500.00,'22','Querétaro',0),(10,'Roberto Díaz','roberto.diaz@mail.com','DIRR950509AA8','Calle 10, Toluca','DIRR950509MEXRRS09','12345678001','2021-04-12','Temporal','Ingeniería','Ingeniero de Proyectos',1150.00,34500.00,'15','Estado de México',0),(11,'Paola Romero','paola.romero@mail.com','ROPA940307ZZ5','Calle 11, Morelia','ROPA940307MICHRS10','23456780123','2022-05-20','Permanente','Legal','Asistente Jurídica',1000.00,30000.00,'16','Michoacán',0),(12,'Sergio Navarro','sergio.navarro@mail.com','NASE870812KK2','Calle 12, Hermosillo','NASE870812SONRRS11','34567801234','2019-03-03','Permanente','Seguridad','Guardia de Seguridad',800.00,24000.00,'26','Sonora',0),(13,'Juan Carlos Ríos','juan.rios@mail.com','RIJC850601MM1','Calle 14, Culiacán','RIJC850601SLRRRR13','56780123456','2023-03-11','Permanente','Tecnología','Desarrollador Backend',1400.00,42000.00,'25','Sinaloa',0),(14,'Ana Hernández','ani.hdez@mail.com','ANIT195826WNE','S/N','GARC010203MDFRRL09','123456','2025-02-01','Permanente','Tecnologia','Desarrollador',1000.00,30000.00,'22','Querétaro',1);
/*!40000 ALTER TABLE `colaboradores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `rfc` varchar(13) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo` (`correo`),
  UNIQUE KEY `rfc` (`rfc`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'María López','maria@example.com','MECA850101XX1','123456'),(2,'lia lopez','lia@correo.com','DEFR235874FR2','147258'),(3,'Laura Gayosso','lau.gayosso@correo.com','GAFL235874FR2','123456'),(4,'Romina Reyes','romi.reyes@mail.com','RERO153984FR1','123456'),(5,'Jesús Ocadiz','jesus.ocadiz@mail.com','OCJE124578GT1','123456');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-18 15:30:26
