-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: onemeal
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `username` varchar(50) NOT NULL,
  `pass` varchar(45) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin@onemeal.com','Admin@123');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `email` varchar(50) NOT NULL,
  `id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES ('abhinav@9641.com',24),('abhinav@9641.com',9),('abhinav@9641.com',6);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contact` (
  `name` varchar(50) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `message` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES ('KIRAT ANKIT BALU','ankitkirat007@gmail.com','8657171735','I have problem in accessing my email...');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dailymenu`
--

DROP TABLE IF EXISTS `dailymenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dailymenu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `memail` varchar(50) NOT NULL,
  `cart` varchar(100) DEFAULT NULL,
  `qty` longtext,
  `poster` varchar(45) DEFAULT NULL,
  `title` varchar(45) DEFAULT NULL,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dailymenu`
--

LOCK TABLES `dailymenu` WRITE;
/*!40000 ALTER TABLE `dailymenu` DISABLE KEYS */;
INSERT INTO `dailymenu` VALUES (1,'abhinav@9641.com','\"[1, 9, 34, 23, 32]\"','[\"Non-Veg Thali\", \"3\", \"1\", \"1\", \"1\", \"1\", \"70\", \"[1, 9, 34, 23, 32]\"]','nonvegthali.jpg','Non-Veg Thali',70),(2,'abhinav@9641.com','\"[7, 19, 35]\"','[\"panner chapati\", \"1\", \"1\", \"3\", \"100\", \"[7, 19, 35]\"]','paneer.jpg','panner chapati',100),(3,'abhinav@9641.com','\"[6, 9, 23, 5]\"','[\"nonvegthali\", \"2\", \"1\", \"1\", \"1\", \"70\", \"[6, 9, 23, 5]\"]','nonvegthali.jpg','nonvegthali',70),(4,'abhinav@9641.com','\"[6, 15, 23]\"','[\"eggthali\", \"2\", \"1\", \"1\", \"85\", \"[6, 15, 23]\"]','eggthali.jpg','eggthali',85);
/*!40000 ALTER TABLE `dailymenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `fanme` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `adds` varchar(200) NOT NULL,
  `mob` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES ('Ankit','Patil','abhinav@9641','Abhinav@123','Sinhgad college Boys hostel','8657171735','Pune','Maharashtra','India','None'),('Mam','Dange','mam@gmail.com','a','','','Pune','Maharashtra','India','None'),('Mam','Dange','mam1@gmail.com','a','','','Pune','Maharashtra','India','None'),('Mam','Dange','mam2@gmail.com','mam@123','Sinhgad college Boys hostel','8657171735','Pune','Maharashtra','India','Active'),('Tushar ','Zambre','tusharzambre8739@gamail.com','Tushar2123','Sinhgad college Boys hostel','8657171735','Pune','Maharashtra','India','Active');
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liveorder`
--

DROP TABLE IF EXISTS `liveorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liveorder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` varchar(45) NOT NULL,
  `uemail` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `memail` varchar(45) NOT NULL,
  `menu` longtext NOT NULL,
  `price` varchar(45) NOT NULL,
  `mstatus` varchar(45) DEFAULT NULL,
  `dstatus` varchar(45) DEFAULT NULL,
  `demail` varchar(45) DEFAULT NULL,
  `ustatus` varchar(45) DEFAULT NULL,
  `umobile` varchar(45) DEFAULT NULL,
  `adds` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liveorder`
--

LOCK TABLES `liveorder` WRITE;
/*!40000 ALTER TABLE `liveorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `liveorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `cat` varchar(45) NOT NULL,
  `img` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (4,'jamun','Sweets','jamun.jpeg'),(5,'Ice cream','Sweets','icecream.jpeg'),(6,'Bajrichi bhakar','Bread','Bajri-Bhakari.jpg'),(7,'Badam korama','Dry','badam-korma.webp'),(8,'Gvarichi bhakri','Bread','Bhakri.jpg'),(9,'Butter chicken','Gravy','butter-chicken.webp'),(10,'Chicken 65','Dry','chicken-65.webp'),(11,'Chicken biryani','Dry','Chicken-Biryani.jpg'),(12,'Dahi vada','Gravy','Dahi-vada.jpg'),(13,'Dhokla','Dry','Dhokla.jpg'),(14,'Dosa','Dry','Dosa.jpg'),(15,'Egg curry','Gravy','Egg-Curry.jpg'),(16,'Fried chicken','Dry','fried-chicken.jpg'),(17,'Grilled chicken','Dry','grilled-chicken.webp'),(18,'Kofta icecream','Sweets','icecream.jpg'),(19,'Paneer','Gravy','paneer.jpg'),(20,'Pani puri','Dry','panipuri.jpeg'),(21,'Pav bhaji','Gravy','pav-Bhaji.jpg'),(22,'Puri bhaji','Gravy','puribhaji.jpg'),(23,'Rice','Dry','rice.jpeg'),(24,'Tandoor roti','Bread','Tandoori-Roti.jpg'),(25,'Veg pulav','Dry','Veg-Pulav.jpg'),(26,'Vada pav','Dry','vada-pav.jpg'),(27,'Cucumber','Salad','cucumber.jpg'),(28,'Onion','Salad','onion.jpg'),(29,'Beetroot','Salad','beetroot.jpg'),(30,'Kobi','Salad','kobi.jpg'),(31,'Lemon','Salad','lemon.jpg'),(32,'Mango pickle','Pickle','mangopickle.jpg'),(33,'Lemon pickle','Pickle','lemonpickle.jpg'),(34,'Dal fry','Gravy','dal.jpg'),(35,'Chapati','Bread','chapati.jpg'),(36,'Keema matar','Dry','keema-matar.webp'),(37,'Keema matar','Dry','keema-matar.webp');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL,
  `date` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `memail` varchar(45) NOT NULL,
  `menu` varchar(225) NOT NULL,
  `price` varchar(45) NOT NULL,
  `mstatus` varchar(45) NOT NULL,
  `dstatus` varchar(45) NOT NULL,
  `demail` varchar(45) NOT NULL,
  `ustatus` varchar(45) NOT NULL,
  `umobile` varchar(45) DEFAULT NULL,
  `adds` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'16/06/2023 11:02:04','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','110','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(2,'16/06/2023 11:02:04','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','110','Accepted','Reject','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(3,'16/06/2023 11:02:04','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','105','Accepted','Delivered','mam2@gmail.com','None','8657171735','Sinhgad college Boys hostel'),(4,'16/06/2023 12:14:49','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','105','Reject','None','None','Reject','8657171735','Sinhgad college Boys hostel'),(5,'16/06/2023 12:21:16','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','105','Reject','None','None','None','8657171735','Sinhgad college Boys hostel'),(6,'17/06/2023 17:45:23','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','105','None','None','None','Reject','8657171735','Sinhgad college Boys hostel'),(7,'17/06/2023 17:45:23','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','105','None','None','None','Reject','8657171735','Sinhgad college Boys hostel'),(10,'17/06/2023 18:04:06','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, ','185','Reject','None','None','None','8657171735','Sinhgad college Boys hostel'),(11,'17/06/2023 18:04:06','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Ice cream, Chapati, jamun, Ice cream, ','185','Accepted','None','None','Reject','8657171735','Sinhgad college Boys hostel'),(12,'27/06/2023 00:44:09','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Butter chicken, ','100','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(13,'27/06/2023 00:44:09','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Butter chicken, ','100','Accepted','Reject','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(14,'27/06/2023 10:19:07','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Butter chicken, ','100','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(15,'27/06/2023 10:19:07','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Chapati, jamun, Butter chicken, ','100','Accepted','Reject','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(16,'27/06/2023 10:19:07','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' jamun, Butter chicken, ','100','Reject','None','None','None','8657171735','Sinhgad college Boys hostel'),(17,'27/06/2023 10:19:07','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Bajrichi bhakar, Butter chicken, ','100','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(18,'27/06/2023 11:15:44','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Bajrichi bhakar, Butter chicken, ','100','None','None','None','Reject','8657171735','Sinhgad college Boys hostel'),(19,'27/06/2023 11:15:44','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Bajrichi bhakar, Butter chicken, ','100','Accepted','Collect','tusharzambre8739@gamail.com','Reject','8657171735','Sinhgad college Boys hostel'),(20,'27/06/2023 13:20:03','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Bajrichi bhakar, Butter chicken, ','100','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(21,'27/06/2023 14:00:14','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Bajrichi bhakar, Butter chicken, ','100','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(23,'27/06/2023 16:12:50','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Bajrichi bhakar, Ice cream, Bajrichi bhakar, ','200','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(22,'27/06/2023 16:12:50','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Bajrichi bhakar, ','200','Accepted','None','tusharzambre8739@gamail.com','Reject','8657171735','Sinhgad college Boys hostel'),(25,'08/08/2023 11:40:57','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Badam korama, Butter chicken, Ice cream, Bajrichi bhakar, Butter chicken, ','200','Reject','None','None','None','8657171735','Sinhgad college Boys hostel'),(24,'08/08/2023 11:40:57','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Badam korama, Butter chicken, ','200','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(26,'22/11/2023 13:28:56','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' jamun, Butter chicken, ','100','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(27,'19/12/2023 22:18:51','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' jamun, Butter chicken, ','100','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(28,'20/12/2023 09:20:10','pankaj123@gmail.com','Pankaj Dhande','abhinav@9641.com',' Ice cream, Badam korama, Butter chicken, ','130','Accepted','Delivered','tusharzambre8739@gamail.com','None','9309545166','arc gaurav society pune'),(30,'20/12/2023 23:13:00','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Badam korama, Butter chicken, ','130','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel'),(29,'20/12/2023 09:20:10','pankaj123@gmail.com','Pankaj Dhande','abhinav@9641.com',' Ice cream, Badam korama, Butter chicken, ','130','Accepted','Delivered','tusharzambre8739@gamail.com','None','9309545166','arc gaurav society pune'),(31,'21/12/2023 12:35:08','ankitkirat007@gmail.com','Ankit Kirat','abhinav@9641.com',' Ice cream, Badam korama, Butter chicken, ','130','Accepted','Delivered','tusharzambre8739@gamail.com','None','8657171735','Sinhgad college Boys hostel');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regc`
--

DROP TABLE IF EXISTS `regc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regc` (
  `regi_type` varchar(50) NOT NULL,
  `fname` varchar(100) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `adds` varchar(200) NOT NULL,
  `mob` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`email`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regc`
--

LOCK TABLES `regc` WRITE;
/*!40000 ALTER TABLE `regc` DISABLE KEYS */;
INSERT INTO `regc` VALUES ('Customer','Ankit','Kirat','ankitkirat007@gmail.com','Ankit@123','Sinhgad college Boys hostel','8657171735','Pune','Maharashtra','India'),('Customer','Pankaj','Dhande','pankaj123@gmail.com','Pankaj@123','arc gaurav society pune','9309545166','Pune','Maharashtra','India'),('Customer','Pramodini','Dange','paramodini123@gmail.com','Pramodini@123','Sinhgad college Boys hostel','8657171735','Pune','Maharashtra','India'),('Customer','Vishwajeet','Hiwale','vishwa@gmail.com','Pass@123','at pune 443401','9561994658','Pune','Maharashtra','India'),('Customer','Vishwajeet','Hiwale','vishwajeethiwale@gmail.com','Vish@123','Sinhgad college Boys hostel','8657171735','Pune','Maharashtra','India');
/*!40000 ALTER TABLE `regc` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `regm`
--

DROP TABLE IF EXISTS `regm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `regm` (
  `reg_type` varchar(50) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `pass` varchar(45) NOT NULL,
  `adds` varchar(245) NOT NULL,
  `mob` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `country` varchar(45) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `regm`
--

LOCK TABLES `regm` WRITE;
/*!40000 ALTER TABLE `regm` DISABLE KEYS */;
INSERT INTO `regm` VALUES ('Mess','Abhinav','Patil','abhinav@9641.com','Abhinav@123','Sinhgad college Boys hostel','8657171737','Pune','Maharashtra','India');
/*!40000 ALTER TABLE `regm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ucart`
--

DROP TABLE IF EXISTS `ucart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ucart` (
  `id` int DEFAULT NULL,
  `uemaill` varchar(45) DEFAULT NULL,
  `memail` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ucart`
--

LOCK TABLES `ucart` WRITE;
/*!40000 ALTER TABLE `ucart` DISABLE KEYS */;
INSERT INTO `ucart` VALUES (2,'vishwa@gmail.com','abhinav@9641.com');
/*!40000 ALTER TABLE `ucart` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-08 22:25:18
