-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: khoahoc
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `audio`
--

DROP TABLE IF EXISTS `audio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audio` (
  `audioId` int unsigned NOT NULL AUTO_INCREMENT,
  `audio` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`audioId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audio`
--

LOCK TABLES `audio` WRITE;
/*!40000 ALTER TABLE `audio` DISABLE KEYS */;
INSERT INTO `audio` VALUES (1,'audio1627288571031.mp3');
/*!40000 ALTER TABLE `audio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `idComment` int unsigned NOT NULL AUTO_INCREMENT,
  `idCourse` int DEFAULT NULL,
  `comment` text,
  `byUser` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idComment`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,2,'hello','marbiosgod'),(2,2,'hi','marbiosgod'),(3,2,'xin chao`','marbiosgod'),(4,2,'xinchaof','marbiosgod'),(5,2,'aa','marbiosgod'),(6,2,'aa','marbiosgod'),(7,2,'aaaaa','marbiosgod'),(8,2,'aaa','marbiosgod'),(9,2,'alo','marbiosgod'),(10,2,'hi','phamngocthai123'),(11,2,'asdasd','marbiosgod');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favoritecourse`
--

DROP TABLE IF EXISTS `favoritecourse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favoritecourse` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `idSource` int DEFAULT NULL,
  `nameFavoriteCourse` varchar(255) DEFAULT NULL,
  `desFavoriteCourse` varchar(255) DEFAULT NULL,
  `imageFavoriteCourse` varchar(255) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favoritecourse`
--

LOCK TABLES `favoritecourse` WRITE;
/*!40000 ALTER TABLE `favoritecourse` DISABLE KEYS */;
INSERT INTO `favoritecourse` VALUES (1,2,'Vocabulary for IELTS','Some vocabulary you can learn for IELTS','imageSource1627522070779.png','thai'),(2,3,'IELTS words for reading and writing','This will help you improve your reading and writing skill','imageSource1628674144993.jpg','thai'),(3,22,'hehhehee','hihihiheeeeeeeee','imageSource1628272598345.png','thai'),(43,16,'hihihiqwqweqwe',NULL,'imageSource1627389081030.jpg','thai');
/*!40000 ALTER TABLE `favoritecourse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `image`
--

DROP TABLE IF EXISTS `image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `image` (
  `imageId` int unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`imageId`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `image`
--

LOCK TABLES `image` WRITE;
/*!40000 ALTER TABLE `image` DISABLE KEYS */;
INSERT INTO `image` VALUES (1,'2e2113b04884f5ec4f91d4d0b8e7ba8d'),(2,'ddb9ca0f1c0fd01ee71eb33b18d1f426'),(3,'image1627030554323.jpg'),(4,'image1627031569674.jpg'),(5,'image1627031819528.jpg'),(6,'image1627034872837.jpg'),(7,'image1627035434729.jpg'),(8,'image1627214360943.jpg'),(9,'/image1627214869213.jpg'),(10,'images/image1627215444202.jpg'),(11,'/images/image1627215480492.jpg'),(12,'image1627219628349.jpg'),(13,'image1627222123789.jpg'),(14,'image1627222140921.jpg'),(15,'image1627224054454.jpg'),(16,'image1627300361179.jpg');
/*!40000 ALTER TABLE `image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `learning`
--

DROP TABLE IF EXISTS `learning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `learning` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `timeLearning` int unsigned DEFAULT NULL,
  `score` int unsigned DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `learning`
--

LOCK TABLES `learning` WRITE;
/*!40000 ALTER TABLE `learning` DISABLE KEYS */;
INSERT INTO `learning` VALUES (1,'2021-08-13',118,26,'thai'),(2,'2021-08-13',118,26,'thai'),(3,'2021-08-13',114,26,'marbiosgod'),(4,'2021-08-13',101,25,'marbiosgod'),(5,'2021-08-13',100,26,'marbiosgod'),(6,'2021-08-13',18,3,'marbiosgod'),(7,'2021-08-14',20,4,'thai'),(8,'2021-08-14',25,4,'thai'),(9,'2021-08-17',16,2,'marbiosgod'),(10,'2021-08-17',33,7,'marbiosgod'),(11,'2021-08-17',31,6,'marbiosgod'),(12,'2021-08-17',7,0,'marbiosgod'),(13,'2021-08-17',15,2,'marbiosgod'),(14,'2021-08-17',6,0,'marbiosgod'),(15,'2021-08-17',8,1,'marbiosgod'),(16,'2021-08-17',8,0,'marbiosgod'),(17,'2021-08-17',11,2,'marbiosgod'),(18,'2021-08-17',11,2,'marbiosgod'),(19,'2021-08-17',10,2,'marbiosgod'),(20,'2021-08-17',8,1,'marbiosgod'),(21,'2021-08-17',8,1,'marbiosgod'),(22,'2021-08-17',9,1,'marbiosgod'),(23,'2021-08-17',9,1,'marbiosgod'),(24,'2021-08-17',6,0,'marbiosgod'),(25,'2021-08-17',6,0,'marbiosgod'),(26,'2021-08-17',5,0,'marbiosgod'),(27,'2021-08-17',5,0,'marbiosgod'),(28,'2021-08-17',7,0,'marbiosgod'),(29,'2021-08-17',7,0,'marbiosgod'),(30,'2021-08-17',8,1,'marbiosgod'),(31,'2021-08-17',10,0,'marbiosgod'),(32,'2021-08-17',10,0,'marbiosgod'),(33,'2021-08-17',19,4,'marbiosgod'),(34,'2021-08-17',7,0,'marbiosgod'),(35,'2021-08-17',7,0,'marbiosgod'),(36,'2021-08-17',8,0,'marbiosgod'),(37,'2021-08-17',8,0,'marbiosgod'),(38,'2021-08-17',16,0,'marbiosgod'),(39,'2021-08-17',16,0,'marbiosgod'),(40,'2021-08-17',6,0,'marbiosgod'),(41,'2021-08-17',6,0,'marbiosgod'),(42,'2021-08-17',6,0,'marbiosgod'),(43,'2021-08-17',13,2,'marbiosgod'),(44,'2021-08-17',13,2,'marbiosgod'),(45,'2021-08-17',13,2,'marbiosgod'),(46,'2021-08-17',13,2,'marbiosgod'),(47,'2021-08-17',6,0,'marbiosgod'),(48,'2021-08-17',5,0,'marbiosgod'),(49,'2021-08-17',5,0,'marbiosgod'),(50,'2021-08-17',8,1,'marbiosgod'),(51,'2021-08-17',16,0,'marbiosgod'),(52,'2021-08-17',14,1,'marbiosgod'),(53,'2021-08-17',11,1,'marbiosgod'),(54,'2021-08-17',5,0,'marbiosgod'),(55,'2021-08-17',5,0,'marbiosgod'),(56,'2021-08-17',10,2,'marbiosgod'),(57,'2021-08-17',10,2,'marbiosgod'),(58,'2021-08-17',10,2,'marbiosgod'),(59,'2021-08-17',34,8,'thai'),(60,'2021-08-17',35,8,'thai'),(61,'2021-08-17',16,0,'thai'),(62,'2021-08-17',7,0,'thai'),(63,'2021-08-18',23,3,'thai'),(64,'2021-08-18',36,7,'marbiosgod'),(65,'2021-08-18',5,0,'marbiosgod'),(66,'2021-08-18',5,0,'marbiosgod'),(67,'2021-08-18',13,1,'marbiosgod'),(68,'2021-08-18',15,2,'marbiosgod'),(69,'2021-08-18',10,1,'marbiosgod');
/*!40000 ALTER TABLE `learning` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level` (
  `idLevel` int unsigned NOT NULL AUTO_INCREMENT,
  `level` int unsigned DEFAULT NULL,
  `idSource` int unsigned NOT NULL,
  `imageLevel` varchar(255) DEFAULT 'image1627300361179.jpg',
  `userName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idLevel`)
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
INSERT INTO `level` VALUES (1,1,1,NULL,NULL),(2,2,1,NULL,NULL),(3,1,16,'imageLevel1628084627253.jpg','marbiosgod'),(4,2,16,'imageLevel1627556114931.png','marbiosgod'),(5,3,16,'imageLevel1627556128637.png','marbiosgod'),(6,1,3,NULL,NULL),(7,2,3,NULL,NULL),(8,3,3,NULL,NULL),(9,1,5,NULL,NULL),(10,3,4,NULL,NULL),(11,1,5,NULL,NULL),(15,4,3,NULL,NULL),(30,1,11,NULL,NULL),(35,2,5,NULL,NULL),(36,4,5,NULL,NULL),(37,5,5,NULL,NULL),(38,6,5,NULL,NULL),(41,7,5,NULL,NULL),(42,8,5,NULL,NULL),(47,1,16,'imageLevel1627402410439.jpg',NULL),(48,1,20,'image1627300361179.jpg',NULL),(49,2,16,'imageLevel1627401202160.jpg',NULL),(50,3,16,'imageLevel1627406869203.jpg',NULL),(52,4,2,'imageLevel1628305706422.jpg','marbiosgod'),(54,2,42,'imageLevel1628084627253.jpg','phamngocthai'),(55,1,42,'imageLevel1627556114931.png','phamngocthai'),(56,3,42,'imageLevel1627556128637.png','phamngocthai'),(57,4,42,'imageLevel1628305706422.jpg','phamngocthai'),(111,2,47,'imageLevel1628084627253.jpg','thai'),(112,1,47,'imageLevel1627556114931.png','thai'),(113,3,47,'imageLevel1627556128637.png','thai'),(114,4,47,'imageLevel1628305706422.jpg','thai'),(132,2,50,'imageLevel1628084627253.jpg','thai'),(133,1,50,'imageLevel1627556114931.png','thai'),(134,3,50,'imageLevel1627556128637.png','thai'),(139,1,51,NULL,'thai'),(140,2,51,NULL,'thai'),(141,3,51,NULL,'thai'),(142,4,51,NULL,'thai'),(146,1,50,NULL,'thai'),(147,2,50,NULL,'thai'),(148,3,50,NULL,'thai'),(149,4,50,NULL,'thai'),(153,2,56,'imageLevel1628084627253.jpg','thai'),(154,1,56,'imageLevel1627556114931.png','thai'),(155,3,56,'imageLevel1627556128637.png','thai'),(156,4,56,'imageLevel1628305706422.jpg','thai'),(160,2,57,'imageLevel1628084627253.jpg','thai'),(161,1,57,'imageLevel1627556114931.png','thai'),(162,3,57,'imageLevel1627556128637.png','thai');
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rating`
--

DROP TABLE IF EXISTS `rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rating` (
  `idRating` int unsigned NOT NULL AUTO_INCREMENT,
  `idCourse` int DEFAULT NULL,
  `star` float DEFAULT NULL,
  `byUser` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idRating`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rating`
--

LOCK TABLES `rating` WRITE;
/*!40000 ALTER TABLE `rating` DISABLE KEYS */;
INSERT INTO `rating` VALUES (17,2,5,'marbiosgod'),(18,2,4.5,'marbiosgod'),(19,2,4.5,'marbiosgod'),(20,2,5,'marbiosgod'),(21,2,5,'marbiosgod'),(22,2,3.5,'marbiosgod'),(23,2,5,'marbiosgod'),(24,2,0.5,'marbiosgod'),(25,2,4,'phamngocthai123'),(26,2,2.5,'marbiosgod'),(27,2,1,'marbiosgod');
/*!40000 ALTER TABLE `rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `source` (
  `idSource` int unsigned NOT NULL AUTO_INCREMENT,
  `nameSource` varchar(255) NOT NULL,
  `desSource` text,
  `imageSource` varchar(255) DEFAULT 'image1627300361179.jpg',
  `userName` varchar(255) DEFAULT NULL,
  `private` tinyint DEFAULT '0',
  `likes` int unsigned DEFAULT '0',
  `star` float DEFAULT '0',
  `countRating` int DEFAULT '0',
  `comments` int DEFAULT '0',
  PRIMARY KEY (`idSource`,`nameSource`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
INSERT INTO `source` VALUES (16,'Vocabulary for IELTS','Some vocabulary you can learn for IELTS','imageSource1627389081030.jpg','marbiosgod',0,2,0,0,0),(18,'asdasqqq','hihihhieeee','imageSource1627401747002.jpg','marbiosgod',0,0,0,0,0),(19,'hiasda','helloasdas','imageSource1627388273018.jpg','ngocthai123',0,0,0,0,0),(20,'hihi','hehe','imageSource1627394239255.jpg','marbiosgod456',0,0,0,0,0),(21,'hihi','hehe','imageSource1627400608991.jpg','marbiosgod',0,0,0,0,0),(22,'hehhehee','hihihiheeeeeeeee','imageSource1628272598345.png','marbiosgod',0,1,0,0,0),(28,'123','321','imageSource1628274313517.jpg','marbiosgod',0,0,0,0,0),(29,'qwer','ewqr','imageSource1628276156866.jpg','marbiosgod',0,0,0,0,0),(37,'Vocabulary for IELTSs','hehes','imageSource1628781074480.jpg','marbiosgod',0,0,0,0,0),(47,'Vocabulary for IELTS','Some vocabulary you can learn for IELTS','imageSource1627522070779.png','thai',0,0,0,0,0),(50,'Vocabulary for IELTS','Some vocabulary you can learn for IELTS','imageSource1628821041710.jpg','thai',1,0,0,0,0),(54,'hehe','hihi','imageSource1628823826420.jpg','thai',1,0,0,0,0),(55,'a','v','imageSource1628823886816.jpg','thai',0,0,0,0,0);
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userId` int unsigned NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) NOT NULL,
  `userEmail` text NOT NULL,
  `userAvatar` varchar(45) DEFAULT NULL,
  `userYear` int unsigned NOT NULL,
  `userPassword` varchar(255) NOT NULL,
  `totalTime` int unsigned DEFAULT NULL,
  `totalScore` int unsigned DEFAULT NULL,
  `target` int unsigned DEFAULT '0',
  `streak` int unsigned DEFAULT '0',
  `streakUpdated` tinyint DEFAULT '0',
  PRIMARY KEY (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (8,'marbiosgod','ngocthaipham99@gmail.com','imageSource1627388709427.jpg',1999,'$2a$10$dBVg6YANoh0x0xoAk3giS.SSs0Dx/WzSaUuuzCpQAEHOuGX7m2LsC',1463,208,10,0,0),(11,'phamngocthai','123456@gmail.com',NULL,1999,'$2a$10$05ugSB21hw9J.wOJ830eUO0pdUOI3PY28buJaav49bBi5.qJ4nk8u',NULL,NULL,0,0,0),(12,'phamngocthai123','marbiosgod@gmail.com',NULL,1999,'$2a$10$ZutMxNAY.b8aLdzbxNUhPe4GVOzG..sJU12n7xN79e9pamXEJgI/G',NULL,NULL,0,0,0),(13,'marbiosgod123','marbiosgod@gmail.com',NULL,1999,'$2a$10$TYtaNjzHT/SlqYx7mXLqmOIEPKQQKLQfBKNNGj0xWcTuwWJ8pZjii',NULL,NULL,0,0,0),(14,'marbiosgod1','ngocthai@gmail.com',NULL,1999,'$2a$10$BIIhQxfxRgLPGjrXLaxMVeG1oDlip8eSlVy/ykCpfNCDKPoSKcRJ.',NULL,NULL,0,0,0),(15,'marbiosgod456','marbiosgod@gmail.com',NULL,1999,'$2a$10$pYdBWj2Bm/kkmRCdEJYutuZ3q3B7BZwcxc2EbSrG6m76WALRdlCMG',NULL,NULL,0,0,0),(16,'thai','ngocthai@gmail.com','imageSource1627388709427.jpg',1999,'$2a$10$fT5sw3hsp/ZFgS9g8QzUfOsc4B9PYdkDp50f.W0T/MHKRZtGsxMAa',396,79,10,0,1),(17,'thai123456','thai123456@gmail.com',NULL,1999,'$2a$10$27GlLt/GPT63PU4JXwQBMehuJgY.V5KtV1kkC7brX3cO9j8R9om0W',NULL,NULL,0,0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word`
--

DROP TABLE IF EXISTS `word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `idSource` int unsigned DEFAULT NULL,
  `idLevel` int unsigned DEFAULT NULL,
  `level` int unsigned DEFAULT NULL,
  `vocab` varchar(45) NOT NULL,
  `meaning` varchar(45) NOT NULL,
  `imageWord` varchar(255) DEFAULT 'image1627300361179.jpg',
  `audioWord` varchar(255) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `isLearned` tinyint DEFAULT '0',
  `learningPoint` float DEFAULT '0',
  PRIMARY KEY (`id`),
  CONSTRAINT `word_chk_1` CHECK (((-(1) <= `learningPoint`) <= 10)),
  CONSTRAINT `word_chk_2` CHECK (((-(1) <= `learningPoint`) <= 10))
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word`
--

LOCK TABLES `word` WRITE;
/*!40000 ALTER TABLE `word` DISABLE KEYS */;
INSERT INTO `word` VALUES (1,NULL,55,NULL,'Operate','(v) Vận hành, hoạt động',NULL,NULL,NULL,0,-2),(2,NULL,55,NULL,'Opportunity','(n) Cơ hội',NULL,NULL,NULL,0,0),(3,NULL,55,NULL,'Beneficial','(adj) Có lợi',NULL,NULL,NULL,0,0),(4,NULL,55,NULL,'Personal','(adj) Cá nhân',NULL,NULL,NULL,0,0),(5,NULL,55,NULL,'Publish','(v) Xuất bản',NULL,NULL,NULL,0,0),(6,NULL,55,NULL,'Charge','(v) Phí, tính phí',NULL,NULL,NULL,0,0),(7,NULL,55,NULL,'Annual','(adj) Hằng năm, thường niên',NULL,NULL,NULL,0,0),(8,NULL,55,NULL,'Package','(n) Bưu kiện, gói hàng',NULL,NULL,NULL,0,0),(9,NULL,55,NULL,'Likely','(adv) Có khả năng, có thể',NULL,NULL,NULL,0,0),(10,NULL,55,NULL,'Enclose','(v) Đính kèm',NULL,NULL,NULL,0,0),(11,NULL,55,NULL,'Article','(n) Bài báo',NULL,NULL,NULL,0,0),(12,NULL,55,NULL,'Item','(n) Món đồ, món hàng, vật dụng',NULL,NULL,NULL,0,0),(14,NULL,55,NULL,'Indicate','(v) Chỉ ra',NULL,NULL,NULL,0,0),(15,NULL,55,NULL,'Promote','(v) Quảng bá, thúc đẩy, thăng chức',NULL,NULL,NULL,0,0),(16,NULL,55,NULL,'Request','(v) Sự yêu cầu, yêu cầu',NULL,NULL,NULL,0,0),(17,NULL,55,NULL,'Assistance','(adj) Sự hỗ trợ',NULL,NULL,NULL,0,0),(18,NULL,55,NULL,'Interest','(n) Sự quan tâm, lãi suất ( kinh tế )',NULL,NULL,NULL,0,0),(19,NULL,55,NULL,'Industry','(n) Ngành, công nghiệp',NULL,NULL,NULL,0,0),(20,NULL,55,NULL,'Suggest','(v) Đề xuất, đề nghị',NULL,NULL,NULL,0,0),(21,16,3,1,'Record','(v) Số liệu, tài liệu lưu trữ, ghi lại','record.jpg','record.ogg','marbiosgod',1,-2),(22,16,3,1,'Improve','(v) Cải thiện','improve.jpg','improve.ogg','marbiosgod',1,10),(23,16,3,1,'Appreciate','(v) Cảm kích','appreciate.jpg','appreciate.mp3','marbiosgod',1,10),(24,16,3,1,'Policy','(n) Chính sách','policy.jpg','policy.mp3','marbiosgod',1,10),(25,16,3,1,'Process','(n) Quy trình, quá trình','process.png','process.mp3','marbiosgod',1,10),(26,16,3,1,'Proposal','(n) Bảng đề xuất, sự đề xuất','proposal.jpg','proposal.mp3','marbiosgod',1,10),(27,16,3,1,'Propose','(v) Đề xuất','propose.png','propose.mp3','marbiosgod',1,10),(28,16,3,1,'Subscription','(n) Hợp đồng đặt báo','subscription.png','subscription.mp3','marbiosgod',1,10),(29,16,3,1,'Schedule','(n) Lịch trình, sắp xếp, lên lịch','schedule.jpg','schedule.mp3','marbiosgod',1,10),(31,NULL,55,NULL,'Graduate','(v) Tốt nghiệp',NULL,NULL,NULL,0,0),(32,NULL,55,NULL,'Curriculum','(n) Chương trình học',NULL,NULL,NULL,0,0),(33,NULL,55,NULL,'Coursework','(n) Đề án, luận án',NULL,NULL,NULL,0,0),(34,NULL,55,NULL,'Cheat','(v) Gian lận',NULL,NULL,NULL,0,0),(35,NULL,55,NULL,'Literacy','(adj) Biết đọc',NULL,NULL,NULL,0,0),(36,NULL,55,NULL,'Illiterate','(adj) Mù chữ',NULL,NULL,NULL,0,0),(37,NULL,55,NULL,'Primary (elementary) education','(n) Tiểu học',NULL,NULL,NULL,0,0),(38,NULL,55,NULL,'Secondary education','(n) Trung học',NULL,NULL,NULL,0,0),(39,NULL,55,NULL,'Higher (tertiary) education','(n) Đại học',NULL,NULL,NULL,0,0),(40,NULL,55,NULL,'Concentrate','(v) Tập trung',NULL,NULL,NULL,0,0),(41,NULL,55,NULL,'Legislation','(n) Pháp luật',NULL,NULL,NULL,0,0),(42,NULL,55,NULL,'Determine','(v) Xác định',NULL,NULL,NULL,0,0),(43,NULL,55,NULL,'Offender','(n) Tội phạm',NULL,NULL,NULL,0,0),(44,NULL,55,NULL,'Punish','(v) Trừng phạt',NULL,NULL,NULL,0,0),(45,NULL,55,NULL,'Prevention','(n) Sự ngăn chặn',NULL,NULL,NULL,0,0),(46,NULL,55,NULL,'Criminal','(adj) Có tội, phạm tội, tội phạm',NULL,NULL,NULL,0,0),(47,NULL,55,NULL,'Probation','(n) Tù treo',NULL,NULL,NULL,0,0),(48,NULL,55,NULL,'Rehabilitate','(v) Cải tạo, giáo dục lại',NULL,NULL,NULL,0,0),(49,NULL,55,NULL,'Guilt','(adj) Tội lỗi',NULL,NULL,NULL,0,0),(50,NULL,55,NULL,'Justice','(n) Công lý',NULL,NULL,NULL,0,0),(51,NULL,55,NULL,'Overweight','(adj) Quá cân',NULL,NULL,NULL,0,0),(52,NULL,55,NULL,'Obesity','(n) Sự béo phì',NULL,NULL,NULL,0,0),(53,NULL,55,NULL,'Eating disorder','(n) Chứng rối loạn ăn uống',NULL,NULL,NULL,0,0),(54,NULL,55,NULL,'Nutrients','(n) Bổ, (chất) dinh dưỡng',NULL,NULL,NULL,0,0),(55,NULL,55,NULL,'Diet','(v) Ăn kiêng',NULL,NULL,NULL,0,0),(56,NULL,55,NULL,'Ingredient','(n) Thành phần',NULL,NULL,NULL,0,0),(57,NULL,55,NULL,'Allergy','(adj) Dị ứng',NULL,NULL,NULL,0,0),(58,NULL,55,NULL,'Addictive','(adj) Nghiện',NULL,NULL,NULL,0,0),(59,NULL,55,NULL,'Appetite','(n) Sự ngon miệng',NULL,NULL,NULL,0,0),(60,NULL,55,NULL,'Regular','(adj) Cân đối',NULL,NULL,NULL,0,0),(61,NULL,55,NULL,'Culture','(n) Văn hóa',NULL,NULL,NULL,0,0),(62,NULL,55,NULL,'Creative','(adj) Sáng tạo',NULL,NULL,NULL,0,0),(63,NULL,55,NULL,'Classical','(adj) Cổ điển',NULL,NULL,NULL,0,0),(64,NULL,55,NULL,'Musical','(adj) Thuộc về âm nhạc',NULL,NULL,NULL,0,0),(65,NULL,55,NULL,'Theatre','(n) Nhà hát',NULL,NULL,NULL,0,0),(66,NULL,55,NULL,'Sculpture','(n) Tượng điêu khắc, điêu khắc',NULL,NULL,NULL,0,0),(67,NULL,55,NULL,'Abstract','(adj) Trừu tượng',NULL,NULL,NULL,0,0),(68,NULL,55,NULL,'Inspired','(v) Được truyền cảm hứng',NULL,NULL,NULL,0,0),(69,NULL,55,NULL,'Opera','(v) Hát opera',NULL,NULL,NULL,0,0),(70,NULL,55,NULL,'Festival','(n) Lễ hội',NULL,NULL,NULL,0,0),(72,NULL,55,NULL,'Placebo effect','(adj) Tác dụng an thần',NULL,NULL,NULL,0,0),(73,NULL,55,NULL,'Side effect','(adj) Tác dụng phụ',NULL,NULL,NULL,0,0),(74,NULL,55,NULL,'Experiment','(n) Thử nghiệm',NULL,NULL,NULL,0,0),(75,NULL,55,NULL,'Generation','(n) Thế hệ',NULL,NULL,NULL,0,0),(76,NULL,55,NULL,'Clone','(n) Nhân bản',NULL,NULL,NULL,0,0),(77,NULL,55,NULL,'Geoengineering','(n) Công nghệ địa cầu',NULL,NULL,NULL,0,0),(78,NULL,55,NULL,'Cyber','(adj) Siêu, phi thường',NULL,NULL,NULL,0,0),(79,NULL,55,NULL,'Hi-tech','(n) Công nghệ cao',NULL,NULL,NULL,0,0),(80,NULL,55,NULL,'Theory','(n) Lý thuyết',NULL,NULL,NULL,0,0),(81,NULL,55,NULL,'Eat','(v) Ăn',NULL,NULL,NULL,0,0),(82,NULL,55,NULL,'Sleep','(v) Ngủ',NULL,NULL,NULL,0,0),(83,NULL,55,NULL,'Work','(v) Làm việc',NULL,NULL,NULL,0,0),(84,NULL,55,NULL,'Hang out','(v) Đi chơi',NULL,NULL,NULL,0,0),(85,NULL,55,NULL,'Run','(v) Chạy',NULL,NULL,NULL,0,0),(86,NULL,55,NULL,'Swim','(v) Bơi',NULL,NULL,NULL,0,0),(87,NULL,55,NULL,'Walk','(v) Đi bộ',NULL,NULL,NULL,0,0),(88,NULL,55,NULL,'Sit','(v) Ngồi',NULL,NULL,NULL,0,0),(89,NULL,55,NULL,'Stand','(v) Đứng',NULL,NULL,NULL,0,0),(90,NULL,55,NULL,'Lay Down','(v) nằm.',NULL,NULL,NULL,0,0),(91,NULL,55,NULL,'Elephant','(n) Con voi',NULL,NULL,NULL,0,0),(92,NULL,55,NULL,'Lion','(n) Con sư tử',NULL,NULL,NULL,0,0),(93,NULL,55,NULL,'Tiger','(n) Con hổ',NULL,NULL,NULL,0,0),(94,NULL,55,NULL,'Hippo','(n) Con hà mã',NULL,NULL,NULL,0,0),(150,NULL,55,NULL,'hi','xin chao',NULL,NULL,NULL,0,0),(151,NULL,55,NULL,'he','eh',NULL,NULL,NULL,0,0),(152,NULL,55,NULL,'123','321',NULL,NULL,NULL,0,0),(153,NULL,55,NULL,'123123','31231231',NULL,NULL,NULL,0,0),(154,NULL,55,NULL,'12312','3123123123',NULL,NULL,NULL,0,0),(155,NULL,55,NULL,'heheeh','hohoho',NULL,NULL,NULL,0,0),(157,NULL,55,NULL,'hi','xin chào',NULL,NULL,NULL,0,0),(159,NULL,55,NULL,'hia','hek','imageWord1627390291397.jpg','audioWord1627390808360.mp3',NULL,0,0),(160,NULL,55,NULL,'hello','xin chao','imageWord1627394313842.jpg','audioWord1627394324597.mp3',NULL,0,0),(166,NULL,55,NULL,'ádasdád','ưeqewqeqádas','imageWord1627406631008.jpg','audioWord1627406631034.mp3',NULL,0,0),(170,42,54,2,'Record','(v) Số liệu, tài liệu lưu trữ, ghi lại','record.jpg','record.ogg','phamngocthai',0,0),(171,42,54,2,'Improve','(v) Cải thiện','improve.jpg','improve.ogg','phamngocthai',0,0),(172,42,54,2,'Appreciate','(v) Cảm kích','appreciate.jpg','appreciate.mp3','phamngocthai',0,0),(173,42,54,2,'Policy','(n) Chính sách','policy.jpg','policy.mp3','phamngocthai',0,0),(174,42,54,2,'Process','(n) Quy trình, quá trình','process.png','process.mp3','phamngocthai',0,0),(175,42,54,2,'Proposal','(n) Bảng đề xuất, sự đề xuất','proposal.jpg','proposal.mp3','phamngocthai',0,0),(176,42,54,2,'Propose','(v) Đề xuất','propose.png','propose.mp3','phamngocthai',0,0),(177,42,54,2,'Subscription','(n) Hợp đồng đặt báo','subscription.png','subscription.mp3','phamngocthai',0,0),(178,42,54,2,'Schedule','(n) Lịch trình, sắp xếp, lên lịch','schedule.jpg','schedule.mp3','phamngocthai',0,0),(201,47,111,2,'Record','(v) Số liệu, tài liệu lưu trữ, ghi lại','record.jpg','record.ogg','thai',0,0),(202,47,111,2,'Improve','(v) Cải thiện','improve.jpg','improve.ogg','thai',0,0),(203,47,111,2,'Appreciate','(v) Cảm kích','appreciate.jpg','appreciate.mp3','thai',0,0),(204,47,111,2,'Policy','(n) Chính sách','policy.jpg','policy.mp3','thai',0,0),(205,47,111,2,'Process','(n) Quy trình, quá trình','process.png','process.mp3','thai',0,0),(206,47,111,2,'Proposal','(n) Bảng đề xuất, sự đề xuất','proposal.jpg','proposal.mp3','thai',0,0),(207,47,111,2,'Propose','(v) Đề xuất','propose.png','propose.mp3','thai',0,0),(208,47,111,2,'Subscription','(n) Hợp đồng đặt báo','subscription.png','subscription.mp3','thai',0,0),(209,47,111,2,'Schedule','(n) Lịch trình, sắp xếp, lên lịch','schedule.jpg','schedule.mp3','thai',0,0),(231,50,132,2,'Record','(v) Số liệu, tài liệu lưu trữ, ghi lại','record.jpg','record.ogg','thai',0,0),(232,50,132,2,'Improve','(v) Cải thiện','improve.jpg','improve.ogg','thai',0,0),(233,50,132,2,'Appreciate','(v) Cảm kích','appreciate.jpg','appreciate.mp3','thai',0,0),(234,50,132,2,'Policy','(n) Chính sách','policy.jpg','policy.mp3','thai',0,0),(235,50,132,2,'Process','(n) Quy trình, quá trình','process.png','process.mp3','thai',0,0),(236,50,132,2,'Proposal','(n) Bảng đề xuất, sự đề xuất','proposal.jpg','proposal.mp3','thai',0,0),(237,50,132,2,'Propose','(v) Đề xuất','propose.png','propose.mp3','thai',0,0),(238,50,132,2,'Subscription','(n) Hợp đồng đặt báo','subscription.png','subscription.mp3','thai',0,0),(239,50,132,2,'Schedule','(n) Lịch trình, sắp xếp, lên lịch','schedule.jpg','schedule.mp3','thai',0,0),(246,56,153,2,'Record','(v) Số liệu, tài liệu lưu trữ, ghi lại','record.jpg','record.ogg','thai',0,0),(247,56,153,2,'Improve','(v) Cải thiện','improve.jpg','improve.ogg','thai',0,0),(248,56,153,2,'Appreciate','(v) Cảm kích','appreciate.jpg','appreciate.mp3','thai',0,0),(249,56,153,2,'Policy','(n) Chính sách','policy.jpg','policy.mp3','thai',0,0),(250,56,153,2,'Process','(n) Quy trình, quá trình','process.png','process.mp3','thai',0,0),(251,56,153,2,'Proposal','(n) Bảng đề xuất, sự đề xuất','proposal.jpg','proposal.mp3','thai',0,0),(252,56,153,2,'Propose','(v) Đề xuất','propose.png','propose.mp3','thai',0,0),(253,56,153,2,'Subscription','(n) Hợp đồng đặt báo','subscription.png','subscription.mp3','thai',0,0),(254,56,153,2,'Schedule','(n) Lịch trình, sắp xếp, lên lịch','schedule.jpg','schedule.mp3','thai',0,0),(261,57,160,2,'Record','(v) Số liệu, tài liệu lưu trữ, ghi lại','record.jpg','record.ogg','thai',0,0),(262,57,160,2,'Improve','(v) Cải thiện','improve.jpg','improve.ogg','thai',0,0),(263,57,160,2,'Appreciate','(v) Cảm kích','appreciate.jpg','appreciate.mp3','thai',0,0),(264,57,160,2,'Policy','(n) Chính sách','policy.jpg','policy.mp3','thai',0,0),(265,57,160,2,'Process','(n) Quy trình, quá trình','process.png','process.mp3','thai',0,0),(266,57,160,2,'Proposal','(n) Bảng đề xuất, sự đề xuất','proposal.jpg','proposal.mp3','thai',0,0),(267,57,160,2,'Propose','(v) Đề xuất','propose.png','propose.mp3','thai',0,0),(268,57,160,2,'Subscription','(n) Hợp đồng đặt báo','subscription.png','subscription.mp3','thai',0,0),(269,57,160,2,'Schedule','(n) Lịch trình, sắp xếp, lên lịch','schedule.jpg','schedule.mp3','thai',0,0);
/*!40000 ALTER TABLE `word` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-22 19:13:58
