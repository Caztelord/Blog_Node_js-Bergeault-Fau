-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  Dim 12 jan. 2020 à 23:43
-- Version du serveur :  10.4.11-MariaDB
-- Version de PHP :  7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `blog_node`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `titre_A` varchar(45) NOT NULL,
  `auteur_A` varchar(45) NOT NULL,
  `date_parution` date NOT NULL,
  `data_articles` text NOT NULL,
  `TAG_A` varchar(44) NOT NULL,
  `brouillon_data_A` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`id`, `titre_A`, `auteur_A`, `date_parution`, `data_articles`, `TAG_A`, `brouillon_data_A`) VALUES
(1, 'nouvelle colone de puissance', 'locklear', '2019-12-06', 'Voici l\'article :\r\n\r\nPost haec Gallus Hierapolim profecturus ut expeditioni specie tenus adesset, Antiochensi plebi suppliciter obsecranti ut inediae dispelleret metum, quae per multas difficilisque causas adfore iam sperabatur, non ut mos est principibus, quorum diffusa potestas localibus subinde medetur aerumnis, disponi quicquam statuit vel ex provinciis alimenta transferri conterminis, sed consularem Syriae Theophilum prope adstantem ultima metuenti multitudini dedit id adsidue replicando quod invito rectore nullus egere poterit victu.', '[1]', ''),
(2, 'Coup de foudre au Lidil', 'Jean Luc', '2020-01-12', 'Aujourd\'hui je vais vous raconter une histoire qui m\'est arrivé il y a 2 ans et demi. Ce jeudi soir, comme souvent, je me suis rendu au Lidl à côté de chez moi pour faire mes courses. Ce soir là, j\'avais particulièrement envie d\'une poêlé de champignon. En entrant je me rendis au rayon fruits et légumes, car j\'aime beaucoup cuisiner, et vis qu\'il restait une seule barquette de champignon. Je me précipita pour la prendre mais au moment où je la toucha, une main l\'avait déjà saisi. Je me retourna, surpris de ce geste et me trouva devant une magnifique femme. Celle-ci se mit à rougir en disant \"il me les faut absolument  pour ma blanquette de veau\". Je lui répondis que moi je voulais absolument ma poêlé de champignon. C\'est alors qu\'elle commença à se fâcher en me disant qu\'elle en avait plus besoin que moi et  je lui rétorqua qu\'elle n\'en savait rien. C\'est à ce moment là, en voyant ses joues rouges de gêne et de colère que la grâce me toucha : c\'était la femme de ma vie. Je lui demanda donc pour qui elle faisait sa blanquette et repondis timidement qu\'elle la préparais pour elle uniquement car elle vivais seule. Je lui proposa donc de la préparer avec elle et que nous mangerions ensemble notre plat. Elle accepta et 1 an plus tard nous nous marions avec comme repas une blanquette de veau. Aujourd\'hui cela fait 2 ans que nous sommes ensemble et nous sommes amoureux et heureux.', '[1,3]', ''),
(3, 'Les incendies en Australie', 'info_rapide', '2020-01-11', 'ceci est un texte d\'exemple je vais essayer de le modifier avec les bouton de théo pour cela je dois me replonger dans du script css\r\njquery ? je sais plus enfin bref voila quoi ', '[2,4]', ''),
(4, 'bonjour', 'root', '2020-01-18', 'je vais vous présenter et vous expliquer comment faire du node.js', '2020-01-18', ''),
(5, 'bonjour', 'root', '2020-01-01', 'je vais vous présenter et vous expliquer comment faire du node.js', '2020-01-01', '');

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id` int(11) NOT NULL,
  `Nom_C` varchar(44) NOT NULL,
  `mdp_client` varchar(80) NOT NULL,
  `attribut` varchar(15) NOT NULL DEFAULT 'no role',
  `mail_c` varchar(44) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `Nom_C`, `mdp_client`, `attribut`, `mail_c`) VALUES
(1, 'yoann@gmail.com', 'oui', 'no role', ''),
(4, 'yes@gmail.fr', 'mdp', 'no role', ''),
(7, 'je@test.fr', 'mdp', 'no role', ''),
(8, 'inserttest@mail.fr', 'yes', 'publisher', ''),
(9, 'root', '4813494d137e1631bba301d5acab6e7bb7aa74ce1185d456565ef51d737677b2', 'admin', 'root@mail.fr');

-- --------------------------------------------------------

--
-- Structure de la table `tags`
--

CREATE TABLE `tags` (
  `id_T` int(11) NOT NULL,
  `name_tags` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `tags`
--

INSERT INTO `tags` (`id_T`, `name_tags`) VALUES
(1, 'Cuisine'),
(2, 'Sport'),
(3, 'Romance'),
(4, 'Actualités');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id_T`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `tags`
--
ALTER TABLE `tags`
  MODIFY `id_T` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
