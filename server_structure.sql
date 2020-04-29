-- phpMyAdmin SQL Dump
-- version 4.2.12deb2+deb8u2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 20, 2018 at 04:30 PM
-- Server version: 10.0.32-MariaDB-0+deb8u1
-- PHP Version: 5.6.33-0+deb8u1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `copy_srp`
--

-- --------------------------------------------------------

--
-- Table structure for table `atms`
--

CREATE TABLE IF NOT EXISTS `atms` (
`id` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `CanDeposit` tinyint(4) NOT NULL,
  `WithdrawLimit` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Int` int(11) NOT NULL,
  `VW` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business_data`
--

CREATE TABLE IF NOT EXISTS `business_data` (
`id` int(11) NOT NULL,
  `Name` varchar(25) COLLATE utf8_lithuanian_ci NOT NULL,
  `Owner` int(11) NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` int(11) NOT NULL,
  `ExitZ` int(11) NOT NULL,
  `ExtraX` float NOT NULL,
  `ExtraY` float NOT NULL,
  `ExtraZ` float NOT NULL,
  `WaresX` float NOT NULL,
  `WaresY` float NOT NULL,
  `WaresZ` float NOT NULL,
  `CratesX` float NOT NULL,
  `CratesY` float NOT NULL,
  `CratesZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `Exterior` int(11) NOT NULL,
  `OutVW` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Locked` tinyint(4) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Type` tinyint(4) NOT NULL,
  `UpdateEat` int(11) NOT NULL,
  `UpdateSafe` int(11) NOT NULL,
  `UpdateClothes` tinyint(4) NOT NULL,
  `Safe` int(11) NOT NULL,
  `Level` smallint(6) NOT NULL,
  `Budget` int(11) NOT NULL,
  `Fuel` int(11) NOT NULL,
  `FuelPrice` int(11) NOT NULL,
  `Sale` int(11) NOT NULL,
  `EnterPrice` int(11) NOT NULL,
  `Slogan` varchar(129) COLLATE utf8_lithuanian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_dubkeys`
--

CREATE TABLE IF NOT EXISTS `business_dubkeys` (
`id` int(11) NOT NULL,
  `BusinessId` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valid` tinyint(4) NOT NULL,
  `P_FurnitureControl` tinyint(4) NOT NULL,
  `P_WaresControl` tinyint(4) NOT NULL,
  `P_WorkersControl` tinyint(4) NOT NULL,
  `P_BudgetControl` tinyint(4) NOT NULL,
  `Salary` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_furniture`
--

CREATE TABLE IF NOT EXISTS `business_furniture` (
`id` int(11) NOT NULL,
  `BusinessId` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `VW` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `Name` varchar(24) COLLATE utf8_lithuanian_ci NOT NULL,
  `Added` int(11) NOT NULL,
  `Category` varchar(86) COLLATE utf8_lithuanian_ci NOT NULL,
  `Price` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Texture0` smallint(6) NOT NULL,
  `Texture1` smallint(6) NOT NULL,
  `Texture2` smallint(6) NOT NULL,
  `Texture3` smallint(6) NOT NULL,
  `Texture4` smallint(6) NOT NULL,
  `Texture5` smallint(6) NOT NULL,
  `Color0` smallint(6) NOT NULL,
  `Color1` smallint(6) NOT NULL,
  `Color2` smallint(6) NOT NULL,
  `Color3` smallint(6) NOT NULL,
  `Color4` smallint(6) NOT NULL,
  `Color5` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_inventory`
--

CREATE TABLE IF NOT EXISTS `business_inventory` (
`id` int(11) NOT NULL,
  `BusinessId` int(11) NOT NULL,
  `Packed` varchar(512) NOT NULL,
  `Updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `business_orders`
--

CREATE TABLE IF NOT EXISTS `business_orders` (
`id` int(11) NOT NULL,
  `BusinessId` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `OrderedBy` int(11) NOT NULL,
  `OrderDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` tinyint(4) NOT NULL,
  `Type` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_orders_fuel`
--

CREATE TABLE IF NOT EXISTS `business_orders_fuel` (
`id` int(11) NOT NULL,
  `BusinessId` int(11) NOT NULL,
  `HoursLeft` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valid` tinyint(4) NOT NULL DEFAULT '1',
  `Added` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `business_wares`
--

CREATE TABLE IF NOT EXISTS `business_wares` (
`id` int(11) NOT NULL,
  `BusinessId` int(11) NOT NULL,
  `Packed` varchar(356) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_data`
--

CREATE TABLE IF NOT EXISTS `dealers_data` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `Active` tinyint(4) NOT NULL,
  `MaxWeapons` int(11) NOT NULL,
  `MaxDrugs` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_drugs_lists`
--

CREATE TABLE IF NOT EXISTS `dealers_drugs_lists` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `DrugId` int(11) NOT NULL,
  `DrugAmount` int(11) NOT NULL,
  `DrugMaxAmount` int(11) NOT NULL,
  `DrugPrice` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_drugs_orders`
--

CREATE TABLE IF NOT EXISTS `dealers_drugs_orders` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Packed` varchar(256) COLLATE utf8_lithuanian_ci NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Price` int(11) NOT NULL,
  `Valid` tinyint(4) NOT NULL,
  `OfflineSent` tinyint(4) NOT NULL,
  `HoursLeft` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_drugs_spawns`
--

CREATE TABLE IF NOT EXISTS `dealers_drugs_spawns` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Added` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_guns_lists`
--

CREATE TABLE IF NOT EXISTS `dealers_guns_lists` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `WeaponId` smallint(6) NOT NULL,
  `WeaponPrice` int(11) NOT NULL,
  `WeaponAmount` int(11) NOT NULL,
  `WeaponMaxAmount` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_guns_orders`
--

CREATE TABLE IF NOT EXISTS `dealers_guns_orders` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Packed` varchar(256) COLLATE utf8_lithuanian_ci NOT NULL,
  `Price` int(11) NOT NULL,
  `HoursLeft` int(11) NOT NULL,
  `Valid` tinyint(4) NOT NULL,
  `OfflineSent` tinyint(4) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_guns_spawns`
--

CREATE TABLE IF NOT EXISTS `dealers_guns_spawns` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Added` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_houses_data`
--

CREATE TABLE IF NOT EXISTS `dealers_houses_data` (
`id` int(11) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `Owner` int(11) NOT NULL,
  `Locked` tinyint(4) NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` int(11) NOT NULL,
  `OutVW` int(11) NOT NULL,
  `Exterior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dealers_houses_inventory`
--

CREATE TABLE IF NOT EXISTS `dealers_houses_inventory` (
`id` int(11) NOT NULL,
  `HouseId` int(11) NOT NULL,
  `Packed` varchar(512) NOT NULL,
  `Updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `donations`
--

CREATE TABLE IF NOT EXISTS `donations` (
`id` int(11) NOT NULL,
  `OrderID` varchar(20) NOT NULL,
  `IP` varchar(20) NOT NULL,
  `Type` varchar(20) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Status` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Username` varchar(24) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `drops_data`
--

CREATE TABLE IF NOT EXISTS `drops_data` (
`id` int(11) NOT NULL,
  `ItemId` int(11) NOT NULL,
  `ItemAmount` mediumint(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `ItemExtraId` mediumint(11) NOT NULL,
  `Unix` int(11) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Valid` tinyint(4) NOT NULL DEFAULT '1',
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `PickedBy` int(11) NOT NULL,
  `ItemIsPacked` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `enters_exits`
--

CREATE TABLE IF NOT EXISTS `enters_exits` (
`id` int(11) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `EnterInt` int(11) NOT NULL,
  `EnterVW` int(11) NOT NULL,
  `ExitInt` int(11) NOT NULL,
  `ExitVW` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Added` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `enters_exits`
--

INSERT INTO `enters_exits` (`id`, `Name`, `EnterX`, `EnterY`, `EnterZ`, `ExitX`, `ExitY`, `ExitZ`, `EnterInt`, `EnterVW`, `ExitInt`, `ExitVW`, `Date`, `Added`) VALUES
(1, 'Áëjimas á bendrabutá', 2241.36, -1882.02, 14.2344, 2223.53, -2225.56, 1013.59, 0, 0, 0, 1, '2017-12-07 18:32:41', 7),
(4, 'Ligoninë', 1672.12, -1370.02, 17.4531, 1933.9, -3592.21, 103.769, 0, 0, 0, 0, '2017-12-09 17:01:21', 5),
(6, 'Bankas', 1473.29, -1264.9, 14.5625, 97.031, -26.5487, 1000.51, 0, 0, 0, 10, '2017-12-09 23:54:06', 5),
(7, 'Los Santos Police Departament', 1383.69, -1619.45, 17.6747, 1999.67, 2908.29, 6008.15, 0, 0, 0, 0, '2017-12-10 18:22:05', 1),
(8, 'San Andreas Network', 1571, -1336.88, 16.4844, 1569.13, -1234.92, 1089.87, 0, 0, 2, 0, '2017-12-10 18:24:39', 1),
(9, 'LSMD Stogas', 1941.55, -3592.15, 109.566, 1667.6, -1383.11, 64.6562, 0, 0, 0, 0, '2017-12-13 17:54:41', 1),
(12, 'LSPD Rooftop', 1392.95, -1691.88, 6.23956, 1383.85, -1674.75, 41.3961, 0, 0, 0, 0, '2017-12-14 20:09:41', 1),
(13, 'LS Savivaldybë', 1478.44, -1794.5, 18.6557, 388.755, 173.803, 1008.38, 0, 0, 3, 0, '2017-12-14 20:53:03', 1),
(15, 'Áëjimas', 2565.14, -1301.63, 1031.42, 2568.64, -1306.72, 1037.77, 2, 10007, 2, 10007, '2017-12-15 19:16:58', 10),
(17, 'Antras aukðtas', 2546.78, -1306.51, 1031.42, 2570.26, -1301.94, 1044.12, 2, 10007, 2, 10007, '2017-12-16 17:22:32', 157),
(22, 'Crenshaw Apartments', 2148.94, -1484.86, 26.6241, 2223.36, -2225.45, 1013.59, 0, 0, 0, 885, '2017-12-17 12:51:36', 12),
(23, 'STAFF ONLY | GALINIS IÐËJIMAS', 1479.76, -1847.03, 13.7755, 366.588, 158.843, 1008.38, 0, 0, 3, 0, '2017-12-18 20:09:15', 2),
(24, 'Shade Lounge Studio', 300.063, 314.763, 999.148, -13.2907, -346.987, 2005.46, 4, 30072, 0, 30072, '2017-12-19 15:18:43', 2),
(25, 'Vacant Deli', 2313.28, 56.3535, 26.4844, 300.213, 310.163, 1003.3, 0, 0, 4, 661, '2017-12-26 21:24:28', 2),
(27, 'Ganton Apartaments 7', 2380.68, -1785.7, 13.5469, 2223.33, -2225.54, 1013.59, 0, 0, 0, 156, '2017-12-28 13:07:23', 2),
(28, 'Áëjimas á garaþà', 2043.42, 2947.61, 6001.19, 1418.29, -1677.17, 6.18488, 0, 0, 0, 0, '2017-12-30 17:29:14', 10),
(29, 'El Corona Apartments', 2003.7, -1993.36, 14.8799, 2223.5, -2225.49, 1013.59, 0, 0, 0, 255, '2018-01-03 16:58:11', 2),
(30, '...', -1601.62, -1949.16, 96.6889, 742.746, 207.421, 11558.8, 0, 0, 0, 0, '2018-01-03 21:58:08', 10),
(31, 'Galinis áëjimas', 2189.04, -982.328, 62.8737, 2451.71, 3233.87, 1029.85, 0, 0, 0, 20109, '2018-01-04 11:23:38', 2),
(37, 'SACF laukiamasis', 250.281, 1367.08, 11.1391, 359.498, 1416.49, 1519.27, 0, 0, 0, 0, '2018-01-07 14:18:45', 10),
(39, 'SACF vidus', 249.957, 1457.25, 11.1404, 400.613, 1454.28, 1844.09, 0, 0, 0, 0, '2018-01-07 14:24:38', 1),
(40, 'SACF PD vidus', 384.701, 1419.35, 1519.27, 398.706, 1460.46, 1847.58, 0, 0, 0, 0, '2018-01-07 14:25:31', 1),
(41, 'SACF KIEMAS', 395.024, 1448.57, 1844.09, 213.452, 1402.62, 10.6305, 0, 0, 0, 0, '2018-01-07 14:26:57', 1),
(42, 'SACF AIKSTE', 206.899, 1418.92, 10.6261, 204.155, 1418.55, 10.6261, 0, 0, 0, 0, '2018-01-07 14:28:27', 1),
(43, 'Harmony Oaks Apartments', 1909.9, -1597.41, 14.3062, 2223.84, -2225.42, 1013.59, 0, 0, 0, 0, '2018-01-07 17:18:39', 2),
(44, 'Iðëjimas á balkonà', 233.796, 1291.2, 1082.14, 1899.58, -1596.26, 19.3672, 1, 20117, 0, 0, '2018-01-07 17:25:08', 2),
(49, 'Iðëjimas á balkonà (2)', 2262.79, -1216.81, 1049.02, 2759.85, -1182.6, 74.3169, 10, 20122, 0, 0, '2018-01-10 18:02:46', 2),
(51, 'Áëjimas', 2228.02, -1150.36, 1029.8, 2230.48, -1150.76, 1029.8, 15, 30010, 15, 30010, '2018-01-12 20:55:53', 10),
(52, 'LSPD Field Training HQ', -23.2185, -269.629, 5.42969, 328.053, 2459.42, 3009.89, 0, 0, 0, 0, '2018-01-20 11:12:11', 2),
(54, 'Ofisas', -2737.81, 136.088, 1506.16, -2737.85, 136.934, 1506.16, 0, 30034, 0, 30034, '2018-01-25 14:08:01', 2),
(55, 'Bendrabutis', 1987, -1605.21, 13.5307, -160.187, 2448.58, 3001.09, 0, 0, 0, 0, '2018-01-25 15:08:41', 10),
(57, 'Field Training Áëjimas', 320.617, 2445.66, 3009.89, 319.282, 2447.51, 3009.89, 0, 0, 0, 0, '2018-01-28 18:22:05', 228),
(58, 'Baþnyèia', 2233.71, -1333.21, 23.9815, 98.0347, 590.603, 2005.97, 0, 0, 15, 0, '2018-01-29 18:09:56', 10),
(59, 'Bendrabutis #2', 1359.89, -1853.46, 13.5703, 2538.82, 460.551, 3312.06, 0, 0, 2, 2004, '2018-02-01 20:05:34', 1),
(60, 'Idlewood Complex', 2007.07, -1777.46, 17.3578, 1843.42, -2361.13, 2486.62, 0, 0, 2, 0, '2018-02-02 20:21:20', 2),
(61, 'Balkonas', 218.867, 1208.42, 1089.5, 567.634, -1215, 44.8603, 3, 20083, 0, 0, '2018-02-07 20:49:55', 157),
(63, 'Liftas', 1554.9, -1227.85, 1089.87, 1548.6, -1363.93, 326.218, 2, 0, 0, 0, '2018-02-10 22:13:19', 2),
(64, 'Balkonas Michelle', 830.724, -1506.95, 18.825, 2188.72, -1216.72, 1059.28, 0, 0, 6, 20125, '2018-02-11 23:53:47', 157),
(65, 'Stogas Michelle', 2182.95, -1210.13, 1059.9, 830.701, -1515.62, 21.2197, 6, 20125, 0, 0, '2018-02-11 23:57:07', 157),
(66, 'Avoria Complex', 1242.26, -1099.36, 27.9766, -166.843, 2827.55, 1086.47, 0, 0, 0, 0, '2018-02-17 13:07:17', 7),
(67, 'High Court of Justice', 1382.15, -1088.81, 28.2111, -2299.08, -2318.82, 4500.97, 0, 0, 2, 0, '2018-02-21 15:33:12', 2),
(68, 'Los Santos Airport', 1685.64, -2335.5, -2.67969, 1730.04, -2356.43, 6243.39, 0, 0, 2, 0, '2018-02-21 15:41:03', 2),
(70, 'Balkonas', 226.82, 1299.79, 1101.63, 206.472, -1767.31, 9.50781, 1, 20205, 0, 0, '2018-02-22 21:16:40', 7),
(71, 'Namo 83 garaþas', 244.02, 1211.62, 1088.96, 702.171, -251.573, 3001.59, 3, 20083, 2, 10047, '2018-03-03 18:53:51', 157),
(72, 'Namo 250 balkonas', 223.659, 1081.19, 1087.82, 998.641, -688.941, 125.522, 6, 20250, 0, 0, '2018-03-04 01:00:24', 157),
(76, 'Laiptinë', 2440.67, -1517.21, 23.9954, 3579.65, 540.272, 942.888, 0, 0, 0, 0, '2018-03-07 16:51:57', 1244),
(77, 'Democratic Party', 1377.8, -1753.15, 14.1406, 0, 0, 0, 0, 0, 0, 0, '2018-03-07 19:27:27', 1244),
(78, 'Democratic Party', 1377.81, -1753.23, 14.1406, 0, 0, 0, 0, 0, 0, 0, '2018-03-07 19:27:43', 1244),
(79, 'Democratic Party', 1377.81, -1753.13, 14.1406, 912.779, -2176.98, 2527.32, 0, 0, 2, 0, '2018-03-07 19:28:56', 1244),
(80, 'Butas 257', 1079.96, -1162.48, 64.5, 0, 0, 0, 0, 0, 0, 0, '2018-03-08 06:54:55', 805),
(81, 'Stogas', 2188.99, -1663.18, 2501.93, 0, 0, 0, 2, 20257, 0, 0, '2018-03-08 06:56:06', 805);

-- --------------------------------------------------------

--
-- Table structure for table `factions_data`
--

CREATE TABLE IF NOT EXISTS `factions_data` (
`id` int(11) NOT NULL,
  `Name` varchar(42) NOT NULL DEFAULT 'No faction name',
  `SpawnX` float NOT NULL,
  `SpawnY` float NOT NULL,
  `SpawnZ` float NOT NULL,
  `Type` smallint(6) NOT NULL DEFAULT '0',
  `ChatEnabled` tinyint(4) NOT NULL DEFAULT '1',
  `HasChat` tinyint(4) NOT NULL DEFAULT '1',
  `Budget` int(11) NOT NULL,
  `Wares1` int(11) NOT NULL,
  `Wares2` int(11) NOT NULL,
  `Wares3` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factions_data`
--

INSERT INTO `factions_data` (`id`, `Name`, `SpawnX`, `SpawnY`, `SpawnZ`, `Type`, `ChatEnabled`, `HasChat`, `Budget`, `Wares1`, `Wares2`, `Wares3`, `Added`, `Date`) VALUES
(1, 'LSPD', 1385.8, -1619.2, 17.6747, 1, 1, 1, 3876254, 0, 0, 0, 1, '2017-11-03 19:59:02'),
(2, 'San News', 1771.05, -1657.49, 14.4218, 6, 1, 1, 34300, 0, 0, 0, 1, '2017-11-19 13:28:41'),
(3, 'LSMD & LSFD', 2034.88, -1404.68, 17.2531, 2, 1, 1, 266875, 0, 0, 0, 1, '2017-11-19 13:44:17'),
(4, 'Government', 1481.37, -1794.14, 18.6557, 3, 1, 1, 1047734, 0, 0, 0, 1, '2017-12-14 20:39:41'),
(6, 'Volkogradov Connections', 0, 0, 0, 4, 1, 1, 0, 0, 0, 0, 2, '2018-01-08 11:51:39'),
(8, 'White Lotus', 0, 0, 0, 4, 0, 1, 115000, 0, 0, 0, 7, '2018-02-09 21:10:37');

-- --------------------------------------------------------

--
-- Table structure for table `factions_ranks`
--

CREATE TABLE IF NOT EXISTS `factions_ranks` (
`id` int(11) NOT NULL,
  `FactionId` int(11) NOT NULL,
  `Rank` int(11) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `Salary` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factions_ranks`
--

INSERT INTO `factions_ranks` (`id`, `FactionId`, `Rank`, `Name`, `Salary`, `Added`, `Date`) VALUES
(1, 1, 0, 'PO I', 1350, 1, '2017-11-08 16:31:17'),
(2, 1, 1, 'PO II', 1500, 1, '2017-11-08 16:31:19'),
(3, 2, 0, 'Staþuotojas', 1200, 1, '2017-12-10 17:27:26'),
(4, 2, 1, 'Þurnalistas', 1300, 1, '2017-12-10 17:27:28'),
(5, 2, 2, 'Reporteris', 1400, 1, '2017-12-10 17:27:29'),
(6, 2, 3, 'Reklamos skyriaus specia', 1500, 1, '2017-12-10 17:27:29'),
(7, 2, 3, 'Fotoreporteris', 1700, 1, '2017-12-10 17:27:31'),
(8, 2, 4, '6', 1800, 1, '2017-12-10 17:27:32'),
(9, 2, 5, 'Radijo laidø vedëjas', 1900, 1, '2017-12-10 17:27:33'),
(10, 2, 6, 'SANN vadovybës sekretori', 2100, 1, '2017-12-10 17:27:34'),
(11, 2, 7, 'SANN vadovybë', 2400, 1, '2017-12-10 17:27:36'),
(12, 3, 0, 'Sanitaras', 1200, 1, '2017-12-10 17:27:45'),
(13, 3, 1, 'Rezidentas', 1300, 1, '2017-12-10 17:27:46'),
(14, 3, 2, 'Paramedikas', 1400, 1, '2017-12-10 17:27:47'),
(15, 3, 3, 'Medikas', 1500, 1, '2017-12-10 17:27:48'),
(16, 3, 3, 'Surgeon', 1700, 1, '2017-12-10 17:27:49'),
(17, 3, 4, 'Firefighter', 1900, 1, '2017-12-10 17:27:53'),
(18, 3, 5, 'Division Chief', 2200, 1, '2017-12-10 17:27:54'),
(19, 3, 6, 'Darbuotojø priþiûrëtojas', 2300, 1, '2017-12-10 17:27:55'),
(20, 3, 7, 'Commissionier', 2500, 1, '2017-12-10 17:27:57'),
(21, 1, 2, 'PO III', 1650, 1, '2017-12-10 17:28:21'),
(22, 1, 3, 'PO III+1', 1750, 1, '2017-12-10 17:28:22'),
(23, 1, 3, 'Police Officer IV', 1500, 1, '2017-12-10 17:28:23'),
(24, 1, 4, 'Detective I', 1650, 1, '2017-12-10 17:28:25'),
(25, 1, 5, 'Detective II', 2000, 1, '2017-12-10 17:28:26'),
(26, 1, 6, 'Detective III', 1850, 1, '2017-12-10 17:28:28'),
(27, 1, 7, 'Police Sergeant I', 2000, 1, '2017-12-10 17:28:29'),
(28, 4, 0, 'NËRA', 0, 1, '2017-12-14 20:39:59'),
(29, 4, 1, 'NËRA', 0, 1, '2017-12-14 20:58:40'),
(30, 4, 2, 'NËRA', 0, 1, '2017-12-14 20:58:41'),
(31, 4, 3, 'NËRA', 0, 1, '2017-12-14 20:58:45'),
(32, 4, 3, 'Staþuotojas', 1100, 1, '2017-12-14 20:58:46'),
(33, 4, 4, 'Darbuotojas', 1400, 1, '2017-12-14 20:58:48'),
(34, 4, 5, 'Vyr. skyriaus darbuotoja', 1600, 1, '2017-12-14 20:58:49'),
(35, 4, 6, 'ÞIS – Vadovas', 2000, 1, '2017-12-14 20:58:51'),
(36, 4, 7, 'VPS – Vadovas', 2000, 1, '2017-12-14 20:58:52'),
(37, 4, 8, 'VRS – Vadovas', 2000, 1, '2017-12-14 20:58:54'),
(38, 4, 9, 'Administracija', 2300, 1, '2017-12-14 20:59:39'),
(39, 4, 10, 'Administracijos direktor', 2500, 1, '2017-12-14 20:59:40'),
(40, 4, 11, 'Meras', 2900, 2, '2017-12-15 08:24:43'),
(46, 6, 0, 'Shestyorka (1)', 600, 2, '2018-01-08 11:52:08'),
(47, 6, 1, 'Boyevik (2)', 600, 2, '2018-01-08 11:52:26'),
(48, 6, 2, 'Krysha (3)', 600, 2, '2018-01-08 11:52:33'),
(49, 6, 3, 'Starshina (4)', 600, 2, '2018-01-08 11:52:41'),
(50, 6, 4, 'Avtorityet (5)', 600, 2, '2018-01-08 11:52:44'),
(51, 1, 8, 'Police Sergeant II', 2250, 2, '2018-01-14 20:05:43'),
(52, 1, 9, 'Lieutenant', 2350, 2, '2018-01-14 20:05:54'),
(53, 6, 5, 'Obschak (6)', 600, 2, '2018-01-19 18:22:06'),
(54, 6, 6, 'Sovietnik (7)', 600, 2, '2018-01-19 18:22:10'),
(55, 6, 7, 'Pakhan (8)', 600, 2, '2018-01-19 18:22:21'),
(56, 1, 10, 'Captain', 2450, 2, '2018-01-30 17:27:14'),
(57, 1, 11, 'Commander', 2550, 2, '2018-02-02 20:01:07'),
(58, 1, 12, 'Deputy Chief', 2900, 2, '2018-02-05 20:12:32'),
(59, 1, 13, 'Assistant Chief', 2750, 2, '2018-02-05 20:12:34'),
(60, 1, 14, 'Chief', 2900, 2, '2018-02-05 20:12:36'),
(65, 8, 0, 'Shatei', 600, 7, '2018-02-09 21:20:12'),
(66, 8, 1, 'Onee-San', 600, 7, '2018-02-09 21:20:14'),
(67, 8, 2, 'Kyodai', 600, 7, '2018-02-09 21:20:16'),
(68, 8, 3, 'Shateigashira', 600, 7, '2018-02-09 21:20:18'),
(69, 8, 4, 'Wakagashira', 600, 7, '2018-02-09 21:20:20'),
(70, 8, 5, 'Shingiin', 600, 7, '2018-02-09 21:20:22'),
(71, 8, 6, 'Saiko-komon', 600, 7, '2018-02-09 21:20:25'),
(72, 8, 7, 'Oyabun', 600, 7, '2018-02-09 21:20:28'),
(73, 1, 15, 'Police Officer IIII', 0, 805, '2018-03-07 13:46:48'),
(74, 1, 16, 'HEAD OF T.D.', 4500, 805, '2018-03-07 13:57:45'),
(75, 1, 16, '4500', 4500, 805, '2018-03-07 14:13:51'),
(76, 1, 16, 'K4S', 15000, 805, '2018-03-07 14:17:52');

-- --------------------------------------------------------

--
-- Table structure for table `factions_wepstore`
--

CREATE TABLE IF NOT EXISTS `factions_wepstore` (
`id` int(11) NOT NULL,
  `FactionId` int(11) NOT NULL,
  `WeaponId` smallint(6) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `garages_data`
--

CREATE TABLE IF NOT EXISTS `garages_data` (
`id` int(11) NOT NULL,
  `Owner` int(11) NOT NULL,
  `Exterior` int(11) NOT NULL,
  `OutVW` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `CarEnterX` float NOT NULL,
  `CarEnterY` float NOT NULL,
  `CarEnterZ` float NOT NULL,
  `CarExitX` float NOT NULL,
  `CarExitY` float NOT NULL,
  `CarExitZ` float NOT NULL,
  `CarEnterA` float NOT NULL,
  `CarExitA` float NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Price` mediumint(9) NOT NULL,
  `Locked` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `garages_furniture`
--

CREATE TABLE IF NOT EXISTS `garages_furniture` (
`id` int(11) NOT NULL,
  `GarageId` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `VW` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `Price` mediumint(9) NOT NULL,
  `Added` int(11) NOT NULL,
  `Category` varchar(86) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Type` tinyint(4) NOT NULL,
  `Texture0` int(11) NOT NULL,
  `Texture1` int(11) NOT NULL,
  `Texture2` int(11) NOT NULL,
  `Texture3` int(11) NOT NULL,
  `Texture4` int(11) NOT NULL,
  `Texture5` int(11) NOT NULL,
  `Color0` int(11) NOT NULL,
  `Color1` int(11) NOT NULL,
  `Color2` int(11) NOT NULL,
  `Color3` int(11) NOT NULL,
  `Color4` int(11) NOT NULL,
  `Color5` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gifts`
--

CREATE TABLE IF NOT EXISTS `gifts` (
`id` int(11) NOT NULL,
  `Valid` tinyint(4) NOT NULL,
  `PrizeName` varchar(48) NOT NULL,
  `PrizeValue` int(11) NOT NULL,
  `PrizeType` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PickedById` int(11) NOT NULL,
  `PickedByIp` varchar(19) NOT NULL,
  `PickedByUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `graffiti`
--

CREATE TABLE IF NOT EXISTS `graffiti` (
`id` int(11) NOT NULL,
  `Font` int(11) NOT NULL,
  `Size` int(11) NOT NULL,
  `String` varchar(256) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `Int` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddedBy` int(11) NOT NULL,
  `Valid` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `groups_commands`
--

CREATE TABLE IF NOT EXISTS `groups_commands` (
`id` int(11) NOT NULL,
  `GroupId` int(11) NOT NULL,
  `Command` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=785 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups_commands`
--

INSERT INTO `groups_commands` (`id`, `GroupId`, `Command`) VALUES
(23, 1, 'customquery'),
(24, 1, 'aqu'),
(25, 1, 'allowooc'),
(26, 1, 'goto'),
(27, 1, 'afurniture'),
(28, 1, 'gethere'),
(29, 1, 'spectate'),
(30, 1, 'slap'),
(32, 1, 'giveweapon'),
(34, 1, 'ban'),
(35, 1, 'lockacc'),
(36, 1, 'cleardroppeditems'),
(37, 1, 'dqu'),
(38, 1, 'gotoxyz'),
(40, 1, 'givemoney'),
(41, 1, 'jail'),
(42, 1, 'kick'),
(43, 1, 'mute'),
(45, 1, 'settime'),
(46, 1, 'setweather'),
(47, 1, 'amenu'),
(48, 1, 'a'),
(50, 1, 'giveitem'),
(51, 1, 'reports'),
(53, 1, 'a'),
(55, 1, 'goto'),
(56, 1, 'giveitem'),
(58, 1, 'setint'),
(59, 1, 'setvw'),
(62, -1, 'settime'),
(63, -1, 'a'),
(64, -1, 'reports'),
(66, -1, 'gethere'),
(67, 1, 'playergroups'),
(68, 1, 'setgroup'),
(69, 1, 'unsetgroup'),
(70, 1, 'groupslist'),
(71, 1, 'aproperty'),
(72, 1, 'ao'),
(73, 1, 'ado'),
(74, -1, 'gotopc'),
(75, -1, 'gotolv'),
(76, -1, 'aheal'),
(79, 1, 'gotolv'),
(80, 1, 'aheal'),
(81, 1, 'gotosf'),
(82, 1, 'getcar'),
(83, 1, 'gotodl'),
(84, 1, 'gotobb'),
(85, 1, 'gotofc'),
(86, 1, 'gotols'),
(87, 1, 'gotomg'),
(88, 1, 'gotopc'),
(89, 1, 'gotoprison'),
(91, 1, 'makeleader'),
(92, 1, 'setskin'),
(95, 1, 'sethp'),
(96, 1, 'ignoreairbreak'),
(97, 1, 'freeze'),
(98, 1, 'setarmour'),
(100, 1, 'unfreeze'),
(101, 1, 'astats'),
(106, 1, 'afrisk'),
(113, 1, 'jobslist'),
(114, 1, 'factionslist'),
(115, 1, 'ip'),
(116, 1, 'rfc'),
(117, 1, 'jetpack'),
(118, 1, 'rac'),
(119, 1, 'rjc'),
(120, 1, 'gotocar'),
(170, 1, 'setstatcar'),
(171, 1, 'setstat'),
(172, 1, 'atakedrugs'),
(173, 1, 'atakeweapons'),
(226, 1, 'rtc'),
(227, 1, 'cleardroppedshells'),
(230, 13, 'setskin'),
(232, 13, 'rtc'),
(235, 13, 'spectate'),
(236, 13, 'unfreeze'),
(237, 13, 'gotobb'),
(238, 13, 'jail'),
(239, 13, 'gethere'),
(240, 13, 'aqu'),
(241, 13, 'kick'),
(242, 13, 'gotocar'),
(243, 13, 'aproperty'),
(244, 13, 'aduty'),
(245, 13, 'ao'),
(246, 13, 'gotofc'),
(247, 13, 'a'),
(248, 13, 'sethp'),
(249, 13, 'ado'),
(250, 13, 'aheal'),
(251, 13, 'getcar'),
(252, 13, 'ban'),
(253, 13, 'slap'),
(254, 13, 'afrisk'),
(255, 13, 'dqu'),
(256, 13, 'freeze'),
(257, 13, 'gotomg'),
(258, 13, 'forumname'),
(259, 13, 'goto'),
(260, 13, 'gotolv'),
(261, 13, 'gotodl'),
(262, 13, 'gotopc'),
(263, 13, 'gotols'),
(264, 13, 'gotoprison'),
(265, 13, 'gotosf'),
(266, 13, 'reports'),
(267, 13, 'gotoxyz'),
(268, 1, 'forumname'),
(269, 13, 'astats'),
(345, 1, 'masked'),
(346, 1, 'spec'),
(347, 1, 'givepayday'),
(348, 13, 'spec'),
(349, 13, 'masked'),
(350, 13, 'rjc'),
(351, 13, 'jobslist'),
(352, 14, 'unbanip'),
(353, 14, 'setvw'),
(354, 14, 'reports'),
(355, 14, 'gotoxyz'),
(356, 14, 'gotosf'),
(357, 14, 'gotoprison'),
(359, 14, 'gotols'),
(360, 14, 'gotopc'),
(361, 14, 'gotolv'),
(362, 14, 'gotodl'),
(363, 14, 'setweather'),
(364, 14, 'goto'),
(365, 14, 'jobslist'),
(367, 14, 'kick'),
(371, 14, 'freeze'),
(372, 14, 'forumname'),
(373, 14, 'gotomg'),
(374, 14, 'jetpack'),
(375, 14, 'rjc'),
(376, 14, 'groupslist'),
(377, 14, 'playergroups'),
(378, 14, 'setstatcar'),
(379, 14, 'rfc'),
(380, 14, 'rtc'),
(381, 14, 'setarmour'),
(382, 14, 'setskin'),
(383, 14, 'mute'),
(385, 14, 'lockacc'),
(386, 14, 'unfreeze'),
(388, 14, 'gotobb'),
(389, 14, 'settime'),
(391, 14, 'setint'),
(394, 14, 'jail'),
(395, 14, 'aqu'),
(396, 14, 'atakeweapons'),
(397, 14, 'dqu'),
(398, 14, 'rac'),
(400, 14, 'atakedrugs'),
(401, 14, 'gotofc'),
(402, 14, 'ao'),
(403, 14, 'getcar'),
(404, 14, 'ban'),
(405, 14, 'astats'),
(406, 14, 'aheal'),
(407, 14, 'ado'),
(408, 14, 'aduty'),
(409, 14, 'sethp'),
(410, 14, 'amenu'),
(411, 14, 'ip'),
(412, 14, 'setstat'),
(413, 14, 'afrisk'),
(414, 14, 'slap'),
(415, 14, 'aproperty'),
(416, 14, 'a'),
(418, 14, 'allowooc'),
(419, 14, 'gethere'),
(420, 14, 'factionslist'),
(421, 14, 'gotocar'),
(422, 14, 'spec'),
(423, 1, 'avote'),
(424, 13, 'jetpack'),
(425, 1, 'kickall'),
(426, 1, 'cmd1'),
(432, 1, 'warn'),
(439, 13, 'warn'),
(440, 13, 'setvw'),
(441, 13, 'allowooc'),
(442, 13, 'ip'),
(443, 1, 'hideadmins'),
(445, 1, 'makedonator'),
(446, 13, 'hideadmins'),
(448, 13, 'rfc'),
(451, 13, 'setarmour'),
(452, 14, 'avote'),
(454, 14, 'hideadmins'),
(455, 14, 'warn'),
(457, 14, 'kickall'),
(458, 14, 'masked'),
(520, 14, 'giveweapon'),
(532, 1, 'newchars'),
(533, 13, 'setweather'),
(534, 13, 'atakeweapons'),
(535, 13, 'setint'),
(536, 13, 'settime'),
(537, 13, 'kickall'),
(538, 13, 'mute'),
(539, 13, 'playergroups'),
(540, 13, 'factionslist'),
(541, 13, 'rac'),
(542, 23, 'reports'),
(545, 23, 'forumname'),
(546, 23, 'dqu'),
(547, 23, 'warn'),
(548, 23, 'setskin'),
(549, 23, 'a'),
(550, 23, 'mute'),
(552, 23, 'aqu'),
(553, 23, 'kick'),
(554, 23, 'newchars'),
(555, 1, 'clearboombox'),
(556, 23, 'clearboombox'),
(557, 14, 'givepayday'),
(561, 14, 'unsetgroup'),
(562, 14, 'cleardroppedshells'),
(563, 14, 'newchars'),
(564, 14, 'clearboombox'),
(566, 14, 'makeleader'),
(567, 14, 'cleardroppeditems'),
(568, 1, 'setstartmoney'),
(569, 23, 'aduty'),
(570, 13, 'newchars'),
(571, 23, 'jail'),
(572, 1, 'unbanip'),
(573, 24, 'warn'),
(574, 24, 'setstartmoney'),
(575, 24, 'reports'),
(576, 24, 'ip'),
(577, 24, 'gotoxyz'),
(578, 24, 'gotoprison'),
(579, 24, 'gotosf'),
(580, 24, 'gotopc'),
(581, 24, 'goto'),
(582, 24, 'givemoney'),
(583, 24, 'jobslist'),
(585, 24, 'forumname'),
(586, 24, 'avote'),
(587, 24, 'rjc'),
(588, 24, 'dqu'),
(589, 24, 'groupslist'),
(590, 24, 'setweather'),
(592, 24, 'customquery'),
(595, 24, 'aheal'),
(596, 24, 'gotolv'),
(597, 24, 'ban'),
(598, 24, 'getcar'),
(599, 24, 'astats'),
(600, 24, 'gethere'),
(601, 24, 'giveweapon'),
(602, 24, 'ado'),
(603, 24, 'sethp'),
(604, 24, 'atakeweapons'),
(605, 24, 'ao'),
(606, 24, 'aproperty'),
(607, 24, 'gotols'),
(608, 24, 'gotofc'),
(609, 24, 'giveitem'),
(610, 24, 'aduty'),
(611, 24, 'setstat'),
(612, 24, 'atakedrugs'),
(613, 24, 'kick'),
(614, 24, 'aqu'),
(615, 24, 'cleardroppedshells'),
(616, 24, 'newchars'),
(617, 24, 'allowooc'),
(618, 24, 'spec'),
(619, 24, 'gotocar'),
(621, 24, 'afrisk'),
(622, 24, 'unbanip'),
(623, 24, 'rac'),
(624, 24, 'setvw'),
(625, 24, 'setskin'),
(626, 24, 'setarmour'),
(627, 24, 'jail'),
(628, 24, 'rtc'),
(629, 24, 'slap'),
(630, 24, 'rfc'),
(631, 24, 'factionslist'),
(632, 24, 'makeleader'),
(633, 24, 'gotobb'),
(634, 24, 'freeze'),
(635, 24, 'setstatcar'),
(637, 24, 'playergroups'),
(638, 24, 'a'),
(639, 24, 'mute'),
(640, 24, 'masked'),
(642, 24, 'kickall'),
(643, 24, 'jetpack'),
(644, 24, 'unfreeze'),
(645, 24, 'gotomg'),
(646, 24, 'clearboombox'),
(647, 24, 'lockacc'),
(648, 24, 'cleardroppeditems'),
(649, 24, 'setint'),
(650, 24, 'hideadmins'),
(651, 24, 'gotodl'),
(652, 24, 'settime'),
(653, 1, 'apark'),
(654, 1, 'gpci'),
(657, 24, 'apark'),
(658, 24, 'gpci'),
(659, 13, 'avote'),
(660, 13, 'apark'),
(661, 14, 'apark'),
(662, 14, 'gpci'),
(663, 24, 'givepayday'),
(664, 1, 'findgpci'),
(665, 14, 'findgpci'),
(666, 24, 'findgpci'),
(667, 1, 'togadmin'),
(668, 1, 'aduty'),
(669, 14, 'togadmin'),
(670, 23, 'togadmin'),
(671, 13, 'togadmin'),
(760, 1, 'setnumberchanges'),
(761, 1, 'setnamechanges'),
(762, 1, 'setplatechanges'),
(763, 29, 'hideadmins'),
(764, 1, 'togglegifts'),
(765, 24, 'togadmin'),
(766, 1, 'msm'),
(768, 1, 'aa'),
(772, 1, 'deletegraffiti'),
(773, 1, 'givegraffiti'),
(774, 13, 'deletegraffiti'),
(775, 13, 'givegraffiti'),
(776, 24, 'amenu'),
(777, 14, 'givemoney'),
(778, 14, 'giveitem'),
(779, 1, 'addwhitelistip'),
(780, 14, 'deletegraffiti'),
(781, 14, 'addwhitelistip'),
(782, 14, 'givegraffiti'),
(783, 14, 'afriskproperty'),
(784, 14, 'makedonator');

-- --------------------------------------------------------

--
-- Table structure for table `groups_data`
--

CREATE TABLE IF NOT EXISTS `groups_data` (
`id` int(11) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Super` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups_data`
--

INSERT INTO `groups_data` (`id`, `Name`, `Added`, `Date`, `Super`) VALUES
(1, 'Ákûrëjas', 1, '2017-01-13 14:29:04', 0),
(13, 'Administratorius', 55, '2017-05-13 14:25:27', 0),
(14, 'Vad. Administratorius', 55, '2017-05-13 14:56:41', 0),
(23, 'Pagalbininkas', 5, '2017-12-10 11:26:08', 0),
(24, 'Koduotojas', 1, '2017-12-11 17:57:15', 0),
(29, 'No AFK', 1, '2017-12-24 21:44:45', 0);

-- --------------------------------------------------------

--
-- Table structure for table `groups_permissions`
--

CREATE TABLE IF NOT EXISTS `groups_permissions` (
`id` int(11) NOT NULL,
  `GroupId` int(11) NOT NULL,
  `Permission` varchar(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=754 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups_permissions`
--

INSERT INTO `groups_permissions` (`id`, `GroupId`, `Permission`) VALUES
(1, 1, 'SetHospitalSpawnPos'),
(73, 1, 'DeleteGarageFurniture'),
(75, 1, 'EditGroups'),
(76, 1, 'EditGroupCommands'),
(80, 1, 'ChangeBusinessExtra'),
(84, 1, 'ChangeHouseExit'),
(85, 1, 'ChangeSalonPosition'),
(86, 1, 'CreateNewATM'),
(88, 1, 'CreateNewBusiness'),
(89, 1, 'CreateNewGarage'),
(91, 1, 'CreateNewHouse'),
(92, 1, 'DeleteBusiness'),
(94, 1, 'DeleteGarage'),
(95, 1, 'DeleteBusinessFurniture'),
(96, 1, 'DeleteGroup'),
(97, 1, 'DeleteHouse'),
(98, 1, 'DeleteHouseFurniture'),
(99, 1, 'DeleteSalon'),
(100, 1, 'DeleteVehicle'),
(101, 1, 'EditBusiness'),
(102, 1, 'EditBusinessInventory'),
(103, 1, 'EditBusinessName'),
(104, 1, 'EditBusinessLevel'),
(105, 1, 'EditBusinessOwner'),
(106, 1, 'EditBusinessPrice'),
(107, 1, 'EditBusinessTaxes'),
(109, 1, 'EditGarageOwner'),
(110, 1, 'EditGaragePrice'),
(111, 1, 'EditGarages'),
(112, 1, 'EditHouseInventory'),
(113, 1, 'EditHouseOwner'),
(114, 1, 'EditHousePrice'),
(115, 1, 'EditHouses'),
(116, 1, 'EditHouseTaxes'),
(117, 1, 'EditSalonName'),
(118, 1, 'EditSalons'),
(119, 1, 'EditSalonSpawns'),
(120, 1, 'EditSalonVehicles'),
(121, 1, 'EditVehicleColor'),
(122, 1, 'EditVehicleFaction'),
(123, 1, 'EditVehicleJob'),
(125, 1, 'EditVehicleModel'),
(126, 1, 'EditVehicleTaxes'),
(127, 1, 'EnableBusinessLabels'),
(128, 1, 'EnablePoliceWeaponUsage'),
(129, 1, 'EnableLoginTimer'),
(130, 1, 'EnableFurnitureMultiSelect'),
(131, 1, 'EnableDroppedItemsSaving'),
(132, 1, 'EnableJobLabels'),
(133, 1, 'EnableHouseLabels'),
(134, 1, 'EnableTransactions'),
(135, 1, 'EnterAnyVehicle'),
(136, 1, 'IgnorePMBlock'),
(137, 1, 'SetArrestSpawn'),
(138, 1, 'SetBankPos'),
(139, 1, 'SetJailSpawn'),
(140, 1, 'SetOOCJailSpawn'),
(141, 1, 'SetOOCUnjailSpawn'),
(142, 1, 'SetUnarrestSpawn'),
(143, 1, 'SetUnjailSpawn'),
(144, 1, 'ViewBusinessInventory'),
(145, 1, 'ViewHouseInventory'),
(156, 1, 'EditGroupPermissions'),
(159, 1, 'ChangeBusinessExit'),
(160, 1, 'ChangeGarageEnter'),
(161, 1, 'ChangeGarageExit'),
(162, 1, 'ChangeHouseEnter'),
(163, 1, 'ChangeVehiclePosition'),
(164, 1, 'CreateNewGroup'),
(174, 1, 'ChangeIconPosition'),
(175, 1, 'CreateNewIcon'),
(176, 1, 'CreateNewSalon'),
(177, 1, 'CreateNewVehicle'),
(179, 1, 'EditIconDistance'),
(180, 1, 'DeleteIcon'),
(181, 1, 'EditIconIcon'),
(182, 1, 'EditIconName'),
(183, 1, 'EditIcons'),
(184, 1, 'EditIconType'),
(186, 1, 'EditFactions'),
(188, 1, 'CreateNewPayPhone'),
(189, 1, 'EditPayPhones'),
(190, 1, 'CreateNewParking'),
(191, 1, 'EditParkings'),
(192, 1, 'DeletePayPhone'),
(193, 1, 'ChangePayPhonePosition'),
(194, 1, 'EditParkingName'),
(196, 1, 'CreateNewDealerHouse'),
(214, 1, 'EditDealerHouses'),
(218, 1, 'ChangeDealerHouseExit'),
(219, 1, 'ChangeDealerHouseEnter'),
(220, 1, 'CreateDealerHouse'),
(221, 1, 'DeleteDealerHouse'),
(222, 1, 'EditDealerHouseOwner'),
(223, 1, 'EditDealerHousePrice'),
(224, 1, 'EditDealerHouseType'),
(225, 1, 'SetDealerDrugsLimit'),
(226, 1, 'SetDealerGunsLimit'),
(227, 1, 'EditFuelSettings'),
(246, 1, 'ChangeBusinessEnter'),
(248, 1, 'EditCityTaxes'),
(249, 1, 'EditBusinessType'),
(250, 1, 'EnabledIllegalOption'),
(366, 14, 'ChangeBusinessEnter'),
(367, 14, 'ChangeBusinessExit'),
(368, 14, 'ChangeBusinessExtra'),
(370, 14, 'ChangeGarageEnter'),
(372, 14, 'ChangeGarageExit'),
(373, 14, 'ChangeHouseEnter'),
(374, 14, 'ChangeHouseExit'),
(376, 14, 'ChangeSalonPosition'),
(377, 14, 'ChangePayPhonePosition'),
(378, 14, 'ChangeIconPosition'),
(379, 14, 'ChangeVehiclePosition'),
(381, 14, 'CreateNewATM'),
(382, 14, 'CreateNewFaction'),
(383, 14, 'CreateNewBusiness'),
(384, 14, 'CreateNewDealerHouse'),
(386, 14, 'CreateNewGarage'),
(387, 14, 'DeletePayPhone'),
(388, 14, 'DeleteIcon'),
(389, 14, 'DeleteHouseFurniture'),
(391, 14, 'DeleteGroup'),
(392, 14, 'DeleteHouse'),
(393, 14, 'DeleteGarageFurniture'),
(394, 14, 'DeleteGarage'),
(396, 14, 'DeleteBusinessFurniture'),
(397, 14, 'DeleteBusiness'),
(398, 14, 'CreateNewVehicle'),
(399, 14, 'CreateNewSalon'),
(400, 14, 'CreateNewParking'),
(401, 14, 'CreateNewPayPhone'),
(402, 14, 'CreateNewIcon'),
(404, 14, 'CreateNewGroup'),
(405, 14, 'CreateNewHouse'),
(406, 14, 'DeleteSalon'),
(407, 14, 'EditGarageOwner'),
(408, 14, 'EditFuelSettings'),
(409, 14, 'EditFactions'),
(414, 14, 'EditCityTaxes'),
(415, 14, 'EditBusinessType'),
(416, 14, 'EditBusinessTaxes'),
(417, 14, 'EditBusinessPrice'),
(418, 14, 'EditBusinessOwner'),
(419, 14, 'EditBusinessName'),
(420, 14, 'EditBusinessLevel'),
(421, 14, 'EditBusinessInventory'),
(422, 14, 'DeleteVehicle'),
(423, 14, 'EditBusiness'),
(424, 14, 'EditGaragePrice'),
(425, 14, 'EditGarages'),
(426, 14, 'EditGroups'),
(427, 14, 'EditHouseInventory'),
(428, 14, 'EditHouseOwner'),
(429, 14, 'EditHouses'),
(430, 14, 'EditHousePrice'),
(431, 14, 'EditHouseTaxes'),
(432, 14, 'EditIconDistance'),
(434, 14, 'EditIconName'),
(435, 14, 'EditIconIcon'),
(436, 14, 'EditIcons'),
(437, 14, 'EditIconType'),
(438, 14, 'EditPayPhones'),
(439, 14, 'EditParkings'),
(440, 14, 'EditParkingName'),
(441, 14, 'EditSalonName'),
(442, 14, 'EditSalons'),
(443, 14, 'EditSalonSpawns'),
(444, 14, 'EditSalonVehicles'),
(445, 14, 'EditVehicleColor'),
(446, 14, 'EditVehicleJob'),
(447, 14, 'EditVehicleFaction'),
(448, 14, 'EditVehicleModel'),
(449, 14, 'EditVehicleTaxes'),
(450, 14, 'EnableBusinessLabels'),
(451, 14, 'EnabledIllegalOption'),
(452, 14, 'EnableFurnitureMultiSelect'),
(454, 14, 'EnableDroppedItemsSaving'),
(455, 14, 'EnableHouseLabels'),
(456, 14, 'EnableLoginTimer'),
(457, 14, 'EnableJobLabels'),
(458, 14, 'EnablePoliceWeaponUsage'),
(459, 14, 'EnableTransactions'),
(460, 14, 'EnterAnyVehicle'),
(461, 14, 'IgnorePMBlock'),
(462, 14, 'IgnoreAFKKicker'),
(465, 14, 'ViewHouseInventory'),
(466, 14, 'ViewBusinessInventory'),
(467, 1, 'IgnoreAFKKicker'),
(468, 1, 'SetAdPos'),
(470, 1, 'CreateNewFaction'),
(504, 13, 'EnterAnyVehicle'),
(505, 13, 'IgnoreAFKKicker'),
(506, 13, 'IgnorePMBlock'),
(508, 14, 'SetAdPos'),
(509, 14, 'SetArrestSpawn'),
(510, 14, 'SetBankPos'),
(511, 14, 'SetDealerGunsLimit'),
(512, 14, 'SetHospitalSpawnPos'),
(513, 14, 'SetDealerDrugsLimit'),
(514, 14, 'SetOOCJailSpawn'),
(515, 14, 'SetOOCUnjailSpawn'),
(516, 14, 'SetJailSpawn'),
(517, 14, 'SetUnarrestSpawn'),
(518, 14, 'SetUnjailSpawn'),
(519, 24, 'ChangeBusinessEnter'),
(520, 24, 'ChangeBusinessExit'),
(521, 24, 'ChangeBusinessExtra'),
(522, 24, 'ChangeGarageExit'),
(523, 24, 'ChangeGarageEnter'),
(524, 24, 'ChangeHouseEnter'),
(525, 24, 'ChangeHouseExit'),
(526, 24, 'ChangeIconPosition'),
(527, 24, 'ChangePayPhonePosition'),
(528, 24, 'ChangeVehiclePosition'),
(529, 24, 'ChangeSalonPosition'),
(530, 24, 'CreateNewATM'),
(531, 24, 'CreateNewBusiness'),
(532, 24, 'CreateNewGarage'),
(534, 24, 'CreateNewHouse'),
(535, 24, 'CreateNewIcon'),
(536, 24, 'CreateNewPayPhone'),
(537, 24, 'CreateNewParking'),
(538, 24, 'CreateNewSalon'),
(539, 24, 'CreateNewVehicle'),
(540, 24, 'DeleteBusiness'),
(541, 24, 'DeleteBusinessFurniture'),
(543, 24, 'DeleteGarage'),
(544, 24, 'DeleteGarageFurniture'),
(545, 24, 'DeleteHouse'),
(546, 24, 'DeleteHouseFurniture'),
(547, 24, 'DeleteIcon'),
(548, 24, 'DeletePayPhone'),
(549, 24, 'DeleteSalon'),
(550, 24, 'DeleteVehicle'),
(551, 24, 'EditBusiness'),
(552, 24, 'EditBusinessLevel'),
(553, 24, 'EditBusinessName'),
(554, 24, 'EditBusinessOwner'),
(555, 24, 'EditBusinessPrice'),
(556, 24, 'EditBusinessTaxes'),
(557, 24, 'EditBusinessType'),
(558, 24, 'EditDealerHouseOwner'),
(559, 24, 'EditCityTaxes'),
(560, 24, 'EditDealerHousePrice'),
(561, 24, 'EditDealerHouses'),
(562, 24, 'EditDealerHouseType'),
(563, 24, 'EditFactions'),
(564, 24, 'EditFuelSettings'),
(565, 24, 'EditGarageOwner'),
(566, 24, 'EditGaragePrice'),
(567, 24, 'EditGarages'),
(570, 24, 'EditHouseInventory'),
(571, 24, 'EditHousePrice'),
(572, 24, 'EditHouseOwner'),
(573, 24, 'EditHouses'),
(574, 24, 'EditHouseTaxes'),
(575, 24, 'EditIconDistance'),
(576, 24, 'EditIconName'),
(577, 24, 'EditIcons'),
(578, 24, 'EditIconIcon'),
(579, 24, 'EditIconType'),
(580, 24, 'EditPayPhones'),
(581, 24, 'EditParkingName'),
(582, 24, 'EditParkings'),
(583, 24, 'EditSalonName'),
(584, 24, 'EditSalons'),
(585, 24, 'EditSalonSpawns'),
(587, 24, 'EditVehicleFaction'),
(588, 24, 'EditVehicleColor'),
(589, 24, 'EditVehicleJob'),
(590, 24, 'EditVehicleModel'),
(591, 24, 'EnableBusinessLabels'),
(592, 24, 'EditVehicleTaxes'),
(595, 24, 'EnableFurnitureMultiSelect'),
(596, 24, 'EnableHouseLabels'),
(597, 24, 'EnableJobLabels'),
(600, 24, 'EnableTransactions'),
(601, 24, 'EnterAnyVehicle'),
(603, 24, 'IgnorePMBlock'),
(604, 24, 'SetAdPos'),
(605, 24, 'SetArrestSpawn'),
(607, 24, 'SetBankPos'),
(610, 24, 'SetHospitalSpawnPos'),
(611, 24, 'SetJailSpawn'),
(612, 24, 'SetOOCJailSpawn'),
(613, 24, 'SetOOCUnjailSpawn'),
(614, 24, 'SetUnarrestSpawn'),
(615, 24, 'SetUnjailSpawn'),
(617, 24, 'ViewHouseInventory'),
(618, 24, 'ViewBusinessInventory'),
(619, 1, 'EditDealers'),
(620, 14, 'EditDealers'),
(621, 14, 'ChangeDealerHouseEnter'),
(622, 14, 'ChangeDealerHouseExit'),
(623, 14, 'CreateDealerHouse'),
(624, 14, 'DeleteDealerHouse'),
(625, 14, 'EditDealerHouseOwner'),
(626, 14, 'EditDealerHousePrice'),
(627, 14, 'EditDealerHouses'),
(628, 14, 'EditDealerHouseType'),
(629, 13, 'IsGroupAdmin'),
(630, 1, 'IsGroupAdmin'),
(631, 14, 'IsGroupAdmin'),
(632, 24, 'IsGroupAdmin'),
(750, 23, 'IgnorePMBlock'),
(753, 29, 'IgnoreAFKKicker');

-- --------------------------------------------------------

--
-- Table structure for table `groups_permissions_list`
--

CREATE TABLE IF NOT EXISTS `groups_permissions_list` (
  `Permission` varchar(32) COLLATE utf8_lithuanian_ci NOT NULL,
  `DefaultValue` tinyint(4) NOT NULL,
  `Comment` varchar(50) COLLATE utf8_lithuanian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `groups_permissions_list`
--

INSERT INTO `groups_permissions_list` (`Permission`, `DefaultValue`, `Comment`) VALUES
('ChangeBusinessEnter', 0, 'Keisti verslo iejimo vieta'),
('ChangeBusinessExit', 0, 'Keisti verslo isejimo vieta'),
('ChangeBusinessExtra', 0, 'Keisti extra koord. vieta (pvz. /fill)'),
('ChangeDealerHouseEnter', 0, 'Keisti konsp. namo iejima'),
('ChangeDealerHouseExit', 0, 'Keisti konsp. namo isejima'),
('ChangeGarageEnter', 0, 'Keisti garazo iejimo/ivaziavimo vieta'),
('ChangeGarageExit', 0, 'Keisti garazo isejimo/isvaziavimo vieta'),
('ChangeHouseEnter', 0, 'Keisti namo iejimo vieta'),
('ChangeHouseExit', 0, 'Keisti namo isejimo vieta'),
('ChangeIconPosition', 0, 'Keisti map ikonos vieta'),
('ChangePayPhonePosition', 0, 'Keisti taksofono vieta'),
('ChangeSalonPosition', 0, 'Keisti tr. priemoniu salono vieta'),
('ChangeVehiclePosition', 0, 'Keisti tr. priemones spawn vieta'),
('CreateDealerHouse', 0, 'Kurti nauja konspiracini nama'),
('CreateNewATM', 0, 'Kurti nauja bankomata'),
('CreateNewBusiness', 0, 'Kurti nauja versla'),
('CreateNewDealerHouse', 0, 'Kurti nauja konspiracini nama'),
('CreateNewFaction', 0, 'Kurti nauja frakcija'),
('CreateNewGarage', 0, 'Kurti nauja garaza'),
('CreateNewGroup', 0, 'Kurti nauja admin grupe'),
('CreateNewHouse', 0, 'Kurti nauja nama'),
('CreateNewIcon', 0, 'Kurti nauja ikona zemelapyje'),
('CreateNewPayPhone', 0, 'Kurti nauja taksofona'),
('CreateNewParking', 0, 'Kurti nauja aikstele'),
('CreateNewSalon', 0, 'Kurti nauja tr. priemoniu salona'),
('CreateNewVehicle', 0, 'Prideti nauja tr. priemone'),
('DeleteBusiness', 0, 'Istrinti versla'),
('DeleteBusinessFurniture', 0, 'Istrinti verslo furniture'),
('DeleteDealerHouse', 0, 'Istrinti konspiracinius namus'),
('DeleteGarage', 0, 'Istrinti garaza'),
('DeleteGarageFurniture', 0, 'Istrinti garazo furniture'),
('DeleteGroup', 0, 'Istrinti admin grupe'),
('DeleteHouse', 0, 'Istrinti nama'),
('DeleteHouseFurniture', 0, 'Istrinti namo furniture'),
('DeleteIcon', 0, 'Istrinti map ikona'),
('DeletePayPhone', 0, 'Istrinti taksofona'),
('DeleteSalon', 0, 'Istrinti tr. priemoniu salona'),
('DeleteVehicle', 0, 'Istrinti tr. priemone'),
('EditBusiness', 0, 'Redaguoti verslus'),
('EditBusinessInventory', 0, 'Redaguoti verslo inventoriu'),
('EditBusinessLevel', 0, 'Keisti verslo ismoku lygi'),
('EditBusinessName', 0, 'Keisti verslo pavadinima'),
('EditBusinessOwner', 0, 'Keisti verslo savininka'),
('EditBusinessPrice', 0, 'Keisti verslo kaina'),
('EditBusinessTaxes', 0, 'Keisti visu verslu mokescius'),
('EditBusinessType', 0, 'Keisti verslo tipa'),
('EditCityTaxes', 0, 'Mokesciu proc. nuo payday'),
('EditDealerHouseOwner', 0, 'Keisti konsp. namo savininka'),
('EditDealerHousePrice', 0, 'Keisti konsp. namo kaina'),
('EditDealerHouses', 0, 'Redaguoti konspiracinius namus'),
('EditDealerHouseType', 0, 'Keisti konspiracinio namo tipa'),
('EditDealers', 0, 'Dealeriu valdymas'),
('EditFactions', 0, 'Redaguoti frakcijas'),
('EditFuelSettings', 0, 'Keisti verslo degalu nustatymus'),
('EditGarageOwner', 0, 'Keisti garazo savininka'),
('EditGaragePrice', 0, 'Keisti garazo kaina'),
('EditGarages', 0, 'Redaguoti garazus'),
('EditGroupCommands', 0, 'Keisti admin grupiu komandas'),
('EditGroupPermissions', 0, 'Keisti admin grupiu teises'),
('EditGroups', 0, 'Redaguoti admin grupes'),
('EditHouseInventory', 0, 'Redaguoti namo inventoriu'),
('EditHouseOwner', 0, 'Keisti namo savininka'),
('EditHousePrice', 0, 'Keisti namo kaina'),
('EditHouses', 0, 'Redaguoti namus'),
('EditHouseTaxes', 0, 'Keisti visu namu mokescius'),
('EditIconDistance', 0, 'Keisti map ikonos matomumo ribas'),
('EditIconIcon', 0, 'Keisti map ikonos paveiksliuka'),
('EditIconName', 0, 'Keisti map ikonos pavadinima'),
('EditIcons', 0, 'Redaguoti map ikonas'),
('EditIconType', 0, 'Redaguoti ikonos tipa'),
('EditPayPhones', 0, 'Redaguoti taksofonus'),
('EditParkingName', 0, 'Keisti aiksteles pavadinima'),
('EditParkings', 0, 'Redaguoti aiksteles'),
('EditSalonName', 0, 'Keisti tr. priemoniu salono pavadinima'),
('EditSalons', 0, 'Redaguoti tr. priemoniu salonus'),
('EditSalonSpawns', 0, 'Keisti salonu random spawn vietas'),
('EditSalonVehicles', 0, 'Keisti parduodamas tr. priemones'),
('EditVehicleColor', 0, 'Keisti tr. priemones spalva'),
('EditVehicleFaction', 0, 'Keisti tr. priemones frakcija'),
('EditVehicleJob', 0, 'Keisti tr. priemones darba'),
('EditVehicleModel', 0, 'Keisti tr. priemones modeli'),
('EditVehicleTaxes', 0, 'Keisti visu tr. priemoniu mokescius'),
('EnableBusinessLabels', 0, 'Ijungti/isjungti verslu 3d labels rodyma'),
('EnabledIllegalOption', 0, 'Ijungti/isjungti legalu/nelegalu sistema'),
('EnableDroppedItemsSaving', 0, 'Ijungti/isjungti ismestu daiktu saugojima'),
('EnableFurnitureMultiSelect', 0, 'Ijungti/isjungti multi-select sistema'),
('EnableHouseLabels', 0, 'Ijungti/isjungti namu 3d labels rodyma'),
('EnableJobLabels', 0, 'Ijungti/isjungti darbu 3d labels rodyma'),
('EnableLoginTimer', 0, 'Ijungti/isjungti prisijungimo 30s laikmati'),
('EnablePoliceWeaponUsage', 0, 'Ijungti/isjungti policijos atsargu sistema'),
('EnableTransactions', 0, 'Ijungti/isjungti banko pervedimu sistema'),
('EnterAnyVehicle', 0, 'Gali ilipti i bet kokia tr. priemone (AOD)'),
('IgnoreAFKKicker', 0, 'Nekickint uz afk'),
('IgnorePMBlock', 0, 'Ignoruoti zaidejo /blockpm (AOD)'),
('IsGroupAdmin', 1, 'Ar grupe admin? 0 - helpers'),
('SetAdPos', 0, 'Keisti /ad vieta'),
('SetArrestSpawn', 0, 'Keisti arestines vidaus vieta'),
('SetBankPos', 0, 'Keisti banko (/bank) vieta'),
('SetDealerDrugsLimit', 0, 'Nustatyti dealerio maks. narkotikus per uzsakyma'),
('SetDealerGunsLimit', 0, 'Nustatyti dealerio maks. ginklus per uzsakyma'),
('SetHospitalSpawnPos', 0, 'Nustatyti ligonines spawn vieta '),
('SetJailSpawn', 0, 'Keisti kalejimo vidaus vieta'),
('SetOOCJailSpawn', 0, 'Keisti OOC kalejimo vidaus vieta'),
('SetOOCUnjailSpawn', 0, 'Keisti OOC kalejimo paleidimo vieta'),
('SetUnarrestSpawn', 0, 'Keisti arestines paleidimo vieta'),
('SetUnjailSpawn', 0, 'Keisti kalejimo paleidimo vieta'),
('ViewBusinessInventory', 0, 'Perziureti verslo inventoriu'),
('ViewHouseInventory', 0, 'Perziureti namo inventoriu');

-- --------------------------------------------------------

--
-- Table structure for table `houses_data`
--

CREATE TABLE IF NOT EXISTS `houses_data` (
`id` int(11) NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Owner` int(11) NOT NULL,
  `Locked` tinyint(4) NOT NULL,
  `Exterior` int(11) NOT NULL,
  `OutVW` int(11) NOT NULL,
  `Price` int(11) NOT NULL DEFAULT '0',
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UpdateEat` int(11) NOT NULL,
  `UpdateClothes` int(11) NOT NULL,
  `UpdateSafe` int(11) NOT NULL,
  `Safe` int(11) NOT NULL,
  `Rent` tinyint(4) NOT NULL,
  `RentPrice` int(11) NOT NULL,
  `RentLimit` int(11) NOT NULL,
  `Sale` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `houses_dubkeys`
--

CREATE TABLE IF NOT EXISTS `houses_dubkeys` (
`id` int(11) NOT NULL,
  `HouseId` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valid` tinyint(4) NOT NULL,
  `P_FurnitureControl` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses_furniture`
--

CREATE TABLE IF NOT EXISTS `houses_furniture` (
`id` int(11) NOT NULL,
  `HouseId` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `VW` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `Name` varchar(24) COLLATE utf8_lithuanian_ci NOT NULL,
  `Price` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Category` varchar(86) COLLATE utf8_lithuanian_ci NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Type` tinyint(4) NOT NULL,
  `Texture0` smallint(6) NOT NULL,
  `Texture1` smallint(6) NOT NULL,
  `Texture2` smallint(6) NOT NULL,
  `Texture3` smallint(6) NOT NULL,
  `Texture4` smallint(6) NOT NULL,
  `Texture5` smallint(6) NOT NULL,
  `Color0` smallint(6) NOT NULL,
  `Color1` smallint(6) NOT NULL,
  `Color2` smallint(6) NOT NULL,
  `Color3` smallint(6) NOT NULL,
  `Color4` smallint(6) NOT NULL,
  `Color5` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses_inventory`
--

CREATE TABLE IF NOT EXISTS `houses_inventory` (
`id` int(11) NOT NULL,
  `HouseId` int(11) NOT NULL,
  `Packed` varchar(512) NOT NULL,
  `Updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `interiors`
--

CREATE TABLE IF NOT EXISTS `interiors` (
`id` int(11) NOT NULL,
  `Name` varchar(86) COLLATE utf8_lithuanian_ci NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `map_editor_files`
--

CREATE TABLE IF NOT EXISTS `map_editor_files` (
  `id` int(11) NOT NULL,
  `Name` varchar(46) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `map_editor_objects`
--

CREATE TABLE IF NOT EXISTS `map_editor_objects` (
  `id` int(11) NOT NULL,
  `FileId` int(11) NOT NULL,
  `Name` varchar(46) NOT NULL,
  `Model` int(11) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `VW` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `X` int(11) NOT NULL,
  `Y` int(11) NOT NULL,
  `Z` int(11) NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `map_icons`
--

CREATE TABLE IF NOT EXISTS `map_icons` (
`id` int(11) NOT NULL,
  `Name` varchar(56) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL DEFAULT '0',
  `Type` int(11) NOT NULL,
  `Color` int(11) NOT NULL,
  `VW` int(11) NOT NULL DEFAULT '-1',
  `Interior` int(11) NOT NULL DEFAULT '-1',
  `StreamDistance` float NOT NULL DEFAULT '300',
  `Active` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE IF NOT EXISTS `options` (
`id` int(11) NOT NULL,
  `Key` varchar(48) NOT NULL,
  `Value` varchar(128) NOT NULL,
  `Type` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `Key`, `Value`, `Type`) VALUES
(1, 'StartMoney', '10000', 1),
(3, 'VehicleTaxes', '20', 1),
(4, 'HouseTaxes', '50', 1),
(5, 'BusinessTaxes', '100', 1),
(6, 'PaydaysToPDWeaponsEmpty', '120', 1),
(7, 'PaydaysToPDSkinsEmpty', '216', 1),
(8, 'PaydaysToPDSpecialEmpty', '336', 1),
(9, 'JailSpawnX', '406.967316', 3),
(10, 'JailSpawnY', '1449.489868', 3),
(11, 'JailSpawnZ', '1844.086304', 3),
(12, 'UnjailSpawnX', '-105.08', 0),
(13, 'UnjailSpawnY', '18.24', 3),
(14, 'UnjailSpawnZ', '3.11', 3),
(15, 'ArrestSpawnX', '2046.485229', 3),
(16, 'ArrestSpawnY', '2944.533447', 3),
(17, 'ArrestSpawnZ', '6002.524414', 3),
(18, 'UnarrestSpawnX', '-105.08', 3),
(19, 'UnarrestSpawnY', '18.24', 3),
(20, 'UnarrestSpawnZ', '3.11', 3),
(21, 'OOCJailSpawnX', '2935.621582', 3),
(22, 'OOCJailSpawnY', '2119.177734', 3),
(23, 'OOCJailSpawnZ', '13.154997', 3),
(24, 'OOCUnjailX', '1422.182373', 3),
(25, 'OOCUnjailY', '-1655.795410', 3),
(26, 'OOCUnjailZ', '13.546875', 3),
(27, 'TaxesToCity', '15', 1),
(28, 'TaxesToPolice', '70', 1),
(29, 'EnabledPoliceWeaponUsage', '0', 1),
(30, 'EnabledFurnitureMultiSelect', '0', 1),
(31, 'EnabledLoginTimer', '0', 1),
(32, 'EnabledDroppedItemsSaving', '0', 1),
(33, 'EnabledJobLabels', '1', 1),
(34, 'EnabledBusinessLabels', '1', 1),
(35, 'EnabledHouseLabels', '1', 1),
(36, 'BankX', '96.894997', 3),
(37, 'BankY', '-13.519484', 3),
(38, 'BankZ', '1000.512817', 3),
(39, 'EnabledTransactions', '1', 1),
(40, 'BusinessPayMaxLevels', '15', 1),
(41, 'BusinessPayLevel0', '0', 1),
(42, 'BusinessPayLevel1', '900', 1),
(43, 'BusinessPayLevel2', '900', 1),
(44, 'BusinessPayLevel3', '900', 1),
(45, 'BusinessPayLevel4', '900', 1),
(46, 'BusinessPayLevel5', '900', 1),
(54, 'WarnsToBan', '3', 1),
(55, 'ArrestSpawnInt', '0', 1),
(56, 'ArrestSpawnVW', '0', 1),
(57, 'UnjailInt', '0', 1),
(58, 'UnjailVW', '0', 1),
(59, 'JailSpawnInt', '0', 1),
(60, 'JailSpawnVW', '0', 1),
(61, 'UnarrestInt', '0', 1),
(62, 'UnarrestVW', '0', 1),
(63, 'OOCJailSpawnInt', '0', 1),
(64, 'OOCJailSpawnVW', '0', 1),
(65, 'OOCUnjailVW', '0', 1),
(66, 'OOCUnjailInt', '0', 1),
(67, 'BankInt', '0', 1),
(68, 'BankVW', '10', 1),
(69, 'SpawnHospitalX', '1658.359131', 3),
(70, 'SpawnHospitalY', '-1395.143921', 3),
(71, 'SpawnHospitalZ', '13.546875', 3),
(72, 'SpawnHopitalInt', '0', 1),
(73, 'SpawnHopitalVW', '0', 1),
(74, 'BusinessFuelCapacity', '10000', 1),
(75, 'BusinessOrderFuelPrice', '1.200000', 3),
(76, 'MaxCharacters', '15', 1),
(77, 'JailX', '406.967316', 3),
(78, 'JailY', '1449.489868', 3),
(79, 'JailZ', '1844.086304', 3),
(80, 'JailInt', '0', 1),
(81, 'JailVW', '0', 1),
(82, 'ArrestX', '2049.671143', 3),
(83, 'ArrestY', '2944.825928', 3),
(84, 'ArrestZ', '6001.186035', 3),
(85, 'ArrestInt', '0', 1),
(86, 'ArrestVW', '0', 1),
(87, 'AdX', '1568.223389', 3),
(88, 'AdY', '-1229.055176', 3),
(89, 'AdZ', '1089.866943', 3),
(90, 'AdInt', '2', 1),
(91, 'AdVW', '0', 1),
(92, 'SpawnX', '1745.011597', 3),
(93, 'SpawnY', '-1859.619873', 3),
(94, 'SpawnZ', '13.348211', 3),
(95, 'SpawnX', '1745.011597', 3),
(96, 'SpawnY', '-1859.619873', 3),
(97, 'SpawnZ', '13.348211', 3),
(98, 'BusinessPayLevel6', '', 1),
(99, 'BusinessPayLevel7', '600', 1),
(100, 'BusinessPayLevel8', '900', 1),
(101, 'BusinessPayLevel9', '1300', 1),
(102, 'BusinessPayLevel10', '1700', 1),
(103, 'BusinessPayLevel11', '2000', 1),
(104, 'BusinessPayLevel12', '3000', 1),
(105, 'BusinessPayLevel13', '4000', 1),
(106, 'BusinessPayLevel14', '5500', 1),
(107, 'BusinessPayLevel15', '13500', 1);

-- --------------------------------------------------------

--
-- Table structure for table `parkings_data`
--

CREATE TABLE IF NOT EXISTS `parkings_data` (
`id` int(11) NOT NULL,
  `Name` varchar(24) COLLATE utf8_lithuanian_ci NOT NULL,
  `EnterX` float NOT NULL,
  `EnterY` float NOT NULL,
  `EnterZ` float NOT NULL,
  `ExitX` float NOT NULL,
  `ExitY` float NOT NULL,
  `ExitZ` float NOT NULL,
  `VW` int(11) NOT NULL,
  `Interior` int(11) NOT NULL,
  `OutVW` int(11) NOT NULL,
  `Exterior` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payphones_data`
--

CREATE TABLE IF NOT EXISTS `payphones_data` (
`id` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `RX` float NOT NULL,
  `RY` float NOT NULL,
  `RZ` float NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players_bank_history`
--

CREATE TABLE IF NOT EXISTS `players_bank_history` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `String` varchar(128) NOT NULL,
  `Amount` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_bans`
--

CREATE TABLE IF NOT EXISTS `players_bans` (
`id` int(11) NOT NULL,
  `PlayerName` varchar(24) NOT NULL,
  `PlayerIP` varchar(24) NOT NULL,
  `AdminName` varchar(24) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `UnbanTime` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valid` tinyint(4) NOT NULL,
  `gpci` varchar(41) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_clothes`
--

CREATE TABLE IF NOT EXISTS `players_clothes` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Packed` varchar(256) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|',
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_clothes_attached`
--

CREATE TABLE IF NOT EXISTS `players_clothes_attached` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Index` tinyint(3) NOT NULL,
  `InventorySlot` smallint(11) NOT NULL DEFAULT '-1',
  `Bone` int(11) NOT NULL,
  `OffsetX` float NOT NULL,
  `OffsetY` float NOT NULL,
  `OffsetZ` float NOT NULL,
  `RotX` float NOT NULL,
  `RotY` float NOT NULL,
  `RotZ` float NOT NULL,
  `ScaleX` float NOT NULL,
  `ScaleY` float NOT NULL,
  `ScaleZ` float NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_config`
--

CREATE TABLE IF NOT EXISTS `players_config` (
`id` int(255) NOT NULL,
  `PlayerId` int(255) NOT NULL,
  `ShowBans` tinyint(1) NOT NULL DEFAULT '0',
  `ShowLocks` tinyint(1) NOT NULL DEFAULT '0',
  `ShowJails` tinyint(1) NOT NULL DEFAULT '0',
  `AccessUrl` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_contacts`
--

CREATE TABLE IF NOT EXISTS `players_contacts` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Packed` varchar(1024) COLLATE utf8_lithuanian_ci NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players_crimes`
--

CREATE TABLE IF NOT EXISTS `players_crimes` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `OfficerName` varchar(24) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `Reason` varchar(126) NOT NULL,
  `Money` int(11) NOT NULL,
  `Valid` tinyint(4) NOT NULL DEFAULT '1',
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_data`
--

CREATE TABLE IF NOT EXISTS `players_data` (
`id` int(11) NOT NULL,
  `Name` varchar(28) NOT NULL,
  `Money` int(11) NOT NULL,
  `BirthDate` mediumint(5) NOT NULL,
  `Gender` varchar(11) NOT NULL,
  `Origin` varchar(30) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  `Skin` mediumint(9) NOT NULL,
  `Faction` mediumint(9) NOT NULL,
  `Job` smallint(11) NOT NULL,
  `SideJob` int(11) NOT NULL,
  `JobXP` smallint(11) NOT NULL,
  `JobContract` smallint(6) NOT NULL,
  `PoliceBadge` tinyint(4) NOT NULL,
  `HaveCars` smallint(6) NOT NULL,
  `RegisterIP` varchar(22) NOT NULL,
  `JobLevel` smallint(6) NOT NULL,
  `PayCheck` mediumint(9) NOT NULL,
  `Level` smallint(6) NOT NULL DEFAULT '1',
  `XP` mediumint(9) NOT NULL,
  `JailType` tinyint(2) NOT NULL,
  `JailTime` int(11) NOT NULL,
  `SpawnType` tinyint(4) NOT NULL,
  `SpawnId` mediumint(9) NOT NULL,
  `Group1` mediumint(9) NOT NULL,
  `Group2` mediumint(9) NOT NULL,
  `Group3` mediumint(9) NOT NULL,
  `PayDayTime` smallint(6) NOT NULL,
  `Savings` int(11) NOT NULL,
  `Bank` int(11) NOT NULL,
  `UserId` int(255) NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `CarLic` tinyint(4) NOT NULL,
  `MotoLic` tinyint(4) NOT NULL,
  `FlyLic` tinyint(4) NOT NULL,
  `BoatLic` tinyint(4) NOT NULL,
  `LastIP` varchar(24) NOT NULL,
  `FactionLeader` tinyint(4) NOT NULL,
  `PhoneNumber` int(11) NOT NULL DEFAULT '0',
  `HoursPlayed` int(11) NOT NULL,
  `RadioChannel` int(11) NOT NULL,
  `BankCard` tinyint(4) NOT NULL,
  `FactionPermission1` tinyint(4) NOT NULL,
  `FactionPermission2` tinyint(4) NOT NULL,
  `FactionPermission3` tinyint(4) NOT NULL,
  `ForumName` varchar(24) NOT NULL,
  `UniqueKey` varchar(20) NOT NULL,
  `LastVersion_Server` int(11) NOT NULL,
  `Warns` int(11) NOT NULL,
  `Fishes` int(11) NOT NULL,
  `FishedLimit` int(11) NOT NULL,
  `gpci` varchar(41) NOT NULL,
  `TaxiLic` int(11) NOT NULL,
  `Donator` int(11) NOT NULL,
  `PayDayCollected` int(11) NOT NULL,
  `DonatorTime` int(11) NOT NULL,
  `StolenCars` int(11) NOT NULL,
  `GraffitiAllowed` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_drugs`
--

CREATE TABLE IF NOT EXISTS `players_drugs` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Type` tinyint(4) NOT NULL,
  `UsedTimes` int(11) NOT NULL DEFAULT '0',
  `Level` int(11) NOT NULL DEFAULT '0',
  `Unused` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players_inventory`
--

CREATE TABLE IF NOT EXISTS `players_inventory` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Packed` varchar(356) NOT NULL,
  `Updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_jails`
--

CREATE TABLE IF NOT EXISTS `players_jails` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `JailerName` varchar(24) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `JailType` int(11) NOT NULL,
  `Valid` tinyint(4) NOT NULL DEFAULT '1',
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `JailTime` int(11) NOT NULL,
  `Bill` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_locks`
--

CREATE TABLE IF NOT EXISTS `players_locks` (
`id` int(11) NOT NULL,
  `PlayerName` varchar(24) NOT NULL,
  `AdminName` varchar(24) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Valid` tinyint(4) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_login_notes`
--

CREATE TABLE IF NOT EXISTS `players_login_notes` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `String` varchar(256) NOT NULL,
  `DidRead` tinyint(4) NOT NULL,
  `Added` int(11) NOT NULL DEFAULT '-1',
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ReadDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_new`
--

CREATE TABLE IF NOT EXISTS `players_new` (
`id` int(11) unsigned NOT NULL,
  `Name` varchar(24) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Skin` int(11) NOT NULL,
  `Origin` varchar(18) NOT NULL,
  `Gender` varchar(18) NOT NULL,
  `Years` int(11) NOT NULL,
  `Answer1` varchar(128) NOT NULL,
  `Answer2` varchar(128) NOT NULL,
  `Answer3` varchar(128) NOT NULL,
  `Status` int(11) NOT NULL,
  `Reviewed` int(11) NOT NULL,
  `AdminId` int(11) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `gpci` varchar(41) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_reports`
--

CREATE TABLE IF NOT EXISTS `players_reports` (
`id` int(11) NOT NULL,
  `ReporterId` int(11) NOT NULL,
  `CheaterId` int(11) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Valid` tinyint(4) NOT NULL,
  `Status` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_settings`
--

CREATE TABLE IF NOT EXISTS `players_settings` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Option` varchar(46) NOT NULL,
  `Value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_sms`
--

CREATE TABLE IF NOT EXISTS `players_sms` (
`id` int(11) NOT NULL,
  `SenderNumber` int(11) NOT NULL,
  `ReceiverNumber` int(11) NOT NULL,
  `Text` varchar(128) COLLATE utf8_lithuanian_ci NOT NULL,
  `Notification` tinyint(4) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

-- --------------------------------------------------------

--
-- Table structure for table `players_wanted`
--

CREATE TABLE IF NOT EXISTS `players_wanted` (
`id` int(11) NOT NULL,
  `Active` tinyint(4) NOT NULL DEFAULT '1',
  `Name` varchar(24) NOT NULL,
  `Reason` varchar(108) NOT NULL,
  `Looks` varchar(108) NOT NULL,
  `Seen` varchar(108) NOT NULL,
  `OfficerName` varchar(24) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_warns`
--

CREATE TABLE IF NOT EXISTS `players_warns` (
`id` int(11) NOT NULL,
  `PlayerName` varchar(24) NOT NULL,
  `AdminName` varchar(24) NOT NULL,
  `Reason` varchar(128) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `players_weapons`
--

CREATE TABLE IF NOT EXISTS `players_weapons` (
`id` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Packed` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `san_news_sms`
--

CREATE TABLE IF NOT EXISTS `san_news_sms` (
`id` int(11) NOT NULL,
  `PlayerNumber` int(11) NOT NULL,
  `Text` varchar(128) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sell_salons`
--

CREATE TABLE IF NOT EXISTS `sell_salons` (
`id` int(11) NOT NULL,
  `Name` varchar(256) COLLATE utf8_lithuanian_ci NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `Interior` int(11) NOT NULL,
  `VW` int(11) NOT NULL,
  `Garbage` tinyint(4) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `sell_salons`
--

INSERT INTO `sell_salons` (`id`, `Name`, `X`, `Y`, `Z`, `Interior`, `VW`, `Garbage`, `Added`, `Date`) VALUES
(1, 'GOTTI', 544.391, -1293.92, 17.242, 0, 0, 0, 4, '2017-12-09 18:07:07'),
(2, 'Coutt And Schutz', 2132, -1149.57, 24.255, 0, 0, 0, 4, '2017-12-09 18:24:34'),
(3, 'Marina Boat Shop', 725.641, -1439.74, 13.5318, 0, 0, 0, 2, '2017-12-12 14:42:08'),
(4, 'Industrial Vehicles Shop', 2341.81, -2077.87, 14.9564, 0, 0, 0, 184, '2017-12-12 20:37:00'),
(5, 'Remëjø tr. priemoniø salonas', 1026.13, -1583.68, 13.547, 0, 0, 0, 1, '2017-12-14 13:11:56'),
(6, 'Bayside Helicopter Dealership', -2236.89, 2354.15, 4.98, 0, 0, 0, 2, '2018-01-18 11:44:32'),
(7, 'Verdant Meadows Aircraft Dealership', 414.868, 2535.28, 19.1484, 0, 0, 0, 2, '2018-01-18 11:50:10'),
(8, 'Dviraèiø ir motociklø salonas', 1994.48, -1282.7, 23.9712, 0, 0, 0, 2, '2018-03-15 08:28:52');

-- --------------------------------------------------------

--
-- Table structure for table `sell_salons_spawns`
--

CREATE TABLE IF NOT EXISTS `sell_salons_spawns` (
`id` int(11) NOT NULL,
  `SalonId` int(11) NOT NULL,
  `X` float NOT NULL DEFAULT '0',
  `Y` float NOT NULL DEFAULT '0',
  `Z` float NOT NULL DEFAULT '0',
  `A` float NOT NULL DEFAULT '0',
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `sell_salons_spawns`
--

INSERT INTO `sell_salons_spawns` (`id`, `SalonId`, `X`, `Y`, `Z`, `A`, `Added`, `Date`) VALUES
(1, 1, 524.958, -1283.75, 17.2422, 166.593, 4, '2017-12-09 18:07:24'),
(2, 1, 531.974, -1278.32, 17.242, 224.654, 4, '2017-12-09 18:07:49'),
(3, 1, 536.106, -1274.68, 17.242, 224.654, 4, '2017-12-09 18:07:59'),
(13, 3, 731.083, -1499.03, -0.593, 181.824, 2, '2017-12-12 14:42:50'),
(14, 3, 722.319, -1504.02, -0.639, 227.109, 2, '2017-12-12 14:43:08'),
(15, 4, 2333.14, -2070.82, 13.554, 91.427, 184, '2017-12-12 20:37:27'),
(16, 4, 2334.73, -2088.65, 13.547, 91.672, 184, '2017-12-12 20:37:43'),
(17, 4, 2323.22, -2068.82, 13.547, 175.904, 184, '2017-12-12 20:38:16'),
(26, 5, 1032.03, -1584.1, 13.547, 113.162, 1, '2017-12-14 13:12:03'),
(27, 5, 1025.34, -1566.76, 13.564, 113.162, 1, '2017-12-14 13:12:08'),
(28, 5, 1011.9, -1566.32, 13.663, 113.162, 1, '2017-12-14 13:12:10'),
(29, 5, 983.724, -1591.45, 13.512, 113.162, 1, '2017-12-14 13:12:14'),
(31, 2, 2160.76, -1143.81, 24.834, 87.725, 2, '2017-12-15 14:05:34'),
(32, 2, 2160.96, -1148.51, 24.354, 89.566, 2, '2017-12-15 14:05:55'),
(33, 2, 2160.82, -1153.1, 23.887, 91.775, 2, '2017-12-15 14:06:05'),
(34, 2, 2160.64, -1158.18, 23.838, 92.634, 2, '2017-12-15 14:06:15'),
(35, 2, 2149.48, -1147.96, 24.445, 271.249, 2, '2017-12-15 14:06:29'),
(36, 2, 2149.35, -1152.95, 23.9, 269.776, 2, '2017-12-15 14:06:39'),
(37, 2, 2149.54, -1157.49, 23.844, 269.654, 2, '2017-12-15 14:06:49'),
(38, 2, 2160.61, -1167.96, 23.82, 90.592, 12, '2017-12-18 09:06:02'),
(39, 2, 2160.36, -1172.94, 23.82, 90.715, 12, '2017-12-18 09:06:18'),
(40, 2, 2160.77, -1177.75, 23.817, 89.856, 12, '2017-12-18 09:06:31'),
(41, 2, 2160.41, -1182.86, 23.818, 88.506, 12, '2017-12-18 09:06:44'),
(42, 6, -2228.13, 2327.08, 7.547, 88.73, 2, '2018-01-18 11:48:34'),
(43, 7, 263.263, 2493.93, 16.484, 89.677, 1, '2018-01-23 18:42:27'),
(44, 7, 92.884, 2493.95, 16.484, 89.677, 1, '2018-01-23 18:42:36'),
(45, 7, 398.494, 2493.97, 16.484, 89.677, 1, '2018-01-23 18:42:44'),
(46, 8, 1993.64, -1274.32, 23.82, 179.119, 2, '2018-03-15 08:40:11'),
(47, 8, 1996.35, -1274.63, 23.82, 182.678, 2, '2018-03-15 08:40:21'),
(48, 8, 1999.36, -1274.62, 23.82, 179.242, 2, '2018-03-15 08:40:31'),
(49, 8, 2002.36, -1274.28, 23.82, 179.732, 2, '2018-03-15 08:40:46'),
(50, 8, 2005.33, -1274.82, 23.82, 178.505, 2, '2018-03-15 08:40:59');

-- --------------------------------------------------------

--
-- Table structure for table `sell_vehicles`
--

CREATE TABLE IF NOT EXISTS `sell_vehicles` (
`id` int(11) NOT NULL,
  `SalonId` int(11) NOT NULL,
  `Model` int(11) NOT NULL DEFAULT '400',
  `Price` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Donator` tinyint(4) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8 COLLATE=utf8_lithuanian_ci;

--
-- Dumping data for table `sell_vehicles`
--

INSERT INTO `sell_vehicles` (`id`, `SalonId`, `Model`, `Price`, `Added`, `Date`, `Donator`) VALUES
(4, 1, 475, 193000, 4, '2017-12-09 18:14:59', 0),
(5, 1, 496, 124000, 4, '2017-12-09 18:19:06', 0),
(7, 1, 558, 176000, 4, '2017-12-09 18:19:41', 0),
(8, 1, 559, 171000, 4, '2017-12-09 18:19:55', 0),
(9, 1, 565, 133000, 4, '2017-12-09 18:20:20', 0),
(10, 1, 587, 178000, 4, '2017-12-09 18:20:33', 0),
(11, 1, 589, 100000, 4, '2017-12-09 18:20:47', 0),
(12, 1, 602, 189000, 4, '2017-12-09 18:20:59', 0),
(13, 1, 603, 240000, 4, '2017-12-09 18:21:14', 0),
(15, 2, 420, 20000, 4, '2017-12-09 18:27:19', 0),
(16, 2, 431, 40000, 4, '2017-12-09 18:27:43', 0),
(17, 2, 437, 55000, 4, '2017-12-09 18:27:56', 0),
(18, 2, 438, 20000, 4, '2017-12-09 18:28:07', 0),
(19, 2, 400, 110000, 4, '2017-12-09 20:27:23', 0),
(20, 2, 489, 140000, 4, '2017-12-09 20:27:43', 0),
(21, 2, 500, 127000, 4, '2017-12-09 20:27:59', 0),
(22, 2, 579, 236000, 4, '2017-12-09 20:28:29', 0),
(23, 2, 401, 15000, 4, '2017-12-09 20:28:47', 0),
(24, 2, 405, 83000, 4, '2017-12-09 20:32:16', 0),
(25, 2, 410, 14000, 4, '2017-12-09 20:32:34', 0),
(26, 2, 419, 36500, 4, '2017-12-09 20:32:52', 0),
(27, 2, 421, 87600, 4, '2017-12-09 20:33:07', 0),
(29, 2, 436, 11000, 4, '2017-12-09 20:33:40', 0),
(30, 2, 445, 71500, 4, '2017-12-09 20:34:04', 0),
(31, 2, 466, 34000, 4, '2017-12-09 20:34:17', 0),
(32, 2, 467, 30000, 4, '2017-12-09 20:34:33', 0),
(33, 2, 474, 40000, 4, '2017-12-09 20:34:55', 0),
(34, 2, 491, 16000, 4, '2017-12-09 20:35:09', 0),
(35, 2, 492, 49200, 4, '2017-12-09 20:35:26', 0),
(36, 2, 507, 84000, 4, '2017-12-09 20:35:39', 0),
(37, 2, 516, 20000, 4, '2017-12-09 20:36:02', 0),
(38, 2, 517, 21000, 4, '2017-12-09 20:36:50', 0),
(39, 2, 518, 13000, 4, '2017-12-09 20:37:13', 0),
(40, 2, 526, 16000, 4, '2017-12-09 20:37:31', 0),
(41, 2, 527, 17600, 4, '2017-12-09 20:37:51', 0),
(42, 2, 540, 62500, 4, '2017-12-09 20:38:06', 0),
(43, 2, 542, 8000, 4, '2017-12-09 20:38:30', 0),
(44, 2, 546, 20000, 4, '2017-12-09 20:38:44', 0),
(45, 2, 547, 15000, 4, '2017-12-09 20:38:59', 0),
(46, 2, 549, 6000, 4, '2017-12-09 20:39:23', 0),
(47, 2, 550, 67400, 4, '2017-12-09 20:39:46', 0),
(48, 2, 551, 91300, 4, '2017-12-09 20:40:05', 0),
(51, 2, 580, 121000, 4, '2017-12-09 20:41:31', 0),
(52, 2, 585, 17000, 4, '2017-12-09 20:41:43', 0),
(61, 2, 412, 33000, 4, '2017-12-09 20:44:23', 0),
(62, 2, 439, 61300, 4, '2017-12-09 20:44:36', 0),
(63, 2, 534, 43000, 4, '2017-12-09 20:44:49', 0),
(65, 2, 536, 36000, 4, '2017-12-09 20:45:38', 0),
(66, 2, 566, 52900, 4, '2017-12-09 20:45:55', 0),
(67, 2, 567, 45000, 4, '2017-12-09 20:46:06', 0),
(68, 2, 575, 55000, 4, '2017-12-09 20:46:20', 0),
(69, 2, 576, 48000, 4, '2017-12-09 20:46:32', 0),
(70, 2, 482, 21000, 10, '2017-12-10 19:12:25', 0),
(71, 2, 413, 19000, 10, '2017-12-10 19:12:59', 0),
(72, 3, 446, 410000, 2, '2017-12-12 14:45:41', 0),
(73, 3, 452, 290000, 2, '2017-12-12 14:46:02', 0),
(74, 3, 453, 200000, 2, '2017-12-12 14:46:31', 0),
(75, 3, 454, 230000, 2, '2017-12-12 14:46:53', 0),
(76, 3, 473, 32500, 2, '2017-12-12 14:47:33', 0),
(77, 4, 408, 28000, 184, '2017-12-12 20:39:11', 0),
(78, 4, 414, 35000, 184, '2017-12-12 20:39:30', 0),
(79, 4, 423, 23000, 184, '2017-12-12 20:39:48', 0),
(80, 4, 455, 37000, 184, '2017-12-12 20:40:10', 0),
(81, 4, 456, 23000, 184, '2017-12-12 20:40:20', 0),
(82, 4, 498, 20000, 184, '2017-12-12 20:40:42', 0),
(83, 4, 499, 19000, 184, '2017-12-12 20:40:50', 0),
(84, 4, 524, 36000, 184, '2017-12-12 20:41:03', 0),
(85, 4, 552, 16000, 184, '2017-12-12 20:41:20', 0),
(86, 4, 573, 30000, 184, '2017-12-12 20:41:33', 0),
(87, 4, 578, 30000, 184, '2017-12-12 20:41:43', 0),
(88, 4, 588, 23000, 184, '2017-12-12 20:41:55', 0),
(89, 2, 418, 27000, 10, '2017-12-13 23:05:02', 0),
(90, 5, 477, 130000, 1, '2017-12-14 13:14:56', 1),
(91, 5, 468, 20000, 1, '2017-12-14 13:15:20', 1),
(92, 5, 535, 60000, 1, '2017-12-14 13:15:31', 1),
(93, 5, 562, 480000, 1, '2017-12-14 13:17:23', 2),
(95, 2, 561, 23000, 10, '2017-12-20 18:22:36', 0),
(96, 2, 458, 19000, 10, '2017-12-20 18:23:23', 0),
(97, 5, 560, 580000, 2, '2017-12-24 09:55:11', 2),
(98, 2, 554, 48000, 10, '2017-12-26 12:54:24', 0),
(99, 2, 479, 20000, 2, '2017-12-27 09:07:12', 0),
(100, 2, 533, 93600, 2, '2017-12-27 09:08:04', 0),
(101, 2, 555, 62000, 2, '2017-12-27 09:08:32', 0),
(102, 5, 429, 545000, 2, '2017-12-29 15:30:33', 3),
(104, 5, 541, 600000, 2, '2017-12-29 15:31:36', 3),
(105, 5, 402, 560000, 2, '2017-12-29 15:33:36', 3),
(106, 5, 415, 600000, 2, '2017-12-29 15:33:48', 3),
(107, 4, 403, 80000, 1, '2017-12-30 23:34:06', 0),
(108, 4, 514, 60000, 1, '2017-12-30 23:34:25', 0),
(109, 4, 515, 70000, 1, '2017-12-30 23:34:38', 0),
(113, 6, 487, 900000, 2, '2018-01-18 11:46:11', 0),
(114, 6, 417, 1100000, 2, '2018-01-18 11:46:34', 0),
(115, 7, 519, 9000000, 2, '2018-01-18 11:51:34', 0),
(116, 7, 593, 1700000, 2, '2018-01-18 11:51:42', 0),
(117, 7, 511, 2500000, 2, '2018-01-18 11:51:57', 0),
(118, 7, 553, 12000000, 2, '2018-01-18 11:53:18', 0),
(123, 2, 529, 20000, 2, '2018-02-16 12:41:55', 0),
(124, 4, 574, 15000, 2, '2018-02-17 12:27:11', 0),
(125, 2, 409, 500000, 184, '2018-02-19 17:38:50', 0),
(126, 8, 461, 48000, 2, '2018-03-15 08:30:02', 0),
(127, 8, 462, 3500, 2, '2018-03-15 08:30:10', 0),
(128, 8, 463, 32000, 2, '2018-03-15 08:30:20', 0),
(129, 8, 481, 900, 2, '2018-03-15 08:30:33', 0),
(130, 8, 509, 900, 2, '2018-03-15 08:30:44', 0),
(131, 8, 521, 56000, 2, '2018-03-15 08:30:58', 0),
(132, 8, 581, 60000, 2, '2018-03-15 08:31:23', 0),
(133, 8, 586, 34000, 2, '2018-03-15 08:31:34', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sell_vehicles_dealers`
--

CREATE TABLE IF NOT EXISTS `sell_vehicles_dealers` (
`id` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `DealerType` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sell_vehicles_factions`
--

CREATE TABLE IF NOT EXISTS `sell_vehicles_factions` (
`id` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `FactionType` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sell_vehicles_factions`
--

INSERT INTO `sell_vehicles_factions` (`id`, `Model`, `Price`, `FactionType`, `Added`, `Date`) VALUES
(1, 596, 10000, 1, 12, '2017-12-11 18:39:08'),
(2, 601, 18000, 1, 12, '2017-12-11 18:42:08'),
(3, 528, 17000, 1, 12, '2017-12-11 18:42:37'),
(4, 497, 30000, 1, 12, '2017-12-11 18:43:09'),
(5, 490, 15000, 1, 12, '2017-12-11 18:43:36'),
(6, 525, 8000, 1, 12, '2017-12-11 18:44:55'),
(7, 416, 10000, 2, 12, '2017-12-11 18:45:36'),
(8, 563, 20000, 2, 12, '2017-12-11 18:46:16'),
(9, 490, 15000, 2, 12, '2017-12-11 18:47:43'),
(10, 488, 30000, 6, 12, '2017-12-11 18:48:16'),
(11, 582, 10000, 6, 12, '2017-12-11 18:49:03'),
(12, 552, 7000, 1, 12, '2017-12-11 18:49:31'),
(14, 560, 65000, 1, 12, '2017-12-11 18:51:01'),
(15, 405, 12000, 1, 184, '2017-12-14 20:12:41'),
(16, 426, 14000, 1, 184, '2017-12-14 20:13:00'),
(17, 445, 15000, 1, 184, '2017-12-14 20:13:20'),
(18, 472, 15000, 1, 184, '2017-12-14 20:13:48'),
(19, 473, 9000, 1, 184, '2017-12-14 20:14:06'),
(20, 599, 12000, 1, 184, '2017-12-14 20:15:05'),
(21, 405, 12000, 3, 184, '2017-12-14 20:16:21'),
(22, 426, 14000, 3, 184, '2017-12-14 20:16:36'),
(23, 505, 13000, 3, 184, '2017-12-14 20:17:03'),
(24, 427, 18000, 1, 184, '2017-12-14 20:17:39'),
(25, 428, 18000, 1, 184, '2017-12-14 20:17:52'),
(26, 421, 13000, 3, 184, '2017-12-14 20:18:22'),
(27, 487, 30000, 2, 184, '2017-12-14 20:19:56'),
(28, 453, 23000, 2, 184, '2017-12-14 20:20:29'),
(29, 473, 9000, 2, 184, '2017-12-14 20:20:48'),
(30, 407, 10000, 2, 184, '2017-12-14 20:21:12'),
(31, 523, 10000, 1, 184, '2017-12-14 20:21:40'),
(32, 419, 9000, 1, 2, '2017-12-16 18:46:56'),
(33, 491, 12000, 1, 2, '2017-12-16 18:47:20'),
(34, 517, 20000, 1, 2, '2017-12-16 18:47:33'),
(35, 566, 35000, 1, 2, '2017-12-16 18:47:45'),
(36, 597, 20000, 1, 2, '2017-12-16 18:49:08'),
(37, 482, 20000, 1, 1, '2017-12-17 15:44:49'),
(38, 406, 18000, 3, 2, '2017-12-21 17:04:35'),
(39, 408, 16000, 3, 2, '2017-12-21 17:04:54'),
(40, 431, 20000, 3, 2, '2017-12-21 17:05:07'),
(41, 455, 15000, 3, 2, '2017-12-21 17:05:19'),
(42, 437, 20000, 3, 2, '2017-12-21 17:05:33'),
(43, 486, 25000, 3, 2, '2017-12-21 17:05:44'),
(44, 524, 18000, 3, 2, '2017-12-21 17:05:54'),
(45, 525, 9000, 3, 2, '2017-12-21 17:06:05'),
(46, 552, 9000, 3, 2, '2017-12-21 17:06:16'),
(47, 574, 5000, 3, 2, '2017-12-21 17:06:28'),
(48, 578, 19000, 3, 2, '2017-12-21 17:06:38'),
(50, 554, 20000, 3, 2, '2017-12-21 17:35:32'),
(51, 402, 120000, 1, 2, '2017-12-28 12:49:43'),
(52, 415, 120000, 1, 2, '2017-12-28 13:03:07'),
(53, 579, 80000, 1, 135, '2018-01-05 11:26:45'),
(54, 580, 50000, 1, 2, '2018-01-16 18:17:36'),
(55, 541, 120000, 1, 2, '2018-01-25 21:00:46'),
(56, 521, 0, 1, 2, '2018-01-25 21:01:40'),
(57, 430, 25000, 1, 2, '2018-01-26 12:45:04'),
(58, 507, 14000, 6, 2, '2018-02-10 22:10:55'),
(59, 409, 500000, 4, 2, '2018-02-22 17:56:33'),
(60, 445, 60000, 4, 2, '2018-02-22 17:57:54'),
(61, 579, 160000, 4, 2, '2018-02-22 17:58:14'),
(62, 405, 75000, 4, 157, '2018-03-04 14:43:11'),
(63, 507, 84000, 4, 157, '2018-03-04 14:50:05'),
(64, 550, 66000, 4, 157, '2018-03-04 14:50:27'),
(65, 580, 120000, 4, 157, '2018-03-04 14:50:47'),
(66, 560, 540000, 4, 157, '2018-03-04 14:51:11'),
(67, 487, 900000, 4, 157, '2018-03-04 14:51:25');

-- --------------------------------------------------------

--
-- Table structure for table `server_whitelist`
--

CREATE TABLE IF NOT EXISTS `server_whitelist` (
`id` int(11) NOT NULL,
  `Name` varchar(24) NOT NULL,
  `IP` varchar(24) NOT NULL,
  `Comment` text NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users_data`
--

CREATE TABLE IF NOT EXISTS `users_data` (
`id` int(10) unsigned NOT NULL,
  `Name` varchar(21) NOT NULL,
  `Password` varchar(130) NOT NULL,
  `Salt` varchar(30) NOT NULL,
  `RegisterIp` varchar(19) NOT NULL,
  `RegisterDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Donator` int(11) NOT NULL,
  `DonatorTime` int(11) NOT NULL,
  `NameChanges` int(11) NOT NULL,
  `NumberChanges` int(11) NOT NULL,
  `PlateChanges` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users_safe_questions`
--

CREATE TABLE IF NOT EXISTS `users_safe_questions` (
`id` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  `Question` varchar(128) NOT NULL,
  `Answer` varchar(130) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_arrested`
--

CREATE TABLE IF NOT EXISTS `vehicles_arrested` (
`id` int(11) NOT NULL,
  `VehicleId` int(11) NOT NULL,
  `OfficerName` varchar(24) NOT NULL,
  `UnarrestedBy` varchar(24) NOT NULL,
  `Valid` tinyint(4) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_crimes`
--

CREATE TABLE IF NOT EXISTS `vehicles_crimes` (
`id` int(11) NOT NULL,
  `VehicleId` int(11) NOT NULL,
  `OfficerName` varchar(24) NOT NULL,
  `Reason` varchar(256) NOT NULL,
  `Money` int(11) NOT NULL,
  `Valid` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_data`
--

CREATE TABLE IF NOT EXISTS `vehicles_data` (
`id` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `Owner` int(11) NOT NULL,
  `Name` varchar(32) NOT NULL,
  `Insurance` smallint(11) NOT NULL,
  `Lock` tinyint(11) NOT NULL,
  `EngineStatus` float NOT NULL DEFAULT '100',
  `BatteryStatus` float NOT NULL DEFAULT '100',
  `Numbers` varchar(23) NOT NULL DEFAULT ' ',
  `KM` float NOT NULL,
  `Fuel` float NOT NULL,
  `Color1` mediumint(11) NOT NULL,
  `Color2` mediumint(11) NOT NULL,
  `SpawnedId` mediumint(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  `Damage` varchar(50) NOT NULL DEFAULT '0/0/0/0/1000/',
  `Price` int(11) NOT NULL,
  `Locked` tinyint(1) NOT NULL DEFAULT '1',
  `Salon` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DonatorRequirement` tinyint(4) NOT NULL,
  `Component0` mediumint(11) NOT NULL,
  `Component1` mediumint(11) NOT NULL,
  `Component2` mediumint(11) NOT NULL,
  `Component3` mediumint(11) NOT NULL,
  `Component4` mediumint(11) NOT NULL,
  `Component5` mediumint(11) NOT NULL,
  `Component6` mediumint(11) NOT NULL,
  `Component7` mediumint(11) NOT NULL,
  `Component8` mediumint(11) NOT NULL,
  `Component9` mediumint(11) NOT NULL,
  `Component10` mediumint(11) NOT NULL,
  `Component11` mediumint(11) NOT NULL,
  `Component12` mediumint(11) NOT NULL,
  `Component13` mediumint(11) NOT NULL,
  `VW` mediumint(9) NOT NULL,
  `Interior` mediumint(9) NOT NULL,
  `Dealer` tinyint(1) NOT NULL DEFAULT '0',
  `Ticket` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_dubkeys`
--

CREATE TABLE IF NOT EXISTS `vehicles_dubkeys` (
`id` int(11) NOT NULL,
  `VehicleId` int(11) NOT NULL,
  `PlayerId` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valid` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_inventory`
--

CREATE TABLE IF NOT EXISTS `vehicles_inventory` (
`id` int(11) NOT NULL,
  `VehicleId` int(11) NOT NULL,
  `Packed` varchar(356) NOT NULL DEFAULT '0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|',
  `Updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `vehicles_server`
--

CREATE TABLE IF NOT EXISTS `vehicles_server` (
`id` int(11) NOT NULL,
  `Model` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `A` float NOT NULL,
  `JobId` int(11) NOT NULL,
  `FactionId` int(11) NOT NULL,
  `RequiredLevel` int(11) NOT NULL DEFAULT '1',
  `Color1` int(11) NOT NULL,
  `Color2` int(11) NOT NULL,
  `AddSiren` int(11) NOT NULL,
  `Added` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AddedType` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Unit` varchar(128) NOT NULL,
  `KM` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `wares_available`
--

CREATE TABLE IF NOT EXISTS `wares_available` (
`id` int(11) NOT NULL,
  `ItemId` int(11) NOT NULL,
  `Amount` int(11) NOT NULL,
  `MinPrice` mediumint(9) NOT NULL DEFAULT '1',
  `MaxPrice` mediumint(9) NOT NULL DEFAULT '500',
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=228 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `wares_available`
--

INSERT INTO `wares_available` (`id`, `ItemId`, `Amount`, `MinPrice`, `MaxPrice`, `Date`) VALUES
(209, 51, 20, 5, 15, '2018-01-24 17:47:04'),
(210, 50, 1, 5, 100, '2018-01-24 17:47:04'),
(211, 52, 20, 2, 5, '2018-01-24 17:47:04'),
(212, 53, 1, 20, 50, '2018-01-24 17:47:04'),
(213, 60, 1, 1, 2, '2018-01-24 17:47:04'),
(214, 63, 1, 1, 3, '2018-01-24 17:47:04'),
(215, 64, 1, 3, 5, '2018-01-24 17:47:04'),
(216, 65, 1, 2, 4, '2018-01-24 17:47:04'),
(217, 67, 1, 2, 4, '2018-01-24 17:47:04'),
(218, 68, 1, 2, 4, '2018-01-24 17:47:04'),
(219, 69, 1, 20, 30, '2018-01-24 17:47:04'),
(220, 70, 1, 40, 80, '2018-01-24 17:47:04'),
(221, 71, 1, 50, 150, '2018-01-24 17:47:04'),
(222, 72, 1, 5, 50, '2018-01-24 17:47:04'),
(223, 73, 20, 5, 50, '2018-01-24 17:47:04'),
(224, 43, 40, 20, 50, '2018-01-24 17:47:04'),
(225, 75, 1, 50, 100, '2018-01-24 17:47:04'),
(226, 76, 1, 600, 1000, '2018-01-24 17:47:04'),
(227, 62, 1, 5, 50, '2018-01-24 17:47:04');

-- --------------------------------------------------------

--
-- Table structure for table `weapons_crimes`
--

CREATE TABLE IF NOT EXISTS `weapons_crimes` (
  `id` int(11) NOT NULL,
  `WeaponId` int(11) NOT NULL,
  `OfficerName` varchar(24) NOT NULL,
  `Reason` varchar(256) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Valid` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `weapons_data`
--

CREATE TABLE IF NOT EXISTS `weapons_data` (
`id` int(11) NOT NULL,
  `WeaponModel` int(11) NOT NULL,
  `GiveAmmo` int(11) NOT NULL,
  `GiveType` int(11) NOT NULL,
  `Date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `atms`
--
ALTER TABLE `atms`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `business_data`
--
ALTER TABLE `business_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_dubkeys`
--
ALTER TABLE `business_dubkeys`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_furniture`
--
ALTER TABLE `business_furniture`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_inventory`
--
ALTER TABLE `business_inventory`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`);

--
-- Indexes for table `business_orders`
--
ALTER TABLE `business_orders`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_orders_fuel`
--
ALTER TABLE `business_orders_fuel`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `business_wares`
--
ALTER TABLE `business_wares`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `BusinessId` (`BusinessId`);

--
-- Indexes for table `dealers_data`
--
ALTER TABLE `dealers_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_drugs_lists`
--
ALTER TABLE `dealers_drugs_lists`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_drugs_orders`
--
ALTER TABLE `dealers_drugs_orders`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_drugs_spawns`
--
ALTER TABLE `dealers_drugs_spawns`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_guns_lists`
--
ALTER TABLE `dealers_guns_lists`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_guns_orders`
--
ALTER TABLE `dealers_guns_orders`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_guns_spawns`
--
ALTER TABLE `dealers_guns_spawns`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_houses_data`
--
ALTER TABLE `dealers_houses_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dealers_houses_inventory`
--
ALTER TABLE `dealers_houses_inventory`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `donations`
--
ALTER TABLE `donations`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `drops_data`
--
ALTER TABLE `drops_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `enters_exits`
--
ALTER TABLE `enters_exits`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factions_data`
--
ALTER TABLE `factions_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factions_ranks`
--
ALTER TABLE `factions_ranks`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factions_wepstore`
--
ALTER TABLE `factions_wepstore`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `garages_data`
--
ALTER TABLE `garages_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `garages_furniture`
--
ALTER TABLE `garages_furniture`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gifts`
--
ALTER TABLE `gifts`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `graffiti`
--
ALTER TABLE `graffiti`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups_commands`
--
ALTER TABLE `groups_commands`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `groups_data`
--
ALTER TABLE `groups_data`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `Name` (`Name`);

--
-- Indexes for table `groups_permissions`
--
ALTER TABLE `groups_permissions`
 ADD PRIMARY KEY (`id`), ADD KEY `GroupId` (`GroupId`);

--
-- Indexes for table `groups_permissions_list`
--
ALTER TABLE `groups_permissions_list`
 ADD UNIQUE KEY `Permission` (`Permission`);

--
-- Indexes for table `houses_data`
--
ALTER TABLE `houses_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses_dubkeys`
--
ALTER TABLE `houses_dubkeys`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses_furniture`
--
ALTER TABLE `houses_furniture`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses_inventory`
--
ALTER TABLE `houses_inventory`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `interiors`
--
ALTER TABLE `interiors`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `map_icons`
--
ALTER TABLE `map_icons`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `parkings_data`
--
ALTER TABLE `parkings_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payphones_data`
--
ALTER TABLE `payphones_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_bank_history`
--
ALTER TABLE `players_bank_history`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_bans`
--
ALTER TABLE `players_bans`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_clothes`
--
ALTER TABLE `players_clothes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_clothes_attached`
--
ALTER TABLE `players_clothes_attached`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_config`
--
ALTER TABLE `players_config`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_contacts`
--
ALTER TABLE `players_contacts`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_crimes`
--
ALTER TABLE `players_crimes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_data`
--
ALTER TABLE `players_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_drugs`
--
ALTER TABLE `players_drugs`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_inventory`
--
ALTER TABLE `players_inventory`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_jails`
--
ALTER TABLE `players_jails`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_locks`
--
ALTER TABLE `players_locks`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_login_notes`
--
ALTER TABLE `players_login_notes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_new`
--
ALTER TABLE `players_new`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_reports`
--
ALTER TABLE `players_reports`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_settings`
--
ALTER TABLE `players_settings`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_sms`
--
ALTER TABLE `players_sms`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_wanted`
--
ALTER TABLE `players_wanted`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_warns`
--
ALTER TABLE `players_warns`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players_weapons`
--
ALTER TABLE `players_weapons`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `san_news_sms`
--
ALTER TABLE `san_news_sms`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sell_salons`
--
ALTER TABLE `sell_salons`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sell_salons_spawns`
--
ALTER TABLE `sell_salons_spawns`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sell_vehicles`
--
ALTER TABLE `sell_vehicles`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sell_vehicles_dealers`
--
ALTER TABLE `sell_vehicles_dealers`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sell_vehicles_factions`
--
ALTER TABLE `sell_vehicles_factions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `server_whitelist`
--
ALTER TABLE `server_whitelist`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_data`
--
ALTER TABLE `users_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users_safe_questions`
--
ALTER TABLE `users_safe_questions`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles_arrested`
--
ALTER TABLE `vehicles_arrested`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles_crimes`
--
ALTER TABLE `vehicles_crimes`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles_data`
--
ALTER TABLE `vehicles_data`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles_dubkeys`
--
ALTER TABLE `vehicles_dubkeys`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `id` (`id`), ADD KEY `id_2` (`id`);

--
-- Indexes for table `vehicles_inventory`
--
ALTER TABLE `vehicles_inventory`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vehicles_server`
--
ALTER TABLE `vehicles_server`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wares_available`
--
ALTER TABLE `wares_available`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `weapons_data`
--
ALTER TABLE `weapons_data`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `atms`
--
ALTER TABLE `atms`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business_data`
--
ALTER TABLE `business_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business_dubkeys`
--
ALTER TABLE `business_dubkeys`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business_furniture`
--
ALTER TABLE `business_furniture`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business_inventory`
--
ALTER TABLE `business_inventory`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business_orders`
--
ALTER TABLE `business_orders`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business_orders_fuel`
--
ALTER TABLE `business_orders_fuel`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `business_wares`
--
ALTER TABLE `business_wares`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_data`
--
ALTER TABLE `dealers_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_drugs_lists`
--
ALTER TABLE `dealers_drugs_lists`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_drugs_orders`
--
ALTER TABLE `dealers_drugs_orders`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_drugs_spawns`
--
ALTER TABLE `dealers_drugs_spawns`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_guns_lists`
--
ALTER TABLE `dealers_guns_lists`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_guns_orders`
--
ALTER TABLE `dealers_guns_orders`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_guns_spawns`
--
ALTER TABLE `dealers_guns_spawns`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_houses_data`
--
ALTER TABLE `dealers_houses_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `dealers_houses_inventory`
--
ALTER TABLE `dealers_houses_inventory`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `donations`
--
ALTER TABLE `donations`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `drops_data`
--
ALTER TABLE `drops_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `enters_exits`
--
ALTER TABLE `enters_exits`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=82;
--
-- AUTO_INCREMENT for table `factions_data`
--
ALTER TABLE `factions_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `factions_ranks`
--
ALTER TABLE `factions_ranks`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=77;
--
-- AUTO_INCREMENT for table `factions_wepstore`
--
ALTER TABLE `factions_wepstore`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `garages_data`
--
ALTER TABLE `garages_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `garages_furniture`
--
ALTER TABLE `garages_furniture`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `gifts`
--
ALTER TABLE `gifts`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `graffiti`
--
ALTER TABLE `graffiti`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `groups_commands`
--
ALTER TABLE `groups_commands`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=785;
--
-- AUTO_INCREMENT for table `groups_data`
--
ALTER TABLE `groups_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `groups_permissions`
--
ALTER TABLE `groups_permissions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=754;
--
-- AUTO_INCREMENT for table `houses_data`
--
ALTER TABLE `houses_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `houses_dubkeys`
--
ALTER TABLE `houses_dubkeys`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `houses_furniture`
--
ALTER TABLE `houses_furniture`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `houses_inventory`
--
ALTER TABLE `houses_inventory`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `interiors`
--
ALTER TABLE `interiors`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `map_icons`
--
ALTER TABLE `map_icons`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=108;
--
-- AUTO_INCREMENT for table `parkings_data`
--
ALTER TABLE `parkings_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `payphones_data`
--
ALTER TABLE `payphones_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_bank_history`
--
ALTER TABLE `players_bank_history`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_bans`
--
ALTER TABLE `players_bans`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_clothes`
--
ALTER TABLE `players_clothes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_clothes_attached`
--
ALTER TABLE `players_clothes_attached`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_config`
--
ALTER TABLE `players_config`
MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_contacts`
--
ALTER TABLE `players_contacts`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_crimes`
--
ALTER TABLE `players_crimes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_data`
--
ALTER TABLE `players_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_drugs`
--
ALTER TABLE `players_drugs`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_inventory`
--
ALTER TABLE `players_inventory`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_jails`
--
ALTER TABLE `players_jails`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_locks`
--
ALTER TABLE `players_locks`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_login_notes`
--
ALTER TABLE `players_login_notes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_new`
--
ALTER TABLE `players_new`
MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_reports`
--
ALTER TABLE `players_reports`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_settings`
--
ALTER TABLE `players_settings`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_sms`
--
ALTER TABLE `players_sms`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_wanted`
--
ALTER TABLE `players_wanted`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_warns`
--
ALTER TABLE `players_warns`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players_weapons`
--
ALTER TABLE `players_weapons`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `san_news_sms`
--
ALTER TABLE `san_news_sms`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sell_salons`
--
ALTER TABLE `sell_salons`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `sell_salons_spawns`
--
ALTER TABLE `sell_salons_spawns`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `sell_vehicles`
--
ALTER TABLE `sell_vehicles`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=134;
--
-- AUTO_INCREMENT for table `sell_vehicles_dealers`
--
ALTER TABLE `sell_vehicles_dealers`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `sell_vehicles_factions`
--
ALTER TABLE `sell_vehicles_factions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT for table `server_whitelist`
--
ALTER TABLE `server_whitelist`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users_data`
--
ALTER TABLE `users_data`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users_safe_questions`
--
ALTER TABLE `users_safe_questions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vehicles_arrested`
--
ALTER TABLE `vehicles_arrested`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vehicles_crimes`
--
ALTER TABLE `vehicles_crimes`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vehicles_data`
--
ALTER TABLE `vehicles_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vehicles_dubkeys`
--
ALTER TABLE `vehicles_dubkeys`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vehicles_inventory`
--
ALTER TABLE `vehicles_inventory`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `vehicles_server`
--
ALTER TABLE `vehicles_server`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wares_available`
--
ALTER TABLE `wares_available`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=228;
--
-- AUTO_INCREMENT for table `weapons_data`
--
ALTER TABLE `weapons_data`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
