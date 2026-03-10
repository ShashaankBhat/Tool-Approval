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
-- Table structure for table `ta_tool_cost_details`
--

DROP TABLE IF EXISTS `ta_tool_cost_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_tool_cost_details` (
  `ta_tool_cost_details_id` bigint NOT NULL AUTO_INCREMENT,
  `ta_tool_request_id` bigint DEFAULT NULL,
  `tool_part_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `part_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `quoted_cost` decimal(15,2) DEFAULT NULL,
  `negotiated_cost` decimal(15,2) DEFAULT NULL,
  `upfront_cost` decimal(15,2) DEFAULT NULL,
  `amortization_cost` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supplier_name` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `development_lead_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cost_active` int DEFAULT NULL,
  `cost_amount` decimal(15,2) DEFAULT NULL,
  `cost_head` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` bigint DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_by` bigint DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  PRIMARY KEY (`ta_tool_cost_details_id`),
  KEY `fk_ta_tcd_request` (`ta_tool_request_id`),
  KEY `fk_ta_tcd_created_by` (`created_by`),
  KEY `fk_ta_tcd_updated_by` (`updated_by`),
  CONSTRAINT `fk_ta_tcd_created_by` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_tcd_request` FOREIGN KEY (`ta_tool_request_id`) REFERENCES `ta_tool_request` (`ta_tool_request_id`),
  CONSTRAINT `fk_ta_tcd_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `m_user` (`m_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_tool_cost_details`
--

LOCK TABLES `ta_tool_cost_details` WRITE;
/*!40000 ALTER TABLE `ta_tool_cost_details` DISABLE KEYS */;
INSERT INTO `ta_tool_cost_details` VALUES (1,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,'100','ok',1,'2026-02-04 16:52:37',NULL,NULL),(2,7,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,1,'2026-02-04 17:15:42',NULL,NULL),(3,9,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,1,'2026-02-05 11:18:54',NULL,NULL),(4,10,'123','1234','INR',12.00,123.00,123.00,'123.00','12','12',1,NULL,NULL,NULL,1,'2026-02-09 14:12:39',NULL,NULL),(8,23,'G070245','BUMP STOPPER','INR',1.00,1.00,1.00,'1.00','BASF INDIA LIMITED','8',1,NULL,NULL,NULL,1,'2026-02-18 16:12:51',NULL,NULL),(9,23,'G070245','BUMP STOPPER','INR',1.00,0.01,1.00,'1.00','BASF INDIA LIMITED','8',1,NULL,NULL,NULL,1,'2026-02-18 16:13:38',NULL,NULL),(11,54,'123','213','INR',123.00,231.00,231.00,'231','231','23',1,NULL,NULL,'12',1,'2026-02-19 16:26:24',NULL,NULL),(13,56,'12','21','INR',21.00,21.00,21.00,'21','21','21',1,NULL,NULL,'\r\n21\r\n',1,'2026-02-19 16:31:34',NULL,NULL),(14,58,'12','12','INR',21.00,21.00,21.00,'221','21','21',1,NULL,NULL,'21\r\n',1,'2026-02-19 17:59:34',NULL,NULL),(15,57,'231','231','INR',321.00,123.00,231.00,'32','21','312',1,NULL,NULL,'321\r\n',1,'2026-02-20 12:37:24',NULL,NULL),(16,59,'1','1','INR',1.00,1.00,1.00,'1','1','1',1,NULL,NULL,'1\r\n',1,'2026-02-20 14:46:44',NULL,NULL);
/*!40000 ALTER TABLE `ta_tool_cost_details` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:51
