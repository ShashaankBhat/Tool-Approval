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
-- Table structure for table `ta_recovery_type`
--

DROP TABLE IF EXISTS `ta_recovery_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_recovery_type` (
  `ta_recovery_type_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_recovery_type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ta_recovery_type_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ta_recovery_type_active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_recovery_type_id`),
  KEY `fk_ta_rt_created_by` (`created_by`),
  KEY `fk_ta_rt_updated_by` (`updated_by`),
  CONSTRAINT `fk_ta_rt_created_by` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_rt_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `m_user` (`m_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_recovery_type`
--

LOCK TABLES `ta_recovery_type` WRITE;
/*!40000 ALTER TABLE `ta_recovery_type` DISABLE KEYS */;
INSERT INTO `ta_recovery_type` VALUES (1,'Recoverable','Tooling cost is recoverable from customer',1,1,'2026-02-09 16:13:08',NULL,NULL),(2,'Non Recoverable','Tooling cost is borne by company and requires MD approval',1,1,'2026-02-09 16:13:08',1,'2026-02-10 12:05:40'),(3,'Non Recoverable test One','Non Recoverable test One',0,1,'2026-02-12 09:08:55',1,'2026-02-27 10:48:34'),(4,'Recoverable TEst','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(5,'Recoverable TEst 0','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(6,'Recoverable TEst 1','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(7,'Recoverable TEst 2','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(8,'Recoverable TEst 3','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(9,'Recoverable TEst 4','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(10,'Recoverable TEst 5','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(11,'Recoverable TEst 6','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(12,'Recoverable TEst 7','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(13,'Recoverable TEst 8','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(14,'Recoverable TEst 9','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(15,'Recoverable TEst 10','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(16,'Recoverable TEst 11','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(17,'Recoverable TEst 12','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(18,'Recoverable TEst 13','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(19,'Recoverable TEst 14','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(20,'Recoverable TEst 15','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(21,'Recoverable TEst 16','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(22,'Recoverable TEst 17','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(23,'Recoverable TEst 18','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(24,'Recoverable TEst 19','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(25,'Recoverable TEst 20','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(26,'Recoverable TEst 21','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(27,'Recoverable TEst 22','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(28,'Recoverable TEst 23','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(29,'Recoverable TEst 24','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(30,'Recoverable TEst 25','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(31,'Recoverable TEst 26','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(32,'Recoverable TEst 27','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(33,'Recoverable TEst 28','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(34,'Recoverable TEst 29','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(35,'Recoverable TEst 30','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(36,'Recoverable TEst 31','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(37,'Recoverable TEst 32','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(38,'Recoverable TEst 33','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(39,'Recoverable TEst 34','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(40,'Recoverable TEst 35','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(41,'Recoverable TEst 36','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(42,'Recoverable TEst 37','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(43,'Recoverable TEst 38','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(44,'Recoverable TEst 39','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(45,'Recoverable TEst 40','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(46,'Recoverable TEst 41','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(47,'Recoverable TEst 42','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(48,'Recoverable TEst 43','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(49,'Recoverable TEst 44','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(50,'Recoverable TEst 45','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(51,'Recoverable TEst 46','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(52,'Recoverable TEst 47','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(53,'Recoverable TEst 48','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL),(54,'Recoverable TEst 49','Recoverable sadf',1,1,'2026-03-06 10:52:20',NULL,NULL);
/*!40000 ALTER TABLE `ta_recovery_type` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:56
