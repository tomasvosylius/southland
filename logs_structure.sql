-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2018 m. Sau 21 d. 17:59
-- Server version: 10.0.32-MariaDB-0+deb8u1
-- PHP Version: 5.6.30-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `southland_logs`
--

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_admins`
--

CREATE TABLE IF NOT EXISTS `logs_admins` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  `ReceiverName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraString` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_ame`
--

CREATE TABLE IF NOT EXISTS `logs_ame` (
  `PlayerId` int(11) NOT NULL,
  `Text` varchar(186) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PlayerName` varchar(24) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_business`
--

CREATE TABLE IF NOT EXISTS `logs_business` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `BusinessId` int(11) NOT NULL,
  `BusinessName` varchar(48) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(128) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Amount` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_chat`
--

CREATE TABLE IF NOT EXISTS `logs_chat` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Text` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraString` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_clothes`
--

CREATE TABLE IF NOT EXISTS `logs_clothes` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ClotheId` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_cmd`
--

CREATE TABLE IF NOT EXISTS `logs_cmd` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `Cmd` varchar(56) COLLATE cp1257_bin NOT NULL,
  `Params` varchar(128) COLLATE cp1257_bin NOT NULL,
  `Flags` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_connections`
--

CREATE TABLE IF NOT EXISTS `logs_connections` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `Type` int(11) NOT NULL,
  `IP` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_dealers`
--

CREATE TABLE IF NOT EXISTS `logs_dealers` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  `ReceiverName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL,
  `Amount` int(11) NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_dealer_houses`
--

CREATE TABLE IF NOT EXISTS `logs_dealer_houses` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  `ReceiverName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(256) COLLATE cp1257_bin NOT NULL,
  `Amount` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `HouseId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_do`
--

CREATE TABLE IF NOT EXISTS `logs_do` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) NOT NULL,
  `Text` varchar(186) NOT NULL,
  `ExtraString` varchar(126) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_donators`
--

CREATE TABLE IF NOT EXISTS `logs_donators` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) NOT NULL,
  `ActionText` varchar(128) NOT NULL,
  `ExtraString` varchar(128) NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_factions`
--

CREATE TABLE IF NOT EXISTS `logs_factions` (
  `FactionId` int(11) NOT NULL,
  `FactionName` varchar(48) COLLATE cp1257_bin NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `PlayerName` int(24) NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  `ReceiverName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL,
  `Amount` int(11) NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_inventory`
--

CREATE TABLE IF NOT EXISTS `logs_inventory` (
`id` int(11) NOT NULL,
  `OwnerId` int(11) NOT NULL,
  `OwnerName` varchar(24) NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  `ReceiverName` varchar(24) NOT NULL,
  `ActionText` varchar(128) NOT NULL,
  `ItemId` int(11) NOT NULL,
  `ItemAmount` int(11) NOT NULL,
  `ItemExtra` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=15692 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_jobs`
--

CREATE TABLE IF NOT EXISTS `logs_jobs` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) NOT NULL,
  `JobName` varchar(56) NOT NULL,
  `ActionText` varchar(128) NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `ExtraString` int(128) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_me`
--

CREATE TABLE IF NOT EXISTS `logs_me` (
  `PlayerId` int(11) NOT NULL DEFAULT '0',
  `PlayerName` varchar(24) NOT NULL,
  `Text` varchar(186) NOT NULL DEFAULT 'EOS',
  `ActionText` varchar(126) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_messages`
--

CREATE TABLE IF NOT EXISTS `logs_messages` (
  `OwnerId` int(11) NOT NULL,
  `OwnerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  `ReceiverName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(256) COLLATE cp1257_bin NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_money`
--

CREATE TABLE IF NOT EXISTS `logs_money` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(126) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(126) COLLATE cp1257_bin NOT NULL,
  `PlaceType` smallint(6) NOT NULL,
  `PlaceId` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_phones`
--

CREATE TABLE IF NOT EXISTS `logs_phones` (
  `OwnerId` int(11) NOT NULL,
  `OwnerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ReceiverId` int(11) NOT NULL,
  `ReceiverName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(128) COLLATE cp1257_bin NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_players`
--

CREATE TABLE IF NOT EXISTS `logs_players` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` int(11) NOT NULL,
  `ActionText` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Amount` int(11) NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_radiochat`
--

CREATE TABLE IF NOT EXISTS `logs_radiochat` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(126) COLLATE cp1257_bin NOT NULL,
  `ExtraString` varchar(256) COLLATE cp1257_bin NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

-- --------------------------------------------------------

--
-- Sukurta duomenų struktūra lentelei `logs_vehicles`
--

CREATE TABLE IF NOT EXISTS `logs_vehicles` (
  `PlayerId` int(11) NOT NULL,
  `PlayerName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `VehicleId` int(11) NOT NULL,
  `VehicleName` varchar(24) COLLATE cp1257_bin NOT NULL,
  `ActionText` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Amount` int(11) NOT NULL,
  `Insurance` int(11) NOT NULL,
  `ExtraId` int(11) NOT NULL,
  `ExtraString` varchar(126) COLLATE cp1257_bin NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=cp1257 COLLATE=cp1257_bin;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `logs_inventory`
--
ALTER TABLE `logs_inventory`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `logs_inventory`
--
ALTER TABLE `logs_inventory`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15692;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
