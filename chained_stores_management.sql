-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 24, 2022 at 06:48 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chained_stores_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `address_id` int(11) NOT NULL,
  `address_line_1` varchar(255) NOT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `city` varchar(255) NOT NULL,
  `zip_code` int(11) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`address_id`, `address_line_1`, `address_line_2`, `city`, `zip_code`, `state`, `country`) VALUES
(1, 'street 1', NULL, 'new york', 10009, 'nyc', 'usa');

-- --------------------------------------------------------

--
-- Stand-in structure for view `address_view`
-- (See below for the actual view)
--
CREATE TABLE `address_view` (
`address_line_1` varchar(255)
,`city` varchar(255)
,`state` varchar(255)
,`country` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `chain_store`
--

CREATE TABLE `chain_store` (
  `chain_store_id` int(11) NOT NULL,
  `chain_store_name` varchar(255) NOT NULL,
  `chain_store_email` varchar(40) DEFAULT NULL,
  `chain_store_number` bigint(30) NOT NULL,
  `chain_store_website` varchar(40) DEFAULT NULL,
  `chain_store_office_address` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_number` bigint(30) DEFAULT NULL,
  `customer_email` varchar(255) DEFAULT NULL,
  `became_customer_from` date NOT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `customer_name`, `customer_number`, `customer_email`, `became_customer_from`, `address_id`) VALUES
(1, 'ali', 9125621247, 'ali@gmail.com', '2022-04-20', 1);

--
-- Triggers `customers`
--
DELIMITER $$
CREATE TRIGGER `customer_delete` BEFORE DELETE ON `customers` FOR EACH ROW DELETE FROM address 
WHERE address.address_id = customers.address_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `customers_view`
-- (See below for the actual view)
--
CREATE TABLE `customers_view` (
`customer_name` varchar(255)
,`customer_number` bigint(30)
,`became_customer_from` date
);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `employee_name` varchar(255) NOT NULL,
  `employee_number` bigint(30) NOT NULL,
  `employee_email` varchar(255) DEFAULT NULL,
  `became_employee_from` date NOT NULL,
  `address_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `employee_view`
-- (See below for the actual view)
--
CREATE TABLE `employee_view` (
`employee_name` varchar(255)
,`employee_number` bigint(30)
,`became_employee_from` date
);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` double NOT NULL,
  `product_type` varchar(255) NOT NULL,
  `product_description` varchar(255) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `product_price`, `product_type`, `product_description`, `store_id`, `category_id`) VALUES
(1, 'morgh', 90000, 'protein', 'morghe', NULL, NULL),
(2, 'mahi', 100000, 'protein', NULL, NULL, NULL);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `products_trigger` AFTER INSERT ON `products` FOR EACH ROW BEGIN
if NEW.product_price>60000 then
INSERT INTO products_off(products_id,products_name,products_price) VALUES(NEW.product_id,NEW.product_name,NEW.product_price*0.7);
end if;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `products_off`
--

CREATE TABLE `products_off` (
  `products_id` int(30) NOT NULL,
  `products_name` varchar(100) NOT NULL,
  `products_price` int(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products_off`
--

INSERT INTO `products_off` (`products_id`, `products_name`, `products_price`) VALUES
(1, 'morgh', 63000),
(2, 'mahi', 70000);

-- --------------------------------------------------------

--
-- Table structure for table `products_suppliers`
--

CREATE TABLE `products_suppliers` (
  `supplier_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `supply_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products_suppliers`
--

INSERT INTO `products_suppliers` (`supplier_id`, `product_id`, `supply_date`) VALUES
(1, 1, '2022-05-04');

-- --------------------------------------------------------

--
-- Stand-in structure for view `products_view`
-- (See below for the actual view)
--
CREATE TABLE `products_view` (
`product_name` varchar(255)
,`product_type` varchar(255)
,`product_price` double
);

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `store_id` int(11) NOT NULL,
  `store_name` varchar(255) NOT NULL,
  `store_description` varchar(255) DEFAULT NULL,
  `store_number` bigint(30) NOT NULL,
  `store_capacity` bigint(30) NOT NULL,
  `chain_store_id` int(11) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `store_customers_buy`
--

CREATE TABLE `store_customers_buy` (
  `store_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `employee_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `supplier_id` int(11) NOT NULL,
  `supplier_name` varchar(255) NOT NULL,
  `supplier_number` bigint(30) NOT NULL,
  `supplier_email` varchar(255) DEFAULT NULL,
  `address_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`supplier_id`, `supplier_name`, `supplier_number`, `supplier_email`, `address_id`) VALUES
(1, 'ali', 912345678, NULL, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `suppliers_view`
-- (See below for the actual view)
--
CREATE TABLE `suppliers_view` (
`supplier_name` varchar(255)
,`supplier_number` bigint(30)
,`supplier_email` varchar(255)
);

-- --------------------------------------------------------

--
-- Structure for view `address_view`
--
DROP TABLE IF EXISTS `address_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `address_view`  AS SELECT `address`.`address_line_1` AS `address_line_1`, `address`.`city` AS `city`, `address`.`state` AS `state`, `address`.`country` AS `country` FROM `address` ;

-- --------------------------------------------------------

--
-- Structure for view `customers_view`
--
DROP TABLE IF EXISTS `customers_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `customers_view`  AS SELECT `customers`.`customer_name` AS `customer_name`, `customers`.`customer_number` AS `customer_number`, `customers`.`became_customer_from` AS `became_customer_from` FROM `customers` ;

-- --------------------------------------------------------

--
-- Structure for view `employee_view`
--
DROP TABLE IF EXISTS `employee_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `employee_view`  AS SELECT `employee`.`employee_name` AS `employee_name`, `employee`.`employee_number` AS `employee_number`, `employee`.`became_employee_from` AS `became_employee_from` FROM `employee` ;

-- --------------------------------------------------------

--
-- Structure for view `products_view`
--
DROP TABLE IF EXISTS `products_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `products_view`  AS SELECT `products`.`product_name` AS `product_name`, `products`.`product_type` AS `product_type`, `products`.`product_price` AS `product_price` FROM `products` ;

-- --------------------------------------------------------

--
-- Structure for view `suppliers_view`
--
DROP TABLE IF EXISTS `suppliers_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `suppliers_view`  AS SELECT `suppliers`.`supplier_name` AS `supplier_name`, `suppliers`.`supplier_number` AS `supplier_number`, `suppliers`.`supplier_email` AS `supplier_email` FROM `suppliers` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`address_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `chain_store`
--
ALTER TABLE `chain_store`
  ADD PRIMARY KEY (`chain_store_id`),
  ADD KEY `chain_store_index` (`chain_store_name`,`chain_store_number`,`chain_store_office_address`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `customers_index` (`customer_name`,`customer_number`,`became_customer_from`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `employee_index` (`employee_name`,`employee_number`,`became_employee_from`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `products_index` (`product_name`,`product_price`,`product_type`);

--
-- Indexes for table `products_off`
--
ALTER TABLE `products_off`
  ADD PRIMARY KEY (`products_id`);

--
-- Indexes for table `products_suppliers`
--
ALTER TABLE `products_suppliers`
  ADD PRIMARY KEY (`product_id`,`supplier_id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`store_id`),
  ADD KEY `chain_store_id` (`chain_store_id`),
  ADD KEY `address_id` (`address_id`),
  ADD KEY `store_index` (`store_name`,`store_number`,`store_capacity`);

--
-- Indexes for table `store_customers_buy`
--
ALTER TABLE `store_customers_buy`
  ADD PRIMARY KEY (`store_id`,`customer_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `employee_id` (`employee_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`supplier_id`),
  ADD KEY `address_id` (`address_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `products_suppliers`
--
ALTER TABLE `products_suppliers`
  ADD CONSTRAINT `products_suppliers_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `products_suppliers_ibfk_2` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);

--
-- Constraints for table `store`
--
ALTER TABLE `store`
  ADD CONSTRAINT `store_ibfk_1` FOREIGN KEY (`chain_store_id`) REFERENCES `chain_store` (`chain_store_id`),
  ADD CONSTRAINT `store_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);

--
-- Constraints for table `store_customers_buy`
--
ALTER TABLE `store_customers_buy`
  ADD CONSTRAINT `store_customers_buy_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`),
  ADD CONSTRAINT `store_customers_buy_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `store_customers_buy_ibfk_3` FOREIGN KEY (`employee_id`) REFERENCES `category` (`category_id`),
  ADD CONSTRAINT `store_customers_buy_ibfk_4` FOREIGN KEY (`product_id`) REFERENCES `category` (`category_id`);

--
-- Constraints for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD CONSTRAINT `suppliers_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
