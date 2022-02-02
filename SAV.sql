-- phpMyAdmin SQL Dump
-- version 5.0.4deb2
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mer. 02 fév. 2022 à 12:54
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
  `COM` longtext NOT NULL,
  `ETAT` enum('OUVERT','ATTENTE MATERIEL','ATTENTE RETOUR MATERIEL','FERME') NOT NULL DEFAULT 'OUVERT',
  `DEMANDEUR` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `DEMANDES`
--

INSERT INTO `DEMANDES` (`Num`, `MATERIEL`, `Client`, `DATE`, `SERIAL`, `COM`, `ETAT`, `DEMANDEUR`) VALUES
(3, 'test materiel', NULL, '2022/01/14', 'R00000', '', 'OUVERT', ''),
(29, 'Disque Dur', 'PECHBONNIEU', '2022/01/15', 'R65106501', 'Le disque dur est en panne d epannage demmande', 'OUVERT', ''),
(30, 'CARTE MERE', 'R564165', '2022/01/15', 'CCSA', 'Ne s allume plus', 'OUVERT', ''),
(31, 'CARTE MERE', 'R654654', '2022/01/15', 'SFQSFQ', 'ne s allume plus de', 'OUVERT', ''),
(32, 'CLAVIER', 'SQDQSD', '2022/01/15', 'TEST', 'AUCUN PROBLEME', 'OUVERT', 'CELINE'),
(33, 'CARTE MERE', 'dfsdfqf', '2022/01/15', 'qsdfqsdf', 'dfghdfghdfgh', 'OUVERT', 'DAVY'),
(34, 'CLAVIER', 'ehgdfgh', '2022/01/15', 'dfghdfgh', 'dgfhdfhdfgh', 'OUVERT', 'ERIC'),
(35, 'CLAVIER', 'R4651', '2022/01/17', 'Davy', 'D epannage', 'OUVERT', 'JULIEN'),
(36, 'CARTE MERE', 'R65464', '2022/02/01', 'SATAR', 'HS', 'OUVERT', 'ERIC');

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
  MODIFY `Num` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
