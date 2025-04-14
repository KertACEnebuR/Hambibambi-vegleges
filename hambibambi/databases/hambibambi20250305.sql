-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2025. Már 11. 19:32
-- Kiszolgáló verziója: 10.4.27-MariaDB
-- PHP verzió: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `hambibambi`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `admin`
--

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `baskets`
--

CREATE TABLE `baskets` (
  `basket_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `payment_id` int(11) DEFAULT NULL,
  `order_status_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `delivery_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `counties`
--

CREATE TABLE `counties` (
  `county_id` int(11) NOT NULL,
  `county_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `counties`
--

INSERT INTO `counties` (`county_id`, `county_name`) VALUES
(1, 'Nógrád'),
(2, 'Heves'),
(3, 'Pest'),
(4, 'Komárom-Esztergom');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `basket_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `order_statuses`
--

CREATE TABLE `order_statuses` (
  `order_status_id` int(11) NOT NULL,
  `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `order_statuses`
--

INSERT INTO `order_statuses` (`order_status_id`, `status`) VALUES
(1, 'felvéve'),
(2, 'készítés alatt'),
(3, 'szállítás alatt'),
(4, 'kiszállítva');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `payment_method` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `payments`
--

INSERT INTO `payments` (`payment_id`, `payment_method`) VALUES
(1, 'készpénz'),
(2, 'bankkártya'),
(3, 'SZÉP-kártya');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_category_id` int(11) DEFAULT NULL,
  `quantity_unit_id` int(11) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `products`
--

INSERT INTO `products` (`product_id`, `product_category_id`, `quantity_unit_id`, `product_name`, `price`, `description`, `picture`) VALUES
(39, 1, 2, 'Cézár saláta', 2500, 'Grillezett csirkemell, római saláta, parmezán, kruton, Cézár öntet', 'cezar_salata.jpg'),
(40, 1, 2, 'Görög saláta', 2300, 'Paradicsom, uborka, feta sajt, olívabogyó, lilahagyma, olívaolaj', 'gorog_salata.jpg'),
(41, 1, 2, 'Tonhal saláta', 2600, 'Tonhal, saláta, kukorica, lilahagyma, paradicsom, olívaolaj', 'tonhal_salata.jpg'),
(42, 2, 2, 'Gulyásleves', 2200, 'Marhahús, burgonya, répa, csipetke, pirospaprika', 'gulyasleves.jpg'),
(43, 2, 2, 'Húsleves', 2000, 'Csirkehús, sárgarépa, zeller, petrezselyem, tészta', 'husleves.jpg'),
(44, 2, 2, 'Paradicsomleves', 1800, 'Paradicsom, bazsalikom, tejszín, pirított kenyérkocka', 'paradicsomleves.jpg'),
(45, 2, 2, 'Sajtkrémleves', 1900, 'Különböző sajtok, tejszín, fokhagyma, pirított kenyér', 'sajtkremleves.jpg'),
(46, 3, 1, 'Dupla sajtburger', 2500, 'Házi buci, marhahús, sajt, uborka, paradicsom, ketchup, mustár', 'dupla_sajtburger.jpg'),
(47, 3, 1, 'Bacon burger', 2700, 'Házi buci, marhahús, bacon, cheddar sajt, bbq szósz, lilahagyma', 'bacon_burger.jpg'),
(48, 3, 1, 'Csirkeburger', 2300, 'Házi buci, ropogós csirkemell, saláta, paradicsom, fokhagymás szósz', 'csirkeburger.jpg'),
(49, 3, 1, 'Chili burger', 2600, 'Házi buci, marhahús, jalapeno, cheddar sajt, saláta, chiliszósz', 'chili_burger.jpg'),
(50, 3, 1, 'BBQ burger', 2800, 'Házi buci, marhahús, bacon, cheddar sajt, bbq szósz, saláta', 'bbq_burger.jpg'),
(51, 3, 1, 'Gombás burger', 2500, 'Házi buci, marhahús, pirított gomba, cheddar sajt, saláta, majonéz', 'gombas_burger.jpg'),
(52, 3, 1, 'Vegetáriánus burger', 2200, 'Házi buci, grillezett zöldségek, avokádókrém, saláta', 'vega_burger.jpg'),
(53, 3, 1, 'Hawaii burger', 2700, 'Házi buci, marhahús, ananász, cheddar sajt, mézes-mustáros szósz', 'hawaii_burger.jpg'),
(54, 3, 1, 'Kéksajtos burger', 2900, 'Házi buci, marhahús, kéksajt, dió, rukkola', 'keksajtos_burger.jpg'),
(55, 3, 1, 'Pikáns csirkeburger', 2500, 'Házi buci, ropogós csirke, jalapeno, cheddar sajt, saláta', 'pikans_csirkeburger.jpg'),
(56, 3, 1, 'Mexikói burger', 2800, 'Házi buci, marhahús, babpüré, jalapeno, cheddar sajt, salsa szósz', 'mexikoi_burger.jpg'),
(57, 3, 1, 'Bivaly burger', 3000, 'Házi buci, marhahús, füstölt sajt, bacon, bbq szósz', 'bivaly_burger.jpg'),
(58, 4, 2, 'Carbonara spagetti', 2700, 'Spagetti, bacon, tojás, parmezán, tejszín', 'carbonara.jpg'),
(59, 4, 2, 'Bolognai spagetti', 2500, 'Spagetti, darált marhahús, paradicsomszósz, sajt', 'bolognai.jpg'),
(60, 4, 2, 'Pesto tészta', 2400, 'Penne, bazsalikom pesto, parmezán, fokhagyma', 'pesto_teszta.jpg'),
(61, 5, 3, 'Sör', 900, 'Hideg csapolt világos sör', 'sor.jpg'),
(62, 5, 3, 'Vörösbor', 1200, 'Száraz vörösbor, Cabernet Sauvignon', 'vorosbor.jpg'),
(63, 5, 3, 'Fehérbor', 1200, 'Száraz fehérbor, Chardonnay', 'feherbor.jpg'),
(64, 5, 3, 'Whiskey', 2500, '12 éves érlelt whiskey, jég nélkül', 'whiskey.jpg'),
(65, 6, 3, 'Cola', 800, 'Hagyományos szénsavas kóla', 'cola.jpg'),
(66, 6, 3, 'Narancslé', 1000, 'Frissen facsart narancslé', 'narancsle.jpg'),
(67, 6, 3, 'Jegeskávé', 1200, 'Presszókávé, tej, jég, vaníliaszirup', 'jegeskave.jpg'),
(68, 6, 3, 'Limonádé', 1000, 'Citrom, cukor, menta, szóda', 'limonade.jpg'),
(69, 6, 3, 'Almalé', 1000, '100% természetes almalé', 'almale.jpg'),
(70, 6, 3, 'Jeges tea', 1100, 'Házi készítésű jeges tea, citrommal', 'jegestea.jpg'),
(71, 6, 3, 'Szénsavmentes víz', 600, 'Tiszta szénsavmentes ásványvíz', 'viz.jpg'),
(72, 7, 1, 'Csokoládétorta', 2500, 'Étcsokoládé, kakaópor, tejszín, vaj', 'csokolade_torta.jpg'),
(73, 7, 1, 'Gesztenyepüré', 2200, 'Gesztenye, tejszínhab, rumaroma, cukor', 'gesztenyepure.jpg'),
(74, 7, 1, 'Almás pite', 2000, 'Alma, fahéj, cukor, leveles tészta', 'almas_pite.jpg'),
(75, 7, 1, 'Sajttorta', 2700, 'Tejszín, mascarpone, keksz alap, eperöntet', 'sajttorta.jpg'),
(76, 7, 1, 'Somlói galuska', 2500, 'Piskóta, csokoládéöntet, tejszínhab, dió', 'somloi_galuska.jpg');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product_categories`
--

CREATE TABLE `product_categories` (
  `product_category_id` int(11) NOT NULL,
  `product_group_id` int(11) DEFAULT NULL,
  `product_category_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `product_categories`
--

INSERT INTO `product_categories` (`product_category_id`, `product_group_id`, `product_category_name`) VALUES
(1, 1, 'Saláták'),
(2, 1, 'Levesek'),
(3, 2, 'Hamburgerek'),
(4, 2, 'Tészták'),
(5, 4, 'Alkoholos italok'),
(6, 4, 'Üdítők'),
(7, 3, 'Sütemények');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `product_groups`
--

CREATE TABLE `product_groups` (
  `product_group_id` int(11) NOT NULL,
  `product_group_name` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `product_groups`
--

INSERT INTO `product_groups` (`product_group_id`, `product_group_name`) VALUES
(1, 'Előételek'),
(2, 'Főételek'),
(3, 'Desszertek'),
(4, 'Italok');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `quantity_units`
--

CREATE TABLE `quantity_units` (
  `quantity_unit_id` int(11) NOT NULL,
  `quantity_unit_value` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `quantity_units`
--

INSERT INTO `quantity_units` (`quantity_unit_id`, `quantity_unit_value`) VALUES
(1, 'db'),
(2, 'adag'),
(3, 'l');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `review_value` double DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `review_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `settlements`
--

CREATE TABLE `settlements` (
  `settlement_id` int(11) NOT NULL,
  `county_id` int(11) DEFAULT NULL,
  `settlement_name` text DEFAULT NULL,
  `postcode` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- A tábla adatainak kiíratása `settlements`
--

INSERT INTO `settlements` (`settlement_id`, `county_id`, `settlement_name`, `postcode`) VALUES
(1, 1, 'Alsópetény', 16425),
(2, 1, 'Alsótold', 7621),
(3, 1, 'Balassagyarmat', 13657),
(4, 1, 'Bánk', 24341),
(5, 1, 'Bárna', 20048),
(6, 1, 'Bátonyterenye', 33534),
(7, 1, 'Bátonyterenye', 33534),
(8, 1, 'Becske', 12016),
(9, 1, 'Bér', 32911),
(10, 1, 'Bercel', 2389),
(11, 1, 'Berkenye', 9034),
(12, 1, 'Bokor', 3841),
(13, 1, 'Borsosberény', 9894),
(14, 1, 'Buják', 14234),
(15, 1, 'Cered', 3665),
(16, 1, 'Csécse', 30270),
(17, 1, 'Cserháthaláp', 21935),
(18, 1, 'Cserhátsurány', 22594),
(19, 1, 'Cserhátszentiván', 32319),
(20, 1, 'Csesztve', 20145),
(21, 1, 'Csitár', 5050),
(22, 1, 'Debercsény', 7320),
(23, 1, 'Dejtár', 12511),
(24, 1, 'Diósjenő', 6743),
(25, 1, 'Dorogháza', 24439),
(26, 1, 'Drégelypalánk', 8156),
(27, 1, 'Ecseg', 4251),
(28, 1, 'Egyházasdengeleg', 17659),
(29, 1, 'Egyházasgerge', 5980),
(30, 1, 'Endrefalva', 25496),
(31, 1, 'Erdőkürt', 22655),
(32, 1, 'Erdőtarcsa', 21795),
(33, 1, 'Érsekvadkert', 21582),
(34, 1, 'Etes', 15370),
(35, 1, 'Felsőpetény', 24323),
(36, 1, 'Felsőtold', 33312),
(37, 1, 'Galgaguta', 25663),
(38, 1, 'Garáb', 18494),
(39, 1, 'Héhalom', 3993),
(40, 1, 'Herencsény', 5324),
(41, 1, 'Hollókő', 33242),
(42, 1, 'Hont', 13204),
(43, 1, 'Horpács', 13718),
(44, 1, 'Hugyag', 16878),
(45, 1, 'Iliny', 26833),
(46, 1, 'Ipolytarnóc', 3328),
(47, 1, 'Ipolyvece', 29319),
(48, 1, 'Jobbágyi', 8712),
(49, 1, 'Kálló', 8642),
(50, 1, 'Karancsalja', 18625),
(51, 1, 'Karancsberény', 25548),
(52, 1, 'Karancskeszi', 8855),
(53, 1, 'Karancslapujtő', 21041),
(54, 1, 'Karancsság', 26897),
(55, 1, 'Kazár', 28389),
(56, 1, 'Kazár', 28389),
(57, 1, 'Keszeg', 31413),
(58, 1, 'Kétbodony', 11846),
(59, 1, 'Kisbágyon', 27243),
(60, 1, 'Kisbárkány', 26295),
(61, 1, 'Kisecset', 33206),
(62, 1, 'Kishartyán', 33400),
(63, 1, 'Kozárd', 13842),
(64, 1, 'Kutasó', 19451),
(65, 1, 'Legénd', 30395),
(66, 1, 'Litke', 4871),
(67, 1, 'Lucfalva', 20190),
(68, 1, 'Ludányhalászi', 2778),
(69, 1, 'Magyargéc', 26967),
(70, 1, 'Magyarnándor', 32407),
(71, 1, 'Márkháza', 14641),
(72, 1, 'Mátramindszent', 20075),
(73, 1, 'Mátranovák', 19372),
(74, 1, 'Mátranovák', 19372),
(75, 1, 'Mátraszele', 24332),
(76, 1, 'Mátraszőlős', 4330),
(77, 1, 'Mátraterenye', 33525),
(78, 1, 'Mátraterenye', 33525),
(79, 1, 'Mátraverebély', 30100),
(80, 1, 'Mihálygerge', 13222),
(81, 1, 'Mohora', 27915),
(82, 1, 'Nagybárkány', 16391),
(83, 1, 'Nagykeresztúr', 34281),
(84, 1, 'Nagylóc', 21102),
(85, 1, 'Nagyoroszi', 23986),
(86, 1, 'Nemti', 27580),
(87, 1, 'Nézsa', 9797),
(88, 1, 'Nógrád', 4358),
(89, 1, 'Nógrádkövesd', 32300),
(90, 1, 'Nógrádmarcal', 29832),
(91, 2, 'Áporka', 2338),
(92, 2, 'Aszód', 2170),
(93, 2, 'Bag', 2191),
(94, 2, 'Bénye', 2216),
(95, 2, 'Bernecebaráti', 2639),
(96, 2, 'Biatorbágy', 2051),
(97, 2, 'Budajenő', 2093),
(98, 2, 'Budakalász', 2011),
(99, 2, 'Budakeszi', 2092),
(100, 2, 'Budaörs', 2040),
(101, 2, 'Budapest', 1011),
(102, 2, 'Budapest', 1012),
(103, 2, 'Budapest', 1013),
(104, 2, 'Budapest', 1014),
(105, 2, 'Budapest', 1015),
(106, 2, 'Budapest', 1016),
(107, 2, 'Budapest', 1021),
(108, 2, 'Budapest', 1022),
(109, 2, 'Budapest', 1023),
(110, 2, 'Budapest', 1024),
(111, 2, 'Budapest', 1025),
(112, 2, 'Budapest', 1026),
(113, 2, 'Budapest', 1027),
(114, 2, 'Budapest', 1028),
(115, 2, 'Budapest', 1029),
(116, 2, 'Budapest', 1031),
(117, 2, 'Budapest', 1032),
(118, 2, 'Budapest', 1033),
(119, 2, 'Budapest', 1034),
(120, 2, 'Budapest', 1035),
(121, 2, 'Budapest', 1036),
(122, 2, 'Budapest', 1037),
(123, 2, 'Budapest', 1038),
(124, 2, 'Budapest', 1039),
(125, 2, 'Budapest', 1041),
(126, 2, 'Budapest', 1042),
(127, 2, 'Budapest', 1043),
(128, 2, 'Budapest', 1044),
(129, 2, 'Budapest', 1045),
(130, 2, 'Budapest', 1046),
(131, 2, 'Budapest', 1047),
(132, 2, 'Budapest', 1048),
(133, 2, 'Budapest', 1051),
(134, 2, 'Budapest', 1052),
(135, 2, 'Budapest', 1053),
(136, 2, 'Budapest', 1054),
(137, 2, 'Budapest', 1055),
(138, 2, 'Budapest', 1056),
(139, 2, 'Budapest', 1061),
(140, 2, 'Budapest', 1062),
(141, 2, 'Budapest', 1063),
(142, 2, 'Budapest', 1064),
(143, 2, 'Budapest', 1065),
(144, 2, 'Budapest', 1066),
(145, 2, 'Budapest', 1067),
(146, 2, 'Budapest', 1068),
(147, 2, 'Budapest', 1069),
(148, 2, 'Budapest', 1071),
(149, 2, 'Budapest', 1072),
(150, 2, 'Budapest', 1073),
(151, 2, 'Budapest', 1074),
(152, 2, 'Budapest', 1075),
(153, 2, 'Budapest', 1076),
(154, 2, 'Budapest', 1077),
(155, 2, 'Budapest', 1078),
(156, 2, 'Budapest', 1081),
(157, 2, 'Budapest', 1082),
(158, 2, 'Budapest', 1083),
(159, 2, 'Budapest', 1084),
(160, 2, 'Budapest', 1085),
(161, 2, 'Budapest', 1086),
(162, 2, 'Budapest', 1087),
(163, 2, 'Budapest', 1088),
(164, 2, 'Budapest', 1089),
(165, 2, 'Budapest', 1091),
(166, 2, 'Budapest', 1092),
(167, 2, 'Budapest', 1093),
(168, 2, 'Budapest', 1094),
(169, 2, 'Budapest', 1095),
(170, 2, 'Budapest', 1096),
(171, 2, 'Budapest', 1097),
(172, 2, 'Budapest', 1098),
(173, 2, 'Budapest', 1101),
(174, 2, 'Budapest', 1102),
(175, 2, 'Budapest', 1103),
(176, 2, 'Budapest', 1104),
(177, 2, 'Budapest', 1105),
(178, 2, 'Budapest', 1106),
(179, 2, 'Budapest', 1107),
(180, 2, 'Budapest', 1108),
(181, 2, 'Budapest', 1111),
(182, 2, 'Budapest', 1112),
(183, 2, 'Budapest', 1113),
(184, 2, 'Budapest', 1114),
(185, 2, 'Budapest', 1115),
(186, 2, 'Budapest', 1116),
(187, 2, 'Budapest', 1117),
(188, 2, 'Budapest', 1118),
(189, 2, 'Budapest', 1119),
(190, 2, 'Budapest', 1121),
(191, 2, 'Budapest', 1122),
(192, 2, 'Budapest', 1123),
(193, 2, 'Budapest', 1124),
(194, 2, 'Budapest', 1125),
(195, 2, 'Budapest', 1126),
(196, 2, 'Budapest', 1131),
(197, 2, 'Budapest', 1132),
(198, 2, 'Budapest', 1133),
(199, 2, 'Budapest', 1134),
(200, 2, 'Budapest', 1135),
(201, 2, 'Budapest', 1136),
(202, 2, 'Budapest', 1137),
(203, 2, 'Budapest', 1138),
(204, 2, 'Budapest', 1139),
(205, 2, 'Budapest', 1141),
(206, 2, 'Budapest', 1142),
(207, 2, 'Budapest', 1143),
(208, 2, 'Budapest', 1144),
(209, 2, 'Budapest', 1145),
(210, 2, 'Budapest', 1146),
(211, 2, 'Budapest', 1147),
(212, 2, 'Budapest', 1148),
(213, 2, 'Budapest', 1149),
(214, 2, 'Budapest', 1151),
(215, 2, 'Budapest', 1152),
(216, 2, 'Budapest', 1153),
(217, 2, 'Budapest', 1154),
(218, 2, 'Budapest', 1155),
(219, 2, 'Budapest', 1156),
(220, 2, 'Budapest', 1157),
(221, 2, 'Budapest', 1158),
(222, 2, 'Budapest', 1161),
(223, 2, 'Budapest', 1162),
(224, 2, 'Budapest', 1163),
(225, 2, 'Budapest', 1164),
(226, 2, 'Budapest', 1165),
(227, 2, 'Budapest', 1171),
(228, 2, 'Budapest', 1172),
(229, 2, 'Budapest', 1173),
(230, 2, 'Budapest', 1174),
(231, 2, 'Budapest', 1181),
(232, 2, 'Budapest', 1182),
(233, 2, 'Budapest', 1183),
(234, 2, 'Budapest', 1184),
(235, 2, 'Budapest', 1185),
(236, 2, 'Budapest', 1186),
(237, 2, 'Budapest', 1188),
(238, 2, 'Budapest', 1191),
(239, 2, 'Budapest', 1192),
(240, 2, 'Budapest', 1193),
(241, 2, 'Budapest', 1194),
(242, 2, 'Budapest', 1195),
(243, 2, 'Budapest', 1196),
(244, 2, 'Budapest', 1201),
(245, 2, 'Bugyi', 2347),
(246, 2, 'Cegléd', 2700),
(247, 2, 'Cegléd', 2738),
(248, 2, 'Ceglédbercel', 2737),
(249, 2, 'Csemő', 2713),
(250, 2, 'Csévharaszt', 2212),
(251, 2, 'Csobánka', 2014),
(252, 2, 'Csomád', 2161),
(253, 2, 'Csömör', 2141),
(254, 2, 'Csörög', 2135),
(255, 2, 'Csővár', 2615),
(256, 2, 'Dabas', 2370),
(257, 2, 'Dabas', 2371),
(258, 2, 'Dabas', 2373),
(259, 2, 'Dánszentmiklós', 2735),
(260, 2, 'Dány', 2118),
(261, 2, 'Délegyháza', 2337),
(262, 2, 'Diósd', 2049),
(263, 2, 'Domony', 2182),
(264, 2, 'Dömsöd', 2344),
(265, 2, 'Dunabogdány', 2023),
(266, 2, 'Dunaharaszti', 2330),
(267, 2, 'Dunakeszi', 2120),
(268, 2, 'Dunavarsány', 2336),
(269, 2, 'Ecser', 2233),
(270, 2, 'Érd', 2030),
(271, 2, 'Érd', 2035),
(272, 2, 'Érd', 2036),
(273, 2, 'Erdőkertes', 2113),
(274, 2, 'Farmos', 2765),
(275, 2, 'Felsőpakony', 2363),
(276, 2, 'Fót', 2151),
(277, 2, 'Galgagyörk', 2681),
(278, 2, 'Galgahévíz', 2193),
(279, 2, 'Galgamácsa', 2183),
(280, 2, 'Göd', 2131),
(281, 2, 'Göd', 2132),
(282, 2, 'Gödöllő', 2100),
(283, 2, 'Gomba', 2217),
(284, 2, 'Gyál', 2360),
(285, 2, 'Gyömrő', 2230),
(286, 2, 'Halásztelek', 2314),
(287, 2, 'Herceghalom', 2053),
(288, 2, 'Hernád', 2376),
(289, 2, 'Hévízgyörk', 2192),
(290, 2, 'Iklad', 2181),
(291, 2, 'Inárcs', 2365),
(292, 2, 'Ipolydamásd', 2631),
(293, 2, 'Ipolytölgyes', 2633),
(294, 2, 'Isaszeg', 2117),
(295, 2, 'Jászkarajenő', 2746),
(296, 2, 'Kakucs', 2366),
(297, 2, 'Kartal', 2173),
(298, 2, 'Káva', 2215),
(299, 2, 'Kemence', 2638),
(300, 2, 'Kerepes', 2144),
(301, 2, 'Kerepes', 2145),
(302, 2, 'Kiskunlacháza', 2340),
(303, 2, 'Kismaros', 2623),
(304, 2, 'Kisnémedi', 2165),
(305, 2, 'Kisoroszi', 2024),
(306, 2, 'Kistarcsa', 2143),
(307, 2, 'Kocsér', 2755),
(308, 2, 'Kóka', 2243),
(309, 2, 'Kőröstetétlen', 2745),
(310, 2, 'Kosd', 2612),
(311, 2, 'Kóspallag', 2625),
(312, 2, 'Leányfalu', 2016),
(313, 2, 'Letkés', 2632),
(314, 2, 'Lórév', 2309),
(315, 2, 'Maglód', 2234),
(316, 2, 'Majosháza', 2339),
(317, 2, 'Makád', 2322),
(318, 2, 'Márianosztra', 2629),
(319, 2, 'Mende', 2235),
(320, 2, 'Mikebuda', 2736),
(321, 2, 'Mogyoród', 2146),
(322, 2, 'Monor', 2200),
(323, 2, 'Monor', 2213),
(324, 2, 'Nagybörzsöny', 2634),
(325, 2, 'Nagykáta', 2760),
(326, 2, 'Nagykőrös', 2750),
(327, 2, 'Nagykovácsi', 2094),
(328, 2, 'Nagymaros', 2626),
(329, 2, 'Nagytarcsa', 2142),
(330, 2, 'Nyáregyháza', 2723),
(331, 2, 'Nyársapát', 2712),
(332, 2, 'Ócsa', 2364),
(333, 2, 'Őrbottyán', 2162),
(334, 2, 'Örkény', 2377),
(335, 2, 'Pánd', 2214),
(336, 2, 'Páty', 2071),
(337, 2, 'Pécel', 2119),
(338, 2, 'Penc', 2614),
(339, 2, 'Perbál', 2074),
(340, 2, 'Perőcsény', 2637),
(341, 2, 'Péteri', 2209),
(342, 2, 'Pilis', 2721),
(343, 2, 'Pilisborosjenő', 2097),
(344, 2, 'Piliscsaba', 2081),
(345, 3, 'Abasár', 24554),
(346, 3, 'Adács', 23241),
(347, 3, 'Aldebrő', 6345),
(348, 3, 'Andornaktálya', 17987),
(349, 3, 'Apc', 7241),
(350, 3, 'Átány', 6503),
(351, 3, 'Atkár', 16090),
(352, 3, 'Balaton', 11527),
(353, 3, 'Bátor', 24022),
(354, 3, 'Bekölce', 4400),
(355, 3, 'Bélapátfalva', 33260),
(356, 3, 'Besenyőtelek', 27517),
(357, 3, 'Boconád', 22354),
(358, 3, 'Bodony', 14933),
(359, 3, 'Boldog', 3452),
(360, 3, 'Bükkszék', 2963),
(361, 3, 'Bükkszenterzsébet', 10621),
(362, 3, 'Bükkszentmárton', 22099),
(363, 3, 'Csány', 16841),
(364, 3, 'Demjén', 8660),
(365, 3, 'Detk', 9201),
(366, 3, 'Domoszló', 7515),
(367, 3, 'Dormánd', 30261),
(368, 3, 'Ecséd', 17181),
(369, 3, 'Eger', 20491),
(370, 3, 'Eger', 20491),
(371, 3, 'Egerbakta', 12821),
(372, 3, 'Egerbocs', 26019),
(373, 3, 'Egercsehi', 16610),
(374, 3, 'Egerfarmos', 2981),
(375, 3, 'Egerszalók', 24758),
(376, 3, 'Egerszólát', 13648),
(377, 3, 'Erdőkövesd', 28556),
(378, 3, 'Erdőtelek', 24235),
(379, 3, 'Erk', 20118),
(380, 3, 'Fedémes', 12432),
(381, 3, 'Feldebrő', 20747),
(382, 3, 'Felsőtárkány', 16328),
(383, 3, 'Füzesabony', 3276),
(384, 3, 'Gyöngyös', 5236),
(385, 3, 'Gyöngyös', 5236),
(386, 3, 'Gyöngyös', 5236),
(387, 3, 'Gyöngyös', 5236),
(388, 3, 'Gyöngyöshalász', 17534),
(389, 3, 'Gyöngyösoroszi', 13338),
(390, 3, 'Gyöngyöspata', 8323),
(391, 3, 'Gyöngyössolymos', 19123),
(392, 3, 'Gyöngyöstarján', 28088),
(393, 3, 'Halmajugra', 11411),
(394, 3, 'Hatvan', 22309),
(395, 3, 'Heréd', 20242),
(396, 3, 'Heves', 14526),
(397, 3, 'Hevesaranyos', 10241),
(398, 3, 'Hevesvezekény', 4084),
(399, 3, 'Hort', 4145),
(400, 3, 'Istenmezeje', 10074),
(401, 3, 'Ivád', 13879),
(402, 3, 'Kál', 32179),
(403, 3, 'Kápolna', 15307),
(404, 3, 'Karácsond', 5935),
(405, 3, 'Kerecsend', 28079),
(406, 3, 'Kisfüzes', 22460),
(407, 3, 'Kisköre', 18281),
(408, 3, 'Kisnána', 12502),
(409, 3, 'Kömlő', 14535),
(410, 3, 'Kompolt', 23995),
(411, 3, 'Lőrinci', 30401),
(412, 3, 'Lőrinci', 30401),
(413, 3, 'Lőrinci', 30401),
(414, 3, 'Ludas', 15796),
(415, 3, 'Maklár', 27696),
(416, 3, 'Markaz', 16540),
(417, 3, 'Mátraballa', 19965),
(418, 3, 'Mátraderecske', 14872),
(419, 3, 'Mátraszentimre', 29045),
(420, 3, 'Mátraszentimre', 29045),
(421, 3, 'Mezőszemere', 25089),
(422, 3, 'Mezőtárkány', 31662),
(423, 3, 'Mikófalva', 31282),
(424, 3, 'Mónosbél', 31565),
(425, 3, 'Nagyfüged', 26879),
(426, 3, 'Nagykökényes', 24943),
(427, 3, 'Nagyréde', 31486),
(428, 3, 'Nagytálya', 27605),
(429, 3, 'Nagyút', 10418),
(430, 3, 'Nagyvisnyó', 28282),
(431, 3, 'Noszvaj', 18810),
(432, 3, 'Novaj', 29276),
(433, 3, 'Ostoros', 27216),
(434, 3, 'Parád', 7436),
(435, 3, 'Parád', 7436),
(436, 3, 'Parádsasvár', 20215),
(437, 3, 'Pély', 19567),
(438, 3, 'Pétervására', 12070),
(439, 3, 'Petőfibánya', 33686),
(440, 3, 'Poroszló', 22196),
(441, 3, 'Recsk', 9609),
(442, 3, 'Rózsaszentmárton', 27650),
(443, 3, 'Sarud', 7180),
(444, 3, 'Sirok', 8527),
(445, 3, 'Szajla', 16063),
(446, 3, 'Szarvaskő', 3382),
(447, 3, 'Szentdomonkos', 13231),
(448, 3, 'Szihalom', 11013),
(449, 3, 'Szilvásvárad', 5643),
(450, 3, 'Szúcs', 13523),
(451, 3, 'Szűcsi', 9982),
(452, 3, 'Tarnabod', 32966),
(453, 3, 'Tarnalelesz', 13240),
(454, 3, 'Tarnaméra', 23348),
(455, 3, 'Tarnaörs', 14128),
(456, 3, 'Tarnaszentmária', 9052),
(457, 3, 'Tarnaszentmiklós', 16160),
(458, 3, 'Tarnazsadány', 17163),
(459, 3, 'Tenk', 14076),
(460, 3, 'Terpes', 12229),
(461, 3, 'Tiszanána', 7083),
(462, 3, 'Tófalu', 9964),
(463, 3, 'Újlőrincfalva', 27623),
(464, 3, 'Vámosgyörk', 14580),
(465, 3, 'Váraszó', 27012),
(466, 3, 'Vécs', 5759),
(467, 3, 'Verpelét', 24147),
(468, 3, 'Visonta', 31246),
(469, 3, 'Visonta', 31246),
(470, 3, 'Visznek', 3513),
(471, 3, 'Zagyvaszántó', 21722),
(472, 3, 'Zaránk', 23445),
(473, 4, 'Ács', 4428),
(474, 4, 'Ácsteszér', 18139),
(475, 4, 'Aka', 6682),
(476, 4, 'Almásfüzitő', 32346),
(477, 4, 'Annavölgy', 34227),
(478, 4, 'Ászár', 23852),
(479, 4, 'Bábolna', 19363),
(480, 4, 'Baj', 29212),
(481, 4, 'Bajna', 16744),
(482, 4, 'Bajót', 29355),
(483, 4, 'Bakonybánk', 24244),
(484, 4, 'Bakonysárkány', 25229),
(485, 4, 'Bakonyszombathely', 22381),
(486, 4, 'Bana', 31422),
(487, 4, 'Bársonyos', 8624),
(488, 4, 'Bokod', 7311),
(489, 4, 'Császár', 16416),
(490, 4, 'Csatka', 33109),
(491, 4, 'Csém', 33640),
(492, 4, 'Csép', 18272),
(493, 4, 'Csolnok', 18926),
(494, 4, 'Dad', 33163),
(495, 4, 'Dág', 22910),
(496, 4, 'Dömös', 6594),
(497, 4, 'Dorog', 10490),
(498, 4, 'Dunaalmás', 33835),
(499, 4, 'Dunaszentmiklós', 24101),
(500, 4, 'Epöl', 29638),
(501, 4, 'Esztergom', 25131),
(502, 4, 'Esztergom', 25131),
(503, 4, 'Ete', 6664),
(504, 4, 'Gyermely', 6521),
(505, 4, 'Héreg', 11891),
(506, 4, 'Kecskéd', 4525),
(507, 4, 'Kerékteleki', 10995),
(508, 4, 'Kesztölc', 29577),
(509, 4, 'Kisbér', 17330),
(510, 4, 'Kisbér', 17330),
(511, 4, 'Kisigmánd', 20923),
(512, 4, 'Kocs', 2510),
(513, 4, 'Komárom', 5449),
(514, 4, 'Komárom', 5449),
(515, 4, 'Komárom', 5449),
(516, 4, 'Kömlőd', 7630),
(517, 4, 'Környe', 30553),
(518, 4, 'Lábatlan', 15255),
(519, 4, 'Leányvár', 25487),
(520, 4, 'Máriahalom', 22637),
(521, 4, 'Mocsa', 26930),
(522, 4, 'Mogyorósbánya', 28255),
(523, 4, 'Nagyigmánd', 22372),
(524, 4, 'Nagysáp', 27076),
(525, 4, 'Naszály', 20163),
(526, 4, 'Neszmély', 33826),
(527, 4, 'Nyergesújfalu', 15352),
(528, 4, 'Nyergesújfalu', 15352),
(529, 4, 'Oroszlány', 30766),
(530, 4, 'Piliscsév', 21874),
(531, 4, 'Pilismarót', 14669),
(532, 4, 'Réde', 30012),
(533, 4, 'Sárisáp', 26903),
(534, 4, 'Súr', 31990),
(535, 4, 'Süttő', 8688),
(536, 4, 'Szákszend', 33516),
(537, 4, 'Szárliget', 33491),
(538, 4, 'Szomód', 22619),
(539, 4, 'Szomor', 21421),
(540, 4, 'Tardos', 30225),
(541, 4, 'Tarján', 18935),
(542, 4, 'Tárkány', 20987),
(543, 4, 'Tát', 8758),
(544, 4, 'Tata', 20127),
(545, 4, 'Tata', 20127),
(546, 4, 'Tatabánya', 18157),
(547, 4, 'Tokod', 14155),
(548, 4, 'Tokodaltáró', 34023),
(549, 4, 'Úny', 27632),
(550, 4, 'Várgesztes', 17251),
(551, 4, 'Vérteskethely', 32586),
(552, 4, 'Vértessomló', 15282),
(553, 4, 'Vértesszőlős', 31264),
(554, 4, 'Vértestolna', 29629);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `settlement_id` int(11) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `registration_date` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- A tábla indexei `baskets`
--
ALTER TABLE `baskets`
  ADD PRIMARY KEY (`basket_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `payment_id` (`payment_id`),
  ADD KEY `order_status_id` (`order_status_id`);

--
-- A tábla indexei `counties`
--
ALTER TABLE `counties`
  ADD PRIMARY KEY (`county_id`);

--
-- A tábla indexei `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `basket_id` (`basket_id`);

--
-- A tábla indexei `order_statuses`
--
ALTER TABLE `order_statuses`
  ADD PRIMARY KEY (`order_status_id`);

--
-- A tábla indexei `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`);

--
-- A tábla indexei `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `product_category_id` (`product_category_id`),
  ADD KEY `quantity_unit_id` (`quantity_unit_id`);

--
-- A tábla indexei `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`product_category_id`),
  ADD KEY `product_group_id` (`product_group_id`);

--
-- A tábla indexei `product_groups`
--
ALTER TABLE `product_groups`
  ADD PRIMARY KEY (`product_group_id`);

--
-- A tábla indexei `quantity_units`
--
ALTER TABLE `quantity_units`
  ADD PRIMARY KEY (`quantity_unit_id`);

--
-- A tábla indexei `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `settlements`
--
ALTER TABLE `settlements`
  ADD PRIMARY KEY (`settlement_id`),
  ADD KEY `county_id` (`county_id`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `settlement_id` (`settlement_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `admin`
--
ALTER TABLE `admin`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `baskets`
--
ALTER TABLE `baskets`
  MODIFY `basket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `counties`
--
ALTER TABLE `counties`
  MODIFY `county_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `order_statuses`
--
ALTER TABLE `order_statuses`
  MODIFY `order_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT a táblához `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `product_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `product_groups`
--
ALTER TABLE `product_groups`
  MODIFY `product_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `quantity_units`
--
ALTER TABLE `quantity_units`
  MODIFY `quantity_unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `settlements`
--
ALTER TABLE `settlements`
  MODIFY `settlement_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=555;

--
-- AUTO_INCREMENT a táblához `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `baskets`
--
ALTER TABLE `baskets`
  ADD CONSTRAINT `baskets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `baskets_ibfk_2` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`),
  ADD CONSTRAINT `baskets_ibfk_3` FOREIGN KEY (`order_status_id`) REFERENCES `order_statuses` (`order_status_id`);

--
-- Megkötések a táblához `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`basket_id`) REFERENCES `baskets` (`basket_id`);

--
-- Megkötések a táblához `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`product_category_id`) REFERENCES `product_categories` (`product_category_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`quantity_unit_id`) REFERENCES `quantity_units` (`quantity_unit_id`);

--
-- Megkötések a táblához `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_ibfk_1` FOREIGN KEY (`product_group_id`) REFERENCES `product_groups` (`product_group_id`);

--
-- Megkötések a táblához `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`);

--
-- Megkötések a táblához `settlements`
--
ALTER TABLE `settlements`
  ADD CONSTRAINT `settlements_ibfk_1` FOREIGN KEY (`county_id`) REFERENCES `counties` (`county_id`);

--
-- Megkötések a táblához `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`settlement_id`) REFERENCES `settlements` (`settlement_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
