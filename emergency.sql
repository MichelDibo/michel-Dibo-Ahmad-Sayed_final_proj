-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2024 at 12:27 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `emergency`
--

-- --------------------------------------------------------

--
-- Table structure for table `1`
--

CREATE TABLE `1` (
  `Name` varchar(30) NOT NULL,
  `Number` int(11) NOT NULL,
  `Description` text NOT NULL,
  `Image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `1`
--

INSERT INTO `1` (`Name`, `Number`, `Description`, `Image`) VALUES
('Police', 112, '      \"The Internal Security Forces are general armed forces whose prerogatives cover all the Lebanese territory and its regional waters and airspace \"\r\n', 'https://scontent.fbey15-1.fna.fbcdn.net/v/t39.30808-6/278669178_295965266040778_7035847565922056851_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=7XrQt59T5_kAX8HCuAa&_nc_ht=scontent.fbey15-1.fna&oh=00_AfAgsPNaDtG9qqgSREowEOXZg3Xix_j8D5wIlzTaK8vx0A&oe=65A00662'),
('Civil Defense', 125, 'The Lebanese Civil Defense or General Directorate of the Lebanese Civil Defense is a public emergency medical service of Lebanon that carries out patient transportation, search and rescue activities and fire-fighting response. It is funded and administered by the Ministry of Interior and Municipalities (Lebanon).', 'https://scontent.fbey1-2.fna.fbcdn.net/v/t39.30808-6/335028707_192721326720007_388785033491755257_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=LvUCq5_OJHIAX-65NmV&_nc_ht=scontent.fbey1-2.fna&oh=00_AfD_bBXgduhRefVGzmNrerIFh1QM7xtpyokyo3WV-G2Atg&oe=659E8735'),
('Red Cross', 140, 'The Lebanese Red Cross Society is led by volunteers, whose mission is to provide relief to victims of natural and human made disasters, and help people prevent, prepare for and respond to emergencies, and to mitigate the suffering of the most vulnerable.', 'https://scontent.fbey15-1.fna.fbcdn.net/v/t39.30808-6/352519796_1318718868999635_8449981597686874365_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=-zQlTPDSn2wAX-uFNc2&_nc_ht=scontent.fbey15-1.fna&oh=00_AfBaj4JbT7V0i8G-GSnqZBjKHvjn60dSDiall0pXnwZArQ&oe=65A029B8'),
('Lebanese Army', 1701, 'The Lebanese Armed Forces : romanized: Al-Quwwāt al-Musallaḥa al-Lubnāniyya), also known as the Lebanese Army[3] romanized: Al-Jaish al-Lubnani), is the military of the Lebanese Republic. It consists of three branches, the ground forces, the air force, and the navy. The motto of the Lebanese Armed Forces is \'Honor, Sacrifice, Loyalty\' .', 'https://scontent.fbey15-1.fna.fbcdn.net/v/t1.6435-9/73346454_2551122528305938_4981920544464044032_n.png?_nc_cat=111&ccb=1-7&_nc_sid=be3454&_nc_ohc=MdXNu641cUwAX9etr_9&_nc_ht=scontent.fbey15-1.fna&oh=00_AfBtXzHNCOZ_Erg8BD7YZeaBYr_D4BHx225a2Dw37m9M2Q&oe=65C1DB9E'),
('General Security', 1717, 'The mission of the General Security is to gather information on behalf of the Lebanese government, notably political, economic and social information. GDGS is entrusted with carrying out judiciary investigations in violations committed against the state\'s internal or external security.', 'https://scontent.fbey15-1.fna.fbcdn.net/v/t39.30808-6/279101028_358470959654826_6592164010901974428_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=cafUXlbWkkQAX9bvSdr&_nc_ht=scontent.fbey15-1.fna&oh=00_AfBiLCfysYuYFqQ3YNEjcngXt3AoP7KfrqBVGq3eKT9W0Q&oe=65A02B8D');

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(40) NOT NULL,
  `roleID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `name`, `email`, `password`, `roleID`) VALUES
(1, 'Michel', 'micho@gmail.com', '1234', 1),
(2, 'john', 'john@gmail.com', '1234', 2),
(19, 'Ahmad sayed', 'ahmad@gmail.com', '1234', 1),
(20, 'test', 'test', '1', 2),
(21, 'dr_abdelrahman', 'sayed@gmail.com', '100', 1),
(22, 'test11', 'test11@gmail.com', '12345', 2);

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `description` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `description`) VALUES
(1, 'Admin'),
(2, 'User');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `1`
--
ALTER TABLE `1`
  ADD PRIMARY KEY (`Number`);

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_ibfk_1` (`roleID`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `client_ibfk_1` FOREIGN KEY (`roleID`) REFERENCES `role` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
