-- MySQL dump 10.13  Distrib 5.5.37, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: getuzer
-- ------------------------------------------------------
-- Server version	5.5.37-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contents`
--

DROP TABLE IF EXISTS `contents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_active` int(11) DEFAULT '1',
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title_tag` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` blob,
  `action_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `root_path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_descriptions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `deleted` int(11) DEFAULT '0',
  `layout` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `breadcrumb` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `share_image` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `action_path` (`action_path`,`root_path`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(32) NOT NULL AUTO_INCREMENT,
  `name` varchar(256) CHARACTER SET latin1 DEFAULT NULL,
  `code` varchar(2) CHARACTER SET latin1 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `code` (`code`),
  KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_field_entries`
--

DROP TABLE IF EXISTS `form_field_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_field_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_field_id` bigint(20) NOT NULL,
  `model_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `entry_data` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `from_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `votes` int(11) NOT NULL DEFAULT '0',
  `is_active` int(11) NOT NULL DEFAULT '1',
  `leads` int(11) NOT NULL DEFAULT '0',
  `img_data` mediumblob,
  PRIMARY KEY (`id`),
  KEY `form_field_id` (`form_field_id`,`model_name`,`model_id`,`campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_fields`
--

DROP TABLE IF EXISTS `form_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_id` int(11) DEFAULT NULL,
  `campaign_id` int(11) DEFAULT NULL,
  `field_type` varchar(25) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_name` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_order` int(11) NOT NULL,
  `required_field` int(11) NOT NULL,
  `show_on_details_page` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_analytics`
--

DROP TABLE IF EXISTS `mobile_analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_analytics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `mobile_campaign_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_name` varchar(50) NOT NULL,
  `day_wise_metric` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  `web_impressions` varchar(1024) DEFAULT NULL,
  `month` int(2) DEFAULT NULL,
  `year` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `my_index` (`model_id`,`model_name`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_app_uuid_maps`
--

DROP TABLE IF EXISTS `mobile_app_uuid_maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_app_uuid_maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile_app_id` int(11) DEFAULT NULL,
  `mobile_uuid_id` int(11) DEFAULT NULL,
  `last_seen_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_apps`
--

DROP TABLE IF EXISTS `mobile_apps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_apps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) DEFAULT '1',
  `key` varchar(255) DEFAULT NULL,
  `platform` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_campaign_filters`
--

DROP TABLE IF EXISTS `mobile_campaign_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_campaign_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filter` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `qual_input` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_campaigns`
--

DROP TABLE IF EXISTS `mobile_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `model_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_id` int(11) DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` int(11) DEFAULT '1',
  `impressions` int(11) DEFAULT '0',
  `leads` int(11) DEFAULT '0',
  `clicks` int(11) DEFAULT '0',
  `campaign_data_updated_at` datetime DEFAULT NULL,
  `mobile_app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_coupons`
--

DROP TABLE IF EXISTS `mobile_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `description` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) DEFAULT '1',
  `user_percentage` int(11) DEFAULT '100',
  `activity` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_button_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `second_button_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `header_message` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `app_version_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internet_connection_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT 'all',
  `mobile_campaign_id` int(11) NOT NULL,
  `main_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `good_until_hour` varchar(10) COLLATE utf8_unicode_ci DEFAULT '11:00 PM',
  `good_until_timezone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `good_until_date` date DEFAULT NULL,
  `coupon_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version_support_condition` varchar(2) COLLATE utf8_unicode_ci DEFAULT '>',
  `app_launch_condition` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '>=',
  `app_launches_counter` int(11) NOT NULL DEFAULT '0',
  `filters` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_feedbacks`
--

DROP TABLE IF EXISTS `mobile_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `description` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) DEFAULT '1',
  `user_percentage` int(11) DEFAULT '100',
  `activity` varchar(512) COLLATE utf8_unicode_ci DEFAULT '',
  `first_button_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `second_button_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `header_message` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `app_version_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT '',
  `internet_connection_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT 'all',
  `mobile_campaign_id` int(11) NOT NULL,
  `main_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version_support_condition` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '=',
  `app_launch_condition` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '>=',
  `app_launches_counter` int(11) NOT NULL DEFAULT '0',
  `filters` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_notifications`
--

DROP TABLE IF EXISTS `mobile_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `mobile_campaign_id` int(11) DEFAULT NULL,
  `header_message` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Popup',
  `main_message` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `first_button_text` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'OK',
  `first_button_link` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `second_button_text` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'Not Now',
  `app_version_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `internet_connection_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT 'all',
  `user_percentage` int(11) DEFAULT '100',
  `activity` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version_support_condition` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '=',
  `app_launches_counter` int(11) NOT NULL DEFAULT '0',
  `app_launch_condition` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '>=',
  `filters` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`mobile_campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_push_notifications`
--

DROP TABLE IF EXISTS `mobile_push_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_push_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `description` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) DEFAULT '1',
  `user_percentage` int(11) DEFAULT '100',
  `activity` varchar(512) COLLATE utf8_unicode_ci DEFAULT '',
  `first_button_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `second_button_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `header_message` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `app_version_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT '',
  `internet_connection_type` varchar(64) COLLATE utf8_unicode_ci DEFAULT 'all',
  `mobile_campaign_id` int(11) NOT NULL,
  `main_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version_support_condition` varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '=',
  `app_launch_condition` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '>=',
  `app_launches_counter` int(11) NOT NULL DEFAULT '0',
  `scheduling` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `time` time DEFAULT NULL,
  `filters` varchar(2048) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mobile_uuids`
--

DROP TABLE IF EXISTS `mobile_uuids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mobile_uuids` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `uuid` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `operating_system` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `height` float DEFAULT NULL,
  `width` float DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `manufacturer` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `gcm_reg_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `payment_plans`
--

DROP TABLE IF EXISTS `payment_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `max_pages` int(11) DEFAULT NULL,
  `prices` float DEFAULT NULL,
  `white_label` int(11) NOT NULL DEFAULT '0',
  `name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_public` int(11) NOT NULL DEFAULT '0',
  `vertical` int(11) DEFAULT '0',
  `duration` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_order` int(11) NOT NULL DEFAULT '0',
  `profile_limit` int(11) NOT NULL,
  `user_limit` int(11) NOT NULL,
  `mention_limit` int(11) NOT NULL,
  `monitoring_allowed` int(11) NOT NULL DEFAULT '1',
  `apps_allowed` int(11) NOT NULL DEFAULT '1',
  `fan_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_analytics`
--

DROP TABLE IF EXISTS `twitter_analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_analytics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `twitter_campaign_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `impression` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  `day_wise_metric` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `my_index` (`model_id`,`model_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_campaign_entries`
--

DROP TABLE IF EXISTS `twitter_campaign_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_campaign_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `model_name` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `model_id` int(11) NOT NULL,
  `campaign_id` int(11) NOT NULL,
  `user_twitter_account_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `campaign_id` (`campaign_id`,`user_twitter_account_id`),
  KEY `form_field_id` (`model_name`,`model_id`,`campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_campaigns`
--

DROP TABLE IF EXISTS `twitter_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `model_id` int(11) DEFAULT NULL,
  `model_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_title` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` int(11) DEFAULT '1',
  `visitors` int(11) DEFAULT '0',
  `leads` int(11) DEFAULT '0',
  `current_twitter_follower` int(11) DEFAULT '0',
  `follower_gain_during_campaign` int(11) DEFAULT '0',
  `handle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `campaign_data_updated_at` datetime DEFAULT NULL,
  `tweet_count` int(11) DEFAULT NULL,
  `retweet_count` int(11) DEFAULT NULL,
  `impressions` int(11) NOT NULL DEFAULT '0',
  `last_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_offers`
--

DROP TABLE IF EXISTS `twitter_offers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_offers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `css` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_link` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `asset_id` int(11) DEFAULT NULL,
  `twitter_campaign_id` int(11) NOT NULL,
  `tweet_text` varchar(256) COLLATE utf8_unicode_ci DEFAULT 'Coupon for 25% off our 9/1 show at Lincoln Center http://bit.ly/1nMi4GS If 20 people retweet by 8pmET Friday, the deal is on!',
  `good_until_hour` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '11:00 PM',
  `good_until_timezone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `good_until_date` date NOT NULL,
  `coupon_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle` varchar(100) COLLATE utf8_unicode_ci DEFAULT '@superbowl',
  `handle_image` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_count` int(11) DEFAULT '0',
  `handle_name` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `require_sign_in` int(11) DEFAULT '1',
  `track_hashtag_and_retweets` int(11) DEFAULT '0',
  `hashtag_to_track` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle_to_track` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `international_params` blob,
  `short_url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`twitter_campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `twitter_virals`
--

DROP TABLE IF EXISTS `twitter_virals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `twitter_virals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `css` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_link` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `fb_user_id` int(11) DEFAULT NULL,
  `asset_id` int(11) DEFAULT NULL,
  `twitter_campaign_id` int(11) NOT NULL,
  `tweet_text` varchar(256) COLLATE utf8_unicode_ci DEFAULT 'Coupon for 25% off our 9/1 show at Lincoln Center http://bit.ly/1nMi4GS If 20 people retweet by 8pmET Friday, the deal is on!',
  `tipping_point` int(11) NOT NULL DEFAULT '20',
  `tipping_point_hour` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '11:00 PM',
  `tipping_point_timezone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tipping_point_date` date NOT NULL,
  `how_to_redeem` int(11) DEFAULT NULL,
  `coupon_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `affiliate_link` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `handle` varchar(100) COLLATE utf8_unicode_ci DEFAULT '@superbowl',
  `handle_image` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `count_till_tipping` int(11) DEFAULT '0',
  `total_count` int(11) DEFAULT '0',
  `handle_name` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `international_params` blob,
  `short_url` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`twitter_campaign_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_accounts`
--

DROP TABLE IF EXISTS `user_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imap_server` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `imap_port` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_audit_trails`
--

DROP TABLE IF EXISTS `user_audit_trails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_audit_trails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `last_login` datetime NOT NULL,
  `last_logout` datetime DEFAULT NULL,
  `ipaddress` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_billings`
--

DROP TABLE IF EXISTS `user_billings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_billings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `payment_plan_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `first_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `last_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `email` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `credit_card_number` varchar(17) COLLATE utf8_unicode_ci DEFAULT NULL,
  `verification_code` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `credit_card_month` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `credit_card_year` varchar(11) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `zip` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `promo_code` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `plan_duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_user_billings_on_user_id` (`user_id`),
  KEY `index_user_billings_on_payment_plan_id` (`payment_plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_monthly_views`
--

DROP TABLE IF EXISTS `user_monthly_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_monthly_views` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `website_id` int(11) DEFAULT NULL,
  `month` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `year` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `views` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_payments`
--

DROP TABLE IF EXISTS `user_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_payments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `payment_plan_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `source` varchar(50) DEFAULT NULL,
  `ppl_payment_flag` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id_2` (`user_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=405777 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_preferences` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `error_message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `source` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `code_sharing_mails` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` int(2) NOT NULL DEFAULT '1',
  `bounce_email` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_analytics`
--

DROP TABLE IF EXISTS `web_analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_analytics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `web_campaign_id` int(11) NOT NULL,
  `model_id` int(11) NOT NULL,
  `model_name` varchar(50) NOT NULL,
  `day_wise_metric` varchar(2048) DEFAULT NULL,
  `month` int(2) DEFAULT NULL,
  `year` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `my_index` (`model_id`,`model_name`)
) ENGINE=MyISAM AUTO_INCREMENT=106 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_campaign_filters`
--

DROP TABLE IF EXISTS `web_campaign_filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_campaign_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(24) COLLATE utf8_unicode_ci NOT NULL,
  `filter` varchar(124) COLLATE utf8_unicode_ci NOT NULL,
  `is_active` int(11) NOT NULL,
  `qual_input` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_campaigns`
--

DROP TABLE IF EXISTS `web_campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_campaigns` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `model_id` int(11) DEFAULT NULL,
  `model_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website_id` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `is_active` int(11) DEFAULT '1',
  `views` int(11) DEFAULT '0',
  `leads` int(11) DEFAULT '0',
  `clicks` int(11) NOT NULL DEFAULT '0',
  `campaign_data_updated_at` datetime DEFAULT NULL,
  `impressions` int(11) NOT NULL DEFAULT '0',
  `last_updated_at` datetime DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_coupons`
--

DROP TABLE IF EXISTS `web_coupons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_coupons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `css` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_link` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `asset_id` int(11) DEFAULT NULL,
  `web_campaign_id` int(11) NOT NULL,
  `good_until_hour` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '11:00 PM',
  `good_until_timezone` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `good_until_date` date DEFAULT NULL,
  `coupon_code` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `total_count` int(11) DEFAULT '0',
  `require_share` int(11) DEFAULT '1',
  `international_params` blob,
  `share_fb` int(11) DEFAULT '1',
  `share_twitter` int(11) DEFAULT '1',
  `share_linkedin` int(11) DEFAULT '1',
  `share_gplus` int(11) DEFAULT '1',
  `tab_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT 'Coupon',
  `text_color` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'ffffff',
  `background_color` varchar(10) COLLATE utf8_unicode_ci DEFAULT '3f6eba',
  `border_color` varchar(10) COLLATE utf8_unicode_ci DEFAULT '3f6eba',
  `show_credits` int(11) DEFAULT '1',
  `tab_text_drop_shadow` int(11) DEFAULT '0',
  `tab_alignment` int(11) DEFAULT '1',
  `open_on_click_of_element` int(11) DEFAULT '1',
  `open_on_click_of_element_name` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `coupon_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Flat 10% Off',
  `coupon_description` varchar(2048) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Share by clicking  on any of the "Share" button below and an exclusive coupon code will appear on your screen.',
  `redirect_url` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_name` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_address` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `title_background_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '3f6eba',
  `title_text_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fff',
  `coupon_border_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '3f6eba',
  `coupon_background_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'e5e6fc',
  `coupon_text_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '000',
  `filters` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`web_campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_feedbacks`
--

DROP TABLE IF EXISTS `web_feedbacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_feedbacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `css` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_link` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `asset_id` int(11) DEFAULT NULL,
  `web_campaign_id` int(11) NOT NULL,
  `tab_text` varchar(128) COLLATE utf8_unicode_ci DEFAULT 'Feedback',
  `text_color` varchar(10) COLLATE utf8_unicode_ci DEFAULT 'ebebeb',
  `background_color` varchar(10) COLLATE utf8_unicode_ci DEFAULT '3f6eba',
  `border_color` varchar(10) COLLATE utf8_unicode_ci DEFAULT '000',
  `show_credits` int(11) DEFAULT '1',
  `tab_text_drop_shadow` int(11) DEFAULT '0',
  `tab_alignment` int(11) DEFAULT '0',
  `open_on_click_of_element` int(11) DEFAULT '0',
  `open_on_click_of_element_name` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `thank_you_message` varchar(512) COLLATE utf8_unicode_ci DEFAULT 'Your feedback has been successfully sent',
  `routing` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `get_name` int(11) NOT NULL DEFAULT '1',
  `get_mobile` int(11) NOT NULL DEFAULT '1',
  `get_category` int(11) NOT NULL DEFAULT '1',
  `get_message` int(11) NOT NULL DEFAULT '1',
  `get_rating` int(11) NOT NULL DEFAULT '1',
  `get_screenshot` int(11) NOT NULL DEFAULT '1',
  `form_title` varchar(256) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Please give your valuable feedback ',
  `title_background_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '3f6eba',
  `title_text_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ebebeb',
  `form_border_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '000',
  `form_background_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'dadafa',
  `form_text_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '000',
  `action_background_color` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT '3f6eba',
  `action_text_color` varchar(16) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'ebebeb',
  `send_to_email` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `screenshot` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `filters` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`web_campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `web_notifications`
--

DROP TABLE IF EXISTS `web_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `web_notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `is_active` int(11) DEFAULT NULL,
  `css` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_link` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  `asset_id` int(11) DEFAULT NULL,
  `web_campaign_id` int(11) NOT NULL,
  `message` varchar(1024) COLLATE utf8_unicode_ci DEFAULT 'Enter your notification text here.',
  `call_to_action_text` varchar(256) COLLATE utf8_unicode_ci DEFAULT 'Click!',
  `call_to_action_url` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `call_to_action_new_window` int(11) DEFAULT NULL,
  `allow_close_notification` int(11) DEFAULT '1',
  `allow_minimize_notification` int(11) DEFAULT '1',
  `fixed_position` int(11) DEFAULT '0',
  `push_down_html` int(11) DEFAULT '1',
  `content_alignment` int(11) DEFAULT '0',
  `background_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'eb593c',
  `text_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fff',
  `border_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fff',
  `action_background_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '000',
  `action_text_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'fff',
  `action_border_color` varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '000',
  `opacity` float NOT NULL DEFAULT '1',
  `filters` varchar(2048) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaign_id` (`web_campaign_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `websites`
--

DROP TABLE IF EXISTS `websites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `websites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci DEFAULT '',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `is_active` int(11) DEFAULT '1',
  `key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `domain` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `white_label_accounts`
--

DROP TABLE IF EXISTS `white_label_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `white_label_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `fb_api_key` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fb_secret` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_access_token` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter_access_token_secret` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin_api_key` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin_secret_key` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instagram_key` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instagram_secret` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-05-23  5:14:57
INSERT INTO schema_migrations (version) VALUES ('1');

INSERT INTO schema_migrations (version) VALUES ('20101015040925');

INSERT INTO schema_migrations (version) VALUES ('20140503083139');

INSERT INTO schema_migrations (version) VALUES ('20140503101941');

INSERT INTO schema_migrations (version) VALUES ('20140503113152');

INSERT INTO schema_migrations (version) VALUES ('20140503113742');

INSERT INTO schema_migrations (version) VALUES ('20140514093707');

INSERT INTO schema_migrations (version) VALUES ('20140514093800');

INSERT INTO schema_migrations (version) VALUES ('20140514093919');

INSERT INTO schema_migrations (version) VALUES ('20140514094435');

INSERT INTO schema_migrations (version) VALUES ('20140514095412');

INSERT INTO schema_migrations (version) VALUES ('20140516122424');

INSERT INTO schema_migrations (version) VALUES ('20140519104427');

INSERT INTO schema_migrations (version) VALUES ('20140519105213');

INSERT INTO schema_migrations (version) VALUES ('20140519105428');

INSERT INTO schema_migrations (version) VALUES ('20140519110959');

INSERT INTO schema_migrations (version) VALUES ('20140521055133');

INSERT INTO schema_migrations (version) VALUES ('20140521070015');

INSERT INTO schema_migrations (version) VALUES ('20140521082002');

INSERT INTO schema_migrations (version) VALUES ('20140521085556');

