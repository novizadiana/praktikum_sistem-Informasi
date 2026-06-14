-- SQL Dump Lengkap untuk Database: pratikum
-- Siap Impor ke phpMyAdmin

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------
-- 1. Struktur Tabel `penyimpanan`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `penyimpanan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_penyimpanan` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data untuk tabel `penyimpanan`
INSERT INTO `penyimpanan` (`id`, `nama_penyimpanan`) VALUES
(1, 'Gedung A'),
(2, 'Gedung B');

-- --------------------------------------------------------
-- 2. Struktur Tabel `status_barang`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `status_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_status` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data untuk tabel `status_barang`
INSERT INTO `status_barang` (`id`, `nama_status`) VALUES
(1, 'Tersedia'),
(2, 'Kosong'),
(3, 'Restok');

-- --------------------------------------------------------
-- 3. Struktur Tabel `vendor` (BARU)
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `vendor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_vendor` varchar(100) NOT NULL,
  `kontak_vendor` varchar(50) DEFAULT NULL,
  `alamat_vendor` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data untuk tabel `vendor`
INSERT INTO `vendor` (`id`, `nama_vendor`, `kontak_vendor`, `alamat_vendor`) VALUES
(1, 'PT. Asus Indonesia', '021-123456', 'Jakarta Pusat'),
(2, 'Logitech Distribution', '021-654321', 'Surabaya'),
(3, 'Samsung Electronic Pusat', '021-987654', 'Semarang');

-- --------------------------------------------------------
-- 4. Struktur Tabel `barang` (DIPERBARUI)
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(100) NOT NULL,
  `status_id` int(11) DEFAULT NULL,
  `penyimpanan_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `harga_barang` int(11) DEFAULT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `limit_stok` int(11) NOT NULL DEFAULT 5,
  PRIMARY KEY (`id`),
  KEY `fk_barang_status` (`status_id`),
  KEY `fk_barang_penyimpanan` (`penyimpanan_id`),
  KEY `fk_barang_vendor` (`vendor_id`),
  -- Menghubungkan relasi antar tabel (Foreign Key)
  CONSTRAINT `fk_barang_penyimpanan` FOREIGN KEY (`penyimpanan_id`) REFERENCES `penyimpanan` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_barang_status` FOREIGN KEY (`status_id`) REFERENCES `status_barang` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_barang_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data untuk tabel `barang`
-- Data string 'aktif' & 'gudang A' otomatis divalidasi ke id relasi yang benar
INSERT INTO `barang` (`id`, `nama_barang`, `status_id`, `penyimpanan_id`, `vendor_id`, `harga_barang`, `stok`, `limit_stok`) VALUES
(1, 'Laptop ASUS', 1, 1, 1, 7500000, 12, 5),
(2, 'Mouse Logi', 1, 2, 2, 150000, 3, 5),
(3, 'Monitor Dell', 2, 2, NULL, 2000000, 20, 10),
(4, 'samsung', 1, 1, 3, 15000000, 1, 3);

-- --------------------------------------------------------
-- 5. Struktur Tabel `distribusi` (BARU)
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `distribusi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `barang_id` int(11) NOT NULL,
  `jenis_distribusi` enum('Masuk','Keluar') NOT NULL,
  `jumlah` int(11) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT current_timestamp(),
  `keterangan` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_distribusi_barang` (`barang_id`),
  CONSTRAINT `fk_distribusi_barang` FOREIGN KEY (`barang_id`) REFERENCES `barang` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data contoh untuk tabel `distribusi`
INSERT INTO `distribusi` (`id`, `barang_id`, `jenis_distribusi`, `jumlah`, `keterangan`) VALUES
(1, 1, 'Masuk', 5, 'Stok masuk dari supplier utama'),
(2, 2, 'Keluar', 2, 'Barang ditarik untuk keperluan pameran');

-- --------------------------------------------------------
-- 6. Struktur Tabel `users`
-- --------------------------------------------------------
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) DEFAULT NULL,
  `role` enum('admin','pengguna') NOT NULL DEFAULT 'pengguna',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data untuk tabel `users`
INSERT INTO `users` (`id`, `username`, `password`, `nama_lengkap`, `role`) VALUES
(1, 'admin', '0192023a7bbd73250516f069df18b500', 'Bagas Admin', 'admin'),
(2, 'user', '6ad14ba9986e3615423dfca256d04e3f', 'Pengguna Umum', 'pengguna'),
(3, 'bagas123', '5ffd9bb73b00bce4feeb77e2d12722da', 'bagas123', 'pengguna');

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;