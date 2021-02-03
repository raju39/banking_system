-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `accounts_deposit`;
CREATE TABLE `accounts_deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(10) unsigned NOT NULL,
  `date` datetime(6) NOT NULL,
  `dep_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `dep_user_id` (`dep_user_id`),
  CONSTRAINT `accounts_deposit_ibfk_1` FOREIGN KEY (`dep_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `accounts_deposit` (`id`, `amount`, `date`, `dep_user_id`) VALUES
(1,	20112,	'2021-02-03 14:36:23.710098',	3),
(2,	500,	'2021-02-03 08:22:43.713366',	5),
(3,	500,	'2021-02-03 14:35:50.000000',	4);

DROP TABLE IF EXISTS `accounts_transaction`;
CREATE TABLE `accounts_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_no` int(11) NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  `tran_type` varchar(200) DEFAULT NULL,
  `date` datetime(6) NOT NULL,
  `tran_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tran_user_id` (`tran_user_id`),
  CONSTRAINT `accounts_transaction_ibfk_1` FOREIGN KEY (`tran_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `accounts_transaction` (`id`, `account_no`, `amount`, `tran_type`, `date`, `tran_user_id`) VALUES
(1,	1612337700,	200,	'Deposit',	'2021-02-03 07:58:20.614911',	3),
(2,	1612337700,	1,	'Deposit',	'2021-02-03 07:58:41.704105',	3),
(3,	1612337700,	1,	'Deposit',	'2021-02-03 08:02:33.269644',	3),
(4,	1612337700,	1,	'Withdraw',	'2021-02-03 08:02:41.698765',	3),
(5,	1612337700,	300,	'Withdraw',	'2021-02-03 08:02:46.887140',	3),
(6,	1612337700,	1,	'Withdraw',	'2021-02-03 08:09:05.569105',	3),
(7,	1612340563,	500,	'Deposit',	'2021-02-03 08:22:43.768936',	5),
(8,	1612337714,	500,	'Deposit',	'2021-02-03 14:37:42.000000',	4),
(9,	1612337700,	10000,	'Deposit',	'2021-02-03 14:32:07.051922',	3),
(10,	1612337700,	10000,	'Deposit',	'2021-02-03 14:32:39.098210',	3),
(11,	1612337700,	100,	'Deposit',	'2021-02-03 14:36:23.710161',	3);

DROP TABLE IF EXISTS `accounts_withdraw`;
CREATE TABLE `accounts_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` int(10) unsigned NOT NULL,
  `date` datetime(6) NOT NULL,
  `with_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `with_user_id` (`with_user_id`),
  CONSTRAINT `accounts_withdraw_ibfk_1` FOREIGN KEY (`with_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `accounts_withdraw` (`id`, `amount`, `date`, `with_user_id`) VALUES
(1,	1,	'2021-02-03 07:43:56.329599',	3),
(2,	1,	'2021-02-03 08:02:41.698675',	3),
(3,	300,	'2021-02-03 08:02:46.887080',	3),
(4,	1,	'2021-02-03 08:09:05.569055',	3);

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1,	'Can add log entry',	1,	'add_logentry'),
(2,	'Can change log entry',	1,	'change_logentry'),
(3,	'Can delete log entry',	1,	'delete_logentry'),
(4,	'Can view log entry',	1,	'view_logentry'),
(5,	'Can add permission',	2,	'add_permission'),
(6,	'Can change permission',	2,	'change_permission'),
(7,	'Can delete permission',	2,	'delete_permission'),
(8,	'Can view permission',	2,	'view_permission'),
(9,	'Can add group',	3,	'add_group'),
(10,	'Can change group',	3,	'change_group'),
(11,	'Can delete group',	3,	'delete_group'),
(12,	'Can view group',	3,	'view_group'),
(13,	'Can add user',	4,	'add_user'),
(14,	'Can change user',	4,	'change_user'),
(15,	'Can delete user',	4,	'delete_user'),
(16,	'Can view user',	4,	'view_user'),
(17,	'Can add content type',	5,	'add_contenttype'),
(18,	'Can change content type',	5,	'change_contenttype'),
(19,	'Can delete content type',	5,	'delete_contenttype'),
(20,	'Can view content type',	5,	'view_contenttype'),
(21,	'Can add session',	6,	'add_session'),
(22,	'Can change session',	6,	'change_session'),
(23,	'Can delete session',	6,	'delete_session'),
(24,	'Can view session',	6,	'view_session'),
(25,	'Can add withdraw',	7,	'add_withdraw'),
(26,	'Can change withdraw',	7,	'change_withdraw'),
(27,	'Can delete withdraw',	7,	'delete_withdraw'),
(28,	'Can view withdraw',	7,	'view_withdraw'),
(29,	'Can add transaction',	8,	'add_transaction'),
(30,	'Can change transaction',	8,	'change_transaction'),
(31,	'Can delete transaction',	8,	'delete_transaction'),
(32,	'Can view transaction',	8,	'view_transaction'),
(33,	'Can add deposit',	9,	'add_deposit'),
(34,	'Can change deposit',	9,	'change_deposit'),
(35,	'Can delete deposit',	9,	'delete_deposit'),
(36,	'Can view deposit',	9,	'view_deposit'),
(37,	'Can add account detail',	10,	'add_accountdetail'),
(38,	'Can change account detail',	10,	'change_accountdetail'),
(39,	'Can delete account detail',	10,	'delete_accountdetail'),
(40,	'Can view account detail',	10,	'view_accountdetail'),
(41,	'Can add auth group',	11,	'add_authgroup'),
(42,	'Can change auth group',	11,	'change_authgroup'),
(43,	'Can delete auth group',	11,	'delete_authgroup'),
(44,	'Can view auth group',	11,	'view_authgroup'),
(45,	'Can add auth group permissions',	12,	'add_authgrouppermissions'),
(46,	'Can change auth group permissions',	12,	'change_authgrouppermissions'),
(47,	'Can delete auth group permissions',	12,	'delete_authgrouppermissions'),
(48,	'Can view auth group permissions',	12,	'view_authgrouppermissions'),
(49,	'Can add auth permission',	13,	'add_authpermission'),
(50,	'Can change auth permission',	13,	'change_authpermission'),
(51,	'Can delete auth permission',	13,	'delete_authpermission'),
(52,	'Can view auth permission',	13,	'view_authpermission'),
(53,	'Can add auth user',	14,	'add_authuser'),
(54,	'Can change auth user',	14,	'change_authuser'),
(55,	'Can delete auth user',	14,	'delete_authuser'),
(56,	'Can view auth user',	14,	'view_authuser'),
(57,	'Can add auth user groups',	15,	'add_authusergroups'),
(58,	'Can change auth user groups',	15,	'change_authusergroups'),
(59,	'Can delete auth user groups',	15,	'delete_authusergroups'),
(60,	'Can view auth user groups',	15,	'view_authusergroups'),
(61,	'Can add auth user user permissions',	16,	'add_authuseruserpermissions'),
(62,	'Can change auth user user permissions',	16,	'change_authuseruserpermissions'),
(63,	'Can delete auth user user permissions',	16,	'delete_authuseruserpermissions'),
(64,	'Can view auth user user permissions',	16,	'view_authuseruserpermissions'),
(65,	'Can add django admin log',	17,	'add_djangoadminlog'),
(66,	'Can change django admin log',	17,	'change_djangoadminlog'),
(67,	'Can delete django admin log',	17,	'delete_djangoadminlog'),
(68,	'Can view django admin log',	17,	'view_djangoadminlog'),
(69,	'Can add django content type',	18,	'add_djangocontenttype'),
(70,	'Can change django content type',	18,	'change_djangocontenttype'),
(71,	'Can delete django content type',	18,	'delete_djangocontenttype'),
(72,	'Can view django content type',	18,	'view_djangocontenttype'),
(73,	'Can add django migrations',	19,	'add_djangomigrations'),
(74,	'Can change django migrations',	19,	'change_djangomigrations'),
(75,	'Can delete django migrations',	19,	'delete_djangomigrations'),
(76,	'Can view django migrations',	19,	'view_djangomigrations'),
(77,	'Can add django session',	20,	'add_djangosession'),
(78,	'Can change django session',	20,	'change_djangosession'),
(79,	'Can delete django session',	20,	'delete_djangosession'),
(80,	'Can view django session',	20,	'view_djangosession');

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1,	'pbkdf2_sha256$216000$kyMgUZzf6N4y$4Cfy9XrZCZO0IqyEbB5oA8d+1zeLzC6gRLQTfv2ejgU=',	NULL,	1,	'raju',	'',	'',	'rajugupta5jan1989@gmail.com',	1,	1,	'2021-02-03 07:24:25.492408'),
(3,	'pbkdf2_sha256$216000$iyR6ZgwEc4aM$K/uTfgEUvuVK8x3Fe3zVX04pbYbtLxd83wIK554JeIQ=',	NULL,	2,	'vishal@gmail.com',	'Vishal',	'singh',	'Vishal@gmail.com',	1,	1,	'2021-02-03 07:35:00.834233'),
(4,	'pbkdf2_sha256$216000$dVCTB2orOkM4$8+xEV31SRxhOn16e6nWUzhbnw3BPsF984EuKg3crzuA=',	NULL,	2,	'mohar@gmail.com',	'Mohar',	'singh',	'Mohar@gmail.com',	1,	1,	'2021-02-03 07:35:14.485653'),
(5,	'pbkdf2_sha256$216000$qhxmbGo5bhpw$IkjU66IRgyCRn9q2Nw4xVfsQSD0mg2shF9Qk6kXyNKE=',	NULL,	2,	'dipu@gmail.com',	'Dipu',	'gupta',	'Dipu@gmail.com',	1,	1,	'2021-02-03 08:22:43.494788');

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `customer_accountdetail`;
CREATE TABLE `customer_accountdetail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address` varchar(128) NOT NULL,
  `account_no` int(11) NOT NULL,
  `created` datetime(6) NOT NULL,
  `acc_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `acc_user_id` (`acc_user_id`),
  CONSTRAINT `customer_accountdetail_ibfk_1` FOREIGN KEY (`acc_user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `customer_accountdetail` (`id`, `address`, `account_no`, `created`, `acc_user_id`) VALUES
(1,	'noida 31 m45 near mamura',	1612337700,	'2021-02-03 07:35:00.878704',	3),
(2,	'123 Main Street',	1612337714,	'2021-02-03 07:35:14.540768',	4),
(3,	'456 Other Street',	1612340563,	'2021-02-03 08:22:43.547105',	5);

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(9,	'accounts',	'deposit'),
(8,	'accounts',	'transaction'),
(7,	'accounts',	'withdraw'),
(1,	'admin',	'logentry'),
(3,	'auth',	'group'),
(2,	'auth',	'permission'),
(4,	'auth',	'user'),
(5,	'contenttypes',	'contenttype'),
(10,	'customer',	'accountdetail'),
(11,	'customer',	'authgroup'),
(12,	'customer',	'authgrouppermissions'),
(13,	'customer',	'authpermission'),
(14,	'customer',	'authuser'),
(15,	'customer',	'authusergroups'),
(16,	'customer',	'authuseruserpermissions'),
(17,	'customer',	'djangoadminlog'),
(18,	'customer',	'djangocontenttype'),
(19,	'customer',	'djangomigrations'),
(20,	'customer',	'djangosession'),
(6,	'sessions',	'session');

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1,	'customer',	'0001_initial',	'2021-02-03 07:13:30.730595'),
(2,	'accounts',	'0001_initial',	'2021-02-03 07:17:15.013483'),
(3,	'contenttypes',	'0001_initial',	'2021-02-03 07:19:22.625774'),
(4,	'auth',	'0001_initial',	'2021-02-03 07:19:25.149016'),
(5,	'admin',	'0001_initial',	'2021-02-03 07:19:33.418546'),
(6,	'admin',	'0002_logentry_remove_auto_add',	'2021-02-03 07:19:35.250636'),
(7,	'admin',	'0003_logentry_add_action_flag_choices',	'2021-02-03 07:19:35.316397'),
(8,	'contenttypes',	'0002_remove_content_type_name',	'2021-02-03 07:19:36.716503'),
(9,	'auth',	'0002_alter_permission_name_max_length',	'2021-02-03 07:19:36.881816'),
(10,	'auth',	'0003_alter_user_email_max_length',	'2021-02-03 07:19:37.039008'),
(11,	'auth',	'0004_alter_user_username_opts',	'2021-02-03 07:19:37.098831'),
(12,	'auth',	'0005_alter_user_last_login_null',	'2021-02-03 07:19:37.851421'),
(13,	'auth',	'0006_require_contenttypes_0002',	'2021-02-03 07:19:37.906380'),
(14,	'auth',	'0007_alter_validators_add_error_messages',	'2021-02-03 07:19:37.976348'),
(15,	'auth',	'0008_alter_user_username_max_length',	'2021-02-03 07:19:38.141130'),
(16,	'auth',	'0009_alter_user_last_name_max_length',	'2021-02-03 07:19:38.296948'),
(17,	'auth',	'0010_alter_group_name_max_length',	'2021-02-03 07:19:38.442006'),
(18,	'auth',	'0011_update_proxy_permissions',	'2021-02-03 07:19:38.511313'),
(19,	'auth',	'0012_alter_user_first_name_max_length',	'2021-02-03 07:19:38.653377'),
(20,	'sessions',	'0001_initial',	'2021-02-03 07:19:39.034635');

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('rkaq0eyk5aw7xfwib2jf4e1kl7f9ibt6',	'eyJlbWFpbCI6IlZpc2hhbEBnbWFpbC5jb20iLCJ1c2VyX3R5cGUiOjIsInVzZXJfaWQiOjN9:1l7JCI:YZOzqI0cp-tj8mHfHF1t1K_bM21qOI7-AJ_1FJmqKRY',	'2021-02-17 14:31:58.599126');

-- 2021-02-03 14:46:09
