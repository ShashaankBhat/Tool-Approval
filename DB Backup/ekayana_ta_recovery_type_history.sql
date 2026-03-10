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
-- Table structure for table `ta_recovery_type_history`
--

DROP TABLE IF EXISTS `ta_recovery_type_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_recovery_type_history` (
  `ta_recovery_type_history_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_recovery_type_id` bigint NOT NULL,
  `ta_recovery_type_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ta_recovery_type_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ta_recovery_type_active` tinyint NOT NULL,
  `created_by` bigint NOT NULL,
  `created_on` datetime NOT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_recovery_type_history_id`),
  KEY `fk_ta_rt_hist_parent` (`ta_recovery_type_id`),
  CONSTRAINT `fk_ta_rt_hist_parent` FOREIGN KEY (`ta_recovery_type_id`) REFERENCES `ta_recovery_type` (`ta_recovery_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_recovery_type_history`
--

LOCK TABLES `ta_recovery_type_history` WRITE;
/*!40000 ALTER TABLE `ta_recovery_type_history` DISABLE KEYS */;
INSERT INTO `ta_recovery_type_history` VALUES (1,2,'Non Recoverable','Tooling cost is borne by company and requires MD approval',1,1,'2026-02-09 16:13:08',NULL,NULL),(2,3,'Non Recoverable-1','test',0,1,'2026-02-16 15:08:57',NULL,NULL),(3,3,'Non Recoverable-1','test',0,1,'2026-02-16 15:18:43',NULL,NULL),(4,3,'Non Recoverable-1','test',0,1,'2026-02-16 15:18:43',NULL,NULL),(5,3,'Non Recoverabletest','test',0,1,'2026-02-27 10:48:10',NULL,NULL),(6,3,'Non Recoverable test','test',0,1,'2026-02-27 10:48:15',NULL,NULL),(7,3,'Non Recoverable test','test',1,1,'2026-02-27 10:48:19',NULL,NULL);
/*!40000 ALTER TABLE `ta_recovery_type_history` ENABLE KEYS */;
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
