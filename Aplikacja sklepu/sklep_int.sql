-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 03, 2023 at 06:19 PM
-- Wersja serwera: 10.4.28-MariaDB
-- Wersja PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sklep int`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `deleted_users`
--

CREATE TABLE `deleted_users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `type` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deleted_users`
--

INSERT INTO `deleted_users` (`id`, `name`, `password`, `created_at`, `deleted_at`, `type`) VALUES
(8, '12', '$2y$10$fN1IBk0FGccQgn3/pvV1qupKYcxH.cepFSKWbRBsk7M/ax5wMZXwO', '2023-12-01 16:29:49', '2023-12-03 16:21:02', 0),
(9, '123', '$2y$10$8L4Yp/5tE3XzQEoAnUgjMeI35am3gQp4sRPLwi4JMfO1zMust67Xe', '2023-12-01 16:30:03', '2023-12-03 16:28:51', 0),
(12, 'Test', '$2y$10$aJTl5nqBey3Npt12TcL24uC1LS6iVOthM.yhBR4vazFyenplXMsYS', '2023-12-03 17:36:35', '2023-12-03 17:36:46', 0),
(13, 'test2', '$2y$10$z6N40apGtHrql4R8VTktT.BEOGLarxyuMrRbJDyLqdXnyTFw9cW/a', '2023-12-03 17:48:44', '2023-12-03 17:48:55', 0);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `koszyk`
--

CREATE TABLE `koszyk` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `produkt_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `koszyk`
--

INSERT INTO `koszyk` (`id`, `user_id`, `produkt_id`) VALUES
(35, 11, 1),
(36, 11, 2),
(37, 11, 2),
(38, 11, 1),
(39, 11, 1),
(40, 11, 1),
(41, 11, 2),
(42, 11, 2),
(43, 11, 13),
(44, 11, 1);

--
-- Wyzwalacze `koszyk`
--
DELIMITER $$
CREATE TRIGGER `after_koszyk_insert` AFTER INSERT ON `koszyk` FOR EACH ROW BEGIN
    UPDATE najczesciej_kupowane
    SET numer = numer + 1
    WHERE id_produktu = NEW.produkt_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `najczesciej_kupowane`
--

CREATE TABLE `najczesciej_kupowane` (
  `id` int(11) NOT NULL,
  `id_produktu` int(11) DEFAULT NULL,
  `numer` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `najczesciej_kupowane`
--

INSERT INTO `najczesciej_kupowane` (`id`, `id_produktu`, `numer`) VALUES
(1, 1, 4),
(2, 2, 2),
(3, 3, 0),
(4, 4, 0),
(5, 5, 0),
(6, 6, 0),
(7, 7, 0),
(8, 8, 0),
(9, 9, 0),
(10, 10, 0),
(11, 11, 0),
(12, 12, 0),
(13, 13, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkty`
--

CREATE TABLE `produkty` (
  `id` int(11) NOT NULL,
  `nazwa` varchar(255) NOT NULL,
  `cena` decimal(10,2) NOT NULL,
  `opis` text DEFAULT NULL,
  `w_koszyku` int(11) DEFAULT 0,
  `obraz_link` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produkty`
--

INSERT INTO `produkty` (`id`, `nazwa`, `cena`, `opis`, `w_koszyku`, `obraz_link`) VALUES
(1, 'Pistolet na wodę', 25.00, 'Strzela woda. Idealny na śmingus-dyngus.', 0, '\"<img src=\'pistolet.jpg\' alt=\'Description of the image\'>\"'),
(2, 'Czapka z daszkiem', 15.00, 'Chroni przed słońcem', 0, '\"<img src=\'czapka.jpg\' alt=\'Description of the image\'>\"'),
(3, 'Lampka nocna', 80.00, 'Dobra, gdy chcesz np. coś przeczytać ale jest za ciemno.', 0, '\"<img src=\'lampka.jpg\' alt=\'Description of the image\'>\"'),
(4, 'Kreatyna jabłkowa', 25.00, 'Mus na siłkę. Ponadto bardzo smaczna', 0, '\"<img src=\'kreatyna.jpg\' alt=\'Description of the image\'>\"'),
(5, 'Danio', 5.00, 'Przydaje się gdy jest się głodnym.', 0, '\"<img src=\'danio.jpg\' alt=\'Description of the image\' width=\"235\" height=\"260\">\"'),
(6, 'Pas do jeansów', 20.00, 'Służy do przymocowania do spodni aby wyregulować ich objętość', 0, '\"<img src=\'pas.jpg\' alt=\'Description of the image\'>\"'),
(7, 'Płyn do naczyń', 18.00, 'Można wyczyścić przy jego pomocy talerz albo miskę.', 0, '\"<img src=\'plyn.jpg\' alt=\'Description of the image\'>\"'),
(8, 'Włócznia', 150.00, 'Do miotania albo do walki wręcz.', 0, '\"<img src=\'wlocznia.jpg\' alt=\'Description of the image\'>\"'),
(9, 'Bombka', 20.00, 'Można powiesić na choince', 0, '\"<img src=\'bombka.jpg\' alt=\'Description of the image\'>\"'),
(10, 'Gniazdko', 30.00, 'Do podłaczenia np. telefonu gdy ma mało baterii', 0, '\"<img src=\'gniazdko.jpg\' alt=\'Description of the image\'>\"'),
(11, 'Sól gruboziarnista', 4.00, 'Służy do solenia potraw', 0, '\"<img src=\'sol.jpg\' alt=\'Description of the image\'>\"'),
(12, 'Lustro', 100.00, 'Odbija promienie światła', 0, '\"<img src=\'lustro.jpg\' alt=\'Description of the image\'>\"'),
(13, 'Łopata do odśnieżania', 50.00, 'Nadaje się do usunięcia nadmiaru puchu z podwórka', 0, '\"<img src=\'lopata.jpg\' alt=\'Description of the image\'>\"');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `produkt_id` int(11) DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `created_at`, `produkt_id`, `type`) VALUES
(1, 'asd', 'asd', '2023-11-30 14:25:24', NULL, 0),
(3, 'Ignax', '$2y$10$6LlcJK.Xp2isxI5NTckp0.3/sDX38d3oKtNMxklMa7Tl8qoWAAqAC', '2023-12-01 15:22:35', NULL, 1),
(10, '12345', '$2y$10$jopmGQ5A59TVVXNAgIZ/kOZKPYTPdMKlpvCv.1ufKsbh5Ucny/iC.', '2023-12-03 16:28:13', NULL, 0),
(11, '1', '$2y$10$QTEoUVWvVl4S/bSgvXTdiuhKZyQ/POPClVYpryUoOQ2AiqQZRUc3a', '2023-12-03 16:31:09', NULL, 0),
(14, 'user1', '$2y$10$C5n8DG.bzztRqvmVpJL8FuMgPon6h8D9FhUxd9f9hO03t2rsYCDZS', '2023-12-03 18:09:58', NULL, 0),
(15, 'Admin', '$2y$10$b89sYEfxnjbcWbfvKJk1W.w0NC71EjQWohJML632kO6Zz5ZnsPtsy', '2023-12-03 18:11:38', NULL, 1);

--
-- Wyzwalacze `users`
--
DELIMITER $$
CREATE TRIGGER `after_delete` AFTER DELETE ON `users` FOR EACH ROW BEGIN
    INSERT INTO deleted_users (id, name, password, created_at,deleted_at)
    VALUES (OLD.id, OLD.username, OLD.password,OLD.created_at, NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `użytkownicy`
--

CREATE TABLE `użytkownicy` (
  `ID` int(11) NOT NULL,
  `Imie` varchar(50) DEFAULT NULL,
  `Nazwisko` varchar(50) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Haslo` varchar(255) DEFAULT NULL,
  `Rola` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `deleted_users`
--
ALTER TABLE `deleted_users`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `koszyk`
--
ALTER TABLE `koszyk`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `produkt_id` (`produkt_id`);

--
-- Indeksy dla tabeli `najczesciej_kupowane`
--
ALTER TABLE `najczesciej_kupowane`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_produktu` (`id_produktu`);

--
-- Indeksy dla tabeli `produkty`
--
ALTER TABLE `produkty`
  ADD PRIMARY KEY (`id`);

--
-- Indeksy dla tabeli `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `produkt_id` (`produkt_id`);

--
-- Indeksy dla tabeli `użytkownicy`
--
ALTER TABLE `użytkownicy`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `deleted_users`
--
ALTER TABLE `deleted_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `koszyk`
--
ALTER TABLE `koszyk`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `najczesciej_kupowane`
--
ALTER TABLE `najczesciej_kupowane`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `produkty`
--
ALTER TABLE `produkty`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `użytkownicy`
--
ALTER TABLE `użytkownicy`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `koszyk`
--
ALTER TABLE `koszyk`
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `koszyk_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `koszyk_ibfk_2` FOREIGN KEY (`produkt_id`) REFERENCES `produkty` (`id`);

--
-- Constraints for table `najczesciej_kupowane`
--
ALTER TABLE `najczesciej_kupowane`
  ADD CONSTRAINT `najczesciej_kupowane_ibfk_1` FOREIGN KEY (`id_produktu`) REFERENCES `produkty` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`produkt_id`) REFERENCES `produkty` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
