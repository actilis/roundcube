-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Hôte : db
-- Généré le :  sam. 16 juin 2018 à 14:05
-- Version du serveur :  5.7.22
-- Version de PHP :  7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `rcub`
--

-- --------------------------------------------------------

--
-- Structure de la table `rcub_attachments`
--

DROP TABLE IF EXISTS `rcub_attachments`;
CREATE TABLE `rcub_attachments` (
  `attachment_id` int(11) UNSIGNED NOT NULL,
  `event_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `mimetype` varchar(255) NOT NULL DEFAULT '',
  `size` int(11) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_cache`
--

DROP TABLE IF EXISTS `rcub_cache`;
CREATE TABLE `rcub_cache` (
  `cache_key` varchar(128) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `data` longtext NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_cache_index`
--

DROP TABLE IF EXISTS `rcub_cache_index`;
CREATE TABLE `rcub_cache_index` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `valid` tinyint(1) NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  `expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_cache_messages`
--

DROP TABLE IF EXISTS `rcub_cache_messages`;
CREATE TABLE `rcub_cache_messages` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `uid` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `data` longtext NOT NULL,
  `flags` int(11) NOT NULL DEFAULT '0',
  `expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_cache_shared`
--

DROP TABLE IF EXISTS `rcub_cache_shared`;
CREATE TABLE `rcub_cache_shared` (
  `cache_key` varchar(255) CHARACTER SET ascii NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `data` longtext NOT NULL,
  `expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_cache_thread`
--

DROP TABLE IF EXISTS `rcub_cache_thread`;
CREATE TABLE `rcub_cache_thread` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `mailbox` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `data` longtext NOT NULL,
  `expires` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_calendars`
--

DROP TABLE IF EXISTS `rcub_calendars`;
CREATE TABLE `rcub_calendars` (
  `calendar_id` int(11) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `color` varchar(8) NOT NULL,
  `showalarms` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_contactgroupmembers`
--

DROP TABLE IF EXISTS `rcub_contactgroupmembers`;
CREATE TABLE `rcub_contactgroupmembers` (
  `contactgroup_id` int(10) UNSIGNED NOT NULL,
  `contact_id` int(10) UNSIGNED NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_contactgroups`
--

DROP TABLE IF EXISTS `rcub_contactgroups`;
CREATE TABLE `rcub_contactgroups` (
  `contactgroup_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_contacts`
--

DROP TABLE IF EXISTS `rcub_contacts`;
CREATE TABLE `rcub_contacts` (
  `contact_id` int(10) UNSIGNED NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `email` text NOT NULL,
  `firstname` varchar(128) NOT NULL DEFAULT '',
  `surname` varchar(128) NOT NULL DEFAULT '',
  `vcard` longtext,
  `words` text,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_dictionary`
--

DROP TABLE IF EXISTS `rcub_dictionary`;
CREATE TABLE `rcub_dictionary` (
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `language` varchar(5) NOT NULL,
  `data` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_events`
--

DROP TABLE IF EXISTS `rcub_events`;
CREATE TABLE `rcub_events` (
  `event_id` int(11) UNSIGNED NOT NULL,
  `calendar_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `recurrence_id` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `uid` varchar(255) NOT NULL DEFAULT '',
  `instance` varchar(16) NOT NULL DEFAULT '',
  `isexception` tinyint(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `sequence` int(1) UNSIGNED NOT NULL DEFAULT '0',
  `start` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `end` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `recurrence` varchar(255) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `location` varchar(255) NOT NULL DEFAULT '',
  `categories` varchar(255) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `all_day` tinyint(1) NOT NULL DEFAULT '0',
  `free_busy` tinyint(1) NOT NULL DEFAULT '0',
  `priority` tinyint(1) NOT NULL DEFAULT '0',
  `sensitivity` tinyint(1) NOT NULL DEFAULT '0',
  `status` varchar(32) NOT NULL DEFAULT '',
  `alarms` text,
  `attendees` text,
  `notifyat` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_google_contacts`
--

DROP TABLE IF EXISTS `rcub_google_contacts`;
CREATE TABLE `rcub_google_contacts` (
  `contact_id` int(10) UNSIGNED NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL DEFAULT '',
  `email` text NOT NULL,
  `firstname` varchar(128) NOT NULL DEFAULT '',
  `surname` varchar(128) NOT NULL DEFAULT '',
  `vcard` longtext,
  `words` text,
  `user_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_identities`
--

DROP TABLE IF EXISTS `rcub_identities`;
CREATE TABLE `rcub_identities` (
  `identity_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `del` tinyint(1) NOT NULL DEFAULT '0',
  `standard` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `organization` varchar(128) NOT NULL DEFAULT '',
  `email` varchar(128) NOT NULL,
  `reply-to` varchar(128) NOT NULL DEFAULT '',
  `bcc` varchar(128) NOT NULL DEFAULT '',
  `signature` longtext,
  `html_signature` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_itipinvitations`
--

DROP TABLE IF EXISTS `rcub_itipinvitations`;
CREATE TABLE `rcub_itipinvitations` (
  `token` varchar(64) NOT NULL,
  `event_uid` varchar(255) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `event` text NOT NULL,
  `expires` datetime DEFAULT NULL,
  `cancelled` tinyint(3) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_searches`
--

DROP TABLE IF EXISTS `rcub_searches`;
CREATE TABLE `rcub_searches` (
  `search_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `type` int(3) NOT NULL DEFAULT '0',
  `name` varchar(128) NOT NULL,
  `data` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_session`
--

DROP TABLE IF EXISTS `rcub_session`;
CREATE TABLE `rcub_session` (
  `sess_id` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `changed` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `ip` varchar(40) NOT NULL,
  `vars` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `rcub_system`
--

DROP TABLE IF EXISTS `rcub_system`;
CREATE TABLE `rcub_system` (
  `name` varchar(64) NOT NULL,
  `value` mediumtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `rcub_system`
--

INSERT INTO `rcub_system` (`name`, `value`) VALUES
('calendar-caldav-version', '2016072000'),
('calendar-database-version', '2015022700'),
('calendar-ical-version', '2015022700'),
('calendar-version', '2017041300'),
('roundcube-version', '2015111100');

-- --------------------------------------------------------

--
-- Structure de la table `rcub_users`
--

DROP TABLE IF EXISTS `rcub_users`;
CREATE TABLE `rcub_users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `mail_host` varchar(128) NOT NULL,
  `created` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `last_login` datetime DEFAULT NULL,
  `language` varchar(5) DEFAULT NULL,
  `preferences` longtext,
  `failed_login` datetime DEFAULT NULL,
  `failed_login_counter` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `rcub_attachments`
--
ALTER TABLE `rcub_attachments`
  ADD PRIMARY KEY (`attachment_id`),
  ADD KEY `fk_attachments_event_id` (`event_id`);

--
-- Index pour la table `rcub_cache`
--
ALTER TABLE `rcub_cache`
  ADD KEY `user_cache_index` (`user_id`,`cache_key`),
  ADD KEY `expires_index` (`expires`);

--
-- Index pour la table `rcub_cache_index`
--
ALTER TABLE `rcub_cache_index`
  ADD PRIMARY KEY (`user_id`,`mailbox`),
  ADD KEY `expires_index` (`expires`);

--
-- Index pour la table `rcub_cache_messages`
--
ALTER TABLE `rcub_cache_messages`
  ADD PRIMARY KEY (`user_id`,`mailbox`,`uid`),
  ADD KEY `expires_index` (`expires`);

--
-- Index pour la table `rcub_cache_shared`
--
ALTER TABLE `rcub_cache_shared`
  ADD KEY `cache_key_index` (`cache_key`),
  ADD KEY `expires_index` (`expires`);

--
-- Index pour la table `rcub_cache_thread`
--
ALTER TABLE `rcub_cache_thread`
  ADD PRIMARY KEY (`user_id`,`mailbox`),
  ADD KEY `expires_index` (`expires`);

--
-- Index pour la table `rcub_calendars`
--
ALTER TABLE `rcub_calendars`
  ADD PRIMARY KEY (`calendar_id`),
  ADD KEY `user_name_idx` (`user_id`,`name`);

--
-- Index pour la table `rcub_contactgroupmembers`
--
ALTER TABLE `rcub_contactgroupmembers`
  ADD PRIMARY KEY (`contactgroup_id`,`contact_id`),
  ADD KEY `contactgroupmembers_contact_index` (`contact_id`);

--
-- Index pour la table `rcub_contactgroups`
--
ALTER TABLE `rcub_contactgroups`
  ADD PRIMARY KEY (`contactgroup_id`),
  ADD KEY `contactgroups_user_index` (`user_id`,`del`);

--
-- Index pour la table `rcub_contacts`
--
ALTER TABLE `rcub_contacts`
  ADD PRIMARY KEY (`contact_id`),
  ADD KEY `user_contacts_index` (`user_id`,`del`);

--
-- Index pour la table `rcub_dictionary`
--
ALTER TABLE `rcub_dictionary`
  ADD UNIQUE KEY `uniqueness` (`user_id`,`language`);

--
-- Index pour la table `rcub_events`
--
ALTER TABLE `rcub_events`
  ADD PRIMARY KEY (`event_id`),
  ADD KEY `uid_idx` (`uid`),
  ADD KEY `recurrence_idx` (`recurrence_id`),
  ADD KEY `calendar_notify_idx` (`calendar_id`,`notifyat`);

--
-- Index pour la table `rcub_google_contacts`
--
ALTER TABLE `rcub_google_contacts`
  ADD PRIMARY KEY (`contact_id`),
  ADD KEY `user_contacts_index` (`user_id`,`del`);

--
-- Index pour la table `rcub_identities`
--
ALTER TABLE `rcub_identities`
  ADD PRIMARY KEY (`identity_id`),
  ADD KEY `user_identities_index` (`user_id`,`del`),
  ADD KEY `email_identities_index` (`email`,`del`);

--
-- Index pour la table `rcub_itipinvitations`
--
ALTER TABLE `rcub_itipinvitations`
  ADD PRIMARY KEY (`token`),
  ADD KEY `uid_idx` (`user_id`,`event_uid`);

--
-- Index pour la table `rcub_searches`
--
ALTER TABLE `rcub_searches`
  ADD PRIMARY KEY (`search_id`),
  ADD UNIQUE KEY `uniqueness` (`user_id`,`type`,`name`);

--
-- Index pour la table `rcub_session`
--
ALTER TABLE `rcub_session`
  ADD PRIMARY KEY (`sess_id`),
  ADD KEY `changed_index` (`changed`);

--
-- Index pour la table `rcub_system`
--
ALTER TABLE `rcub_system`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `rcub_users`
--
ALTER TABLE `rcub_users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`,`mail_host`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `rcub_attachments`
--
ALTER TABLE `rcub_attachments`
  MODIFY `attachment_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `rcub_calendars`
--
ALTER TABLE `rcub_calendars`
  MODIFY `calendar_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `rcub_contactgroups`
--
ALTER TABLE `rcub_contactgroups`
  MODIFY `contactgroup_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT pour la table `rcub_contacts`
--
ALTER TABLE `rcub_contacts`
  MODIFY `contact_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1764;

--
-- AUTO_INCREMENT pour la table `rcub_events`
--
ALTER TABLE `rcub_events`
  MODIFY `event_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `rcub_google_contacts`
--
ALTER TABLE `rcub_google_contacts`
  MODIFY `contact_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `rcub_identities`
--
ALTER TABLE `rcub_identities`
  MODIFY `identity_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `rcub_searches`
--
ALTER TABLE `rcub_searches`
  MODIFY `search_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `rcub_users`
--
ALTER TABLE `rcub_users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1380;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `rcub_attachments`
--
ALTER TABLE `rcub_attachments`
  ADD CONSTRAINT `fk_attachments_event_id` FOREIGN KEY (`event_id`) REFERENCES `rcub_events` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_cache`
--
ALTER TABLE `rcub_cache`
  ADD CONSTRAINT `user_id_fk_cache` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_cache_index`
--
ALTER TABLE `rcub_cache_index`
  ADD CONSTRAINT `user_id_fk_cache_index` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_cache_messages`
--
ALTER TABLE `rcub_cache_messages`
  ADD CONSTRAINT `user_id_fk_cache_messages` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_cache_thread`
--
ALTER TABLE `rcub_cache_thread`
  ADD CONSTRAINT `user_id_fk_cache_thread` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_calendars`
--
ALTER TABLE `rcub_calendars`
  ADD CONSTRAINT `fk_calendars_user_id` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_contactgroupmembers`
--
ALTER TABLE `rcub_contactgroupmembers`
  ADD CONSTRAINT `contact_id_fk_contacts` FOREIGN KEY (`contact_id`) REFERENCES `rcub_contacts` (`contact_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contactgroup_id_fk_contactgroups` FOREIGN KEY (`contactgroup_id`) REFERENCES `rcub_contactgroups` (`contactgroup_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_contactgroups`
--
ALTER TABLE `rcub_contactgroups`
  ADD CONSTRAINT `user_id_fk_contactgroups` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_contacts`
--
ALTER TABLE `rcub_contacts`
  ADD CONSTRAINT `user_id_fk_contacts` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_dictionary`
--
ALTER TABLE `rcub_dictionary`
  ADD CONSTRAINT `user_id_fk_dictionary` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_events`
--
ALTER TABLE `rcub_events`
  ADD CONSTRAINT `fk_events_calendar_id` FOREIGN KEY (`calendar_id`) REFERENCES `rcub_calendars` (`calendar_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_google_contacts`
--
ALTER TABLE `rcub_google_contacts`
  ADD CONSTRAINT `google_contacts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_identities`
--
ALTER TABLE `rcub_identities`
  ADD CONSTRAINT `user_id_fk_identities` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_itipinvitations`
--
ALTER TABLE `rcub_itipinvitations`
  ADD CONSTRAINT `fk_itipinvitations_user_id` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `rcub_searches`
--
ALTER TABLE `rcub_searches`
  ADD CONSTRAINT `user_id_fk_searches` FOREIGN KEY (`user_id`) REFERENCES `rcub_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
