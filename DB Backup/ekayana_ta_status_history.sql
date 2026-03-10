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
-- Table structure for table `ta_status_history`
--

DROP TABLE IF EXISTS `ta_status_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_status_history` (
  `ta_status_history_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_status_id` bigint NOT NULL,
  `ta_status_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ta_status_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ta_status_active` tinyint NOT NULL,
  `created_by` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_status_history_id`),
  KEY `fk_ta_status_hist_parent` (`ta_status_id`),
  CONSTRAINT `fk_ta_status_hist_parent` FOREIGN KEY (`ta_status_id`) REFERENCES `ta_status` (`ta_status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_status_history`
--

LOCK TABLES `ta_status_history` WRITE;
/*!40000 ALTER TABLE `ta_status_history` DISABLE KEYS */;
INSERT INTO `ta_status_history` VALUES (1,6,'Rejected','Rejected by approver',0,1,'2026-02-04 12:42:45',NULL,NULL),(2,5,'Approved','Final approved request',0,1,'2026-02-04 12:42:45',NULL,NULL),(3,6,'Rejected','Rejected by approver',1,1,'2026-02-04 12:18:00',NULL,NULL),(4,1,'Draft','Initial request state',0,1,'2026-02-04 12:42:45',NULL,NULL),(5,5,'Approved','Final approved request',1,1,'2026-02-04 12:18:00',NULL,NULL),(6,1,'Draft','Initial request state',1,1,'2026-02-04 12:42:45',1,'2026-02-18 15:04:05'),(7,1,'Draft','Initial request state',0,1,'2026-02-04 12:42:45',1,'2026-02-18 15:04:34'),(8,6,'Submitted','Request submitted for approval',1,1,'2026-02-04 12:18:00',NULL,NULL),(9,1,'Draft','Initial request state',1,1,'2026-02-04 12:18:00',NULL,NULL),(10,4,'Pending','Waiting for approval workflow processing',1,1,'2026-02-18 15:17:24',NULL,NULL),(11,4,'Pending Approval','Waiting for approval workflow processing',1,1,'2026-02-18 15:17:24',1,'2026-02-18 16:15:21'),(12,4,'Pending ','Waiting for approval workflow processing',1,1,'2026-02-18 15:17:24',1,'2026-02-18 19:13:03'),(13,20,'Test 12','Test 12',1,1,'2026-03-05 20:47:04',NULL,NULL),(14,20,'Test Check','Test 12',1,1,'2026-03-05 20:47:04',NULL,NULL);
/*!40000 ALTER TABLE `ta_status_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:53
