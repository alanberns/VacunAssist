-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-05-2022 a las 03:59:01
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `vacunassist`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradorc`
--

CREATE TABLE `administradorc` (
  `email` varchar(50) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `clave` varchar(32) NOT NULL,
  `centroId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administradorg`
--

CREATE TABLE `administradorg` (
  `email` varchar(50) NOT NULL,
  `clave` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centro`
--

CREATE TABLE `centro` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `direccion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `centro`
--

INSERT INTO `centro` (`id`, `nombre`, `direccion`) VALUES
(1, 'Plaza Moreno', 'Avenida 13 esquina 50 n345'),
(2, 'Zona terminal', 'Calle 42 n345'),
(3, 'Zona cementerio', 'Calle 74 n756');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE `paciente` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `apellido` varchar(40) NOT NULL,
  `esRiesgo` enum('Si','No') NOT NULL,
  `fechaNacimiento` date NOT NULL,
  `dni` int(8) NOT NULL,
  `token` int(4) NOT NULL,
  `genero` enum('Masculino','Femenino','NoBinario') NOT NULL,
  `centroId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`id`, `email`, `nombre`, `apellido`, `esRiesgo`, `fechaNacimiento`, `dni`, `token`, `genero`, `centroId`) VALUES
(2, 'nombre@mail.com', 'Marce', 'Kope', 'Si', '2012-05-01', 23549971, 8901, 'Masculino', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `queja`
--

CREATE TABLE `queja` (
  `id` int(11) NOT NULL,
  `comentario` varchar(255) NOT NULL,
  `fecha` date NOT NULL,
  `pacienteId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `quejatipoqueja`
--

CREATE TABLE `quejatipoqueja` (
  `motivoQueja` varchar(30) NOT NULL,
  `quejaId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipoqueja`
--

CREATE TABLE `tipoqueja` (
  `motivo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tipoqueja`
--

INSERT INTO `tipoqueja` (`motivo`) VALUES
('Demoras'),
('Mala atencion personal');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno`
--

CREATE TABLE `turno` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `estado` enum('Atendido','Confirmado','Ausente','Cancelado','A confirmar') NOT NULL,
  `observaciones` varchar(255) NOT NULL,
  `pacienteId` int(11) NOT NULL,
  `vacunaId` int(11) NOT NULL,
  `centroId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacuna`
--

CREATE TABLE `vacuna` (
  `id` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL,
  `dosis` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `vacuna`
--

INSERT INTO `vacuna` (`id`, `nombre`, `dosis`) VALUES
(1, 'Covid', 1),
(2, 'Fiebre amarilla', 1),
(3, 'Gripe', 1),
(4, 'Covid', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vacunasprevias`
--

CREATE TABLE `vacunasprevias` (
  `pacienteId` int(11) NOT NULL,
  `vacunaId` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administradorc`
--
ALTER TABLE `administradorc`
  ADD PRIMARY KEY (`email`),
  ADD KEY `centroId` (`centroId`);

--
-- Indices de la tabla `administradorg`
--
ALTER TABLE `administradorg`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `centro`
--
ALTER TABLE `centro`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD KEY `centro` (`centroId`);

--
-- Indices de la tabla `queja`
--
ALTER TABLE `queja`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pacienteId` (`pacienteId`);

--
-- Indices de la tabla `quejatipoqueja`
--
ALTER TABLE `quejatipoqueja`
  ADD PRIMARY KEY (`motivoQueja`,`quejaId`),
  ADD KEY `quejaId` (`quejaId`);

--
-- Indices de la tabla `tipoqueja`
--
ALTER TABLE `tipoqueja`
  ADD PRIMARY KEY (`motivo`);

--
-- Indices de la tabla `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pacienteId` (`pacienteId`),
  ADD KEY `centroId` (`centroId`),
  ADD KEY `vacunaId` (`vacunaId`);

--
-- Indices de la tabla `vacuna`
--
ALTER TABLE `vacuna`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `vacunasprevias`
--
ALTER TABLE `vacunasprevias`
  ADD PRIMARY KEY (`pacienteId`,`vacunaId`),
  ADD KEY `vacunaId` (`vacunaId`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `centro`
--
ALTER TABLE `centro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `queja`
--
ALTER TABLE `queja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `turno`
--
ALTER TABLE `turno`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `vacuna`
--
ALTER TABLE `vacuna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administradorc`
--
ALTER TABLE `administradorc`
  ADD CONSTRAINT `administradorc_ibfk_1` FOREIGN KEY (`centroId`) REFERENCES `centro` (`id`);

--
-- Filtros para la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `paciente_ibfk_1` FOREIGN KEY (`centroId`) REFERENCES `centro` (`id`);

--
-- Filtros para la tabla `queja`
--
ALTER TABLE `queja`
  ADD CONSTRAINT `queja_ibfk_1` FOREIGN KEY (`pacienteId`) REFERENCES `paciente` (`id`);

--
-- Filtros para la tabla `quejatipoqueja`
--
ALTER TABLE `quejatipoqueja`
  ADD CONSTRAINT `quejatipoqueja_ibfk_1` FOREIGN KEY (`motivoQueja`) REFERENCES `tipoqueja` (`motivo`),
  ADD CONSTRAINT `quejatipoqueja_ibfk_2` FOREIGN KEY (`quejaId`) REFERENCES `queja` (`id`);

--
-- Filtros para la tabla `turno`
--
ALTER TABLE `turno`
  ADD CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`pacienteId`) REFERENCES `paciente` (`id`),
  ADD CONSTRAINT `turno_ibfk_2` FOREIGN KEY (`centroId`) REFERENCES `centro` (`id`),
  ADD CONSTRAINT `turno_ibfk_3` FOREIGN KEY (`vacunaId`) REFERENCES `vacuna` (`id`);

--
-- Filtros para la tabla `vacunasprevias`
--
ALTER TABLE `vacunasprevias`
  ADD CONSTRAINT `vacunasprevias_ibfk_1` FOREIGN KEY (`pacienteId`) REFERENCES `paciente` (`id`),
  ADD CONSTRAINT `vacunasprevias_ibfk_2` FOREIGN KEY (`vacunaId`) REFERENCES `vacuna` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
