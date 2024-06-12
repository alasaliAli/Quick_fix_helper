-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 12 يونيو 2024 الساعة 21:43
-- إصدار الخادم: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `quick_fix_helper`
--

-- --------------------------------------------------------

--
-- بنية الجدول `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add ticket category', 7, 'add_ticketcategory'),
(26, 'Can change ticket category', 7, 'change_ticketcategory'),
(27, 'Can delete ticket category', 7, 'delete_ticketcategory'),
(28, 'Can view ticket category', 7, 'view_ticketcategory'),
(29, 'Can add ticket', 8, 'add_ticket'),
(30, 'Can change ticket', 8, 'change_ticket'),
(31, 'Can delete ticket', 8, 'delete_ticket'),
(32, 'Can view ticket', 8, 'view_ticket'),
(33, 'Can add article', 9, 'add_article'),
(34, 'Can change article', 9, 'change_article'),
(35, 'Can delete article', 9, 'delete_article'),
(36, 'Can view article', 9, 'view_article'),
(37, 'Can add ticket attachment', 10, 'add_ticketattachment'),
(38, 'Can change ticket attachment', 10, 'change_ticketattachment'),
(39, 'Can delete ticket attachment', 10, 'delete_ticketattachment'),
(40, 'Can view ticket attachment', 10, 'view_ticketattachment'),
(41, 'Can add faq', 11, 'add_faq'),
(42, 'Can change faq', 11, 'change_faq'),
(43, 'Can delete faq', 11, 'delete_faq'),
(44, 'Can view faq', 11, 'view_faq'),
(45, 'Can add ticket status', 12, 'add_ticketstatus'),
(46, 'Can change ticket status', 12, 'change_ticketstatus'),
(47, 'Can delete ticket status', 12, 'delete_ticketstatus'),
(48, 'Can view ticket status', 12, 'view_ticketstatus'),
(49, 'Can add ticket remark', 13, 'add_ticketremark'),
(50, 'Can change ticket remark', 13, 'change_ticketremark'),
(51, 'Can delete ticket remark', 13, 'delete_ticketremark'),
(52, 'Can view ticket remark', 13, 'view_ticketremark'),
(53, 'Can add ticket status', 14, 'add_ticketstatus'),
(54, 'Can change ticket status', 14, 'change_ticketstatus'),
(55, 'Can delete ticket status', 14, 'delete_ticketstatus'),
(56, 'Can view ticket status', 14, 'view_ticketstatus'),
(57, 'Can add contact', 15, 'add_contact'),
(58, 'Can change contact', 15, 'change_contact'),
(59, 'Can delete contact', 15, 'delete_contact'),
(60, 'Can view contact', 15, 'view_contact');

-- --------------------------------------------------------

--
-- بنية الجدول `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(3, 'pbkdf2_sha256$720000$2AqA1VKBaqAIDeFy6amoQH$lEy/UHMjr3w1WflMYfyTX3wZNcxF9H8XFIFqgwlTjCo=', '2024-06-11 09:45:05.713944', 0, 'staff_member', 'Adam', 'Omran', 'povuky@mailinator.com', 1, 1, '2024-02-06 19:17:01.810406'),
(5, 'pbkdf2_sha256$720000$rUv20G3elXWRuhfgC8el6h$FAuHh561JMMIQg7vvaKe59iIHUh9s6HLdcc10WU/yUw=', '2024-06-11 09:43:41.866424', 0, 'user_member', 'Ahmad', 'Ali', 'nebavozoc@mailinator.com', 0, 1, '2024-02-08 14:29:21.988098'),
(2, 'pbkdf2_sha256$720000$8vwiobCZBHO23kFPVqc9kF$GO9qszmCIXhQ8EGkbLih/PHLgK+XbSmKYovgioDKSdE=', '2024-06-12 19:29:25.730605', 1, 'admin', 'Ibrahim', 'Nasor', 'adamballen@gmail.com', 0, 1, '2024-05-31 19:16:16.243869'),
(9, 'pbkdf2_sha256$720000$pFIl7392cWgSFyAvm51LpJ$PskNSFlOFCXL60n6z2KABoqozVeJY2jTjJUdDjw1tVM=', '2024-06-05 20:22:03.615796', 0, 'noof', 'noof ', 'ahmed', 'noof@gmail.com', 1, 1, '2024-06-05 20:02:06.802127');

-- --------------------------------------------------------

--
-- بنية الجدول `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'permission'),
(3, 'auth', 'group'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(7, 'helpdesk', 'ticketcategory'),
(8, 'helpdesk', 'ticket'),
(9, 'helpdesk', 'article'),
(10, 'helpdesk', 'ticketattachment'),
(11, 'helpdesk', 'faq'),
(14, 'helpdesk', 'ticketstatus'),
(13, 'helpdesk', 'ticketremark'),
(15, 'helpdesk', 'contact');

-- --------------------------------------------------------

--
-- بنية الجدول `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-01-26 11:20:39.907933'),
(2, 'auth', '0001_initial', '2024-01-26 11:20:40.942322'),
(3, 'admin', '0001_initial', '2024-01-26 11:20:41.322524'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-01-26 11:20:41.332613'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-01-26 11:20:41.345611'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-01-26 11:20:41.460789'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-01-26 11:20:41.530393'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-01-26 11:20:41.599805'),
(9, 'auth', '0004_alter_user_username_opts', '2024-01-26 11:20:41.609935'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-01-26 11:20:41.682482'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-01-26 11:20:41.684485'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-01-26 11:20:41.696315'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-01-26 11:20:41.761041'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-01-26 11:20:41.829657'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-01-26 11:20:41.889846'),
(16, 'auth', '0011_update_proxy_permissions', '2024-01-26 11:20:41.905545'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-01-26 11:20:41.970455'),
(18, 'sessions', '0001_initial', '2024-01-26 11:20:42.037253'),
(19, 'helpdesk', '0001_initial', '2024-01-30 08:27:15.725667'),
(20, 'helpdesk', '0002_ticket_category_id_ticket_priority', '2024-02-01 12:20:22.524344'),
(21, 'helpdesk', '0003_alter_ticket_assigned_user_and_more', '2024-02-01 12:45:22.444412'),
(22, 'helpdesk', '0004_alter_ticketattachment_file', '2024-02-01 12:56:59.737151'),
(23, 'helpdesk', '0005_ticket_create_at', '2024-02-02 10:45:58.936279'),
(24, 'helpdesk', '0006_rename_create_at_ticket_created_at_and_more', '2024-02-02 10:47:37.668875'),
(25, 'helpdesk', '0007_alter_ticketremark_ticket_id', '2024-02-02 10:55:51.272385'),
(26, 'helpdesk', '0008_contact_delete_ticketstatus', '2024-05-28 16:39:36.600563');

-- --------------------------------------------------------

--
-- بنية الجدول `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('f31xso5w48z5fmvdnpkn18k0wpwe4wry', '.eJxVjDsOwyAQRO9CbSFgHT4p0-cMaIElOIlAMnYV5e6xJRdxMc28N_NhHtel-LXT7KfErkyx4b8LGF9Ud5CeWB-Nx1aXeQp8V_hBO7-3RO_b4Z4OCvayrWXETCDBkA5W2GwJrAMZhRRmNE47JVVGcupiNQoyoNMWTAhRuDxq9v0By2k3IA:1rqsy2:jH-65utBGp0iciwezezxxDjOkR4LjCkOSxztrh3rLm0', '2024-04-14 11:03:14.591248'),
('subv7nyjtsch0t7ms2cj3knkv8inr607', '.eJxVjDsOwyAQRO9CbSFgHT4p0-cMaIElOIlAMnYV5e6xJRdxMc28N_NhHtel-LXT7KfErkyx4b8LGF9Ud5CeWB-Nx1aXeQp8V_hBO7-3RO_b4Z4OCvayrWXETCDBkA5W2GwJrAMZhRRmNE47JVVGcupiNQoyoNMWTAhRuDxq9v0By2k3IA:1sCcqc:PeSdhBFQX7_sFWv_v066Zr3BSfOdns7fX8tCVYSafKA', '2024-06-13 10:17:26.001021'),
('7lg77by10hj6sz20ncywe4745q9r6rev', '.eJxVjMEOwiAQRP-FsyFli4AevfcbyC67laqBpLQn47_bJj3obTLvzbxVxHXJcW0yx4nVVQV1-u0I01PKDviB5V51qmWZJ9K7og_a9FBZXrfD_TvI2PK27qEL_mx9PxrHjCE5dtCP3gIBEhhDLrC3HVyYjAFxlrYkiYxFdOLV5wvK_zfG:1sD8x6:JHf8lTVcBFlp9y9rP3B3ywRQMXka0ZPiIoOjN3Ev978', '2024-06-14 20:34:16.046075'),
('6lhs1h1ujxaskku5apjlq5xeao8q7w7h', '.eJxVjMEOwiAQRP-FsyFli4AevfcbyC67laqBpLQn47_bJj3obTLvzbxVxHXJcW0yx4nVVQV1-u0I01PKDviB5V51qmWZJ9K7og_a9FBZXrfD_TvI2PK27qEL_mx9PxrHjCE5dtCP3gIBEhhDLrC3HVyYjAFxlrYkiYxFdOLV5wvK_zfG:1sDRy2:MNQw0UtBfDFfIVcaKtLebfkjk5Gu7Kmy7t947lliKIY', '2024-06-15 16:52:30.872804'),
('ujuizs9yqz74b3xuhh1t04lfyxzeh01t', '.eJxVjMEOwiAQRP-FsyFli4AevfcbyC67laqBpLQn47_bJj3obTLvzbxVxHXJcW0yx4nVVQV1-u0I01PKDviB5V51qmWZJ9K7og_a9FBZXrfD_TvI2PK27qEL_mx9PxrHjCE5dtCP3gIBEhhDLrC3HVyYjAFxlrYkiYxFdOLV5wvK_zfG:1sDRv4:C24rqXMg5e8x5M_QXGQiveMeF-l1cFy9kPmzywwXLrY', '2024-06-15 16:49:26.114211'),
('un3mg06qihf6u5z3cx6gl2dnx5jxvtft', '.eJxVjMEOwiAQRP-FsyFli4AevfcbyC67laqBpLQn47_bJj3obTLvzbxVxHXJcW0yx4nVVQV1-u0I01PKDviB5V51qmWZJ9K7og_a9FBZXrfD_TvI2PK27qEL_mx9PxrHjCE5dtCP3gIBEhhDLrC3HVyYjAFxlrYkiYxFdOLV5wvK_zfG:1sDRys:zqlsfGzoTPytxkIivyexfs9Fg9PHYJ_1ktrW3pCMXC4', '2024-06-15 16:53:22.022516'),
('dqiahvr19aadhxlufgm6vnnid5tid1pj', '.eJxVjMsOgjAQRf-la9OUPoS6dM83kNuZQVDTJhRWxn9XEha6veec-1IDtnUatirLMLO6qKBOv1sCPSTvgO_It6Kp5HWZk94VfdCq-8LyvB7u38GEOn1rTw0E6DoBSWhTTGycC-BIhp2zYsCmDTDWjz7amMjDUtPGkc9C4tX7Aw_4OOA:1sDoJN:agitLpEPVAwYFBd3zN_TZZkt2DPkfgKJhQ53G_jl1nc', '2024-06-16 16:44:01.065018'),
('gv1ovvmvqqvedg3sa1s82zpje9nqqdkm', '.eJxVjMEOwiAQRP-FsyFli4AevfcbyC67laqBpLQn47_bJj3obTLvzbxVxHXJcW0yx4nVVYE6_XaE6SllB_zAcq861bLME-ld0Qdteqgsr9vh_h1kbHlb99AFf7a-H41jxpAcO-hHb4EACYwhF9jbDi5MxoA4S1uSRMYiOvHq8wXHaTfA:1sHTev:K7fCR5HQER61Cc2eDG0I066culeSJwG0JeLv10zSAhM', '2024-06-26 19:29:25.731426');

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_article`
--

CREATE TABLE `helpdesk_article` (
  `id` bigint(20) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `published_date` datetime(6) NOT NULL,
  `views` int(11) NOT NULL,
  `user_id_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `helpdesk_article`
--

INSERT INTO `helpdesk_article` (`id`, `title`, `description`, `published_date`, `views`, `user_id_id`) VALUES
(1, '\"Troubleshooting Common Software Issues: A Technical Support Guide\"', 'This article outlines strategies for addressing prevalent software glitches, offering step-by-step solutions for common technical challenges encountered by users. From troubleshooting error messages to resolving compatibility issues, it equips technical support teams with the knowledge needed to assist users effectively.', '2024-02-08 14:01:11.944642', 0, 2),
(2, '\"Best Practices for Streamlining Customer Support Processes\"', 'Explore techniques for optimizing customer support operations, including ticket management systems, effective communication strategies, and leveraging automation tools. This article provides insights into enhancing customer satisfaction while maximizing efficiency within support teams.', '2024-02-08 14:01:32.241260', 0, 2),
(3, '\"The Role of Human Resources in Fostering Employee Engagement\"', 'Delve into the significance of human resources in cultivating a culture of engagement and productivity within organizations. From implementing effective feedback mechanisms to designing employee development programs, this article explores HR strategies for nurturing a motivated workforce.', '2024-02-08 14:01:47.485217', 0, 2),
(4, '\"Preventive Maintenance: A Guide to Proactive Equipment Management\"', 'Learn the importance of preventive maintenance in minimizing downtime and maximizing operational efficiency. This article outlines best practices for implementing a preventive maintenance program, including scheduling routines, conducting inspections, and leveraging technology for predictive maintenance.', '2024-02-08 14:02:05.806442', 0, 2),
(5, '\"Mastering Effective Communication in Technical Support\"', 'Communication lies at the heart of effective technical support. This article explores communication strategies, active listening techniques, and the art of conveying technical information in a clear and concise manner. Discover how improved communication skills can enhance the customer support experience.', '2024-02-08 14:02:22.004852', 0, 2),
(6, '\"Building a Robust Knowledge Base for Customer Self-Service\"', 'Empower customers to find solutions independently by creating a comprehensive knowledge base. This article discusses the importance of a well-organized knowledge repository, tips for content creation, and strategies for ensuring accessibility. By facilitating self-service options, businesses can enhance customer satisfaction and reduce support overhead.', '2024-02-08 14:02:39.922721', 0, 2),
(7, '\"Navigating Complex IT Infrastructure: Tips for Technical Support Specialists\"', 'Technical support specialists often encounter intricate IT environments. This article offers guidance on navigating complex infrastructure, troubleshooting network issues, and effectively managing multiple systems. From identifying root causes to implementing scalable solutions, it equips support professionals with the tools needed to tackle diverse IT challenges.', '2024-02-08 14:02:54.828843', 0, 2),
(8, '\"The Role of Emotional Intelligence in Customer Support\"', 'Explore the impact of emotional intelligence on customer interactions and satisfaction levels. This article discusses strategies for developing empathy, managing difficult conversations, and fostering positive rapport with customers. By prioritizing emotional intelligence, support agents can build stronger relationships and enhance overall service quality.', '2024-02-08 14:03:10.786288', 0, 2),
(9, '\"Optimizing Help Desk Performance Through Metrics and KPIs\"', 'Unlock insights into measuring help desk performance and driving continuous improvement. This article explores key performance indicators (KPIs) such as response times, resolution rates, and customer satisfaction scores. By leveraging data-driven insights, organizations can identify areas for enhancement and optimize help desk operations.', '2024-02-08 14:03:27.142621', 0, 2);

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_contact`
--

CREATE TABLE `helpdesk_contact` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `subject` longtext NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_faq`
--

CREATE TABLE `helpdesk_faq` (
  `id` bigint(20) NOT NULL,
  `question` longtext NOT NULL,
  `answer` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `helpdesk_faq`
--

INSERT INTO `helpdesk_faq` (`id`, `question`, `answer`, `created_at`, `user_id_id`) VALUES
(1, 'My computer is running slow. What should I do?', 'A slow computer can result from various issues such as low disk space, excessive background processes, or malware. Try clearing temporary files, running disk cleanup, and uninstalling unused programs. Additionally, consider upgrading your RAM or switching to a solid-state drive (SSD) for improved performance.', '2024-02-08 14:06:44.382533', 2),
(2, 'I forgot my password. How can I reset it?', 'For password resets, visit the login page and look for the \"Forgot Password\" link. Follow the prompts to verify your identity, typically by answering security questions or receiving a password reset link via email or text message. If you\'re unable to reset your password, contact your organization\'s IT help desk for further assistance.', '2024-02-08 14:07:56.177356', 2),
(3, 'I\'m experiencing network connectivity issues. What should I check?', 'Start by verifying that your device is connected to the correct network and that Wi-Fi or Ethernet cables are securely plugged in. Check for any network outage notifications from your internet service provider (ISP) and ensure that your router and modem are functioning properly. Restarting your router and device can also resolve many connectivity issues.', '2024-02-08 14:08:13.690059', 2),
(4, 'How do I install software on my computer?', 'To install software, first download the installation file from a trusted source. Double-click the downloaded file to begin the installation process, then follow the on-screen instructions provided by the installer. Be cautious of any additional software bundled with the installation and deselect any unwanted options during the installation process.', '2024-02-08 14:08:27.817974', 2),
(5, 'My email client is not sending or receiving emails. What could be the problem?', 'Start troubleshooting by checking your internet connection and ensuring that your email account settings are configured correctly. Verify that your email server settings (such as SMTP and IMAP/POP3) are accurate. If the issue persists, try restarting your email client, clearing cache and cookies, or accessing your email account through a web browser.', '2024-02-08 14:08:43.611058', 2),
(6, 'I accidentally deleted an important file. Can it be recovered?', 'Deleted files may be recoverable if they haven\'t been overwritten by new data. Try using file recovery software or contacting your IT support team for assistance. Avoid using the device or saving new files to prevent overwriting the deleted data, as this reduces the chances of successful recovery.', '2024-02-08 14:09:02.818482', 2),
(7, 'Id blanditiis aut e', 'Ex odit corrupti cu', '2024-03-31 11:03:47.739243', 2);

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_profile`
--

CREATE TABLE `helpdesk_profile` (
  `id` bigint(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf16 COLLATE=utf16_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `helpdesk_profile`
--

INSERT INTO `helpdesk_profile` (`id`, `image`, `user_id`) VALUES
(1, 'faces/Untitled_FgthfUm.jpg', 2),
(2, 'faces/Untitled_4lJYbCa.jpg', 9);

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_ticket`
--

CREATE TABLE `helpdesk_ticket` (
  `id` bigint(20) NOT NULL,
  `ticket_token` varchar(6) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `status` varchar(1) NOT NULL,
  `is_assigned` tinyint(1) NOT NULL,
  `assigned_user_id` int(11) DEFAULT NULL,
  `user_id_id` int(11) NOT NULL,
  `category_id_id` bigint(20) DEFAULT NULL,
  `priority` varchar(50) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `helpdesk_ticket`
--

INSERT INTO `helpdesk_ticket` (`id`, `ticket_token`, `subject`, `description`, `status`, `is_assigned`, `assigned_user_id`, `user_id_id`, `category_id_id`, `priority`, `created_at`) VALUES
(1, 'VZIG1K', 'Required an information about Job', 'I just completed my degree and looking for a job. can you please suggest the opportunities?', '0', 1, 3, 5, 2, 'urgent', '2024-02-08 16:32:10.223729'),
(2, '9LWEYL', 'Looking for help for my PC', 'My PC suddenly shut down without any reason even not show any issue. Please let me know why I\'m unable to fix it. My PC is by HP.', '0', 1, 3, 5, 1, 'moderate', '2024-02-13 04:18:20.312055'),
(3, 'YWJX1P', 'Sit nostrud officiakj', 'Dolor temporibus suslkl', '0', 1, 3, 7, 3, 'moderate', '2024-05-28 18:13:47.878508'),
(4, 'S5YMH5', 'Ut rerum qui odit relkl', 'Illum nisi duis bea', '0', 0, NULL, 7, 2, 'not urgent', '2024-05-30 05:47:11.049745'),
(5, 'FP3FHT', 'Aute dolor velit des', 'Repellendus Alias sk', '0', 0, NULL, 7, 2, 'moderate', '2024-05-30 05:47:42.140677'),
(6, 'YT70AY', 'Nulla sapiente bland fjf', 'Quidem dolore consecthi', '2', 1, 3, 7, 1, 'not urgent', '2024-05-30 10:17:04.578960'),
(12, '07LI34', 'Help with team viewer', 'PLz help!!!', '0', 0, NULL, 5, 3, 'urgent', '2024-06-01 16:47:34.995924'),
(15, '7YBDZA', 'PC slow', 'I can not open any app. And every time sticking', '0', 0, NULL, 5, 1, 'urgent', '2024-06-05 20:21:13.305366');

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_ticketattachment`
--

CREATE TABLE `helpdesk_ticketattachment` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `file_type` varchar(100) NOT NULL,
  `ticket_id_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `helpdesk_ticketattachment`
--

INSERT INTO `helpdesk_ticketattachment` (`id`, `file`, `file_type`, `ticket_id_id`) VALUES
(1, 'attachments/fd.PNG', 'image/png', 4),
(4, 'attachments/t45646456cx.png', 'image/png', 7),
(5, 'attachments/a.png', 'image/png', 13);

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_ticketcategory`
--

CREATE TABLE `helpdesk_ticketcategory` (
  `id` bigint(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` longtext NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `helpdesk_ticketcategory`
--

INSERT INTO `helpdesk_ticketcategory` (`id`, `title`, `description`) VALUES
(1, 'Technical Support', 'Technical Support includes Software Bugs, Hardware Issues, Network Problems, Software Installation'),
(2, 'Human Resources', 'Human Resources include Payroll Inquiries, Benefits Questions, Leave Requests, Policy Clarifications'),
(3, 'Customer Support', 'Customer Support includes Billing Inquiries, Account Issues, Product Information, Complaints'),
(4, 'Maintenance and Operations', 'Maintenance and Operations include Routine Maintenance, Facility Issues, Equipment Maintenance, Supplies Replenishment');

-- --------------------------------------------------------

--
-- بنية الجدول `helpdesk_ticketremark`
--

CREATE TABLE `helpdesk_ticketremark` (
  `id` bigint(20) NOT NULL,
  `status_remarks` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `added_by_id` int(11) NOT NULL,
  `ticket_id_id` bigint(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `helpdesk_ticketremark`
--

INSERT INTO `helpdesk_ticketremark` (`id`, `status_remarks`, `created_at`, `added_by_id`, `ticket_id_id`) VALUES
(1, 'Please suggest some IT courses and job portals.', '2024-02-13 11:58:04.068417', 2, 1),
(2, 'Sapiente eu aliquam', '2024-03-31 11:04:16.750352', 2, 1),
(3, 'test', '2024-05-31 19:52:52.512039', 3, 1),
(4, 'test', '2024-05-31 19:52:58.678792', 3, 1),
(5, 'test', '2024-06-02 16:32:05.526322', 5, 1),
(6, 'test', '2024-06-02 16:32:32.933600', 5, 1),
(7, '', '2024-06-02 16:38:43.261384', 5, 1),
(8, 'did you finish solving my problem?', '2024-06-05 19:30:14.460629', 5, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  ADD KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  ADD KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  ADD KEY `auth_user_groups_group_id_97559544` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  ADD KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `helpdesk_article`
--
ALTER TABLE `helpdesk_article`
  ADD PRIMARY KEY (`id`),
  ADD KEY `helpdesk_article_user_id_id_aa74b04d` (`user_id_id`);

--
-- Indexes for table `helpdesk_contact`
--
ALTER TABLE `helpdesk_contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `helpdesk_faq`
--
ALTER TABLE `helpdesk_faq`
  ADD PRIMARY KEY (`id`),
  ADD KEY `helpdesk_faq_user_id_id_5e6026b2` (`user_id_id`);

--
-- Indexes for table `helpdesk_profile`
--
ALTER TABLE `helpdesk_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `helpdesk_ticket`
--
ALTER TABLE `helpdesk_ticket`
  ADD PRIMARY KEY (`id`),
  ADD KEY `helpdesk_ticket_assigned_user_id_fda35b47` (`assigned_user_id`),
  ADD KEY `helpdesk_ticket_user_id_id_cc723518` (`user_id_id`),
  ADD KEY `helpdesk_ticket_category_id_id_43126e04` (`category_id_id`);

--
-- Indexes for table `helpdesk_ticketattachment`
--
ALTER TABLE `helpdesk_ticketattachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `helpdesk_ticketattachment_ticket_id_id_22895084` (`ticket_id_id`);

--
-- Indexes for table `helpdesk_ticketcategory`
--
ALTER TABLE `helpdesk_ticketcategory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `helpdesk_ticketremark`
--
ALTER TABLE `helpdesk_ticketremark`
  ADD PRIMARY KEY (`id`),
  ADD KEY `helpdesk_ticketremark_added_by_id_0900e40e` (`added_by_id`),
  ADD KEY `helpdesk_ticketremark_ticket_id_id_b4ec1b20` (`ticket_id_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `helpdesk_article`
--
ALTER TABLE `helpdesk_article`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `helpdesk_contact`
--
ALTER TABLE `helpdesk_contact`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `helpdesk_faq`
--
ALTER TABLE `helpdesk_faq`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `helpdesk_profile`
--
ALTER TABLE `helpdesk_profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `helpdesk_ticket`
--
ALTER TABLE `helpdesk_ticket`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `helpdesk_ticketattachment`
--
ALTER TABLE `helpdesk_ticketattachment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `helpdesk_ticketcategory`
--
ALTER TABLE `helpdesk_ticketcategory`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `helpdesk_ticketremark`
--
ALTER TABLE `helpdesk_ticketremark`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
