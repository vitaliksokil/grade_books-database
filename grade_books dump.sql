CREATE DATABASE  IF NOT EXISTS `gradebooks` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gradebooks`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: gradebooks
-- ------------------------------------------------------
-- Server version	8.0.18

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
-- Table structure for table `attestations`
--

DROP TABLE IF EXISTS `attestations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attestations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_title` varchar(255) NOT NULL,
  `exam_date` timestamp NOT NULL,
  `national_scale` varchar(10) NOT NULL,
  `number_of_points` tinyint(2) unsigned NOT NULL,
  `ects_scale` char(1) NOT NULL,
  `commission_verification` tinyint(4) NOT NULL DEFAULT '0',
  `exam_books_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`exam_books_id`),
  KEY `fk_attestation_exam_books1_idx` (`exam_books_id`),
  CONSTRAINT `fk_attestation_exam_books1` FOREIGN KEY (`exam_books_id`) REFERENCES `exam_books` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attestations`
--

LOCK TABLES `attestations` WRITE;
/*!40000 ALTER TABLE `attestations` DISABLE KEYS */;
INSERT INTO `attestations` VALUES (1,'Exam title 1','2019-12-31 22:00:00','добре',70,'C',1,1);
/*!40000 ALTER TABLE `attestations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_books`
--

DROP TABLE IF EXISTS `exam_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_books` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `exam_book_number` varchar(20) NOT NULL,
  `students_id` int(10) unsigned NOT NULL,
  `exam_regulation_id` int(11) DEFAULT NULL,
  `graduate_work_id` int(11) DEFAULT NULL,
  `education_form` tinyint(4) NOT NULL,
  `dean_id` int(11) NOT NULL,
  `prorector_id` int(11) NOT NULL,
  `education_level` tinyint(4) NOT NULL,
  `enrollment_date` timestamp NOT NULL,
  PRIMARY KEY (`id`,`students_id`,`dean_id`,`prorector_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `exam_book_number_UNIQUE` (`exam_book_number`),
  KEY `fk_exam_books_students1_idx` (`students_id`),
  KEY `fk_exam_books_exam_regulation1_idx` (`exam_regulation_id`),
  KEY `fk_exam_books_graduate_work1_idx` (`graduate_work_id`),
  KEY `fk_exam_books_teachers1_idx` (`dean_id`),
  KEY `fk_exam_books_teachers2_idx` (`prorector_id`),
  CONSTRAINT `fk_exam_books_students1` FOREIGN KEY (`students_id`) REFERENCES `students` (`id`),
  CONSTRAINT `fk_exam_books_teachers1` FOREIGN KEY (`dean_id`) REFERENCES `teachers` (`id`),
  CONSTRAINT `fk_exam_books_teachers2` FOREIGN KEY (`prorector_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_books`
--

LOCK TABLES `exam_books` WRITE;
/*!40000 ALTER TABLE `exam_books` DISABLE KEYS */;
INSERT INTO `exam_books` VALUES (1,'ІПЗ-22-17',1,2,1,1,1,2,1,'2017-08-31 21:00:00');
/*!40000 ALTER TABLE `exam_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_regulation`
--

DROP TABLE IF EXISTS `exam_regulation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_regulation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `regulation` text NOT NULL,
  `date` timestamp NOT NULL,
  `is_honor` tinyint(4) NOT NULL DEFAULT '0',
  `teacher_verification` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_regulation`
--

LOCK TABLES `exam_regulation` WRITE;
/*!40000 ALTER TABLE `exam_regulation` DISABLE KEYS */;
INSERT INTO `exam_regulation` VALUES (2,'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','2020-06-15 21:00:00',1,1);
/*!40000 ALTER TABLE `exam_regulation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_regulation_has_teachers`
--

DROP TABLE IF EXISTS `exam_regulation_has_teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exam_regulation_has_teachers` (
  `exam_regulation_id` int(11) NOT NULL,
  `teachers_id` int(11) NOT NULL,
  PRIMARY KEY (`exam_regulation_id`,`teachers_id`),
  KEY `fk_exam_regulation_has_teachers_teachers1_idx` (`teachers_id`),
  KEY `fk_exam_regulation_has_teachers_exam_regulation1_idx` (`exam_regulation_id`),
  CONSTRAINT `fk_exam_regulation_has_teachers_exam_regulation1` FOREIGN KEY (`exam_regulation_id`) REFERENCES `exam_regulation` (`id`),
  CONSTRAINT `fk_exam_regulation_has_teachers_teachers1` FOREIGN KEY (`teachers_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_regulation_has_teachers`
--

LOCK TABLES `exam_regulation_has_teachers` WRITE;
/*!40000 ALTER TABLE `exam_regulation_has_teachers` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_regulation_has_teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exams`
--

DROP TABLE IF EXISTS `exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `exams` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) unsigned NOT NULL,
  `title` varchar(45) NOT NULL,
  `hours` smallint(2) unsigned NOT NULL,
  `ects_credits` tinyint(1) unsigned NOT NULL,
  `national_scale` varchar(10) NOT NULL,
  `number_of_points` tinyint(2) unsigned NOT NULL,
  `ects_scale` char(1) NOT NULL,
  `exam_date` timestamp NOT NULL,
  `teacher_verification` tinyint(4) NOT NULL DEFAULT '0',
  `teachers_id` int(11) NOT NULL,
  `exam_books_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`,`teachers_id`,`exam_books_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_exams_teachers1_idx` (`teachers_id`),
  KEY `fk_exams_exam_books1_idx` (`exam_books_id`),
  CONSTRAINT `fk_exams_exam_books1` FOREIGN KEY (`exam_books_id`) REFERENCES `exam_books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_exams_teachers1` FOREIGN KEY (`teachers_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exams`
--

LOCK TABLES `exams` WRITE;
/*!40000 ALTER TABLE `exams` DISABLE KEYS */;
INSERT INTO `exams` VALUES (2,1,'Бази даних',180,6,'відмінно',90,'A','2019-01-21 22:00:00',1,2,1);
/*!40000 ALTER TABLE `exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculties`
--

DROP TABLE IF EXISTS `faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties`
--

LOCK TABLES `faculties` WRITE;
/*!40000 ALTER TABLE `faculties` DISABLE KEYS */;
INSERT INTO `faculties` VALUES (1,'Математики та інформатики');
/*!40000 ALTER TABLE `faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculties_has_students`
--

DROP TABLE IF EXISTS `faculties_has_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculties_has_students` (
  `faculties_id` int(11) NOT NULL,
  `students_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`faculties_id`,`students_id`),
  KEY `fk_faculties_has_students_students1_idx` (`students_id`),
  KEY `fk_faculties_has_students_faculties1_idx` (`faculties_id`),
  CONSTRAINT `fk_faculties_has_students_faculties1` FOREIGN KEY (`faculties_id`) REFERENCES `faculties` (`id`),
  CONSTRAINT `fk_faculties_has_students_students1` FOREIGN KEY (`students_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculties_has_students`
--

LOCK TABLES `faculties_has_students` WRITE;
/*!40000 ALTER TABLE `faculties_has_students` DISABLE KEYS */;
INSERT INTO `faculties_has_students` VALUES (1,1);
/*!40000 ALTER TABLE `faculties_has_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `graduate_work`
--

DROP TABLE IF EXISTS `graduate_work`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `graduate_work` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `theme` varchar(255) NOT NULL,
  `teachers_id` int(11) NOT NULL,
  `submission_date` timestamp NOT NULL,
  `defense_date` timestamp NOT NULL,
  `national_scale` varchar(10) NOT NULL,
  `number_of_points` tinyint(2) unsigned NOT NULL,
  `ects_scale` char(1) NOT NULL,
  `commission_verification` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`teachers_id`,`defense_date`),
  KEY `fk_graduate_work_teachers1_idx` (`teachers_id`),
  CONSTRAINT `fk_graduate_work_teachers1` FOREIGN KEY (`teachers_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `graduate_work`
--

LOCK TABLES `graduate_work` WRITE;
/*!40000 ALTER TABLE `graduate_work` DISABLE KEYS */;
INSERT INTO `graduate_work` VALUES (1,'Theme 1',1,'2021-06-14 21:00:00','2021-06-15 21:00:00','добре',82,'B',1);
/*!40000 ALTER TABLE `graduate_work` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutes`
--

DROP TABLE IF EXISTS `institutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institutes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutes`
--

LOCK TABLES `institutes` WRITE;
/*!40000 ALTER TABLE `institutes` DISABLE KEYS */;
INSERT INTO `institutes` VALUES (1,'ПНУ');
/*!40000 ALTER TABLE `institutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutes_has_faculties`
--

DROP TABLE IF EXISTS `institutes_has_faculties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institutes_has_faculties` (
  `institutes_id` int(11) NOT NULL,
  `faculties_id` int(11) NOT NULL,
  PRIMARY KEY (`institutes_id`,`faculties_id`),
  KEY `fk_institutes_has_faculties_faculties1_idx` (`faculties_id`),
  KEY `fk_institutes_has_faculties_institutes1_idx` (`institutes_id`),
  CONSTRAINT `fk_institutes_has_faculties_faculties1` FOREIGN KEY (`faculties_id`) REFERENCES `faculties` (`id`),
  CONSTRAINT `fk_institutes_has_faculties_institutes1` FOREIGN KEY (`institutes_id`) REFERENCES `institutes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutes_has_faculties`
--

LOCK TABLES `institutes_has_faculties` WRITE;
/*!40000 ALTER TABLE `institutes_has_faculties` DISABLE KEYS */;
INSERT INTO `institutes_has_faculties` VALUES (1,1);
/*!40000 ALTER TABLE `institutes_has_faculties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutes_has_students`
--

DROP TABLE IF EXISTS `institutes_has_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institutes_has_students` (
  `institutes_id` int(11) NOT NULL,
  `students_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`institutes_id`,`students_id`),
  KEY `fk_institutes_has_students_students1_idx` (`students_id`),
  KEY `fk_institutes_has_students_institutes1_idx` (`institutes_id`),
  CONSTRAINT `fk_institutes_has_students_institutes1` FOREIGN KEY (`institutes_id`) REFERENCES `institutes` (`id`),
  CONSTRAINT `fk_institutes_has_students_students1` FOREIGN KEY (`students_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutes_has_students`
--

LOCK TABLES `institutes_has_students` WRITE;
/*!40000 ALTER TABLE `institutes_has_students` DISABLE KEYS */;
INSERT INTO `institutes_has_students` VALUES (1,1);
/*!40000 ALTER TABLE `institutes_has_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `practices`
--

DROP TABLE IF EXISTS `practices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `practices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_books_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `course` tinyint(1) unsigned NOT NULL,
  `practice_place` varchar(255) NOT NULL,
  `job` varchar(255) NOT NULL,
  `from_date` timestamp NOT NULL,
  `to_date` timestamp NOT NULL,
  `teachers_id` int(11) NOT NULL,
  `national_scale` varchar(10) NOT NULL,
  `number_of_points` tinyint(2) unsigned NOT NULL,
  `ects_scale` char(1) NOT NULL,
  `defense_date` timestamp NOT NULL,
  `teacher_verification` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`,`exam_books_id`,`teachers_id`),
  KEY `fk_Practice_exam_books1_idx` (`exam_books_id`),
  KEY `fk_Practice_teachers1_idx` (`teachers_id`),
  CONSTRAINT `fk_Practice_exam_books1` FOREIGN KEY (`exam_books_id`) REFERENCES `exam_books` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_Practice_teachers1` FOREIGN KEY (`teachers_id`) REFERENCES `teachers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `practices`
--

LOCK TABLES `practices` WRITE;
/*!40000 ALTER TABLE `practices` DISABLE KEYS */;
INSERT INTO `practices` VALUES (1,1,'Практика 1',3,'Company A','software developer','2019-11-30 22:00:00','2020-01-14 22:00:00',1,'добре',75,'C','2020-01-15 22:00:00',1);
/*!40000 ALTER TABLE `practices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialities`
--

DROP TABLE IF EXISTS `specialities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `faculties_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`faculties_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `title_UNIQUE` (`name`),
  KEY `fk_specialities_faculties1_idx` (`faculties_id`),
  CONSTRAINT `fk_specialities_faculties1` FOREIGN KEY (`faculties_id`) REFERENCES `faculties` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialities`
--

LOCK TABLES `specialities` WRITE;
/*!40000 ALTER TABLE `specialities` DISABLE KEYS */;
INSERT INTO `specialities` VALUES (1,'ІПЗ',1),(2,'КН',1);
/*!40000 ALTER TABLE `specialities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `specialities_has_students`
--

DROP TABLE IF EXISTS `specialities_has_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `specialities_has_students` (
  `specialities_id` int(11) NOT NULL,
  `students_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`specialities_id`,`students_id`),
  KEY `fk_specialities_has_students_students1_idx` (`students_id`),
  KEY `fk_specialities_has_students_specialities1_idx` (`specialities_id`),
  CONSTRAINT `fk_specialities_has_students_specialities1` FOREIGN KEY (`specialities_id`) REFERENCES `specialities` (`id`),
  CONSTRAINT `fk_specialities_has_students_students1` FOREIGN KEY (`students_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `specialities_has_students`
--

LOCK TABLES `specialities_has_students` WRITE;
/*!40000 ALTER TABLE `specialities_has_students` DISABLE KEYS */;
INSERT INTO `specialities_has_students` VALUES (1,1);
/*!40000 ALTER TABLE `specialities_has_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL,
  `middle_name` varchar(20) NOT NULL,
  `photo` varchar(255) NOT NULL,
  `birth_date` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Vitalii','Sokil','Svyatoslavich','12345.png','2000-06-04 21:00:00');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teachers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `surname` varchar(20) NOT NULL,
  `middle_name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,'Володимир ','Пилипів ','Михайлович'),(2,'Галина','Михайлишин','Йосипівна');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'gradebooks'
--

--
-- Dumping routines for database 'gradebooks'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-15 23:26:13
