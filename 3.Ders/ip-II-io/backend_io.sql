-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1:3306
-- Üretim Zamanı: 21 Mar 2024, 17:44:40
-- Sunucu sürümü: 8.0.31
-- PHP Sürümü: 8.0.26

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

DROP TABLE IF EXISTS `branches`;
CREATE TABLE IF NOT EXISTS `branches` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `adress` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;

--
-- Tablo döküm verisi `branches`
--

INSERT INTO `branches` (`id`, `title`, `adress`, `created_at`) VALUES
(1, 'merkez', 'Kemer mahallesi', '2024-03-15 14:49:20'),
(2, 'İlçe', 'Adnan menderes mahallesi', '2024-03-15 14:53:51');

--
-- Tetikleyiciler `branches`
--
DROP TRIGGER IF EXISTS `trg_branches_delete`;
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
DROP TRIGGER IF EXISTS `trg_branches_insert`;
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
DROP TRIGGER IF EXISTS `trg_branches_update`;
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

DROP TABLE IF EXISTS `branches_logs`;
CREATE TABLE IF NOT EXISTS `branches_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `branches_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_adress` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `after_adress` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `brands`
--

DROP TABLE IF EXISTS `brands`;
CREATE TABLE IF NOT EXISTS `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `rank` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;

--
-- Tablo döküm verisi `brands`
--

INSERT INTO `brands` (`id`, `img_url`, `title`, `rank`, `is_active`, `created_at`) VALUES
(1, '111', '111', 1, 0, '2024-03-14 12:23:54');

--
-- Tetikleyiciler `brands`
--
DROP TRIGGER IF EXISTS `trg_brands_delete`;
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
DROP TRIGGER IF EXISTS `trg_brands_update`;
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

DROP TABLE IF EXISTS `brands_logs`;
CREATE TABLE IF NOT EXISTS `brands_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `brand_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_rank` int DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_rank` int DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3;

--
-- Tablo döküm verisi `brands_logs`
--

INSERT INTO `brands_logs` (`id`, `brand_id`, `trigger`, `before_img_url`, `before_title`, `before_rank`, `before_is_active`, `after_img_url`, `after_title`, `after_rank`, `after_is_active`, `created_at`) VALUES
(1, 1, 'inserted', NULL, NULL, NULL, NULL, '1', '1', 1, 1, '0000-00-00 00:00:00'),
(2, 1, 'updated', '1', '1', 1, 1, '1', '111', 1, 1, '0000-00-00 00:00:00'),
(4, 1, 'inserted', NULL, NULL, NULL, NULL, '11', '1', 1, 0, '0000-00-00 00:00:00'),
(5, 1, 'updated', '11', '1', 1, 0, '11', '111', 1, 0, '0000-00-00 00:00:00'),
(6, 1, 'updated', '11', '111', 1, 0, '111', '111', 1, 0, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tetikleyiciler `products`
--
DROP TRIGGER IF EXISTS `trg_products_delete`;
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
DROP TRIGGER IF EXISTS `trg_products_insert`;
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
DROP TRIGGER IF EXISTS `trg_products_update`;
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

DROP TABLE IF EXISTS `products_logs`;
CREATE TABLE IF NOT EXISTS `products_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_description` text,
  `before_rank` int DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_description` text,
  `after_rank` int DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product_categories`
--

DROP TABLE IF EXISTS `product_categories`;
CREATE TABLE IF NOT EXISTS `product_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `is_active` tinyint NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;

--
-- Tablo döküm verisi `product_categories`
--

INSERT INTO `product_categories` (`id`, `title`, `is_active`, `created_at`) VALUES
(2, 'Kıyafet', 1, '2024-03-14 12:47:14'),
(3, 'aasdasd', 0, '2024-03-21 17:03:02');

--
-- Tetikleyiciler `product_categories`
--
DROP TRIGGER IF EXISTS `trg_product_categories_delete`;
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
DROP TRIGGER IF EXISTS `trg_product_categories_insert`;
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
DROP TRIGGER IF EXISTS `trg_product_categories_update`;
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

DROP TABLE IF EXISTS `product_categories_logs`;
CREATE TABLE IF NOT EXISTS `product_categories_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_categories_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_adress` int DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_adress` int DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;

--
-- Tablo döküm verisi `product_categories_logs`
--

INSERT INTO `product_categories_logs` (`id`, `product_categories_id`, `trigger`, `before_title`, `before_adress`, `before_is_active`, `after_title`, `after_adress`, `after_is_active`, `created_at`) VALUES
(6, 1, 'updated', 'Kıyafet', NULL, 1, 'Kıyyafet', NULL, 1, '0000-00-00 00:00:00'),
(7, 1, 'deleted', 'Kıyyafet', NULL, 1, NULL, NULL, NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product_images`
--

DROP TABLE IF EXISTS `product_images`;
CREATE TABLE IF NOT EXISTS `product_images` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `rank` int NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `is_cover` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tetikleyiciler `product_images`
--
DROP TRIGGER IF EXISTS `trg_product_images_delete`;
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
DROP TRIGGER IF EXISTS `trg_product_images_insert`;
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
DROP TRIGGER IF EXISTS `trg_product_images_update`;
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

DROP TABLE IF EXISTS `product_images_logs`;
CREATE TABLE IF NOT EXISTS `product_images_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_image_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_product_id` int DEFAULT NULL,
  `before_rank` int DEFAULT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_is_cover` tinyint(1) DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_product_id` int DEFAULT NULL,
  `after_rank` int DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_is_cover` tinyint(1) DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `references`
--

DROP TABLE IF EXISTS `references`;
CREATE TABLE IF NOT EXISTS `references` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tetikleyiciler `references`
--
DROP TRIGGER IF EXISTS `trg_references_delete`;
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
DROP TRIGGER IF EXISTS `trg_references_insert`;
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
DROP TRIGGER IF EXISTS `trg_references_update`;
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

DROP TABLE IF EXISTS `references_logs`;
CREATE TABLE IF NOT EXISTS `references_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `reference_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_description` text,
  `before_rank` int DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_description` text,
  `after_rank` int DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `services`
--

DROP TABLE IF EXISTS `services`;
CREATE TABLE IF NOT EXISTS `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img_url` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `url` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `rank` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tetikleyiciler `services`
--
DROP TRIGGER IF EXISTS `trg_services_delete`;
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
DROP TRIGGER IF EXISTS `trg_services_insert`;
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
DROP TRIGGER IF EXISTS `trg_services_update`;
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

DROP TABLE IF EXISTS `services_logs`;
CREATE TABLE IF NOT EXISTS `services_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_url` varchar(50) DEFAULT NULL,
  `before_description` text,
  `before_rank` int DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_url` varchar(50) DEFAULT NULL,
  `after_description` text,
  `after_rank` int DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `settings`
--

DROP TABLE IF EXISTS `settings`;
CREATE TABLE IF NOT EXISTS `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tetikleyiciler `settings`
--
DROP TRIGGER IF EXISTS `trg_settings_delete`;
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
DROP TRIGGER IF EXISTS `trg_settings_insert`;
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
DROP TRIGGER IF EXISTS `trg_settings_update`;
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

DROP TABLE IF EXISTS `settings_logs`;
CREATE TABLE IF NOT EXISTS `settings_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `setting_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_company_name` varchar(50) DEFAULT NULL,
  `before_adress` varchar(100) DEFAULT NULL,
  `before_about_us` text,
  `before_slogan` varchar(100) DEFAULT NULL,
  `before_mission` text,
  `before_vision` text,
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
  `after_about_us` text,
  `after_slogan` varchar(100) DEFAULT NULL,
  `after_mission` text,
  `after_vision` text,
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
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `testimanials`
--

DROP TABLE IF EXISTS `testimanials`;
CREATE TABLE IF NOT EXISTS `testimanials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `company` varchar(100) NOT NULL,
  `img_url` varchar(50) NOT NULL,
  `rank` int NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tetikleyiciler `testimanials`
--
DROP TRIGGER IF EXISTS `trg_testiminals_delete`;
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
DROP TRIGGER IF EXISTS `trg_testiminals_insert`;
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
DROP TRIGGER IF EXISTS `trg_testiminals_update`;
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

DROP TABLE IF EXISTS `testimanials_logs`;
CREATE TABLE IF NOT EXISTS `testimanials_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `testimanial_id` int DEFAULT NULL,
  `trigger` varchar(15) NOT NULL,
  `before_title` varchar(50) DEFAULT NULL,
  `before_description` text,
  `before_full_name` varchar(100) DEFAULT NULL,
  `before_company` varchar(100) DEFAULT NULL,
  `before_img_url` varchar(50) DEFAULT NULL,
  `before_rank` int DEFAULT NULL,
  `before_is_active` tinyint(1) DEFAULT NULL,
  `after_title` varchar(50) DEFAULT NULL,
  `after_description` text,
  `after_full_name` varchar(100) DEFAULT NULL,
  `after_company` varchar(100) DEFAULT NULL,
  `after_img_url` varchar(50) DEFAULT NULL,
  `after_rank` int DEFAULT NULL,
  `after_is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `img_url` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Tetikleyiciler `users`
--
DROP TRIGGER IF EXISTS `trg_users_delete`;
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
DROP TRIGGER IF EXISTS `trg_users_insert`;
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
DROP TRIGGER IF EXISTS `trg_users_update`;
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

DROP TABLE IF EXISTS `users_logs`;
CREATE TABLE IF NOT EXISTS `users_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
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
  `created_at` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
