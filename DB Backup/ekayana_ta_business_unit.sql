-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: ekayana
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
-- Table structure for table `ta_business_unit`
--

DROP TABLE IF EXISTS `ta_business_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_business_unit` (
  `ta_business_unit_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_business_unit_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ta_business_unit_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ta_business_unit_active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_business_unit_id`),
  KEY `fk_ta_bu_created_by` (`created_by`),
  KEY `fk_ta_bu_updated_by` (`updated_by`),
  CONSTRAINT `fk_ta_bu_created_by` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_bu_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `m_user` (`m_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_business_unit`
--

LOCK TABLES `ta_business_unit` WRITE;
/*!40000 ALTER TABLE `ta_business_unit` DISABLE KEYS */;
INSERT INTO `ta_business_unit` VALUES (1,'Anand ','Anand group',1,1,'2026-02-03 10:06:47',NULL,NULL),(2,'Anand Two','Anand Two Group',0,1,'2026-02-10 17:34:44',1,'2026-02-24 09:47:08'),(3,'Anand ','Anand group',1,1,'2026-02-13 12:30:08',NULL,NULL),(4,'Anand ','Anand group',1,1,'2026-02-13 12:30:20',NULL,NULL),(5,'Anand ','Anand group',1,1,'2026-02-13 12:39:03',NULL,NULL),(6,'Anand ','Anand group',0,1,'2026-02-13 12:42:45',1,'2026-02-17 10:59:38'),(7,'Anand  One','Anand group One',0,1,'2026-02-24 09:46:47',NULL,NULL),(8,'Test','Test',1,1,'2026-02-24 10:20:34',NULL,NULL),(9,'test asd','test',1,1,'2026-02-24 10:21:29',NULL,NULL),(13,'Check one','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(14,'Check one 1','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(15,'Check one 2','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(16,'Check one 3','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(17,'Check one 4','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(18,'Check one 5','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(19,'Check one 6','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(20,'Check one 7','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(21,'Check one 8','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(22,'Check one 9','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(23,'Check one 10','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(24,'Check one 11','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(25,'Check one 12','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(26,'Check one 13','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(27,'Check one 14','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(28,'Check one 15','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(29,'Check one 16','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(30,'Check one 17','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(31,'Check one 18','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(32,'Check one 19','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(33,'Check one 20','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(34,'Check one 21','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(35,'Check one 22','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(36,'Check one 23','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(37,'Check one 24','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(38,'Check one 25','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(39,'Check one 26','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(40,'Check one 27','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(41,'Check one 28','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(42,'Check one 29','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(43,'Check one 30','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(44,'Check one 31','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(45,'Check one 32','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(46,'Check one 33','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(47,'Check one 34','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(48,'Check one 35','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(49,'Check one 36','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(50,'Check one 37','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(51,'Check one 38','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(52,'Check one 39','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(53,'Check one 40','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(54,'Check one 41','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(55,'Check one 42','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(56,'Check one 43','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(57,'Check one 44','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(58,'Check one 45','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(59,'Check one 46','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(60,'Check one 47','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(61,'Check one 48','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(62,'Check one 49','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL),(63,'Check one 50','Check One',1,1,'2026-03-06 08:45:07',NULL,NULL);
/*!40000 ALTER TABLE `ta_business_unit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:50
