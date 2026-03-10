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
-- Table structure for table `ta_tool_request_cost_detail`
--

DROP TABLE IF EXISTS `ta_tool_request_cost_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ta_tool_request_cost_detail` (
  `ta_tool_request_cost_detail_id` bigint NOT NULL AUTO_INCREMENT,
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
  PRIMARY KEY (`ta_tool_request_cost_detail_id`),
  KEY `fk_ta_tacd_created_by` (`created_by`),
  KEY `fk_ta_tacd_request` (`ta_tool_request_id`),
  KEY `fk_ta_tacd_updated_by` (`updated_by`),
  CONSTRAINT `fk_ta_tacd_created_by` FOREIGN KEY (`created_by`) REFERENCES `m_user` (`m_user_id`),
  CONSTRAINT `fk_ta_tacd_request` FOREIGN KEY (`ta_tool_request_id`) REFERENCES `ta_tool_request` (`ta_tool_request_id`),
  CONSTRAINT `fk_ta_tacd_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `m_user` (`m_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ta_tool_request_cost_detail`
--

LOCK TABLES `ta_tool_request_cost_detail` WRITE;
/*!40000 ALTER TABLE `ta_tool_request_cost_detail` DISABLE KEYS */;
INSERT INTO `ta_tool_request_cost_detail` VALUES (17,62,'Part One','Description','3',10.00,20.00,30.00,'40.0','asdf\r\nasdf','50',1,NULL,NULL,'asdf\r\nqwer',1,'2026-03-10 10:46:18',NULL,NULL),(18,61,'Part Two','Description two','2',100.00,200.00,300.00,'400.0','qwer\r\nasdf','500',0,NULL,NULL,'tyui\r\ntyui',1,'2026-03-10 10:42:23',1,'2026-03-10 10:48:02'),(19,62,'Part Three','Description Three','4',1000.00,2000.00,3000.00,'4000.0','987\r\n654','5000',1,NULL,NULL,'123456789\r\n654\r\n789',1,'2026-03-10 10:46:18',NULL,NULL),(20,61,'Part One','Description One','4',10.00,20.00,30.00,'40.0','asdf\r\n1234','500',1,NULL,NULL,'123\r\nasd',1,'2026-03-10 10:47:42',1,'2026-03-10 10:48:02');
/*!40000 ALTER TABLE `ta_tool_request_cost_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-10 11:07:54
