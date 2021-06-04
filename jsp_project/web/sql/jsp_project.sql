-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 19, 2020 at 10:02 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `jsp_project`
--
CREATE DATABASE IF NOT EXISTS `jsp_project` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `jsp_project`;

-- --------------------------------------------------------

--
-- Table structure for table `bikes`
--

DROP TABLE IF EXISTS `bikes`;
CREATE TABLE IF NOT EXISTS `bikes` (
  `bike_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int(10) UNSIGNED NOT NULL,
  `bike_name` varchar(45) DEFAULT NULL,
  `bike_description` longtext DEFAULT NULL,
  `bike_image` varchar(255) DEFAULT NULL,
  `price` double(10,2) DEFAULT 0.00 COMMENT 'Price without vat',
  `time_unit` enum('hour','day','week','month') DEFAULT 'hour',
  `added` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`bike_id`),
  KEY `category_id` (`category_id`),
  KEY `bike_name` (`bike_name`),
  KEY `bike_image` (`bike_image`(250)),
  KEY `added` (`added`),
  KEY `price` (`price`),
  KEY `time_unit` (`time_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `bikes`
--

TRUNCATE TABLE `bikes`;
--
-- Dumping data for table `bikes`
--

INSERT INTO `bikes` (`bike_id`, `category_id`, `bike_name`, `bike_description`, `bike_image`, `price`, `time_unit`, `added`) VALUES
(1, 1, 'Giant Cypress', 'Adult unisex comfort hybrid bicycle with 7 speeds, comfortable seat, hand brakes, sizes Small, Medium, Large, Extra-Large.', './img/giantCypress.jpg', 10.00, 'hour', '2020-05-17 00:00:00'),
(2, 1, 'Live Flourish 4', 'Women\'s/step-thru comfort hybrid bicycle with 7 speeds, comfortable seat, hand brakes, sizes Extra-Small, Small, Medium.', './img/LivFlourish4.jpg', 10.00, 'hour', '2020-05-17 00:00:00'),
(3, 1, 'Electra Townie Original 3i', 'Adult comfort cruiser with flat-foot design, 3 speeds, rear pedal brake, front hand brake. Step-thru and unisex frames available. One size fits most.', './img/ElectraTownieOriginal3i.jpg', 10.00, 'hour', '2020-05-17 00:00:00'),
(4, 1, 'Giant XTC Jr 24 Lite', 'For girls and boys aged 7 to 12 years (approximately), 24-inch wheels, 7 speeds, hand brakes.', './img/GiantXTCJr24Lite.jpg', 10.00, 'hour', '2020-05-17 00:00:00'),
(5, 1, 'Adams Trail-a-Bike', 'Attaches to one of our rental bikes to allow a small child to pedal with you. Child must be 85 pounds or less. Compatible with our Giant Cypress and Liv Flourish rental bikes; cannot be used with the Electra Townie. Can be used with your own bike only if your bike uses a seatpost with 30.9mm diameter. Not for use on e-bikes.', './img/AdamsTrial-a-Bike.jpg', 5.00, 'hour', '2020-05-17 00:00:00'),
(6, 1, 'Burley Cub Child Trailer', 'May carry one or two children, up to 100 pounds total weight. Secure safety harnesses. Can be attached to our rental bikes, or to your own bike (in some cases -- disc brakes, full suspension, and other non-standard frame features may interfere). Not for use one-bikes. No pets.', './img/BurleyCubChildTrailer.jpg', 10.00, 'hour', '2020-05-17 00:00:00'),
(7, 1, 'Burley Tail Wagon Pet Trailer', 'You don\'t have to leave your best friend at home to enjoy a ride on the Towpath! Weight limit of 75 pounds. Can be attached to our rental bikes, or to your own bike (in some cases -- disc brakes, full suspension, and other non-standard frame features may interfere). Not for use on e-bikes.', './img/BurleyTailWagonPetTrailer.jpg', 10.00, 'hour', '2020-05-17 00:00:00'),
(8, 2, 'Merida Big 9 20', 'Very good bike for mountain riding!', './img/MERIDA-BIG.NINE-20.jpg', 20.00, 'hour', '2020-05-17 00:00:00'),
(9, 2, 'Giant Glory 1', 'Good and comfortable bike for downhill riding in mountains!', './img/MY20Glory1_ColorA.jpg', 40.00, 'hour', '2020-05-17 00:00:00'),
(10, 3, 'Giant Escape 2', 'Sizes: Small, Medium, Large, Extra-Large.', './img/GIANT_ESCAPE_2.jpg', 15.00, 'hour', '2020-05-17 00:00:00'),
(11, 3, 'Liv Alight 2', 'Women\'s-specific sizes: Extra-Small, Small, Medium, Large\r\n', './img/GiantXTCJr24Lite.jpg', 15.00, 'hour', '2020-05-17 00:00:00'),
(12, 4, 'Momentum Vida E+', '(Step-Through frame)\r\n$45 for 2 Hours (minimum) $20 per each additional hour Sales Tax is additional.', './img/MomentumVidaE+_StepThrough.jpg', 20.00, 'hour', '2020-05-17 00:00:00'),
(13, 4, 'Momentum Vida E+ SE', '(Step-Over frame)\r\n$45 for 2 Hours (minimum) ` $20 per each additional hour Sales Tax is additional.', './img/Momentum%20Vida%20E+_StepOver.jpg', 20.00, 'hour', '2020-05-17 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `from_date` datetime DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `bike_id` int(10) UNSIGNED NOT NULL,
  `paid` enum('Yes','No') NOT NULL DEFAULT 'No',
  `paid_date` datetime DEFAULT NULL,
  `booking_sum` double(10,2) NOT NULL DEFAULT 0.00,
  `paid_sum` double(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`booking_id`),
  KEY `from_date` (`from_date`),
  KEY `to_date` (`to_date`),
  KEY `user_id` (`user_id`),
  KEY `booking_sum` (`booking_sum`),
  KEY `paid_sum` (`paid_sum`),
  KEY `paid_date` (`paid_date`),
  KEY `paid` (`paid`),
  KEY `category_id` (`category_id`),
  KEY `bike_id` (`bike_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `booking`
--

TRUNCATE TABLE `booking`;
--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `from_date`, `to_date`, `user_id`, `category_id`, `bike_id`, `paid`, `paid_date`, `booking_sum`, `paid_sum`) VALUES
(1, '2020-10-08 00:00:00', '2020-10-17 00:00:00', 22, 1, 4, 'Yes', '2020-08-20 00:16:43', 1080.00, 1080.00);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `b_class` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `descr` text DEFAULT NULL,
  `long_desc` longtext DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `faq` longtext DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `name` (`name`),
  KEY `desc` (`descr`(768)),
  KEY `image_url` (`image_url`),
  KEY `b_class` (`b_class`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `category`
--

TRUNCATE TABLE `category`;
--
-- Dumping data for table `category`
--

INSERT INTO `category` (`category_id`, `b_class`, `name`, `descr`, `long_desc`, `image_url`, `faq`) VALUES
(1, 'body_comfortPage', 'Comfort Bike Rental', 'I want to take a casual ride with family or friends on a car-free bike path.', 'At the TurboRoot store, we have comfort/hybrid bicycles for rent for use on the Ohio & Erie Canal Towpath Trail in the Cuyahoga Valley National Park. Bicycles for rent are available on a first-come, first-served basis. Reservations are not required or accepted. Rentals are by the hour, minimum of one hour, with rental rates pro-rated for each fifteen-minute interval after the first hour. Two-hour minimum for e-bikes. We stop renting bikes 90 minutes before the store closing time. Bicycles MUST be returned before the store closing time or a late fee will be charged. See below for rental hours. We are open year-round, but bike rental may be restricted due to weather and trail conditions. You may call us at 330-657-2209 to verify availability. Also, check the Cuyahoga Valley National Park\'s Alerts and Conditions page to be aware of any trail closures. You must have a photo ID and a major credit card to rent bikes. You must be 18 years of age or older, or accompanied by a parent or guardian 18 or older. Helmets are included with all bicycle rentals.', './img/Comfort_Bike.jpg', ''),
(2, 'body_mountainPage', 'Mountain Bike Rental', 'I want to go fast on smooth paved roads.', 'A 10 kilo meters day trip through tea plantations to the Labookellie tea factory is quite challenging but worth every bit of it. Ask at the Single Tree Hotel about mountain-bike rental. Fat-tyre fans will find plenty of steep dirt trails radiating into the hills from the outskirts of town. Enjoy cycling in the lap of nature and take breathtaking photography of the nature at its best. Tourists from all around the world come here to enjoy mountain biking and local villages of Sri Lanka.', './img/Mountain_Bike.jpg', '<h3>Mountain Bike Rental Travel Tips</h3>\r\n            <p> &#10004; Do carry a raincoat along, in case there is a weather change.</p>\r\n            <p> &#10004; Wear a cap and a good pair of sports shoes so as to enjoy the ride.</p>\r\n            <p> &#10004; Though there is no specific time, it is ideal to opt for cycling either early in the morning, or after noon. One can then relax at one of the many restaurants or enjoy high tea.<p/>'),
(3, 'body_cityPage', 'City Bike Rental', 'I want to cruise streets and paved trails.', 'We have City Bicycles available for rent in our Turbo Bike store. These bikes are our best-sellers, and are perfect to rent if don\'t have a bike of your own, but are looking for a fun way to enjoy a day out in our local parks! These bikes are sometimes referred to as \"performance hybrid bikes\" or \"flat-bar road bikes.\" They feature lightweight aluminum frames, 24 speeds, hand brakes, and regular platform pedals. The tires are a \"happy medium\" 32mm wide, which makes them appropriate for riding on streets, but provide plenty of traction on bike paths. Not for use on mountain bike trails. We do not take reservations; bikes are available on a first-come, first-served basis only. Use of helmets is required. Helmets are provided with all rentals at no extra charge.', './img/City_Bike.jpg', '<h3>Frequently Asked Questions (FAQ)</h3>\r\nRental Rates:\r\n$15 per Hour\r\nSales Tax is additional.\r\nDaily and multi-day rentals are available for special events;\r\nplease call us to make arrangements.\r\n\r\nQ. Is there a speedometer on the bikes?\r\nA. Yes, each bicycle has a CatEye Enduro cyclocomputer installed, which provides speed, distance, average speed, maximum speed, and ride time. We cannot guarantee the accuracy of the time-of-day clock on the CatEye Enduro computers.\r\nQ. Are emergency repair supplies included?\r\nA. Yes, each bicycle has a seat bag with a spare inner tube, tire levers, patch kit, and CO2 inflator. You will be charged for any of these supplies that are used or missing when you return the bike.\r\nQ. What if I break down and can\'t get going on my own? A. Support and pickup service are NOT provided. We recommend that you carry a phone and have access to a friend or taxi service should you need help out on the road.\r\nQ. Are water bottles included?\r\nA. Water bottle holders are provided on each bike. Bring your own bicycle-specific water bottles, or buy some in the store when you pick up the bike.'),
(4, 'body_electricPage', 'Electric Bike Rental', 'It?s just like riding a bike?but even more fun. Our electric bicycle rentals give you a natural-feeling boost of electric power to help you ride farther and faster with less effort.', 'It’s just like riding a bike—but even more fun. The Momentum Vida E+ features a motor which gives you a natural-feeling boost of electric power to help you ride farther and faster with less effort. It’s the perfect way to explore the city, feel the wind on your face, or put a kick into your fitness routine. The frame is designed with a comfortable upright rider position, which gives it a confident, easygoing ride quality.', './img/Electricbike.jpg', '<h3>Lorem ipsum</h3>\r\nLorem ipsum dolorem sit amet .....');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `feedback_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` int(10) UNSIGNED NOT NULL,
  `bike_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `feedback_title` varchar(255) DEFAULT NULL,
  `feedback_text` text DEFAULT NULL,
  `date_added` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`feedback_id`),
  KEY `category_id` (`category_id`),
  KEY `bike_id` (`bike_id`),
  KEY `user_id` (`user_id`),
  KEY `date_added` (`date_added`),
  KEY `feedback_text` (`feedback_text`(768)),
  KEY `feedback_title` (`feedback_title`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `feedback`
--

TRUNCATE TABLE `feedback`;
--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `category_id`, `bike_id`, `user_id`, `feedback_title`, `feedback_text`, `date_added`) VALUES
(1, 3, 11, 22, 'lorem ipsum', 'lorem ipsum dolorem sit amet', '2020-08-20 00:33:06'),
(2, 2, 8, 22, 'Bike', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', '2020-08-20 00:35:42');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(65) NOT NULL,
  `added` datetime DEFAULT NULL,
  `admin` enum('Yes','No') NOT NULL DEFAULT 'No',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `password` (`password`) USING BTREE,
  KEY `added` (`added`),
  KEY `admin` (`admin`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

--
-- Truncate table before insert `user`
--

TRUNCATE TABLE `user`;
--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `password`, `added`, `admin`) VALUES
(22, 'Kely', 'not@existing.lk', 'a2a8ae4546dddfdd6d6a529a200a50e6', NULL, 'Yes');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bikes`
--
ALTER TABLE `bikes` ADD FULLTEXT KEY `bike_description` (`bike_description`);

--
-- Indexes for table `category`
--
ALTER TABLE `category` ADD FULLTEXT KEY `long_desc` (`long_desc`);
ALTER TABLE `category` ADD FULLTEXT KEY `faq` (`faq`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bikes`
--
ALTER TABLE `bikes`
  ADD CONSTRAINT `fk2_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `fk_bike_id` FOREIGN KEY (`bike_id`) REFERENCES `bikes` (`bike_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `fk3_bike_id` FOREIGN KEY (`bike_id`) REFERENCES `bikes` (`bike_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk3_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk3_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS=1;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
