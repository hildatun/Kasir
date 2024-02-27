-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2024 at 08:37 AM
-- Server version: 10.1.29-MariaDB
-- PHP Version: 7.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_kasir`
--

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `kdBarang` char(8) NOT NULL,
  `idKategori` int(11) NOT NULL,
  `namaBarang` varchar(64) NOT NULL,
  `harga` int(11) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `barang`
--

INSERT INTO `barang` (`kdBarang`, `idKategori`, `namaBarang`, `harga`, `stok`) VALUES
('B2400001', 9, 'GUCCI', 45000000, 10),
('B2400002', 9, 'Dior Book Tote', 35000000, 10);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `idKategori` int(11) NOT NULL,
  `namaKategori` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`idKategori`, `namaKategori`) VALUES
(9, 'TAS');

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `noItem` int(11) NOT NULL,
  `kdBarang` char(10) NOT NULL,
  `idUser` char(4) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Triggers `keranjang`
--
DELIMITER $$
CREATE TRIGGER `kurangi_stok` AFTER INSERT ON `keranjang` FOR EACH ROW UPDATE barang SET stok = stok - NEW.qty WHERE barang.kdBarang = NEW.kdBarang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `idTransaksi` char(10) NOT NULL,
  `tanggal` date NOT NULL,
  `idUser` char(4) NOT NULL,
  `namaPelanggan` varchar(64) NOT NULL,
  `alamatPelanggan` varchar(128) NOT NULL,
  `totalHarga` int(11) NOT NULL,
  `uangBayar` int(11) NOT NULL,
  `kembalian` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`idTransaksi`, `tanggal`, `idUser`, `namaPelanggan`, `alamatPelanggan`, `totalHarga`, `uangBayar`, `kembalian`) VALUES
('T240227001', '2024-02-27', 'U002', 'irma', 'Darma', 90000000, 100000000, 10000000),
('T240227002', '2024-02-27', 'U002', 'Umum', 'Darma', 35000000, 50000000, 15000000);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_detail`
--

CREATE TABLE `transaksi_detail` (
  `idTransaksi` char(10) NOT NULL,
  `kdBarang` char(8) NOT NULL,
  `qty` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi_detail`
--

INSERT INTO `transaksi_detail` (`idTransaksi`, `kdBarang`, `qty`, `subtotal`) VALUES
('T240227001', 'B2400001', 2, 90000000),
('T240227002', 'B2400002', 1, 35000000);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `idUser` char(4) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(128) NOT NULL,
  `level` enum('administrator','petugas','kepala toko') NOT NULL,
  `nama` varchar(64) NOT NULL,
  `noTelp` varchar(20) NOT NULL,
  `foto` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`idUser`, `username`, `password`, `level`, `nama`, `noTelp`, `foto`) VALUES
('U001', 'admin', '$2y$10$R/ZJxF0U31Uq4IXhfMVE6OSG1h2efszpNiZP1RjRI9ifShCAU//Cy', 'administrator', 'Super Admin', '081212830909', 'c1b9b51347a0f82814a433282c601311.png'),
('U002', 'petugas', '$2y$10$FXNkXwaU/TGDf5Xv7INhFu9RxJvhcjLNNP9ewTaKkYxXbhtHxwypi', 'petugas', 'Hildatun', '085797163092', '870b3551284de14e1bb1f050ae8ac42d.jpg'),
('U003', 'owner', '$2y$10$zBSdHDbDoV/rZsnLkEzmsORSAQbt.h7/DfH1JIHH/RRE5daY7x0.G', 'kepala toko', 'rizki', '085795427321', '97d7ae1ddd021c12c18785a8beed0c53.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kdBarang`),
  ADD KEY `idKategori` (`idKategori`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`idKategori`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`noItem`),
  ADD KEY `kdBarang` (`kdBarang`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`idTransaksi`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD KEY `idTransaksi` (`idTransaksi`),
  ADD KEY `kdBarang` (`kdBarang`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `idKategori` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `barang`
--
ALTER TABLE `barang`
  ADD CONSTRAINT `barang_ibfk_1` FOREIGN KEY (`idKategori`) REFERENCES `kategori` (`idKategori`);

--
-- Constraints for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD CONSTRAINT `keranjang_ibfk_1` FOREIGN KEY (`kdBarang`) REFERENCES `barang` (`kdBarang`);

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`);

--
-- Constraints for table `transaksi_detail`
--
ALTER TABLE `transaksi_detail`
  ADD CONSTRAINT `transaksi_detail_ibfk_2` FOREIGN KEY (`kdBarang`) REFERENCES `barang` (`kdBarang`),
  ADD CONSTRAINT `transaksi_detail_ibfk_3` FOREIGN KEY (`idTransaksi`) REFERENCES `transaksi` (`idTransaksi`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
