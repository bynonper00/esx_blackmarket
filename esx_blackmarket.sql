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

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
('sarjorpistol', '9mm Sarjor', -1, 0, 1),
('sarjortaramali', 'Taramalı Şarjör', -1, 0, 1),
('sarjorroket', 'Roket', -1, 0, 1),
('sarjorpompali', 'Pompalı Şarjör', -1, 0, 1),
('sarjorkeskin', 'Keskin Nişancı Şarjör', -1, 0, 1),
('sarjoragirtaramali', 'Ağır Taramalı Şarjör', -1, 0, 1);


