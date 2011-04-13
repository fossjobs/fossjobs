-- phpMyAdmin SQL Dump
-- version 2.11.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 20, 2008 at 02:39 AM
-- Server version: 5.0.41
-- PHP Version: 5.2.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `jobberbase`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(16) NOT NULL,
  `password` varchar(32) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `var_name` varchar(32) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `keywords` text NOT NULL,
  `category_order` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `category_order` (`category_order`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='programming/design/admin/etc.' AUTO_INCREMENT=15 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `var_name`, `category_order`) VALUES
(1, 'Programmers', 'programmers', 7),
(2, 'Designers', 'designers', 3),
(3, 'Administrators', 'administrators', 0),
(7, 'Marketers', 'marketers', 2),
(5, 'Testers', 'testers', 5),
(6, 'Editors', 'editors', 1),
(8, 'Managers', 'managers', 4),
(9, 'Consultants', 'consultants', 6);

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `ascii_name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=73 ;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `ascii_name`) VALUES
(1, 'London', 'London'),
(2, 'Buenos Aires', 'Buenos-Aires'),
(3, 'New York', 'New-York'),
(4, 'Tokyo', 'Tokyo'),
(5, 'Cairo', 'Cairo');

-- --------------------------------------------------------

--
-- Table structure for table `hits`
--

CREATE TABLE IF NOT EXISTS `hits` (
  `job_id` int(10) unsigned NOT NULL,
  `created_on` datetime NOT NULL,
  `ip` varchar(15) NOT NULL,
  KEY `job_id` (`job_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `hits`
--

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `type_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(100) default '',
  `description` text,
  `company` varchar(150) default '',
  `city_id` int(11),
  `url` varchar(150) default NULL,
  `apply` varchar(200) default '',
  `created_on` timestamp NOT NULL default '0000-00-00 00:00:00',
  `is_temp` tinyint(4) NOT NULL,
  `is_active` tinyint(4) NOT NULL,
  `views_count` int(11) NOT NULL,
  `auth` varchar(32) NOT NULL,
  `outside_location` varchar(150) NOT NULL,
  `poster_email` varchar(100) NOT NULL,
  `apply_online` tinyint(4) NOT NULL,
  `spotlight` tinyint(4) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `type_id` (`type_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `type_id`, `category_id`, `title`, `description`, `company`, `city_id`, `url`, `apply`, `created_on`, `is_temp`, `is_active`, `views_count`, `auth`, `outside_location`, `poster_email`, `apply_online`, `spotlight`) VALUES
(1, 1, 1, 'web developer', 'We\\''re a startup searching for a cool web developer that masters following technologies:\r\n* php, mysql\r\n* javascript, dom, ajax\r\n* html, css\r\n\r\nPerson should also have a good sense of user behavior.\r\n\r\nExcellent payment! ;)', 'Foo Inc.', NULL, 'http://www.fooinc.com', '', '2008-08-20 02:35:29', 0, 1, 10, 'f1acd80152446f4cf8a0bb8242398be7', 'sss', 'jobs@fooinc.com', 1, 1),
(2, 3, 2, 'Illustrator/Photoshop expert', 'Could you redraw in Illustrator da Vinci\\''s Gioconda, blindfolded?\r\nLet us know! :)', 'UnrealExpectations', NULL, 'http://unrealexpectations.com', '', '2008-08-20 02:35:37', 0, 1, 6, '6ebcfde637d98a9738c024c6074e945d', '', 'jobs@unrealexpectations.com', 1, 0),
(4, 1, 1, 'web developer 3', 'We\\''re a startup searching for a cool web developer that masters following technologies:\r\n* php, mysql\r\n* javascript, dom, ajax\r\n* html, css\r\n\r\nPerson should also have a good sense of user behavior.\r\n\r\nExcellent payment! ;)', 'Foo Inc.', NULL, 'http://www.fooinc.com', '', '2008-08-20 02:35:45', 0, 1, 8, 'f1acd80152446f4cf8a0bb8242398be7', 'London, UK', 'jobs@fooinc.com', 1, 1),
(5, 1, 1, 'web developer 2', 'We\\''re a startup searching for a cool web developer that masters following technologies:\r\n* php, mysql\r\n* javascript, dom, ajax\r\n* html, css\r\n\r\nPerson should also have a good sense of user behavior.\r\n\r\nExcellent payment! ;)', 'Foo Inc.', NULL, 'http://www.fooinc.com', '', '2008-08-20 02:35:52', 0, 1, 6, 'f1acd80152446f4cf8a0bb8242398be7', 'London, UK', 'jobs@fooinc.com', 1, 0),
(11, 1, 3, 'nice developer needed', 'asdfsd', 'temp name', 1, 'http://google.com', '', '2008-08-20 02:35:57', 0, 1, 2, '2e3f1e857af3a4e191f453d747fbf212', '', 'jobs@fooinc.com', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE IF NOT EXISTS `job_applications` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `job_id` int(10) unsigned NOT NULL,
  `created_on` datetime NOT NULL,
  `ip` varchar(15) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `job_applications`
--

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(11) NOT NULL auto_increment,
  `url` varchar(255) NOT NULL,
  `page_title` varchar(255) NOT NULL,
  `keywords` text NOT NULL,
  `description` text NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `has_form` enum('0','1') NOT NULL,
  `form_message` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `url`, `page_title`, `keywords`, `description`, `title`, `content`, `has_form`, `form_message`) VALUES
(1, 'about', 'About Us', '', '', 'About Us', '<h4>Hello!</h4>\r\n<p>This job board is an open source implementation of <a href="http://www.jobber.ro/">www.jobber.ro</a>.</p>\r\n<p>Don''t hesitate to&nbsp;contact us!</p>', '0', ''),
(2, 'contact', 'Contact Us', '', '', 'We really appreciate feedback!', '<p>E-mail us at <strong>hello [at] domain [dot] com</strong> or use the form below:</p>', '1', '<p>Thank you for your message! :)</p>');

-- --------------------------------------------------------

--
-- Table structure for table `searches`
--

CREATE TABLE IF NOT EXISTS `searches` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `keywords` varchar(100) NOT NULL,
  `created_on` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `searches`
--


-- --------------------------------------------------------

--
-- Table structure for table `spam_reports`
--

CREATE TABLE IF NOT EXISTS `spam_reports` (
  `id` int(11) NOT NULL auto_increment,
  `the_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `ip` varchar(15) NOT NULL,
  `job_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `spam_reports`
--


-- --------------------------------------------------------

--
-- Table structure for table `types`
--

CREATE TABLE IF NOT EXISTS `types` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(16) NOT NULL,
  `var_name` varchar(32) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='full-time/freelance' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `types`
--

INSERT INTO `types` (`id`, `name`, `var_name`) VALUES
(1, 'Full-time', 'fulltime'),
(2, 'Part-time', 'parttime'),
(3, 'Freelance', 'freelance');

--
-- Table structure for table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(64) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  `data_type` varchar(255) DEFAULT NULL,
  `input_type` varchar(255) DEFAULT NULL,
  `input_options` text,
  `validation` text,
  `value` longtext,
  `ordering` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=39 ;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `category_id`, `name`, `title`, `description`, `data_type`, `input_type`, `input_options`, `validation`, `value`, `ordering`) VALUES
(1, 1, 'site_name', 'Site name', 'The name of your JobBoard, used in various templates.', NULL, NULL, NULL, 'not_empty', 'Jobberbase', 1),
(2, 1, 'admin_email', 'Admin Email', 'The email companies will receive mail from.', NULL, NULL, NULL, 'not_empty|is_email', 'admin@localhost.cc', 2),
(3, 1, 'notify_email', 'Notify Email', 'The email for receiving new job postings.', NULL, NULL, NULL, 'not_empty|is_email', 'admin@localhost.cc', 3),
(4, 1, 'theme', 'Theme', 'Pick the theme to use for the frontend.', NULL, 'available_themes', NULL, 'not_empty', 'default', 4),
(5, 1, 'html_title', 'HTML Title', 'The HTML title for the homepage.', NULL, NULL, NULL, NULL, NULL, 5),
(6, 1, 'meta_keywords', 'Site keywords', 'Meta Keywords. Useful for Search Engine Optimization (separate by comma).', NULL, NULL, NULL, NULL, NULL, 6),
(7, 1, 'meta_description', 'Site description', 'Meta Description Tag. Useful for Search Engine Optimization.', NULL, 'text_area', NULL, NULL, NULL, 7),
(8, 1, 'max_cv_size', 'Max CV filesize', 'The maximum filesize for uploaded CV''s in bytes (Update accordingly in translations.ini)', NULL, NULL, NULL, 'not_empty|is_number', '3145728', 8),
(9, 1, 'file_upload_dir', 'Upload Directory', 'Upload directory to temporarily save CV''s. Must be writable.', NULL, NULL, NULL, 'not_empty', 'uploads/', 9),
(10, 1, 'apply_delay', 'Apply delay', 'The number of minutes that must pass between applications from the same IP address', NULL, NULL, NULL, 'not_empty|is_number', '0', 10),
(11, 1, 'old_job_notify', 'Old Job Notify', 'No. of days after which a job should be reported as old. Use 0 to disable this functionality.', 'integer', NULL, NULL, 'not_empty', '40', 11),
(12, 1, 'date_format', 'Date format', 'The format in which dates are displayed. %d = day, %m = month, %Y = 4 digit year. Follow <a href="http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html#function_date-format" target="_blank">this link</a> for more formatting options.', NULL, NULL, NULL, 'not_empty', '%d-%m-%Y', 12),
(13, 1, 'date_time_format', 'Date / Time format', 'The format in which times are displayed. %d = day, %m = month, %Y = 4 digit year, %H = 24-hour and %i = minute. Follow <a href="http://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html#function_date-format" target="_blank">this link</a> for more formatting options.', NULL, NULL, NULL, 'not_empty', '%d-%m-%Y %H:%i', 13),
(14, 1, 'sidebar_show_what', 'Sidebar - show', 'Either cities or categories can be shown in the sidebar', NULL, 'select', 'categories|cities', 'not_empty|is_alpha', 'categories', 14),
(15, 1, 'sidebar_only_cities_with_at_least_number_of_jobs', 'Sidebar - only cities with at least X jobs', 'If the sidebar is configured to show cities, then only show cities that have at least the specified number of jobs available.', 'integer', NULL, NULL, 'non_empty', '1', 15),
(16, 1, 'enable_new_jobs', 'Enable Job Posting', 'By turning this off, the only way to add jobs is through the admin-panel.', 'boolean', 'radiobutton', 'no|yes', NULL, '1', 16),
(17, 2, 'jobs_per_page', 'Jobs per page', 'The amount of jobs per page, before pagination is called.', 'integer', NULL, NULL, 'not_empty', '50', 1),
(18, 2, 'jobs_per_search', 'Jobs per search', 'The amount of jobs per page when searching.', 'integer', NULL, NULL, 'not_empty', '25', 2),
(19, 2, 'spotlight_jobs', 'Spotlight Jobs #', 'Amount of Spotlight Jobs to display on the front page.', 'integer', NULL, NULL, 'not_empty', '3', 3),
(20, 2, 'latest_jobs', 'Latest Jobs #', 'Amount of latest jobs to show on the front page.', 'integer', NULL, NULL, 'not_empty', '7', 4),
(21, 2, 'most_applied_jobs', 'Most Applied to #', 'Amount of most-applied-to jobs to show on the front page.', 'integer', NULL, NULL, 'not_empty', '7', 5),
(22, 2, 'search_method', 'Search Method', 'Choose which search method to use. ''Alternate'' checks every keyword to appear in either the title, description or cityname.', NULL, 'radiobutton', 'classic|alternate', NULL, 'classic', 6),
(23, 3, 'url_cities', 'Cities Cloud', 'The URL for the City Cloud page.', NULL, NULL, NULL, 'not_empty|is_url_string', 'cities', 1),
(24, 3, 'url_companies', 'Companies Cloud', 'The URL for the Company Cloud page.', NULL, NULL, NULL, 'not_empty|is_url_string', 'companies', 2),
(25, 3, 'url_job', 'Job Details', 'The URL for the Job Details page.', NULL, NULL, NULL, 'not_empty|is_url_string', 'job', 3),
(26, 3, 'url_jobs', 'Jobs per Category', 'The URL for the Jobs per Category pages.', NULL, NULL, NULL, 'not_empty|is_url_string', 'jobs', 4),
(27, 3, 'url_jobs_at_company', 'Jobs per Company', 'The URL for the Jobs per Company pages.', NULL, NULL, NULL, 'not_empty|is_url_string', 'jobs-at', 5),
(28, 3, 'url_jobs_in_city', 'Jobs per City', 'The URL for the Jobs per City pages.', NULL, NULL, NULL, 'not_empty|is_url_string', 'jobs-in', 6),
(29, 4, 'enable_recaptcha', 'Enable ReCaptcha', 'Before enabling ReCaptcha, make sure to add your private and public key.', 'boolean', 'radiobutton', 'no|yes', NULL, '0', 1),
(30, 4, 'captcha_public_key', 'Captcha Public Key', 'You can register these keys for free at recaptcha.net.', NULL, NULL, NULL, NULL, 'PUBLIC_KEY', 2),
(31, 4, 'captcha_private_key', 'Captcha Private Key', 'You can register these keys for free at recaptcha.net.', NULL, NULL, NULL, NULL, 'PRIVATE_KEY', 3),
(32, 5, 'mailer_mailer', 'Mailer', 'Send mails with PHP''s mail() function or through SMTP', NULL, 'select', 'mail|smtp', 'not_empty', 'mail', 1),
(33, 5, 'mailer_encoding', 'Mail encoding', 'The mail''s encoding (default is utf-8, change only if it is not working correctly)', NULL, NULL, NULL, 'not_empty', 'utf-8', 2),
(34, 5, 'mailer_smtp_host', 'SMTP host name', 'Host name (for example, smtp.example.com)', NULL, NULL, NULL, NULL, NULL, 3),
(35, 5, 'mailer_smtp_port', 'SMTP port', 'Port (default is 25, change only if you know what you are doing)', 'integer', NULL, NULL, 'not_empty', '25', 4),
(36, 5, 'mailer_smtp_requires_authentication', 'SMTP authentication', 'Is authentication required for SMTP?', 'boolean', 'radiobutton', 'no|yes', NULL, '0', 5),
(37, 5, 'mailer_smtp_secure_connection_prefix', 'SMTP secure connection prefix', 'SMTP secure connection prefix. Leave empty if not specified for your host.', NULL, 'select', '|ssl|tls', NULL, '', 6),
(38, 5, 'mailer_smtp_username', 'SMTP user name', 'User name (for example, user@example.com)', NULL, NULL, NULL, NULL, NULL, 7),
(39, 5, 'mailer_smtp_password', 'SMTP password', 'Password', NULL, NULL, NULL, NULL, NULL, 8),
(40, 4, 'report_post_after', 'Report Post Delay', 'No of Minutes after which a user is allowed to report same post after the previous report.', NULL, NULL, NULL, 'not_empty|is_number', '10', 7),
(41, 4, 'post_notify_on', 'When to send Mail?', 'Send mail only after this number of reports on a post.', 'integer', NULL, NULL, 'not_empty', '2', 8),
(42, 4, 'captcha_enable_on_post_page', 'Enable ReCaptcha on post page', 'Enable spam protection on the post a job page.', 'boolean', 'radiobutton', 'no|yes', NULL, '0', 4),
(43, 4, 'captcha_enable_on_apply_page', 'Enable ReCaptcha on apply page', 'Enable spam protection on the apply to a job page.', 'boolean', 'radiobutton', 'no|yes', NULL, '1', 5),
(44, 4, 'captcha_enable_on_contact_page', 'Enable ReCaptcha on contact page', 'Enable spam protection on the contact page.', 'boolean', 'radiobutton', 'no|yes', NULL, '0', 6),
(45, 1, 'enable_new_post_moderation', 'Enable Job Moderation', 'If enabled, the administrator must always activate the very first job posted by a hiring person/company. From there on, every job posted with the same email address will be automatically activated.', 'boolean', 'radiobutton', 'no|yes', NULL, '1', 17);

--
-- Table structure for table `settings_categories`
--

CREATE TABLE IF NOT EXISTS `settings_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `var_name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `settings_categories`
--

INSERT INTO `settings_categories` (`id`, `name`, `var_name`, `description`) VALUES
(1, 'Main Settings', 'main', 'The main settings for your JobberBase installation. This includes settings such as site name, meta-tags etc.'),
(2, 'Search / Pagination Settings', 'search-and-pagination', 'Settings that change the amount of jobs to display per page and which search method to use.'),
(3, 'URL Rewrite Settings', 'url-rewrite', 'You can easily change the structure of various URLs with these settings.'),
(4, 'Spam Settings', 'anti-spam', 'JobberBase has built-in Spam prevention features which help you to combat spam job posts.'),
(5, 'Mailer Settings', 'mail', 'You can setup the route through which emails are sent (SMTP, for example).');

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `menu` varchar(255) NOT NULL,
  `link_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Dumping data for table `links`
--

INSERT INTO `links` (`id`, `url`, `name`, `title`, `menu`, `link_order`) VALUES
(1, 'widgets', 'Site widget', 'Would you like to display our latest jobs on your site?', 'primary', 1),
(2, 'about', 'About Us', 'More information about us.', 'primary', 2),
(3, 'contact', 'Contact', 'Don''t hesitate to contact us!', 'primary', 3),
(4, 'post', 'Post a new job', 'Post a new job for free!', 'footer1', 4),
(5, 'widgets', 'Site widget', 'Would you like to display our latest jobs on your site?', 'footer1', 5),
(6, 'rss', 'RSS Feeds', 'An overview of all our available RSS Feeds.', 'footer1', 6),
(7, 'about', 'About Us', 'More information about us.', 'footer2', 7),
(8, 'contact', 'Contact', 'Don''t hesitate to contact us!', 'footer2', 8),
(9, 'companies', 'Companies', 'An overview of all available companies.', 'footer3', 9),
(10, 'cities', 'Cities', 'An overview of all available cities.', 'footer3', 10),
(11, 'sitemap', 'Sitemap', 'Sitemap.', 'footer3', 11);