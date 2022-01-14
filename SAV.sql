-- phpMyAdmin SQL Dump
-- version 5.0.4deb2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : ven. 14 jan. 2022 à 16:05
-- Version du serveur :  10.5.12-MariaDB-0+deb11u1
-- Version de PHP : 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `SAV`
--

-- --------------------------------------------------------

--
-- Structure de la table `DEMANDES`
--

CREATE TABLE `DEMANDES` (
  `Num` int(11) NOT NULL,
  `MATERIEL` text NOT NULL,
  `Client` text DEFAULT NULL,
  `DATE` text NOT NULL,
  `SERIAL` text DEFAULT NULL,
  `ETAT` enum('OUVERT','ATTENTE MATERIEL','ATTENTE RETOUR MATERIEL','FERME') NOT NULL DEFAULT 'OUVERT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `DEMANDES`
--

INSERT INTO `DEMANDES` (`Num`, `MATERIEL`, `Client`, `DATE`, `SERIAL`, `ETAT`) VALUES
(3, 'test materiel', NULL, '2022/01/14', 'R00000', 'OUVERT'),
(18, 'MATOS TEST', NULL, '2022/01/14', 'R25165', 'OUVERT'),
(19, 'Carte Mere', 'CCSA', '2022/01/14', 'R065410', 'OUVERT');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `DEMANDES`
--
ALTER TABLE `DEMANDES`
  ADD PRIMARY KEY (`Num`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `DEMANDES`
--
ALTER TABLE `DEMANDES`
  MODIFY `Num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
