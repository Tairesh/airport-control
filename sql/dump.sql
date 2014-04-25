-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Хост: 127.0.0.1
-- Время создания: Апр 25 2014 г., 05:28
-- Версия сервера: 5.5.25
-- Версия PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `airport`
--

-- --------------------------------------------------------

--
-- Структура таблицы `airplanes`
--

CREATE TABLE IF NOT EXISTS `airplanes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `airplanes`
--

INSERT INTO `airplanes` (`id`, `company_id`, `model_id`) VALUES
(1, 1, 2),
(2, 1, 1),
(3, 1, 2),
(4, 2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `airports`
--

CREATE TABLE IF NOT EXISTS `airports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf32_unicode_ci NOT NULL,
  `latitude` float NOT NULL,
  `longitude` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `airports`
--

INSERT INTO `airports` (`id`, `name`, `latitude`, `longitude`) VALUES
(1, 'Кольцово (Екатеринбург)', 56.8575, 60.6125),
(2, 'Орли (Париж)', 48.8567, 2.351),
(3, 'Хитроу(Лондон)', 51.5002, -0.1262),
(4, 'Международный аэропорт имени Джона Кеннеди (Нью-Йорк)', 40.43, -74);

-- --------------------------------------------------------

--
-- Структура таблицы `companies`
--

CREATE TABLE IF NOT EXISTS `companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `companies`
--

INSERT INTO `companies` (`id`, `name`) VALUES
(1, 'Аэрофлот'),
(2, 'Уральские Авиалинии');

-- --------------------------------------------------------

--
-- Структура таблицы `flights`
--

CREATE TABLE IF NOT EXISTS `flights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `airplane_id` int(11) NOT NULL,
  `from_id` int(11) NOT NULL,
  `to_id` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `end` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `flights`
--

INSERT INTO `flights` (`id`, `airplane_id`, `from_id`, `to_id`, `start`, `end`, `status_id`) VALUES
(1, 4, 1, 3, 1398486194, 1398500594, 1),
(2, 3, 2, 1, 1398486294, 1398504594, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `models`
--

CREATE TABLE IF NOT EXISTS `models` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf32_unicode_ci NOT NULL,
  `capacity` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `models`
--

INSERT INTO `models` (`id`, `name`, `capacity`) VALUES
(1, 'Boeing 777', 550),
(2, 'Airbus A320', 180);

-- --------------------------------------------------------

--
-- Структура таблицы `passengers`
--

CREATE TABLE IF NOT EXISTS `passengers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf32_unicode_ci NOT NULL,
  `passport` varchar(10) COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `passengers`
--

INSERT INTO `passengers` (`id`, `name`, `passport`) VALUES
(1, 'Илья Горохов', '123 456'),
(2, 'Ashley Swenson', '654 321');

-- --------------------------------------------------------

--
-- Структура таблицы `statuses`
--

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf32_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=7 ;

--
-- Дамп данных таблицы `statuses`
--

INSERT INTO `statuses` (`id`, `name`) VALUES
(0, 'Неизвестно'),
(1, 'Запланирован'),
(2, 'Посадка'),
(3, 'В полете'),
(4, 'Прибыл'),
(5, 'Отменен'),
(6, 'Авария');

-- --------------------------------------------------------

--
-- Структура таблицы `tickets`
--

CREATE TABLE IF NOT EXISTS `tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `passenger_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_unicode_ci AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
