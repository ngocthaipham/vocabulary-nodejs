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
-- Table structure for table `level`
--

DROP TABLE IF EXISTS `level`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `level` (
  `idLevel` int unsigned NOT NULL,
  `level` int unsigned NOT NULL,
  `idSource` int unsigned NOT NULL,
  `nameSource` varchar(45) NOT NULL,
  PRIMARY KEY (`idLevel`),
  KEY `idSource_idx` (`idSource`,`nameSource`),
  CONSTRAINT `idSource` FOREIGN KEY (`idSource`, `nameSource`) REFERENCES `source` (`idSource`, `nameSource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `level`
--

LOCK TABLES `level` WRITE;
/*!40000 ALTER TABLE `level` DISABLE KEYS */;
INSERT INTO `level` (`idLevel`, `level`, `idSource`, `nameSource`) VALUES (1,1,1,'600 essential word for TOEIC'),(2,2,1,'600 essential word for TOEIC'),(3,3,1,'600 essential word for TOEIC'),(4,1,2,'Vocabulary for IELTS'),(5,2,2,'Vocabulary for IELTS'),(6,1,3,'IELTS words for reading and writing'),(7,2,3,'IELTS words for reading and writing'),(8,3,3,'IELTS words for reading and writing'),(9,1,4,'Basis english for beginer'),(10,2,4,'Basis english for beginer');
/*!40000 ALTER TABLE `level` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `source` (
  `idSource` int unsigned NOT NULL,
  `nameSource` varchar(45) NOT NULL,
  `desSource` text,
  PRIMARY KEY (`idSource`,`nameSource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
INSERT INTO `source` (`idSource`, `nameSource`, `desSource`) VALUES (1,'600 essential word for TOEIC','Include 600 words so you can review for the TOEIC exam'),(2,'Vocabulary for IELTS','Some vocabulary you can learn for IELTS'),(3,'IELTS words for reading and writing','This will help you improve your reading and writing skill'),(4,'Basis english for beginer','If you want to learn english, you must to learn this course');
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `word`
--

DROP TABLE IF EXISTS `word`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `word` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `idLevel` int unsigned NOT NULL,
  `vocab` varchar(45) NOT NULL,
  `meaning` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idLevel_idx` (`idLevel`),
  CONSTRAINT `idLevel` FOREIGN KEY (`idLevel`) REFERENCES `level` (`idLevel`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `word`
--

LOCK TABLES `word` WRITE;
/*!40000 ALTER TABLE `word` DISABLE KEYS */;
INSERT INTO `word` (`id`, `idLevel`, `vocab`, `meaning`) VALUES (1,1,'Operate','(v) Vận hành, hoạt động'),(2,1,'Opportunity','(n) Cơ hội'),(3,1,'Beneficial','(adj) Có lợi'),(4,1,'Personal','(adj) Cá nhân'),(5,1,'Publish','(v) Xuất bản'),(6,1,'Charge','(n/v) Phí, tính phí'),(7,1,'Annual','(adj) Hằng năm, thường niên'),(8,1,'Package','(n) Bưu kiện, gói hàng'),(9,1,'Likely','(adj/adv) Có khả năng, có thể'),(10,1,'Enclose','(v) Đính kèm'),(11,2,'Article','(n) Bài báo'),(12,2,'Item','(n) Món đồ, món hàng, vật dụng'),(13,2,'Available','(adj) Được cung cấp sẵn, sẵn có, sẵn sàng'),(14,2,'Indicate','(v) Chỉ ra'),(15,2,'Promote','(v) Quảng bá, thúc đẩy, thăng chức'),(16,2,'Request','(n/v) Sự yêu cầu, yêu cầu'),(17,2,'Assistance','(adj) Sự hỗ trợ'),(18,2,'Interest','(n) Sự quan tâm, lãi suất ( kinh tế )'),(19,2,'Industry','(n) Ngành, công nghiệp'),(20,2,'Suggest','(v) Đề xuất, đề nghị'),(21,3,'Record','(n/v) Số liệu, tài liệu lưu trữ/ghi lại'),(22,3,'Improve','(v) Cải thiện'),(23,3,'Appreciate','(v) Cảm kích'),(24,3,'Policy','(n) Chính sách'),(25,3,'Process','(n/v) Quy trình, quá trình/xử lý'),(26,3,'Proposal','(n) Bảng đề xuất, sự đề xuất'),(27,3,'Propose','(v) Đề xuất'),(28,3,'Subscription','(n) Hợp đồng đặt báo'),(29,3,'Schedule','(n/v) Lịch trình/sắp xếp, lên lịch'),(30,3,'Conduct','(v) Tiến hành, tổ chức'),(31,4,'Graduate','(v) Tốt nghiệp'),(32,4,'Curriculum','(n) Chương trình học'),(33,4,'Coursework','(n) Đề án/luận án'),(34,4,'Cheat','(v) Gian lận'),(35,4,'Literacy','(adj) Biết đọc'),(36,4,'Illiterate','(adj) Mù chữ'),(37,4,'Primary (elementary) education','(n) Tiểu học'),(38,4,'Secondary education','(n) Trung học'),(39,4,'Higher (tertiary) education','(n) Đại học'),(40,4,'Concentrate','(v) Tập trung'),(41,5,'Legislation','(n) Pháp luật'),(42,5,'Determine','(v) Xác định'),(43,5,'Offender','(n) Tội phạm'),(44,5,'Punish','(v) Trừng phạt'),(45,5,'Prevention','(n) Sự ngăn chặn'),(46,5,'Criminal','(adj/n) Có tội, phạm tội, tội phạm'),(47,5,'Probation','(n) Tù treo'),(48,5,'Rehabilitate','(v) Cải tạo, giáo dục lại'),(49,5,'Guilt','(adj) Tội lỗi'),(50,5,'Justice','(n) Công lý'),(51,6,'Overweight','(adj) Quá cân'),(52,6,'Obesity','(n) Sự béo phì'),(53,6,'Eating disorder','(n) Chứng rối loạn ăn uống'),(54,6,'Nutrients','(n) Bổ, (chất) dinh dưỡng'),(55,6,'Diet','(v) Ăn kiêng'),(56,6,'Ingredient','(n) Thành phần'),(57,6,'Allergy','(adj) Dị ứng'),(58,6,'Addictive','(adj) Nghiện'),(59,6,'Appetite','(n) Sự ngon miệng'),(60,6,'Regular','(adj) Cân đối'),(61,7,'Culture','(n) Văn hóa'),(62,7,'Creative','(adj) Sáng tạo'),(63,7,'Classical','(adj) Cổ điển'),(64,7,'Musical','(adj) Thuộc về âm nhạc'),(65,7,'Theatre','(n) Nhà hát'),(66,7,'Sculpture','(n/v) Tượng điêu khắc, điêu khắc'),(67,7,'Abstract','(adj) Trừu tượng'),(68,7,'Inspired','(v) Được truyền cảm hứng'),(69,7,'Opera','(v) Hát opera'),(70,7,'Festival','(n) Lễ hội'),(71,8,'Placebo','(n) Thuốc an thần'),(72,8,'Placebo effect','(adj) Tác dụng an thần'),(73,8,'Side effect','(adj) Tác dụng phụ'),(74,8,'Experiment','(n) Thử nghiệm'),(75,8,'Generation','(n) Thế hệ'),(76,8,'Clone','(n) Nhân bản'),(77,8,'Geoengineering','(n) Công nghệ địa cầu'),(78,8,'Cyber','(adj) Siêu, phi thường'),(79,8,'Hi-tech','(n) Công nghệ cao'),(80,8,'Theory','(n) Lý thuyết'),(81,9,'Eat','(v) Ăn'),(82,9,'Sleep','(v) Ngủ'),(83,9,'Work','(v) Làm việc'),(84,9,'Hang out','(v) Đi chơi'),(85,9,'Run','(v) Chạy'),(86,9,'Swim','(v) Bơi'),(87,9,'Walk','(v) Đi bộ'),(88,9,'Sit','(v) Ngồi'),(89,9,'Stand','(v) Đứng'),(90,9,'Lay down','(v) Nằm'),(91,10,'Elephant','(n) Con voi'),(92,10,'Lion','(n) Con sư tử'),(93,10,'Tiger','(n) Con hổ'),(94,10,'Hippo','(n) Con hà mã'),(95,10,'Monkey','(n) Con khỉ'),(96,10,'Snake','(n) Con rắn'),(97,10,'Bird','(n) Con Chim'),(98,10,'Chicken','(n) Con gà'),(99,10,'Hen','(n) Con gà mái'),(100,10,'Rooster','(n) Con gà trống');
/*!40000 ALTER TABLE `word` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'khoahoc'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-16 21:46:37
