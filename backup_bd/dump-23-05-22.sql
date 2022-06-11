-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: oftalmolog_sys
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clinic_addresses`
--

DROP TABLE IF EXISTS `clinic_addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `postIndex` varchar(1000) DEFAULT NULL,
  `address` varchar(1000) NOT NULL,
  `comments` varchar(1000) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `clinicId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clinicId` (`clinicId`),
  CONSTRAINT `clinic_addresses_ibfk_1` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_addresses`
--

LOCK TABLES `clinic_addresses` WRITE;
/*!40000 ALTER TABLE `clinic_addresses` DISABLE KEYS */;
INSERT INTO `clinic_addresses` VALUES (1,'650066','г. Кемерово, пр-т Октябрьский, 22А','ГАУЗ Кузбасская областная клиническая больница им. С.В. Беляева. Проезд до остановки «Областная больница на пр. Октябрьский». Офтальмологический корпус областной больницы (расположен сразу за хирургическим корпусом), второй этаж, направо, хирургическое отделение №7, кабинет заведующего. За справками можно обратиться на сестринский пост и к старшей сестре отделения.','2022-02-28 16:24:54','2022-02-28 16:24:54',1);
/*!40000 ALTER TABLE `clinic_addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_contacts`
--

DROP TABLE IF EXISTS `clinic_contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `contact` varchar(1000) NOT NULL,
  `isMain` tinyint(1) DEFAULT '0',
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `clinicId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `clinicId` (`clinicId`),
  CONSTRAINT `clinic_contacts_ibfk_1` FOREIGN KEY (`id`) REFERENCES `clinics` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `clinic_contacts_ibfk_2` FOREIGN KEY (`clinicId`) REFERENCES `clinics` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_contacts`
--

LOCK TABLES `clinic_contacts` WRITE;
/*!40000 ALTER TABLE `clinic_contacts` DISABLE KEYS */;
INSERT INTO `clinic_contacts` VALUES (1,'Call центр','39-65-33',0,'2022-02-28 16:20:15','2022-02-28 16:20:15',1),(2,'Отделение №7','39-60-58',0,'2022-02-28 16:20:42','2022-02-28 16:20:42',1),(3,'Отделение №7','68-10-96',0,'2022-02-28 16:21:05','2022-02-28 16:21:05',1),(4,'Заведующий отделением №7, Хатминский Николай Юрьевич','+79131238881',1,'2022-02-28 16:21:53','2022-02-28 16:21:53',1);
/*!40000 ALTER TABLE `clinic_contacts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinics`
--

DROP TABLE IF EXISTS `clinics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `shortDescription` varchar(1000) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinics`
--

LOCK TABLES `clinics` WRITE;
/*!40000 ALTER TABLE `clinics` DISABLE KEYS */;
INSERT INTO `clinics` VALUES (1,'Кузбасская областная клиническая больница им. С.В. Беляева, хирургическое отделение №7','В отделении проводится хирургическое и медикаментозное лечение заболеваний глаз','2022-02-28 14:46:39','2022-02-28 14:46:39');
/*!40000 ALTER TABLE `clinics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `scientific_title` varchar(255) DEFAULT NULL,
  `description` varchar(3000) DEFAULT NULL,
  `phoneNumber` varchar(255) DEFAULT NULL,
  `imgLink` varchar(1000) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `doctors_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Николай','Хатминский','Юрьевич','Заведующий отделением','к.м.н., врач высшей категории',NULL,'Автор ряда патентов и рацпредложений.  Имеет награды областного и федерального значения. Специализируется на микрохирургии глаза, консультирует пациентов по вопросам выбора и планирования операции.','+79131238881',NULL,'2022-02-14 16:25:57','2022-02-14 16:26:07',NULL),(2,'Марина','Никитина','Юрьевна','Старшая медицинская сестра','Категория - высшая',NULL,NULL,NULL,NULL,'2022-02-14 16:27:29','2022-02-14 16:27:29',NULL),(3,'Татьяна','Баева','Витальевна','Врач-офтальмолог','Врач высшей категории',NULL,'Специализируется на амбулаторной хирургии при заболеваниях век, конъюнктивы. <br/> Так же занимается консервативным лечением при воспалительных заболеваниях глаза (кератит, склерит, иридоциклит, хориоретинит), глаукоме, заболеваниях сетчатки. ',NULL,NULL,'2022-02-14 16:29:45','2022-02-14 16:29:45',NULL),(4,'Нина','Федорова','Федоровна','Врач-офтальмолог','Врач высшей категории',NULL,'Специализация - пластическая хирургия век. <br/>Выполняет операции по коррекции блефарохолязиса, грыж орбитальной клетчатки. Имеет награды областного и федерального значения, медаль за заслуги перед Кузбассом 3 степени. Нагрудный знак «Отличник здравоохранения».  ',NULL,NULL,'2022-02-14 16:33:39','2022-02-14 16:33:39',NULL),(5,'Дарья','Пушкарева','Андреевна','Врач-офтальмолог',NULL,NULL,'Специализируется на курации пациентов с различной патологией, выполняет операции экстренные и плановые на веках, конъюнктиве.',NULL,NULL,'2022-02-14 16:40:15','2022-02-14 16:40:15',NULL),(6,'Татьяна','Янченко','Валентиновна','Заведующий отделением','к.м.н',NULL,'Специализируется на операциях при косоглазии, птозе, операциях при новообразованиях глаза, орбиты и век.',NULL,NULL,'2022-02-17 17:32:18','2022-02-17 17:32:18',NULL),(7,'Дарья','Белозерова','Юрьевна',NULL,NULL,NULL,'Специалист по индивидуальному подбору искусственного хрусталика и дополнительным инструментальным исследованиям строения и функций глаза.',NULL,NULL,'2022-02-22 12:10:44','2022-02-22 12:10:44',NULL),(8,'Наталья','Баркова','Юрьевна',NULL,NULL,NULL,'Специалист по исследованию глаза на ОКТ – оптическом когерентном (лазерном) томографе с компьютерной обработкой изображения. ОКТ позволяет оценить состояние микроструктур сетчатки, зрительного нерва и переднего отдела глаза.',NULL,NULL,'2022-02-22 12:11:32','2022-02-22 12:11:32',NULL);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faqs`
--

DROP TABLE IF EXISTS `faqs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faqs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `question` varchar(1000) NOT NULL,
  `answer` varchar(1000) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faqs`
--

LOCK TABLES `faqs` WRITE;
/*!40000 ALTER TABLE `faqs` DISABLE KEYS */;
INSERT INTO `faqs` VALUES (1,'Что такое катаракта?','К. – это помутнение хрусталика','2022-03-04 13:01:16','2022-03-04 13:01:16'),(2,'Что такое хрусталик?','Х. это естественная линза, увеличительное биологическое стекло внутри глаза','2022-03-04 13:01:38','2022-03-04 13:01:38'),(3,'Что такое искусственный хрусталик?','- это индивидуально подобранная линза, которая имплантируется внутрь глаза вместо мутного хрусталика','2022-03-04 13:02:11','2022-03-04 13:02:11'),(4,'Что такое интраокулярная линза – ИОЛ?','Это искусственный хрусталик, его научное название','2022-03-04 13:02:43','2022-03-04 13:02:43'),(5,'Какие бывают ИОЛ - искусственные хрусталики?','ИОЛ бывают разной конструкции и из разных материалов. Модели отличаются технологическим совершенством и ценой. Более новые модели ИОЛ обладают новыми свойствами. Обеспечивается более четкое изображение, защита сетчатки от вредного действия света. Есть модели для полного избавления от очков','2022-03-04 13:03:13','2022-03-04 13:03:13');
/*!40000 ALTER TABLE `faqs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(5000) NOT NULL,
  `date` datetime NOT NULL,
  `imgLink` varchar(1000) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `news_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `patronymic` varchar(255) DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `patients_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_role` varchar(255) NOT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin',NULL,NULL),(2,'doctor',NULL,NULL),(3,'patient',NULL,NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_doctors`
--

DROP TABLE IF EXISTS `service_doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serviceId` int DEFAULT NULL,
  `doctorId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `service_doctors_serviceId_doctorId_unique` (`serviceId`,`doctorId`),
  KEY `doctorId` (`doctorId`),
  CONSTRAINT `service_doctors_ibfk_1` FOREIGN KEY (`serviceId`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `service_doctors_ibfk_2` FOREIGN KEY (`doctorId`) REFERENCES `doctors` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_doctors`
--

LOCK TABLES `service_doctors` WRITE;
/*!40000 ALTER TABLE `service_doctors` DISABLE KEYS */;
INSERT INTO `service_doctors` VALUES (1,2,4,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,4,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,4,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,1,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,1,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(7,1,5,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(8,3,6,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(9,4,2,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(10,5,3,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(11,6,7,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(12,7,8,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(55,27,3,'2022-04-19 09:37:49','2022-04-19 09:37:49'),(56,27,5,'2022-04-19 09:37:49','2022-04-19 09:37:49');
/*!40000 ALTER TABLE `service_doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_options`
--

DROP TABLE IF EXISTS `service_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_options` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(1000) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `imgLink` varchar(1000) DEFAULT NULL,
  `serviceId` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `serviceId` (`serviceId`),
  CONSTRAINT `service_options_ibfk_1` FOREIGN KEY (`serviceId`) REFERENCES `services` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_options`
--

LOCK TABLES `service_options` WRITE;
/*!40000 ALTER TABLE `service_options` DISABLE KEYS */;
INSERT INTO `service_options` VALUES (1,'Монофокальная линза','Обеспечивает зрение для дали. Для чтения и работы  близи понадобятся очки.',NULL,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(2,'ИОЛ со светофильтром для защиты от вредного воздействия света',NULL,NULL,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(3,'ИОЛ с асферической оптикой',NULL,NULL,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(4,'Монофокальная ИОЛ коррекцией астигматизма','линза для дали, очки для близи',NULL,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(5,'Мультифокальная ИОЛ линза для дали и близи',NULL,NULL,1,'0000-00-00 00:00:00','0000-00-00 00:00:00'),(6,'Мультифокальная торическая','линза для дали и близи с коррекцией астигматизма на всех расстояниях',NULL,1,'0000-00-00 00:00:00','0000-00-00 00:00:00');
/*!40000 ALTER TABLE `service_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` varchar(5000) NOT NULL,
  `price` float DEFAULT NULL,
  `parentId` int DEFAULT NULL,
  `imgLink` varchar(1000) DEFAULT NULL,
  `sort` int DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Факоэмульсификация катаракты','Факоэмульсификация катаракты с имплантацией гибкой интраокулярной линзы (ИОЛ). ИОЛ – интраокулярная линза или искусственный хрусталик. <br/> Операция: Факоэмульсификация катаракты – современный метод хирургического лечения. <br/> Операция проводится при помощи аппарата под контролем компьютера. <br/> Операция Факоэмульсификация катаракты проводится через микропрокол. Эта операция является легкой и малоболезненной. В этот же день после операции пациенты отдыхают и идут домой.',NULL,NULL,NULL,100,'2022-02-14 17:32:59','2022-02-14 17:32:59'),(2,'Операции по коррекции блефарохолязиса, грыж орбитальной клетчатки','Избыток кожи верхних или нижних век – блефарохолязис с наличием или отсутствием выпячивания жировой клетчатки орбиты изменяет форму век, иногда может быть принят за новообразование, может нарушать или не нарушать функцию век. Хирургическое лечение проводится, в основном, под местной анестезией. Консультации хирурга Федоровой Н.Ф. проводятся по понедельникам с 9:00. При отсутствии Н.Ф. Федоровой обратиться за помощью к старшей сестре и заведующему отделения.',NULL,NULL,NULL,101,'2022-02-14 17:43:01','2022-02-14 17:43:01'),(3,'Операции при косоглазии и птозе','В отделении проводятся операции при птозе и косоглазии пациентам старше 18 лет. <br/> Птоз – состояние, когда глаз открывается не полностью и верхнее веко поднимается при открывании глаза недостаточно. <br/> Косоглазие у взрослых пациентов встречается не часто. Для выбора лечения необходима предварительная консультация специалиста.',NULL,NULL,NULL,102,'2022-02-14 17:44:55','2022-02-14 17:44:55'),(4,'Операции при патологии век и конъюнктивы глаза','(вывороте и завороте век, новообразованиях век и конъюнктивы и др.) <br/> В Дневном стационаре Хирургического отделения №7 проводится хирургическое лечение при холязионе, новообразованиях кожи век, слизистой оболочки глаза, роговицы,  вывороте век, завороте век, ксантелазмах, пингвекуле,  атероме, кистах, контагиозном моллюске,  новообразованиях конъюнктивы, птеригиуме, сужении слезных точек и др. Операции проводятся амбулаторно 2 раза в неделю в Дневном стационаре Хирургического отделения №7. Дни операций: понедельник, пятница. <br/> Телефон для записи на операцию: 68-10-96.',NULL,NULL,NULL,103,'2022-02-14 17:47:47','2022-02-14 17:47:47'),(5,'Медикаментозное  лечение при воспалительных заболеваниях глаза','(кератит, склерит, иридоциклит, хориоретинит), глаукоме, заболеваниях сетчатки.',NULL,NULL,NULL,104,'2022-02-14 17:50:23','2022-02-14 17:50:23'),(6,'ЭФИ.Исследования глаз на современном оборудовании','индивидуальный подбор искусственного хрусталика и дополнительные инструментальные исследования строения и функций глаза.',NULL,NULL,NULL,105,'2022-02-14 17:51:22','2022-02-14 17:51:22'),(7,'ОКТ','ОКТ – оптический когерентный (лазерный) томограф с компьютерной обработкой изображения. ОКТ позволяет оценить состояние микроструктур сетчатки, зрительного нерва и переднего отдела глаза.',NULL,NULL,NULL,106,'2022-02-22 12:08:00','2022-02-22 12:08:00'),(26,'Тестовая услуга','Факоэмульсификация катаракты с имплантацией гибкой интраокулярной линзы (ИОЛ)',4700,1,NULL,850,'2022-04-19 09:35:23','2022-05-12 15:46:24'),(27,'Услуга офтальмологии','Услуга, предоставляемая офтальмологией',NULL,NULL,NULL,108,'2022-04-19 09:35:36','2022-04-19 09:35:36');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `token_id` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `userId` int DEFAULT NULL,
  PRIMARY KEY (`token_id`),
  KEY `userId` (`userId`),
  CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES ('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImxvZ2luIjoiKzc5NDc3NzM1MzUiLCJyb2xlIjoicGF0aWVudCIsImlhdCI6MTY0MTYzNzE5OSwiZXhwIjoxNjQxNjQwNzk5fQ.MlKzBtFZn5y9M53h3ogLL_uOkVbplR0EZKSX91jPRzA','2022-01-08 10:19:59','2022-01-08 10:19:59',11),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImxvZ2luIjoiKzc5MjM2MjA1ODk2Iiwicm9sZSI6InBhdGllbnQiLCJpYXQiOjE2NDMxMjA2MDIsImV4cCI6MTY0MzEyNDIwMn0.-4SW4mjSiQhDbUZJ0kVinNuiaZTHiQcis5ombR39V70','2022-01-25 14:21:56','2022-01-25 14:23:22',12),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTMsImxvZ2luIjoiKzc5ODcxMjM0NTYiLCJyb2xlIjoicGF0aWVudCIsImlhdCI6MTY0OTk1MzI0MiwiZXhwIjoxNjQ5OTU2ODQyfQ.WViXQPvA6Oeo-SYlLtsz9_rtiDZmOaFGdqpwZpU1zpw','2022-02-09 11:49:07','2022-04-14 16:20:42',13),('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTYsImxvZ2luIjoiYWRtaW4iLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE2NTI3ODkwNTgsImV4cCI6MTY1ODQwNTA1OH0.NaSdtdTZXGZxbE4PScvSD9bSNqf6rcdfkj23LaClwLg','2022-04-14 15:33:41','2022-05-17 12:04:18',16);
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `roleId` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`),
  KEY `roleId` (`roleId`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'+7947773535','$2b$05$UEd9P4Bfs7wgVv0vGz3equ9Kbern89Hd56u5dYjPQmUPzaFkWVJK6','2022-01-08 10:19:59','2022-01-08 10:19:59',3),(12,'+79236205896','$2b$05$7qii9ylyBlBlpInmrB.HhuOF76A.C4QcRluAIWFnoGA4AApKg/Tl6','2022-01-25 13:10:09','2022-01-25 13:10:09',3),(13,'+7987123456','$2b$05$U4kvAGNOtGB2tDSJZSycu.2I6rZ8hXmeZZRnxZOvFTfMo8L.p1iwa','2022-02-09 11:49:07','2022-02-09 11:49:07',3),(16,'admin','$2b$05$r.ovGsJg9z6BOo/DgzVgbeSErPvJZKk6x8c6ZPr9MaCCr1EsA/2gm','2022-04-14 15:32:38','2022-04-14 15:32:38',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-22 17:01:49
