-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               10.6.4-MariaDB - mariadb.org binary distribution
-- Операционная система:         Win64
-- HeidiSQL Версия:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Дамп данных таблицы db_oftalmolog.clinic_addresses: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `clinic_addresses` DISABLE KEYS */;
-- REPLACE INTO `clinic_addresses` (`id`, `postIndex`, `address`, `comments`, `clinicId`, `createdAt`, `updatedAt`) VALUES
-- 	(1, '650066', 'г. Кемерово, пр-т Октябрьский, 22А', 'Отделение располагается на втором этаже офтальмологического корпуса ГАУЗ КОКБ им. С.В. Беляева <br/> В отделении есть все необходимое для комфорта пациентов.', 1, '2022-02-28 16:24:54', '2022-02-28 16:24:54');
/*!40000 ALTER TABLE `clinic_addresses` ENABLE KEYS */;
REPLACE INTO `clinic_addresses` VALUES (1,'650066','г. Кемерово, пр-т Октябрьский, 22А','ГАУЗ Кузбасская областная клиническая больница им. С.В. Беляева. Проезд до остановки «Областная больница на пр. Октябрьский». Офтальмологический корпус областной больницы (расположен сразу за хирургическим корпусом), второй этаж, направо, хирургическое отделение №7, кабинет заведующего. За справками можно обратиться на сестринский пост и к старшей сестре отделения.','2022-02-28 16:24:54','2022-02-28 16:24:54',1);
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
