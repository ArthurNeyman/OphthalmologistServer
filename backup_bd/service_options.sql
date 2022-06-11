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

-- Дамп данных таблицы db_oftalmolog.service_options: ~0 rows (приблизительно)
DELETE FROM `service_options`;
/*!40000 ALTER TABLE `service_options` DISABLE KEYS */;
INSERT INTO `service_options` (`id`, `name`, `description`, `imgLink`, `serviceId`) VALUES
	(1, 'Монофокальная линза', 'Обеспечивает зрение для дали. Для чтения и работы  близи понадобятся очки.', NULL, 1),
	(2, 'ИОЛ со светофильтром для защиты от вредного воздействия света', NULL, NULL, 1),
	(3, 'ИОЛ с асферической оптикой', NULL, NULL, 1),
	(4, 'Монофокальная ИОЛ коррекцией астигматизма', 'линза для дали, очки для близи', NULL, 1),
	(5, 'Мультифокальная ИОЛ линза для дали и близи', NULL, NULL, 1),
	(6, 'Мультифокальная торическая', 'линза для дали и близи с коррекцией астигматизма на всех расстояниях', NULL, 1);
/*!40000 ALTER TABLE `service_options` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
