# Host: localhost  (Version 5.5.5-10.4.32-MariaDB)
# Date: 2024-01-15 21:31:04
# Generator: MySQL-Front 6.0  (Build 2.20)


#
# Structure for table "barang"
#

DROP TABLE IF EXISTS `barang`;
CREATE TABLE `barang` (
  `Kd_Barang` char(3) NOT NULL,
  `Nama_Barang` varchar(20) NOT NULL,
  `Harga` int(10) NOT NULL,
  `JenisBarang` varchar(20) NOT NULL,
  PRIMARY KEY (`Kd_Barang`),
  KEY `KdKategori` (`JenisBarang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#
# Data for table "barang"
#

INSERT INTO `barang` VALUES ('B01','Mild',32000,'Rokok'),('B02','Teh Gelas',2000,'Minuman Dingin');

#
# Structure for table "customer"
#

DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `Kd_Customer` char(5) NOT NULL,
  `Nama` varchar(15) NOT NULL,
  `Alamat` varchar(50) NOT NULL,
  `No_Telp` int(15) NOT NULL,
  PRIMARY KEY (`Kd_Customer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#
# Data for table "customer"
#

INSERT INTO `customer` VALUES ('K01','Ucup','Serpong, Tangerang Selatan',812),('K02','Asep','Serpong, Tangerang Selatan',813);

#
# Structure for table "jenis"
#

DROP TABLE IF EXISTS `jenis`;
CREATE TABLE `jenis` (
  `KdJenis` char(5) NOT NULL,
  `JenisBarang` varchar(20) NOT NULL,
  PRIMARY KEY (`KdJenis`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#
# Data for table "jenis"
#

INSERT INTO `jenis` VALUES ('J01','Rokok'),('J02','Minuman Dingin');

#
# Structure for table "po"
#

DROP TABLE IF EXISTS `po`;
CREATE TABLE `po` (
  `KdPo` char(5) NOT NULL,
  `TglPO` date NOT NULL,
  `Kd_Barang` char(5) NOT NULL,
  `Nama_Barang` varchar(20) NOT NULL,
  `SisaStok` int(12) NOT NULL,
  `Harga` int(12) NOT NULL,
  `JumlahBeli` int(12) NOT NULL,
  `Total` int(12) NOT NULL,
  `Nama` varchar(20) NOT NULL,
  PRIMARY KEY (`KdPo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#
# Data for table "po"
#

INSERT INTO `po` VALUES ('Nt01','2024-01-15','B01','Mild',10,30000,2,60000,'Ucup'),('Nt02','2024-01-15','B02','Teh Gelas',30,2000,5,10000,'Asep');

#
# Structure for table "stok"
#

DROP TABLE IF EXISTS `stok`;
CREATE TABLE `stok` (
  `KdStok` char(50) NOT NULL,
  `Kd_Barang` varchar(255) DEFAULT NULL,
  `Nama_Barang` varchar(20) NOT NULL,
  `Terbeli` int(12) NOT NULL,
  `Terjual` int(12) NOT NULL,
  `SisaStok` int(12) NOT NULL,
  PRIMARY KEY (`KdStok`),
  UNIQUE KEY `SKU` (`Kd_Barang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#
# Data for table "stok"
#

INSERT INTO `stok` VALUES ('St01','B01','Mild',30,20,10),('St02','B02','Teh Gelas',50,20,30);

#
# Structure for table "users"
#

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `Email` char(20) NOT NULL,
  `Password` char(20) NOT NULL,
  PRIMARY KEY (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

#
# Data for table "users"
#

INSERT INTO `users` VALUES ('asep@gmail.com','1234');
