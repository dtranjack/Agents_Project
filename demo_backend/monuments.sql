-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jul 12, 2023 at 04:25 PM
-- Server version: 11.0.2-MariaDB-1:11.0.2+maria~ubu2204
-- PHP Version: 8.1.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `monument`
--

-- --------------------------------------------------------

--
-- Table structure for table `monuments`
--

CREATE TABLE `monuments` (
  `ID` int(11) NOT NULL,
  `name` varchar(26) DEFAULT NULL,
  `description` varchar(1740) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `gallery` varchar(255) DEFAULT NULL,
  `country_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `monuments`
--

INSERT INTO `monuments` (`ID`, `name`, `description`, `cover`, `gallery`, `country_ID`) VALUES
(1, 'Great Wall of China', 'The Great Wall of China (traditional Chinese: 萬里長城; simplified Chinese: 万里长城; pinyin: Wànlǐ Chángchéng, literally \"ten thousand li long wall\") is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection against various nomadic groups from the Eurasian Steppe. Several walls were built from as early as the 7th century BC, with selective stretches later joined by Qin Shi Huang (220–206 BC), the first emperor of China. Little of the Qin wall remains.[5] Later on, many successive dynasties built and maintained multiple stretches of border walls. The best-known sections of the wall were built by the Ming dynasty (1368–1644).\r\n\r\nApart from defense, other purposes of the Great Wall have included border controls, allowing the imposition of duties on goods transported along the Silk Road, regulation or encouragement of trade and the control of immigration and emigration. Furthermore, the defensive characteristics of the Great Wall were enhanced by the construction of watchtowers, troop barracks, garrison stations, signaling capabilities through the means of smoke or fire, and the fact that the path of the Great Wall also served as a transportation corridor.\r\n\r\nThe frontier walls built by different dynasties have multiple courses. Collectively, they stretch from Liaodong in the east to Lop Lake in the west, from the present-day Sino–Russian border in the north to Tao River (Taohe) in the south; along an arc that roughly delineates the edge of the Mongolian steppe; spanning 21,196.18 km (13,170.70 mi) in total. Today, the defensive system of the Great Wall is generally recognized as one of the most impressive architectural feats in history.', '/IMG/wallpaperflare.com_wallpaper.jpg', 'li', 1),
(2, 'Petra', '', '', '', 2),
(3, 'Christ the Redeemer Statue', '', '', '', 5),
(4, 'Machu Picchu', '', '', '', 6),
(5, 'Chichen Itza', '', '', '', 7),
(6, 'Colosseum', '', '', '', 8),
(7, 'Taj Mahal', '', '', '', 3),
(8, 'Statue of Liberty', '', '', '', 10),
(9, 'Arc de Triomphe', '', '', '', 9),
(10, 'Halong Bay', '', '', '', 4),
(11, 'Ho Chi Minh Mausoleum', '', '', '', 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `monuments`
--
ALTER TABLE `monuments`
  ADD PRIMARY KEY (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
