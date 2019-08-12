USE `essentialmode`;
  
CREATE TABLE IF NOT EXISTS `black_shipments` (
  `id` int(11) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `count` varchar(50) DEFAULT NULL,
  `time` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


  
CREATE TABLE IF NOT EXISTS `black_muhshipments` (
  `id` int(11) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `label` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `price` varchar(50) DEFAULT NULL,
  `count` varchar(50) DEFAULT NULL,
  `time` int(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `items` (`id`, `name`, `label`, `limit`, `rare`, `can_remove`) VALUES
(3001, 'sarjorpistol', '9mm Sarjor', -1, 0, 1),
(3002, 'sarjortaramali', 'Taramalı Şarjör', -1, 0, 1),
(3003, 'sarjorroket', 'Roket', -1, 0, 1),
(3004, 'sarjorpompali', 'Pompalı Şarjör', -1, 0, 1),
(3005, 'sarjorkeskin', 'Keskin Nişancı Şarjör', -1, 0, 1),
(3006, 'sarjoragirtaramali', 'Ağır Taramalı Şarjör', -1, 0, 1);


