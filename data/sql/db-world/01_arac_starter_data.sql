-- MySQL dump 10.13  Distrib 8.4.9, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: World
-- ------------------------------------------------------
-- Server version	8.4.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `playercreateinfo`
--

DROP TABLE IF EXISTS `playercreateinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playercreateinfo` (
  `race` tinyint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `map` smallint unsigned NOT NULL DEFAULT '0',
  `zone` int unsigned NOT NULL DEFAULT '0',
  `position_x` float NOT NULL DEFAULT '0',
  `position_y` float NOT NULL DEFAULT '0',
  `position_z` float NOT NULL DEFAULT '0',
  `orientation` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo`
--

LOCK TABLES `playercreateinfo` WRITE;
/*!40000 ALTER TABLE `playercreateinfo` DISABLE KEYS */;
INSERT INTO `playercreateinfo` VALUES (1,1,0,12,-8949.95,-132.493,83.5312,0),(1,2,0,12,-8949.95,-132.493,83.5312,0),(1,3,0,12,-8949.95,-132.493,83.5312,0),(1,4,0,12,-8949.95,-132.493,83.5312,0),(1,5,0,12,-8949.95,-132.493,83.5312,0),(1,6,609,4298,2355.84,-5664.77,426.028,3.65997),(1,8,0,12,-8949.95,-132.493,83.5312,0),(1,9,0,12,-8949.95,-132.493,83.5312,0),(2,1,1,14,-618.518,-4251.67,38.718,0),(2,3,1,14,-618.518,-4251.67,38.718,0),(2,4,1,14,-618.518,-4251.67,38.718,0),(2,6,609,4298,2358.44,-5666.9,426.023,3.65997),(2,7,1,14,-618.518,-4251.67,38.718,0),(2,8,1,14,-618.518,-4251.67,38.718,0),(2,9,1,14,-618.518,-4251.67,38.718,0),(3,1,0,1,-6240.32,331.033,382.758,6.17716),(3,2,0,1,-6240.32,331.033,382.758,6.17716),(3,3,0,1,-6240.32,331.033,382.758,6.17716),(3,4,0,1,-6240.32,331.033,382.758,6.17716),(3,5,0,1,-6240.32,331.033,382.758,6.17716),(3,6,609,4298,2358.44,-5666.9,426.023,3.65997),(3,7,0,1,-6240.32,331.033,382.758,6.17716),(3,8,0,1,-6240.32,331.033,382.758,6.17716),(3,9,0,1,-6240.32,331.033,382.758,6.17716),(4,1,1,141,10311.3,832.463,1326.41,5.69632),(4,3,1,141,10311.3,832.463,1326.41,5.69632),(4,4,1,141,10311.3,832.463,1326.41,5.69632),(4,5,1,141,10311.3,832.463,1326.41,5.69632),(4,6,609,4298,2356.21,-5662.21,426.026,3.65997),(4,8,1,141,10311.3,832.463,1326.41,5.69632),(4,9,1,141,10311.3,832.463,1326.41,5.69632),(4,11,1,141,10311.3,832.463,1326.41,5.69632),(5,1,0,85,1676.71,1678.31,121.67,2.70526),(5,2,0,85,1676.71,1678.31,121.67,2.70526),(5,3,0,85,1676.71,1678.31,121.67,2.70526),(5,4,0,85,1676.71,1678.31,121.67,2.70526),(5,5,0,85,1676.71,1678.31,121.67,2.70526),(5,6,609,4298,2356.21,-5662.21,426.026,3.65997),(5,8,0,85,1676.71,1678.31,121.67,2.70526),(5,9,0,85,1676.71,1678.31,121.67,2.70526),(6,1,1,215,-2917.58,-257.98,52.9968,0),(6,2,1,215,-2917.58,-257.98,52.9968,0),(6,3,1,215,-2917.58,-257.98,52.9968,0),(6,5,1,215,-2917.58,-257.98,52.9968,0),(6,6,609,4298,2358.17,-5663.21,426.027,3.65997),(6,7,1,215,-2917.58,-257.98,52.9968,0),(6,11,1,215,-2917.58,-257.98,52.9968,0),(7,1,0,1,-6240.32,331.033,382.758,0),(7,3,0,1,-6240.32,331.033,382.758,0),(7,4,0,1,-6240,331,383,0),(7,5,0,1,-6240.32,331.033,382.758,0),(7,6,609,4298,2355.05,-5661.7,426.026,3.65997),(7,8,0,1,-6240,331,383,0),(7,9,0,1,-6240,331,383,0),(8,1,1,14,-618.518,-4251.67,38.718,0),(8,3,1,14,-618.518,-4251.67,38.718,0),(8,4,1,14,-618.518,-4251.67,38.718,0),(8,5,1,14,-618.518,-4251.67,38.718,0),(8,6,609,4298,2355.05,-5661.7,426.026,3.65997),(8,7,1,14,-618.518,-4251.67,38.718,0),(8,8,1,14,-618.518,-4251.67,38.718,0),(8,9,1,14,-618.518,-4251.67,38.718,0),(10,1,530,3431,10349.6,-6357.29,33.4026,5.31605),(10,2,530,3431,10349.6,-6357.29,33.4026,5.31605),(10,3,530,3431,10349.6,-6357.29,33.4026,5.31605),(10,4,530,3431,10349.6,-6357.29,33.4026,5.31605),(10,5,530,3431,10349.6,-6357.29,33.4026,5.31605),(10,6,609,4298,2355.84,-5664.77,426.028,3.65997),(10,8,530,3431,10349.6,-6357.29,33.4026,5.31605),(10,9,530,3431,10349.6,-6357.29,33.4026,5.31605),(11,1,530,3526,-3961.64,-13931.2,100.615,2.08364),(11,2,530,3526,-3961.64,-13931.2,100.615,2.08364),(11,3,530,3526,-3961.64,-13931.2,100.615,2.08364),(11,5,530,3526,-3961.64,-13931.2,100.615,2.08364),(11,6,609,4298,2358.17,-5663.21,426.027,3.65997),(11,7,530,3526,-3961.64,-13931.2,100.615,2.08364),(11,8,530,3524,-3961.64,-13931.2,100.615,2.08364),(11,9,530,3524,-3961.64,-13931.2,100.615,2.08364);
/*!40000 ALTER TABLE `playercreateinfo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_action`
--

DROP TABLE IF EXISTS `playercreateinfo_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playercreateinfo_action` (
  `race` tinyint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `button` smallint unsigned NOT NULL DEFAULT '0',
  `action` int unsigned NOT NULL DEFAULT '0',
  `type` smallint unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`race`,`class`,`button`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_action`
--

LOCK TABLES `playercreateinfo_action` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_action` DISABLE KEYS */;
INSERT INTO `playercreateinfo_action` VALUES (1,1,72,6603,0),(1,1,73,78,0),(1,1,82,59752,0),(1,1,84,6603,0),(1,1,96,6603,0),(1,2,0,6603,0),(1,2,1,21084,0),(1,2,2,635,0),(1,2,9,59752,0),(1,3,0,6603,0),(1,3,1,2973,0),(1,3,2,75,0),(1,3,3,59752,0),(1,4,0,6603,0),(1,4,1,1752,0),(1,4,2,2098,0),(1,4,3,2764,0),(1,4,10,59752,0),(1,5,0,585,0),(1,5,1,2050,0),(1,5,9,59752,0),(1,6,0,6603,0),(1,6,1,49576,0),(1,6,2,45477,0),(1,6,3,45462,0),(1,6,4,45902,0),(1,6,5,47541,0),(1,6,11,59752,0),(1,8,0,133,0),(1,8,1,168,0),(1,8,9,59752,0),(1,9,0,686,0),(1,9,1,687,0),(1,9,9,59752,0),(2,1,72,6603,0),(2,1,73,78,0),(2,1,74,20572,0),(2,1,84,6603,0),(2,1,96,6603,0),(2,3,0,6603,0),(2,3,1,2973,0),(2,3,2,75,0),(2,3,3,20572,0),(2,4,0,6603,0),(2,4,1,1752,0),(2,4,2,2098,0),(2,4,3,2764,0),(2,4,4,20572,0),(2,6,0,6603,0),(2,6,1,49576,0),(2,6,2,45477,0),(2,6,3,45462,0),(2,6,4,45902,0),(2,6,5,47541,0),(2,6,10,20572,0),(2,7,0,6603,0),(2,7,1,403,0),(2,7,2,331,0),(2,7,3,33697,0),(2,8,0,133,0),(2,8,1,168,0),(2,8,2,33702,0),(2,9,0,686,0),(2,9,1,687,0),(2,9,2,33702,0),(3,1,72,6603,0),(3,1,73,78,0),(3,1,74,20594,0),(3,1,75,2481,0),(3,1,84,6603,0),(3,1,96,6603,0),(3,2,0,6603,0),(3,2,1,21084,0),(3,2,2,635,0),(3,2,3,20594,0),(3,2,4,2481,0),(3,3,0,6603,0),(3,3,1,2973,0),(3,3,2,75,0),(3,3,3,20594,0),(3,3,4,2481,0),(3,4,0,6603,0),(3,4,1,1752,0),(3,4,2,2098,0),(3,4,3,2764,0),(3,4,4,20594,0),(3,4,5,2481,0),(3,5,0,585,0),(3,5,1,2050,0),(3,5,2,20594,0),(3,5,3,2481,0),(3,6,0,6603,0),(3,6,1,49576,0),(3,6,2,45477,0),(3,6,3,45462,0),(3,6,4,45902,0),(3,6,5,47541,0),(3,6,10,2481,0),(3,7,0,6603,0),(3,7,1,403,0),(3,7,2,331,0),(3,7,3,20594,0),(3,7,4,2481,0),(3,8,0,133,0),(3,8,1,168,0),(3,8,2,20594,0),(3,9,0,686,0),(3,9,1,687,0),(3,9,2,20594,0),(4,1,72,6603,0),(4,1,73,78,0),(4,1,74,58984,0),(4,1,84,6603,0),(4,1,96,6603,0),(4,3,0,6603,0),(4,3,1,2973,0),(4,3,2,75,0),(4,3,3,58984,0),(4,4,0,6603,0),(4,4,1,1752,0),(4,4,2,2098,0),(4,4,3,2764,0),(4,4,4,58984,0),(4,5,0,585,0),(4,5,1,2050,0),(4,5,2,58984,0),(4,6,0,6603,0),(4,6,1,49576,0),(4,6,2,45477,0),(4,6,3,45462,0),(4,6,4,45902,0),(4,6,5,47541,0),(4,6,10,58984,0),(4,8,0,133,0),(4,8,1,168,0),(4,8,2,58984,0),(4,9,0,686,0),(4,9,1,687,0),(4,9,2,58984,0),(4,11,0,5176,0),(4,11,1,5185,0),(4,11,2,58984,0),(4,11,72,6603,0),(4,11,74,58984,0),(4,11,96,6603,0),(5,1,72,6603,0),(5,1,73,78,0),(5,1,74,20577,0),(5,1,84,6603,0),(5,1,96,6603,0),(5,2,0,6603,0),(5,2,1,21084,0),(5,2,2,635,0),(5,2,3,20577,0),(5,3,0,6603,0),(5,3,1,2973,0),(5,3,2,75,0),(5,3,3,20577,0),(5,4,0,6603,0),(5,4,1,1752,0),(5,4,2,2098,0),(5,4,3,2764,0),(5,4,4,20577,0),(5,5,0,585,0),(5,5,1,2050,0),(5,5,2,20577,0),(5,6,0,6603,0),(5,6,1,49576,0),(5,6,2,45477,0),(5,6,3,45462,0),(5,6,4,45902,0),(5,6,5,47541,0),(5,6,10,20577,0),(5,8,0,133,0),(5,8,1,168,0),(5,8,2,20577,0),(5,9,0,686,0),(5,9,1,687,0),(5,9,2,20577,0),(6,1,72,6603,0),(6,1,73,78,0),(6,1,74,20549,0),(6,1,84,6603,0),(6,1,96,6603,0),(6,2,0,6603,0),(6,2,1,21084,0),(6,2,2,635,0),(6,2,3,20549,0),(6,3,0,6603,0),(6,3,1,2973,0),(6,3,2,75,0),(6,3,3,20549,0),(6,5,0,585,0),(6,5,1,2050,0),(6,5,2,20549,0),(6,6,0,6603,0),(6,6,1,49576,0),(6,6,2,45477,0),(6,6,3,45462,0),(6,6,4,45902,0),(6,6,5,47541,0),(6,6,10,20549,0),(6,7,0,6603,0),(6,7,1,403,0),(6,7,2,331,0),(6,7,3,20549,0),(6,11,0,5176,0),(6,11,1,5185,0),(6,11,2,20549,0),(6,11,72,6603,0),(6,11,75,20549,0),(6,11,96,6603,0),(7,1,72,6603,0),(7,1,73,78,0),(7,1,84,6603,0),(7,1,96,6603,0),(7,3,0,6603,0),(7,3,1,2973,0),(7,3,2,75,0),(7,4,0,6603,0),(7,4,1,1752,0),(7,4,2,2098,0),(7,4,3,2764,0),(7,5,0,585,0),(7,5,1,2050,0),(7,6,0,6603,0),(7,6,1,49576,0),(7,6,2,45477,0),(7,6,3,45462,0),(7,6,4,45902,0),(7,6,5,47541,0),(7,6,10,20589,0),(7,8,0,133,0),(7,8,1,168,0),(7,9,0,686,0),(7,9,1,687,0),(8,1,72,6603,0),(8,1,73,78,0),(8,1,74,2764,0),(8,1,75,26297,0),(8,1,84,6603,0),(8,1,96,6603,0),(8,3,0,6603,0),(8,3,1,2973,0),(8,3,2,75,0),(8,3,3,26297,0),(8,4,0,6603,0),(8,4,1,1752,0),(8,4,2,2098,0),(8,4,3,2764,0),(8,4,4,26297,0),(8,5,0,585,0),(8,5,1,2050,0),(8,5,2,26297,0),(8,6,0,6603,0),(8,6,1,49576,0),(8,6,2,45477,0),(8,6,3,45462,0),(8,6,4,45902,0),(8,6,5,47541,0),(8,6,10,26297,0),(8,7,0,6603,0),(8,7,1,403,0),(8,7,2,331,0),(8,7,3,26297,0),(8,8,0,133,0),(8,8,1,168,0),(8,8,2,26297,0),(8,9,0,686,0),(8,9,1,687,0),(8,9,2,26297,0),(10,1,72,6603,0),(10,1,73,78,0),(10,1,74,69179,0),(10,1,84,6603,0),(10,1,96,6603,0),(10,2,0,6603,0),(10,2,1,21084,0),(10,2,2,635,0),(10,2,3,28730,0),(10,3,0,6603,0),(10,3,1,2973,0),(10,3,2,75,0),(10,3,3,28730,0),(10,4,0,6603,0),(10,4,1,1752,0),(10,4,2,2098,0),(10,4,3,2764,0),(10,4,4,25046,0),(10,5,0,585,0),(10,5,1,2050,0),(10,5,2,28730,0),(10,6,0,6603,0),(10,6,1,49576,0),(10,6,2,45477,0),(10,6,3,45462,0),(10,6,4,45902,0),(10,6,5,47541,0),(10,6,6,50613,0),(10,8,0,133,0),(10,8,1,168,0),(10,8,2,28730,0),(10,9,0,686,0),(10,9,1,687,0),(10,9,2,28730,0),(11,1,72,6603,0),(11,1,73,78,0),(11,1,74,28880,0),(11,1,84,6603,0),(11,1,96,6603,0),(11,2,0,6603,0),(11,2,1,21084,0),(11,2,2,635,0),(11,2,3,59542,0),(11,3,0,6603,0),(11,3,1,2973,0),(11,3,2,75,0),(11,3,3,59543,0),(11,5,0,585,0),(11,5,1,2050,0),(11,5,2,59544,0),(11,6,0,6603,0),(11,6,1,49576,0),(11,6,2,45477,0),(11,6,3,45462,0),(11,6,4,45902,0),(11,6,5,47541,0),(11,6,10,59545,0),(11,7,0,6603,0),(11,7,1,403,0),(11,7,2,331,0),(11,7,3,59547,0),(11,8,0,133,0),(11,8,1,168,0),(11,8,2,28880,0),(11,9,0,686,0),(11,9,1,687,0),(11,9,2,28880,0);
/*!40000 ALTER TABLE `playercreateinfo_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_item`
--

DROP TABLE IF EXISTS `playercreateinfo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playercreateinfo_item` (
  `race` tinyint unsigned NOT NULL DEFAULT '0',
  `class` tinyint unsigned NOT NULL DEFAULT '0',
  `itemid` int unsigned NOT NULL DEFAULT '0',
  `amount` int NOT NULL DEFAULT '1',
  `Note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`race`,`class`,`itemid`),
  KEY `playercreateinfo_race_class_index` (`race`,`class`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_item`
--

LOCK TABLES `playercreateinfo_item` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_item` DISABLE KEYS */;
INSERT INTO `playercreateinfo_item` VALUES (0,1,23389,4,'TuWoW starter bags - Warrior'),(0,2,23389,4,'TuWoW starter bags - Paladin'),(0,3,23389,3,'TuWoW starter bags - Hunter plus ammo pouch'),(0,4,23389,4,'TuWoW starter bags - Rogue'),(0,5,23389,4,'TuWoW starter bags - Priest'),(0,6,23389,4,'TuWoW starter bags - Death Knight'),(0,6,40582,-1,'[TDB PH] - unsused Scourgestone'),(0,7,23389,4,'TuWoW starter bags - Shaman'),(0,8,23389,4,'TuWoW starter bags - Mage'),(0,9,23389,4,'TuWoW starter bags - Warlock'),(0,11,23389,4,'TuWoW starter bags - Druid');
/*!40000 ALTER TABLE `playercreateinfo_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playercreateinfo_skills`
--

DROP TABLE IF EXISTS `playercreateinfo_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playercreateinfo_skills` (
  `raceMask` int unsigned NOT NULL,
  `classMask` int unsigned NOT NULL,
  `skill` smallint unsigned NOT NULL,
  `rank` smallint unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`raceMask`,`classMask`,`skill`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playercreateinfo_skills`
--

LOCK TABLES `playercreateinfo_skills` WRITE;
/*!40000 ALTER TABLE `playercreateinfo_skills` DISABLE KEYS */;
INSERT INTO `playercreateinfo_skills` VALUES (0,0,95,0,'Defense'),(0,0,162,0,'Unarmed'),(0,0,183,0,'GENERIC (DND)'),(0,0,415,0,'Cloth'),(0,0,777,0,'Mounts'),(0,0,778,0,'Companion Pets'),(0,1,26,0,'Warrior - Arms'),(0,1,256,0,'Warrior - Fury'),(0,1,257,0,'Warrior - Protection'),(0,2,184,0,'Paladin - Retribution'),(0,2,267,0,'Paladin - Protection'),(0,2,594,0,'Paladin - Holy'),(0,4,50,0,'Hunter - Beast Mastery'),(0,4,51,0,'Hunter - Survival'),(0,4,163,0,'Hunter - Marksmanship'),(0,8,38,0,'Rogue - Combat'),(0,8,39,0,'Rogue - Subtlety'),(0,8,253,0,'Rogue - Assassination'),(0,9,176,0,'Thrown'),(0,16,56,0,'Priest - Holy'),(0,16,78,0,'Priest - Shadow'),(0,16,613,0,'Priest - Discipline'),(0,32,129,4,'Death Knight - First Aid'),(0,32,229,0,'Polearms'),(0,32,293,0,'Plate'),(0,32,762,0,'Death Knight - Riding'),(0,32,770,0,'Death Knight - Blood'),(0,32,771,0,'Death Knight - Frost'),(0,32,772,0,'Death Knight - Unholy'),(0,35,55,0,'Two-Handed Swords'),(0,35,413,0,'Mail'),(0,37,44,0,'Axes'),(0,37,172,0,'Two-Handed Axes'),(0,39,43,0,'Swords'),(0,40,118,0,'Dual Wield'),(0,64,373,0,'Shaman - Enhancement'),(0,64,374,0,'Shaman - Restoration'),(0,64,375,0,'Shaman - Elemental'),(0,67,433,0,'Shield'),(0,128,6,0,'Mage - Frost'),(0,128,8,0,'Mage - Fire'),(0,128,237,0,'Mage - Arcane'),(0,256,354,0,'Warlock - Demonology'),(0,256,355,0,'Warlock - Affliction'),(0,256,593,0,'Warlock - Destruction'),(0,400,228,0,'Wands'),(0,1024,134,0,'Druid - Feral'),(0,1024,573,0,'Druid - Restoration'),(0,1024,574,0,'Druid - Balance'),(0,1107,54,0,'Maces'),(0,1135,414,0,'Leather'),(0,1488,136,0,'Staves'),(1,0,754,0,'Human - Racial'),(1,4,45,0,'Custom Human Hunter restricted weapon skill'),(1,4,46,0,'TuWoW Human Hunter - Guns for mod-arac starter outfit'),(1,4,173,0,'Custom Human Hunter restricted weapon skill'),(2,0,125,0,'Orc - Racial'),(4,0,101,0,'Dwarf - Racial'),(4,0,111,0,'Language: Dwarven'),(8,0,113,0,'Language: Darnassian'),(8,0,126,0,'Night Elf - Racial'),(16,0,220,0,'Undead - Racial'),(16,0,673,0,'Language: Forsaken'),(16,2,160,0,'TuWoW Undead Paladin - Two-Handed Maces for mod-arac starter outfit'),(16,4,45,0,'Custom Undead Hunter restricted weapon skill'),(16,4,46,0,'TuWoW Undead Hunter - Guns for mod-arac starter outfit'),(16,4,173,0,'Custom Undead Hunter restricted weapon skill'),(32,0,115,0,'Language: Taurahe'),(32,0,124,0,'Tauren - Racial'),(36,4,46,0,'Guns'),(64,0,313,0,'Language: Gnomish'),(64,0,753,0,'Gnome - Racial'),(64,4,46,0,'Custom Gnome Hunter restricted weapon skill'),(64,4,173,0,'Custom Gnome Hunter restricted weapon skill'),(128,0,315,0,'Language: Troll'),(128,0,733,0,'Troll - Racial'),(512,0,137,0,'Language: Thalassian'),(512,0,756,0,'Blood Elf - Racial'),(650,4,45,0,'Bows'),(690,0,109,0,'Language: Orcish'),(735,1293,173,0,'Daggers'),(1024,0,759,0,'Language: Draenei'),(1024,0,760,0,'Draenei - Racial'),(1024,4,226,0,'Crossbows'),(1061,3,160,0,'Two-Handed Maces'),(1101,0,98,0,'Language: Common');
/*!40000 ALTER TABLE `playercreateinfo_skills` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-22  5:20:03
