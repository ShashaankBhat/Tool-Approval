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
-- Table structure for table `ta_status`
--

DROP TABLE IF EXISTS `ta_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_status` (
  `ta_status_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_status_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ta_status_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ta_status_active` tinyint NOT NULL DEFAULT '1',
  `created_by` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_status_id`),
  KEY `fk_ta_status_created_by` (`created_by`),
  KEY `fk_ta_status_updated_by` (`updated_by`),
  CONSTRAINT `fk_ta_status_created_by` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_status_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `m_user` (`m_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_status`
--

LOCK TABLES `ta_status` WRITE;
/*!40000 ALTER TABLE `ta_status` DISABLE KEYS */;
INSERT INTO `ta_status` VALUES (1,'Draft','Initial request state',1,1,'2026-02-18 15:17:24',NULL,NULL),(2,'Pending Approval @ Level 1','Tool details completed but cost not entered',1,1,'2026-02-18 15:17:24',NULL,NULL),(3,'Rejected by Level 1','Cost details completed by initiator',1,1,'2026-02-18 15:17:24',NULL,NULL),(4,'Approved by Level 1','Waiting for approval workflow processing',1,1,'2026-02-18 15:17:24',1,'2026-02-20 14:42:06'),(5,'Approved by Level 2','Final approved request',1,1,'2026-02-18 15:17:24',NULL,NULL),(6,'Rejected by Level 2','Rejected by approver',1,1,'2026-02-18 15:17:24',NULL,NULL),(7,'Approved by Level 3','Test',1,1,'2026-03-05 20:31:50',NULL,NULL),(8,'Rejected by Level 3','Test 0',1,1,'2026-03-05 20:31:50',NULL,NULL),(9,'Approved by Level 4','Test 1',1,1,'2026-03-05 20:31:50',NULL,NULL),(10,'Rejected by Level 4','Test 2',1,1,'2026-03-05 20:31:50',NULL,NULL),(11,'Test 3','Test 3',1,1,'2026-03-05 20:31:50',NULL,NULL),(12,'Test 4','Test 4',1,1,'2026-03-05 20:31:50',NULL,NULL),(13,'Test 5','Test 5',1,1,'2026-03-05 20:31:50',NULL,NULL),(14,'Test 6','Test 6',1,1,'2026-03-05 20:31:50',NULL,NULL),(15,'Test 7','Test 7',1,1,'2026-03-05 20:31:50',NULL,NULL),(16,'Test 8','Test 8',1,1,'2026-03-05 20:31:50',NULL,NULL),(17,'Test 9','Test 9',1,1,'2026-03-05 20:31:50',NULL,NULL),(18,'Test 10','Test 10',1,1,'2026-03-05 20:31:50',NULL,NULL),(19,'Test 11','Test 11',1,1,'2026-03-05 20:31:50',NULL,NULL),(20,'Test Check','Test 12',0,1,'2026-03-05 20:31:50',1,'2026-03-06 11:16:08'),(21,'Test 13','Test 13',1,1,'2026-03-05 20:31:50',NULL,NULL),(22,'Test 14','Test 14',1,1,'2026-03-05 20:31:50',NULL,NULL),(23,'Test 15','Test 15',1,1,'2026-03-05 20:31:50',NULL,NULL),(24,'Test 16','Test 16',1,1,'2026-03-05 20:31:50',NULL,NULL),(25,'Test 17','Test 17',1,1,'2026-03-05 20:31:50',NULL,NULL),(26,'Test 18','Test 18',1,1,'2026-03-05 20:31:50',NULL,NULL),(27,'Test 19','Test 19',1,1,'2026-03-05 20:31:50',NULL,NULL),(28,'Test 20','Test 20',1,1,'2026-03-05 20:31:50',NULL,NULL),(29,'Test 21','Test 21',1,1,'2026-03-05 20:31:50',NULL,NULL),(30,'Test 22','Test 22',1,1,'2026-03-05 20:31:50',NULL,NULL),(31,'Test 23','Test 23',1,1,'2026-03-05 20:31:50',NULL,NULL),(32,'Test 24','Test 24',1,1,'2026-03-05 20:31:50',NULL,NULL),(33,'Test 25','Test 25',1,1,'2026-03-05 20:31:50',NULL,NULL),(34,'Test 26','Test 26',1,1,'2026-03-05 20:31:50',NULL,NULL),(35,'Test 27','Test 27',1,1,'2026-03-05 20:31:50',NULL,NULL),(36,'Test 28','Test 28',1,1,'2026-03-05 20:31:50',NULL,NULL),(37,'Test 29','Test 29',1,1,'2026-03-05 20:31:50',NULL,NULL),(38,'Test 30','Test 30',1,1,'2026-03-05 20:31:50',NULL,NULL),(39,'Test 31','Test 31',1,1,'2026-03-05 20:31:50',NULL,NULL),(40,'Test 32','Test 32',1,1,'2026-03-05 20:31:50',NULL,NULL),(41,'Test 33','Test 33',1,1,'2026-03-05 20:31:50',NULL,NULL),(42,'Test 34','Test 34',1,1,'2026-03-05 20:31:50',NULL,NULL),(43,'Test 35','Test 35',1,1,'2026-03-05 20:31:50',NULL,NULL),(44,'Test 36','Test 36',1,1,'2026-03-05 20:31:50',NULL,NULL),(45,'Test 37','Test 37',1,1,'2026-03-05 20:31:50',NULL,NULL),(46,'Test 38','Test 38',1,1,'2026-03-05 20:31:50',NULL,NULL),(47,'Test 39','Test 39',1,1,'2026-03-05 20:31:50',NULL,NULL),(48,'Test 40','Test 40',1,1,'2026-03-05 20:31:50',NULL,NULL),(49,'Test 41','Test 41',1,1,'2026-03-05 20:31:50',NULL,NULL),(50,'Test 42','Test 42',1,1,'2026-03-05 20:31:50',NULL,NULL),(51,'Test 43','Test 43',1,1,'2026-03-05 20:31:50',NULL,NULL),(52,'Test 44','Test 44',1,1,'2026-03-05 20:31:50',NULL,NULL),(53,'Test 45','Test 45',1,1,'2026-03-05 20:31:50',NULL,NULL),(54,'Test 46','Test 46',1,1,'2026-03-05 20:31:50',NULL,NULL),(55,'Test 47','Test 47',1,1,'2026-03-05 20:31:50',NULL,NULL),(56,'Test 48','Test 48',1,1,'2026-03-05 20:31:50',NULL,NULL),(57,'Test 49','Test 49',1,1,'2026-03-05 20:31:50',NULL,NULL);
/*!40000 ALTER TABLE `ta_status` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:52
