-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 29, 2025 at 10:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_elective3`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_11_27_163911_create_rfid_logs_table', 1),
(6, '2025_11_27_175343_create_rfid_registereds_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rfid_logs`
--

CREATE TABLE `rfid_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `rfid` varchar(255) NOT NULL,
  `status` varchar(255) DEFAULT NULL,
  `time_log` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rfid_logs`
--

INSERT INTO `rfid_logs` (`id`, `rfid`, `status`, `time_log`) VALUES
(67, '23B1F34B', '0', '11/29/2025 05:16'),
(68, '23B1F34B', '1', '11/29/2025 05:16'),
(69, '23B1F34B', '0', '11/29/2025 05:16'),
(70, '23B1F34B', '1', '11/29/2025 05:17'),
(71, '23B1F34B', '0', '11/29/2025 05:17'),
(72, '23B1F34B', '1', '11/29/2025 05:17'),
(73, '23B1F34B', '0', '11/29/2025 05:29'),
(74, '23B1F34B', '1', '11/29/2025 05:29'),
(75, '23B1F34B', '0', '11/29/2025 05:29'),
(76, '23B1F34B', '1', '11/29/2025 05:29'),
(77, '23B1F34B', '0', '11/29/2025 05:29'),
(78, '5C17B73B', NULL, '11/29/2025 05:30'),
(79, '23B1F34B', '1', '11/29/2025 05:30'),
(80, '23B1F34B', '0', '11/29/2025 05:30'),
(81, '23B1F34B', '1', '11/29/2025 05:31'),
(82, '23B1F34B', '0', '11/29/2025 05:31'),
(83, '5C17B73B', NULL, '11/29/2025 05:37'),
(84, '5C17B73B', NULL, '11/29/2025 05:37'),
(85, '23B1F34B', '1', '11/29/2025 05:40'),
(86, '23B1F34B', '0', '11/29/2025 05:40'),
(87, '5C17B73B', NULL, '11/29/2025 05:40'),
(88, '23B1F34B', '1', '11/29/2025 05:42'),
(89, '23B1F34B', '0', '11/29/2025 05:42'),
(90, '5C17B73B', NULL, '11/29/2025 05:42'),
(91, '23B1F34B', '1', '11/29/2025 05:43'),
(92, '5C17B73B', NULL, '11/29/2025 05:43'),
(93, '23B1F34B', '0', '11/29/2025 05:45'),
(94, '23B1F34B', '1', '11/29/2025 05:45'),
(95, '23B1F34B', '0', '11/29/2025 08:25'),
(96, '23B1F34B', '1', '11/29/2025 08:25'),
(97, '23B1F34B', '0', '11/29/2025 08:29'),
(98, '23B1F34B', '1', '11/29/2025 08:29'),
(99, '23B1F34B', '0', '11/29/2025 08:30'),
(100, '23B1F34B', '1', '11/29/2025 08:30'),
(101, '23B1F34B', '0', '11/29/2025 08:30'),
(102, '23B1F34B', '1', '11/29/2025 08:31'),
(103, '23B1F34B', '0', '11/29/2025 08:31'),
(104, '23B1F34B', '1', '11/29/2025 08:32'),
(105, '23B1F34B', '0', '11/29/2025 08:32'),
(106, '23B1F34B', '1', '11/29/2025 08:32'),
(107, '23B1F34B', '0', '11/29/2025 08:32'),
(108, '23B1F34B', '1', '11/29/2025 09:12'),
(109, '23B1F34B', '0', '11/29/2025 09:14'),
(110, '23B1F34B', '1', '11/29/2025 09:18'),
(111, '23B1F34B', '0', '11/29/2025 09:24'),
(112, '23B1F34B', '1', '11/29/2025 09:24'),
(113, '23B1F34B', '0', '11/29/2025 09:24'),
(114, '23B1F34B', '1', '11/29/2025 09:24'),
(115, '23B1F34B', '0', '11/29/2025 09:25'),
(116, '23B1F34B', '1', '11/29/2025 09:25'),
(117, '23B1F34B', '0', '11/29/2025 09:25'),
(118, '23B1F34B', '1', '11/29/2025 09:25'),
(119, '23B1F34B', '0', '11/29/2025 09:25'),
(120, '23B1F34B', '1', '11/29/2025 09:25'),
(121, '23B1F34B', '0', '11/29/2025 09:25'),
(122, '23B1F34B', '1', '11/29/2025 09:26'),
(123, '23B1F34B', '0', '11/29/2025 09:26'),
(124, '23B1F34B', '1', '11/29/2025 09:26'),
(125, '058550A8DBC200', NULL, '11/29/2025 09:27');

-- --------------------------------------------------------

--
-- Table structure for table `rfid_registereds`
--

CREATE TABLE `rfid_registereds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uid` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rfid_registereds`
--

INSERT INTO `rfid_registereds` (`id`, `uid`, `status`) VALUES
(1, '1A12A509', '0'),
(2, '23B1F34B', '1');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `rfid_logs`
--
ALTER TABLE `rfid_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rfid_registereds`
--
ALTER TABLE `rfid_registereds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `rfid_registereds_uid_unique` (`uid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rfid_logs`
--
ALTER TABLE `rfid_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `rfid_registereds`
--
ALTER TABLE `rfid_registereds`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
