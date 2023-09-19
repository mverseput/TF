-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Gegenereerd op: 07 jun 2023 om 14:49
-- Serverversie: 10.4.24-MariaDB
-- PHP-versie: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `trainingfactory`
--
CREATE DATABASE IF NOT EXISTS `trainingfactory` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `trainingfactory`;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230607095238', '2023-06-07 11:53:06', 162),
('DoctrineMigrations\\Version20230607100004', '2023-06-07 12:00:20', 14),
('DoctrineMigrations\\Version20230607102712', '2023-06-07 12:27:31', 14),
('DoctrineMigrations\\Version20230607115813', '2023-06-07 13:58:25', 43),
('DoctrineMigrations\\Version20230607120211', '2023-06-07 14:02:24', 16),
('DoctrineMigrations\\Version20230607121002', '2023-06-07 14:10:19', 552);

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `lesson`
--

DROP TABLE IF EXISTS `lesson`;
CREATE TABLE `lesson` (
  `id` int(11) NOT NULL,
  `time` time NOT NULL,
  `date` date NOT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `max_persons` int(11) NOT NULL,
  `training_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `registration`
--

DROP TABLE IF EXISTS `registration`;
CREATE TABLE `registration` (
  `id` int(11) NOT NULL,
  `payment` decimal(10,2) DEFAULT NULL,
  `lesson_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `training`
--

DROP TABLE IF EXISTS `training`;
CREATE TABLE `training` (
  `id` int(11) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_costs` decimal(10,2) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Gegevens worden geëxporteerd voor tabel `training`
--

INSERT INTO `training` (`id`, `description`, `duration`, `extra_costs`, `name`, `image`) VALUES
(1, 'Boksen, of pugilistiek, is een tactische vechtsport waarbij ringinzicht, de coördinatie van voeten, ogen en handen, en conditie centraal staan.  Twee tegenstanders proberen punten te scoren door elkaar op de juiste trefvlakken te raken, of te winnen op bijvoorbeeld een knock-out (KO). Dat kan door enkele stoten of combinatie van verschillende stoten; de directe stoot, de opstoot en de hoek. Kracht is evenveel nodig als pure snelheid om een tegenstander zowel snel en hard te kunnen raken. Naast het traditionele mannenboksen worden ook bokskampioenschappen voor vrouwen gehouden.', '1 uur', '30.00', 'Boksen', 'boksen.jpg'),
(2, 'Kickboksen is een vechtsport waarbij zowel de handen als de benen mogen worden gebruikt. De sport kent zijn oorsprong in Japan en de Verenigde Staten, en werd daar populair in het begin van de jaren 1970. Bij kickboksen worden de stoten van het boksen gecombineerd met de trappen uit sporten zoals karate en taekwondo. Deze sport dient te worden onderscheiden van het oorspronkelijke, gelijkende thaiboksen.', '1,5 uur', '35.00', 'Kickboksen', 'kickboksen.jpg'),
(3, 'Mixed martial arts (Engels voor gemengde gevechtskunsten), meestal afgekort tot MMA, is een multidisciplinaire vechtsport die zich richt op het combineren van technieken uit meerdere traditionele vechtkunsten (en vechtsporten) die door beoefenaars van MMA met de verzamelnaam TMA (Traditional Martial Arts) worden aangeduid, zoals worstelen (grappling), judo, karate, kungfu, kickboksen, thaiboksen, boksen, jiujitsu en taekwondo. Een belangrijk verschil met deze bronnen is dat de daaruit afkomstige technieken zijn losgemaakt van alle daarvoor vaak nog juist kenmerkende regels, principes en tradities. Dat MMA-wedstrijden geen regels zouden kennen ter bescherming van de vechters is echter een misvatting. Deze regels verschillen echter per organisatie.', '1,5 uur', '45.00', 'MMA', 'mma.jpg'),
(4, 'Een vuistslag of stoot is een slaande beweging met dichtgeknepen hand. Deze beweging kan aanvallend of verdedigend gebruikt worden in een gevecht. Verscheidene vechtsporten kennen verschillende typen vuistslag, variërend in snelheid, reikwijdte en impuls. Handbescherming kan gebruikt worden om blessures te voorkomen.  Veel vechtsporten, zoals karate en taekwondo, combineren de vuistslag met andere bewegingen, terwijl andere, zoals boksen uitsluitend van vuistslagen gebruikmaken.', '2 uur', '20.00', 'Stootzak trainingen', 'stootzak.jpg'),
(5, 'Een bootcamp is een spierversterkende trainingsmethode uitgevoerd in teamverband onder professionele begeleiding van een fitnessinstructeur. Het doel is om de kracht en uithouding te verbeteren door intense groepstrainingen gedurende de periode van een uur. Door het teamverband sporten de deelnemers intenser dan ze individueel zouden doen, zodat de efficiëntie van de training verhoogt.[bron?]', '1 uur', '30.00', 'Bootcamps', 'bootcamp.jpg'),
(6, 'Fitness is een sportactiviteit gericht op onder andere het verbeteren van de conditie, vetverbranding en krachttraining, waarbij het eigen lichaam als weerstand kan dienen. Vaak wordt met fitness de sportactiviteit bedoeld die bedreven wordt met behulp van zogenaamde fitnessapparaten of sporttoestellen. Dit kan onder andere in een sportschool of fitnesscentrum, maar ook thuis of in de buitenlucht.', '2 uur', '25.00', 'Fitness-uren', 'fitness.jpg');

-- --------------------------------------------------------

--
-- Tabelstructuur voor tabel `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `preprovision` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthdate` date NOT NULL,
  `hiring_date` date DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `social_sec_number` int(11) DEFAULT NULL,
  `street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `place` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexen voor geëxporteerde tabellen
--

--
-- Indexen voor tabel `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexen voor tabel `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F87474F3BEFD98D1` (`training_id`),
  ADD KEY `IDX_F87474F3A76ED395` (`user_id`);

--
-- Indexen voor tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indexen voor tabel `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_62A8A7A7CDF80196` (`lesson_id`),
  ADD KEY `IDX_62A8A7A7A76ED395` (`user_id`);

--
-- Indexen voor tabel `training`
--
ALTER TABLE `training`
  ADD PRIMARY KEY (`id`);

--
-- Indexen voor tabel `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT voor geëxporteerde tabellen
--

--
-- AUTO_INCREMENT voor een tabel `lesson`
--
ALTER TABLE `lesson`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `registration`
--
ALTER TABLE `registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT voor een tabel `training`
--
ALTER TABLE `training`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT voor een tabel `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Beperkingen voor geëxporteerde tabellen
--

--
-- Beperkingen voor tabel `lesson`
--
ALTER TABLE `lesson`
  ADD CONSTRAINT `FK_F87474F3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_F87474F3BEFD98D1` FOREIGN KEY (`training_id`) REFERENCES `training` (`id`);

--
-- Beperkingen voor tabel `registration`
--
ALTER TABLE `registration`
  ADD CONSTRAINT `FK_62A8A7A7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_62A8A7A7CDF80196` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
