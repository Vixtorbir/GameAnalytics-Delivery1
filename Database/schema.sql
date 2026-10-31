-- phpMyAdmin SQL Dump
-- version 5.2.2deb1+deb13u1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 31-10-2026 a las 09:35:31
-- Versión del servidor: 11.8.6-MariaDB-0+deb13u1 from Debian
-- Versión de PHP: 8.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `marcam5`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Item`
--

CREATE TABLE `Item` (
  `ItemID` int(11) NOT NULL,
  `ItemPrice` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Purchases`
--

CREATE TABLE `Purchases` (
  `PurchasesID` int(11) NOT NULL,
  `SessionID` int(10) UNSIGNED NOT NULL,
  `ItemID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `SessionUser`
--

CREATE TABLE `SessionUser` (
  `SessionID` int(10) UNSIGNED NOT NULL,
  `StartSession` datetime NOT NULL,
  `EndSession` datetime DEFAULT NULL,
  `UserID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

CREATE TABLE `User` (
  `UserID` int(11) NOT NULL,
  `UserAge` int(10) UNSIGNED DEFAULT NULL,
  `UserGender` float DEFAULT NULL,
  `UserCountry` text DEFAULT NULL,
  `UserName` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Item`
--
ALTER TABLE `Item`
  ADD PRIMARY KEY (`ItemID`);

--
-- Indices de la tabla `Purchases`
--
ALTER TABLE `Purchases`
  ADD PRIMARY KEY (`PurchasesID`),
  ADD KEY `fk_purchase_session` (`SessionID`),
  ADD KEY `fk_purchase_item` (`ItemID`);

--
-- Indices de la tabla `SessionUser`
--
ALTER TABLE `SessionUser`
  ADD PRIMARY KEY (`SessionID`),
  ADD KEY `fk_session_user` (`UserID`);

--
-- Indices de la tabla `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Item`
--
ALTER TABLE `Item`
  MODIFY `ItemID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Purchases`
--
ALTER TABLE `Purchases`
  MODIFY `PurchasesID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `SessionUser`
--
ALTER TABLE `SessionUser`
  MODIFY `SessionID` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `User`
--
ALTER TABLE `User`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Purchases`
--
ALTER TABLE `Purchases`
  ADD CONSTRAINT `fk_purchase_item` FOREIGN KEY (`ItemID`) REFERENCES `Item` (`ItemID`),
  ADD CONSTRAINT `fk_purchase_session` FOREIGN KEY (`SessionID`) REFERENCES `SessionUser` (`SessionID`);

--
-- Filtros para la tabla `SessionUser`
--
ALTER TABLE `SessionUser`
  ADD CONSTRAINT `fk_session_user` FOREIGN KEY (`UserID`) REFERENCES `User` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
