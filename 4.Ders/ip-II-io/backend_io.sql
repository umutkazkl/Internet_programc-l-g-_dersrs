-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 25 Nis 2024, 18:12:09
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `backend_io`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `branches`
--

CREATE TABLE `branches` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `adress` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `branches`
--

INSERT INTO `branches` (`id`, `title`, `adress`, `created_at`) VALUES
(1, 'merkez', 'Kemer mahallesi', '2024-03-15 14:49:20'),
(2, 'İlçe', 'Adnan menderes mahallesi', '2024-03-15 14:53:51');

--
-- Tetikleyiciler `branches`
--
DELIMITER $$
CREATE TRIGGER `trg_branches_delete` AFTER DELETE ON `branches` FOR EACH ROW BEGIN
    INSERT INTO `backend_io`.`branches_logs` (
        `trigger`,
        branches_id,
        before_title,
        before_adress
    )
    VALUES (
        'deleted',
        OLD.id,
        OLD.title,
        OLD.adress
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_branches_insert` AFTER INSERT ON `branches` FOR EACH ROW BEGIN
    INSERT INTO `backend_io`.`branches_logs` (
        `trigger`,
        branches_id,
        after_title,
        after_adress
    )
    VALUES (
        'inserted',
        NEW.id,
        NEW.title,
        NEW.adress
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_branches_update` AFTER UPDATE ON `branches` FOR EACH ROW BEGIN
    INSERT INTO `backend_io`.`branches_logs` (
        `trigger`,
        branches_id,
        before_title,
        before_adress,
        after_title,
        after_adress
    )
    VALUES (
        'updated',
        OLD.id,
        OLD.title,
        OLD.adress,
        NEW.title,
        NEW.adress
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `branches_logs`
--

CREATE TABLE `branches_logs` (
  `id` int(11) NOT NULL,
  `branches_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_adress` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `after_adress` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `brands`
--

CREATE TABLE `brands` (
  `id` int(11) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `rank` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `brands`
--

INSERT INTO `brands` (`id`, `img_url`, `title`, `rank`, `is_active`, `created_at`) VALUES
(1, '1', 'LOFT', 1, 0, '2024-04-25 15:49:02'),
(3, '2', 'LC WAİKİKİ', 0, 0, '2024-04-25 15:49:05'),
(4, '3', 'KOTON', 0, 0, '2024-04-25 15:49:14');

--
-- Tetikleyiciler `brands`
--
DELIMITER $$
CREATE TRIGGER `trg_brands_delete` AFTER DELETE ON `brands` FOR EACH ROW insert into `backend_io`.`brands_logs`(
	`trigger`,
	brand_id,
	before_img_url,
	before_title,
	before_rank,
	before_is_active
) 

values(
		'deleted',
		OLD.id,
		OLD.img_url,
		OLD.title,
		OLD.rank,
		OLD.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_brands_update` AFTER UPDATE ON `brands` FOR EACH ROW insert into `backend_io`.`brands_logs`(
	brand_id,
	`trigger`,
	before_img_url,
	before_title,
	before_rank,
	before_is_active,
	after_img_url,
	after_title,
	after_rank,
	after_is_active
)

values(
		NEW.id,
		'updated',
		OLD.img_url,
		OLD.title,
		OLD.rank,
		OLD.is_active,
		NEW.img_url,
		NEW.title,
		NEW.rank,
		NEW.is_active
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `brands_logs`
--

CREATE TABLE `brands_logs` (
  `id` int(11) NOT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_rank` int(11) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_rank` int(11) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `brands_logs`
--

INSERT INTO `brands_logs` (`id`, `brand_id`, `trigger`, `before_img_url`, `before_title`, `before_rank`, `before_is_active`, `after_img_url`, `after_title`, `after_rank`, `after_is_active`, `created_at`) VALUES
(1, 1, 'inserted', NULL, NULL, NULL, NULL, '1', '1', 1, 1, '0000-00-00 00:00:00'),
(2, 1, 'updated', '1', '1', 1, 1, '1', '111', 1, 1, '0000-00-00 00:00:00'),
(4, 1, 'inserted', NULL, NULL, NULL, NULL, '11', '1', 1, 0, '0000-00-00 00:00:00'),
(5, 1, 'updated', '11', '1', 1, 0, '11', '111', 1, 0, '0000-00-00 00:00:00'),
(6, 1, 'updated', '11', '111', 1, 0, '111', '111', 1, 0, '0000-00-00 00:00:00'),
(7, 2, 'deleted', '', 'hljk', 0, 0, NULL, NULL, NULL, NULL, '2024-04-25 15:30:26'),
(8, 3, 'updated', '', 'adlsçd', 0, 0, '', 'LC WAİKİKİ', 0, 0, '2024-04-25 15:37:39'),
(9, 4, 'updated', '', 'asdasd', 0, 0, '', 'KOTON', 0, 0, '2024-04-25 15:37:50'),
(10, 1, 'updated', '111', '111', 1, 0, '111', 'LOFT', 1, 0, '2024-04-25 15:38:00'),
(11, 1, 'updated', '111', 'LOFT', 1, 0, '', 'LOFT', 1, 0, '2024-04-25 15:47:59'),
(12, 5, 'deleted', '', 'lkll', 0, 0, NULL, NULL, NULL, NULL, '2024-04-25 15:48:10'),
(13, 1, 'updated', '', 'LOFT', 1, 0, '1', 'LOFT', 1, 0, '2024-04-25 15:49:02'),
(14, 3, 'updated', '', 'LC WAİKİKİ', 0, 0, '2', 'LC WAİKİKİ', 0, 0, '2024-04-25 15:49:05'),
(15, 4, 'updated', '', 'KOTON', 0, 0, '3', 'KOTON', 0, 0, '2024-04-25 15:49:14');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tetikleyiciler `products`
--
DELIMITER $$
CREATE TRIGGER `trg_products_delete` AFTER DELETE ON `products` FOR EACH ROW insert into `backend_io`.`products_logs`(
	product_id,
	`trigger`,
	before_img_url,
	before_title,
	before_rank,
	before_is_active
)

values(
	OLD.id,
	'deleted',
	OLD.img_url,
	OLD.title,
	OLD.rank,
	OLD.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_products_insert` AFTER INSERT ON `products` FOR EACH ROW insert into `backend_io`.`products_logs`(
	product_id,
	`trigger`,
	after_img_url,
	after_title,
	after_rank,
	after_is_active
) 

values(
	NEW.id,
	'inserted',
	NEW.img_url,
	NEW.title,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_products_update` AFTER UPDATE ON `products` FOR EACH ROW insert into `backend_io`.`products_logs`(
	product_id,
	`trigger`,
	before_img_url,
	before_title,
	before_rank,
	before_is_active,
	after_img_url,
	after_title,
	after_rank,
	after_is_active
)

values(
	OLD.id,
	'updated',
	OLD.img_url,
	OLD.title,
	OLD.rank,
	OLD.is_active,
	NEW.img_url,
	NEW.title,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `products_logs`
--

CREATE TABLE `products_logs` (
  `id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_description` text DEFAULT NULL,
  `before_rank` int(11) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_description` text DEFAULT NULL,
  `after_rank` int(11) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product_categories`
--

CREATE TABLE `product_categories` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `product_categories`
--

INSERT INTO `product_categories` (`id`, `title`, `is_active`, `created_at`) VALUES
(3, 'aasdasdlkj', 0, '2024-03-21 17:03:02');

--
-- Tetikleyiciler `product_categories`
--
DELIMITER $$
CREATE TRIGGER `trg_product_categories_delete` AFTER DELETE ON `product_categories` FOR EACH ROW BEGIN
    INSERT INTO `backend_io`.`product_categories_logs` (
        `trigger`,
        product_categories_id,
        before_title,
        before_is_active
    )
    VALUES (
        'deleted',
        OLD.id,
        OLD.title,
        OLD.is_active
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_product_categories_insert` AFTER INSERT ON `product_categories` FOR EACH ROW BEGIN
    INSERT INTO `backend_io`.`product_categories_logs` (
        `trigger`,
        product_categories_id,
        after_title,
        after_is_active
    )
    VALUES (
        'inserted',
        NEW.id,
        NEW.title,
        NEW.is_active
    );
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_product_categories_update` AFTER UPDATE ON `product_categories` FOR EACH ROW BEGIN
    INSERT INTO `backend_io`.`product_categories_logs` (
        `trigger`,
        product_categories_id,
        before_title,
        before_is_active,
        after_title,
        after_is_active
    )
    VALUES (
        'updated',
        OLD.id,
        OLD.title,
        OLD.is_active,
        NEW.title,
        NEW.is_active
    );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product_categories_logs`
--

CREATE TABLE `product_categories_logs` (
  `id` int(11) NOT NULL,
  `product_categories_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_adress` int(11) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_adress` int(11) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `product_categories_logs`
--

INSERT INTO `product_categories_logs` (`id`, `product_categories_id`, `trigger`, `before_title`, `before_adress`, `before_is_active`, `after_title`, `after_adress`, `after_is_active`, `created_at`) VALUES
(6, 1, 'updated', 'Kıyafet', NULL, 1, 'Kıyyafet', NULL, 1, '0000-00-00 00:00:00'),
(7, 1, 'deleted', 'Kıyyafet', NULL, 1, NULL, NULL, NULL, '0000-00-00 00:00:00'),
(8, 2, 'deleted', 'Kıyafet', NULL, 1, NULL, NULL, NULL, '2024-04-25 15:00:18'),
(9, 3, 'updated', 'aasdasd', NULL, 0, 'aasdasdlkj', NULL, 0, '2024-04-25 15:00:25');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rank` int(11) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `is_cover` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tetikleyiciler `product_images`
--
DELIMITER $$
CREATE TRIGGER `trg_product_images_delete` AFTER DELETE ON `product_images` FOR EACH ROW insert into `backend_io`.`product_images_logs`(
	product_image_id,
	`trigger`,
	before_product_id,
	before_rank,
	before_img_url,
	before_is_cover,
	before_is_active
)

values(
	OLD.id,
	'delete',
	OLD.product_id,
	OLD.rank,
	OLD.img_url,
	OLD.is_cover,
	OLD.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_product_images_insert` AFTER INSERT ON `product_images` FOR EACH ROW insert into `backend_io`.`product_images_logs`(
	product_image_id,
	`trigger`,
	after_product_id,
	after_rank,
	after_img_url,
	after_is_cover,
	after_is_active
)

values(
	NEW.id,
	'insert',
	NEW.product_id,
	NEW.rank,
	NEW.img_url,
	NEW.is_cover,
	NEW.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_product_images_update` AFTER UPDATE ON `product_images` FOR EACH ROW insert into `backend_io`.`product_images_logs`(
	product_image_id,
	`trigger`,
	before_product_id,
	before_rank,
	before_img_url,
	before_is_cover,
	before_is_active,
	after_product_id,
	after_rank,
	after_img_url,
	after_is_cover,
	after_is_active
)

values(
	NEW.id,
	'update',
	OLD.product_id,
	OLD.rank,
	OLD.img_url,
	OLD.is_cover,
	OLD.is_active,
	NEW.product_id,
	NEW.rank,
	NEW.img_url,
	NEW.is_cover,
	NEW.is_active
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product_images_logs`
--

CREATE TABLE `product_images_logs` (
  `id` int(11) NOT NULL,
  `product_image_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_product_id` int(11) DEFAULT NULL,
  `before_rank` int(11) DEFAULT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_is_cover` tinyint(1) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_product_id` int(11) DEFAULT NULL,
  `after_rank` int(11) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_is_cover` tinyint(1) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `references`
--

CREATE TABLE `references` (
  `id` int(11) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tetikleyiciler `references`
--
DELIMITER $$
CREATE TRIGGER `trg_references_delete` AFTER DELETE ON `references` FOR EACH ROW insert into `backend_io`.`references_logs`(
	reference_id,
	`trigger`,
	before_img_url,
	before_title,
	before_description,
	before_rank,
	before_is_active
)

values(
	OLD.id,
	'deleted',
	OLD.img_url,
	OLD.title,
	OLD.description,
	OLD.rank,
	OLD.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_references_insert` AFTER INSERT ON `references` FOR EACH ROW insert into `backend_io`.`references_logs`(
	reference_id,
	`trigger`,
	after_img_url,
	after_title,
	after_description,
	after_rank,
	after_is_active
)

values(
	NEW.id,
	'inserted',
	NEW.img_url,
	NEW.title,
	NEW.description,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_references_update` AFTER UPDATE ON `references` FOR EACH ROW insert into `backend_io`.`references_logs`(
	reference_id,
	`trigger`,
	before_img_url,
	before_title,
	before_description,
	before_rank,
	before_is_active,
	after_img_url,
	after_title,
	after_description,
	after_rank,
	after_is_active
)

values(
	NEW.id,
	'updated',
	OLD.img_url,
	OLD.title,
	OLD.description,
	OLD.rank,
	OLD.is_active,
	NEW.img_url,
	NEW.title,
	NEW.description,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `references_logs`
--

CREATE TABLE `references_logs` (
  `id` int(11) NOT NULL,
  `reference_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_description` text DEFAULT NULL,
  `before_rank` int(11) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_description` text DEFAULT NULL,
  `after_rank` int(11) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `url` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tetikleyiciler `services`
--
DELIMITER $$
CREATE TRIGGER `trg_services_delete` AFTER DELETE ON `services` FOR EACH ROW insert into `backend_io`.`services_logs`(
	service_id,
	`trigger`,
	before_img_url,
	before_title,
	before_url,
	before_description,
	before_rank,
	before_is_active
)

values(
	OLD.id,
	'deleted',
	OLD.img_url,
	OLD.title,
	OLD.url,
	OLD.description,
	OLD.rank,
	OLD.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_services_insert` AFTER INSERT ON `services` FOR EACH ROW insert into `backend_io`.`services_logs`(
	service_id,
	`trigger`,
	after_img_url,
	after_title,
	after_url,
	after_description,
	after_rank,
	after_is_active
)

values(
	NEW.id,
	'inserted',
	NEW.img_url,
	NEW.title,
	NEW.url,
	NEW.description,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_services_update` AFTER UPDATE ON `services` FOR EACH ROW insert into `backend_io`.`services_logs`(
	service_id,
	`trigger`,
	before_img_url,
	before_title,
	before_url,
	before_description,
	before_rank,
	before_is_active,
	after_img_url,
	after_title,
	after_url,
	after_description,
	after_rank,
	after_is_active
)

values(
	NEW.id,
	'updated',
	OLD.img_url,
	OLD.title,
	OLD.url,
	OLD.description,
	OLD.rank,
	OLD.is_active,
	NEW.img_url,
	NEW.title,
	NEW.url,
	NEW.description,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `services_logs`
--

CREATE TABLE `services_logs` (
  `id` int(11) NOT NULL,
  `service_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_url` varchar(50) DEFAULT NULL,
  `before_description` text DEFAULT NULL,
  `before_rank` int(11) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_url` varchar(50) DEFAULT NULL,
  `after_description` text DEFAULT NULL,
  `after_rank` int(11) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `company_name` varchar(50) NOT NULL,
  `adress` varchar(100) NOT NULL,
  `about_us` text NOT NULL,
  `slogan` varchar(100) NOT NULL,
  `mission` text NOT NULL,
  `vision` text NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `mobile_img_url` varchar(50) NOT NULL,
  `favicon` varchar(50) NOT NULL,
  `phone_one` varchar(50) NOT NULL,
  `phone_two` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `facebook` varchar(50) NOT NULL,
  `twitter` varchar(50) NOT NULL,
  `instagram` varchar(50) NOT NULL,
  `linkedin` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `gsm_one` varchar(50) NOT NULL,
  `gsm_two` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tetikleyiciler `settings`
--
DELIMITER $$
CREATE TRIGGER `trg_settings_delete` AFTER DELETE ON `settings` FOR EACH ROW insert into `backend_io`.`settings_logs`(
	setting_id,
	`trigger`,
	before_company_name,
	before_adress,
	before_about_us,
	before_slogan,
	before_mission,
	before_vision,
	before_img_url,
	before_mobile_img_url,
	before_favicon,
	before_phone_one,
	before_phone_two,
	before_email,
	before_facebook,
	before_twitter,
	before_instagram,
	before_linkedin,
	before_is_active,
	before_gsm_one,
	before_gsm_two	
)

values(
	OLD.id,
	'deleted',
	OLD.company_name,
	OLD.adress,
	OLD.about_us,
	OLD.slogan,
	OLD.mission,
	OLD.vision,
	OLD.img_url,
	OLD.mobile_img_url,
	OLD.favicon,
	OLD.phone_one,
	OLD.phone_two,
	OLD.email,
	OLD.facebook,
	OLD.twitter,
	OLD.instagram,
	OLD.linkedin,
	OLD.is_active,
	OLD.gsm_one,
	OLD.gsm_two
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_settings_insert` AFTER INSERT ON `settings` FOR EACH ROW insert into `backend_io`.`settings_logs`(
	setting_id,
	`trigger`,
	after_company_name,
	after_adress,
	after_about_us,
	after_slogan,
	after_mission,
	after_vision,
	after_img_url,
	after_mobile_img_url,
	after_favicon,
	after_phone_one,
	after_phone_two,
	after_email,
	after_facebook,
	after_twitter,
	after_instagram,
	after_linkedin,
	after_is_active,
	after_gsm_one,
	after_gsm_two	
)

values(
	NEW.id,
	'inserted',
	NEW.company_name,
	NEW.adress,
	NEW.about_us,
	NEW.slogan,
	NEW.mission,
	NEW.vision,
	NEW.img_url,
	NEW.mobile_img_url,
	NEW.favicon,
	NEW.phone_one,
	NEW.phone_two,
	NEW.email,
	NEW.facebook,
	NEW.twitter,
	NEW.instagram,
	NEW.linkedin,
	NEW.is_active,
	NEW.gsm_one,
	NEW.gsm_two
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_settings_update` AFTER UPDATE ON `settings` FOR EACH ROW insert into `backend_io`.`settings_logs`(
	setting_id,
	`trigger`,
	before_company_name,
	before_adress,
	before_about_us,
	before_slogan,
	before_mission,
	before_vision,
	before_img_url,
	before_mobile_img_url,
	before_favicon,
	before_phone_one,
	before_phone_two,
	before_email,
	before_facebook,
	before_twitter,
	before_instagram,
	before_linkedin,
	before_is_active,
	before_gsm_one,
	before_gsm_two,
	after_company_name,
	after_adress,
	after_about_us,
	after_slogan,
	after_mission,
	after_vision,
	after_img_url,
	after_mobile_img_url,
	after_favicon,
	after_phone_one,
	after_phone_two,
	after_email,
	after_facebook,
	after_twitter,
	after_instagram,
	after_linkedin,
	after_is_active,
	after_gsm_one,
	after_gsm_two
)

values(
	NEW.id,
	'updated',
	OLD.company_name,
	OLD.adress,
	OLD.about_us,
	OLD.slogan,
	OLD.mission,
	OLD.vision,
	OLD.img_url,
	OLD.mobile_img_url,
	OLD.favicon,
	OLD.phone_one,
	OLD.phone_two,
	OLD.email,
	OLD.facebook,
	OLD.twitter,
	OLD.instagram,
	OLD.linkedin,
	OLD.is_active,
	OLD.gsm_one,
	OLD.gsm_two,
	NEW.company_name,
	NEW.adress,
	NEW.about_us,
	NEW.slogan,
	NEW.mission,
	NEW.vision,
	NEW.img_url,
	NEW.mobile_img_url,
	NEW.favicon,
	NEW.phone_one,
	NEW.phone_two,
	NEW.email,
	NEW.facebook,
	NEW.twitter,
	NEW.instagram,
	NEW.linkedin,
	NEW.is_active,
	NEW.gsm_one,
	NEW.gsm_two
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `settings_logs`
--

CREATE TABLE `settings_logs` (
  `id` int(11) NOT NULL,
  `setting_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_company_name` varchar(50) DEFAULT NULL,
  `before_adress` varchar(100) DEFAULT NULL,
  `before_about_us` text DEFAULT NULL,
  `before_slogan` varchar(100) DEFAULT NULL,
  `before_mission` text DEFAULT NULL,
  `before_vision` text DEFAULT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_mobile_img_url` varchar(50) DEFAULT NULL,
  `before_favicon` varchar(50) DEFAULT NULL,
  `before_phone_one` varchar(50) DEFAULT NULL,
  `before_phone_two` varchar(50) DEFAULT NULL,
  `before_email` varchar(50) DEFAULT NULL,
  `before_facebook` varchar(50) DEFAULT NULL,
  `before_twitter` varchar(50) DEFAULT NULL,
  `before_instagram` varchar(50) DEFAULT NULL,
  `before_linkedin` varchar(50) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `before_gsm_one` varchar(50) DEFAULT NULL,
  `before_gsm_two` varchar(50) DEFAULT NULL,
  `after_company_name` varchar(50) DEFAULT NULL,
  `after_adress` varchar(100) DEFAULT NULL,
  `after_about_us` text DEFAULT NULL,
  `after_slogan` varchar(100) DEFAULT NULL,
  `after_mission` text DEFAULT NULL,
  `after_vision` text DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_mobile_img_url` varchar(50) DEFAULT NULL,
  `after_favicon` varchar(50) DEFAULT NULL,
  `after_phone_one` varchar(50) DEFAULT NULL,
  `after_phone_two` varchar(50) DEFAULT NULL,
  `after_email` varchar(50) DEFAULT NULL,
  `after_facebook` varchar(50) DEFAULT NULL,
  `after_twitter` varchar(50) DEFAULT NULL,
  `after_instagram` varchar(50) DEFAULT NULL,
  `after_linkedin` varchar(50) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `after_gsm_one` varchar(50) DEFAULT NULL,
  `after_gsm_two` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `testimanials`
--

CREATE TABLE `testimanials` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `company` varchar(100) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `rank` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tetikleyiciler `testimanials`
--
DELIMITER $$
CREATE TRIGGER `trg_testiminals_delete` AFTER DELETE ON `testimanials` FOR EACH ROW insert into `backend_io`.`testimanials_logs`(
	testimanial_id,
	`trigger`,
	before_title,
	before_description,
	before_full_name,
	before_company,
	before_img_url,
	before_rank,
	before_is_active
)

values(
	OLD.id,
	'deleted',
	OLD.title,
	OLD.description,
	OLD.full_name,
	OLD.company,
	OLD.img_url,
	OLD.rank,
	OLD.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_testiminals_insert` AFTER INSERT ON `testimanials` FOR EACH ROW insert into `backend_io`.`testimanials_logs`(
	testimanial_id,
	`trigger`,
	after_title,
	after_description,
	after_full_name,
	after_company,
	after_img_url,
	after_rank,
	after_is_active
)

values(
	NEW.id,
	'inserted',
	NEW.title,
	NEW.description,
	NEW.full_name,
	NEW.company,
	NEW.img_url,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_testiminals_update` AFTER UPDATE ON `testimanials` FOR EACH ROW insert into `backend_io`.`testimanials_logs`(
	testimanial_id,
	`trigger`,
	before_title,
	before_description,
	before_full_name,
	before_company,
	before_img_url,
	before_rank,
	before_is_active,
	after_title,
	after_description,
	after_full_name,
	after_company,
	after_img_url,
	after_rank,
	after_is_active
)

values(
	NEW.id,
	'updated',
	OLD.title,
	OLD.description,
	OLD.full_name,
	OLD.company,
	OLD.img_url,
	OLD.rank,
	OLD.is_active,
	NEW.title,
	NEW.description,
	NEW.full_name,
	NEW.company,
	NEW.img_url,
	NEW.rank,
	NEW.is_active
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `testimanials_logs`
--

CREATE TABLE `testimanials_logs` (
  `id` int(11) NOT NULL,
  `testimanial_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_description` text DEFAULT NULL,
  `before_full_name` varchar(100) DEFAULT NULL,
  `before_company` varchar(100) DEFAULT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_rank` int(11) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_description` text DEFAULT NULL,
  `after_full_name` varchar(100) DEFAULT NULL,
  `after_company` varchar(100) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_rank` int(11) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tetikleyiciler `users`
--
DELIMITER $$
CREATE TRIGGER `trg_users_delete` AFTER DELETE ON `users` FOR EACH ROW insert into `backend_io`.`users_logs`(
	user_id,
	`trigger`,
	before_img_url,
	before_email,
	before_name,
	before_surname,
	before_password,
	before_is_active
)
values(
	OLD.id,
	'deleted',
	OLD.img_url,
	OLD.email,
	OLD.name,
	OLD.surname,
	OLD.password,
	OLD.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_users_insert` AFTER INSERT ON `users` FOR EACH ROW insert into `backend_io`.`users_logs`(
	`trigger`,
	user_id,
	after_img_url,
	after_email,
	after_name,
	after_surname,
	after_password,
	after_is_active
) 

values(
		'inserted',
		NEW.id,
		NEW.img_url,
		NEW.email,
		NEW.name,
		NEW.surname,
		NEW.password,
		NEW.is_active
)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `trg_users_update` AFTER UPDATE ON `users` FOR EACH ROW insert into `backend_io`.`users_logs`(
	user_id,
	`trigger`,
	before_img_url,
	before_email,
	before_name,
	before_surname,
	before_password,
	before_is_active,
	after_img_url,
	after_email,
	after_name,
	after_surname,
	after_password,
	after_is_active
)
values(
	OLD.id,
	'updated',
	OLD.img_url,
	OLD.email,
	OLD.name,
	OLD.surname,
	OLD.password,
	OLD.is_active,
	NEW.img_url,
	NEW.email,
	NEW.name,
	NEW.surname,
	NEW.password,
	NEW.is_active
)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users_logs`
--

CREATE TABLE `users_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_email` varchar(50) DEFAULT NULL,
  `before_name` varchar(50) DEFAULT NULL,
  `before_surname` varchar(50) DEFAULT NULL,
  `before_password` varchar(50) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_email` varchar(50) DEFAULT NULL,
  `after_name` varchar(50) DEFAULT NULL,
  `after_surname` varchar(50) DEFAULT NULL,
  `after_password` varchar(50) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `branches_logs`
--
ALTER TABLE `branches_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `brands_logs`
--
ALTER TABLE `brands_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `products_logs`
--
ALTER TABLE `products_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `product_categories_logs`
--
ALTER TABLE `product_categories_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `product_images_logs`
--
ALTER TABLE `product_images_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `references`
--
ALTER TABLE `references`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `references_logs`
--
ALTER TABLE `references_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `services_logs`
--
ALTER TABLE `services_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Tablo için indeksler `settings_logs`
--
ALTER TABLE `settings_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `testimanials`
--
ALTER TABLE `testimanials`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `testimanials_logs`
--
ALTER TABLE `testimanials_logs`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Tablo için indeksler `users_logs`
--
ALTER TABLE `users_logs`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `branches`
--
ALTER TABLE `branches`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tablo için AUTO_INCREMENT değeri `branches_logs`
--
ALTER TABLE `branches_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `brands_logs`
--
ALTER TABLE `brands_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Tablo için AUTO_INCREMENT değeri `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `products_logs`
--
ALTER TABLE `products_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `product_categories`
--
ALTER TABLE `product_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tablo için AUTO_INCREMENT değeri `product_categories_logs`
--
ALTER TABLE `product_categories_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Tablo için AUTO_INCREMENT değeri `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `product_images_logs`
--
ALTER TABLE `product_images_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `references`
--
ALTER TABLE `references`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `references_logs`
--
ALTER TABLE `references_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `services_logs`
--
ALTER TABLE `services_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `settings_logs`
--
ALTER TABLE `settings_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `testimanials`
--
ALTER TABLE `testimanials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `testimanials_logs`
--
ALTER TABLE `testimanials_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `users_logs`
--
ALTER TABLE `users_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
