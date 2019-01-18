/*
Navicat MySQL Data Transfer

Source Server         : MySQL-Local
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : FineWork

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2019-01-18 10:18:37
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for Department
-- ----------------------------
DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of Department
-- ----------------------------
INSERT INTO `Department` VALUES ('1', '项目部');
INSERT INTO `Department` VALUES ('2', '工程部');
INSERT INTO `Department` VALUES ('3', 'IT部');
INSERT INTO `Department` VALUES ('4', '办公室');

-- ----------------------------
-- Table structure for Permission
-- ----------------------------
DROP TABLE IF EXISTS `Permission`;
CREATE TABLE `Permission` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) DEFAULT NULL,
  `Value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Permission
-- ----------------------------
INSERT INTO `Permission` VALUES ('1', '新建项目', 'Project-Create');
INSERT INTO `Permission` VALUES ('2', '项目计划管理', 'Project-Plan');
INSERT INTO `Permission` VALUES ('3', '部门管理', 'System-Department');
INSERT INTO `Permission` VALUES ('4', '人员管理', 'System-User');
INSERT INTO `Permission` VALUES ('5', '项目阶段计划修改授权', 'Project-Plan-Edit-Authorize');
INSERT INTO `Permission` VALUES ('6', '工作汇报回复', 'Work-Replay');
INSERT INTO `Permission` VALUES ('7', '工作汇报', 'Work-Report');
INSERT INTO `Permission` VALUES ('8', '日志查看', 'View-Report');
INSERT INTO `Permission` VALUES ('9', '日志删除', 'Delete-WorkLog');
INSERT INTO `Permission` VALUES ('10', '项目删除', 'Delete-Project');

-- ----------------------------
-- Table structure for Phase
-- ----------------------------
DROP TABLE IF EXISTS `Phase`;
CREATE TABLE `Phase` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Progress` decimal(10,0) DEFAULT NULL,
  `ProjectId` int(11) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` int(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ProjectId` (`ProjectId`),
  KEY `CreatedBy` (`CreatedBy`),
  CONSTRAINT `phase_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `phase_ibfk_1` FOREIGN KEY (`ProjectId`) REFERENCES `Project` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Phase
-- ----------------------------

-- ----------------------------
-- Table structure for Project
-- ----------------------------
DROP TABLE IF EXISTS `Project`;
CREATE TABLE `Project` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `Progress` varchar(255) DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `CreatedBy` (`CreatedBy`),
  CONSTRAINT `Project_ibfk_1` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Project
-- ----------------------------

-- ----------------------------
-- Table structure for Task
-- ----------------------------
DROP TABLE IF EXISTS `Task`;
CREATE TABLE `Task` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Progress` decimal(10,0) DEFAULT '0',
  `PhaseId` int(11) DEFAULT NULL,
  `ParentTaskId` int(11) DEFAULT NULL,
  `PlanStartDate` datetime DEFAULT NULL,
  `PlanEndDate` datetime DEFAULT NULL,
  `ActualStartDate` datetime DEFAULT NULL,
  `ActualEndDate` datetime DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `PhaseId` (`PhaseId`),
  KEY `ParentTaskId` (`ParentTaskId`),
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`ParentTaskId`) REFERENCES `Task` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`PhaseId`) REFERENCES `Phase` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Task
-- ----------------------------

-- ----------------------------
-- Table structure for User
-- ----------------------------
DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `RealName` varchar(255) DEFAULT NULL,
  `Mobile` varchar(255) DEFAULT NULL,
  `DepartmentId` int(11) DEFAULT NULL,
  `Permissions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `User_ibfk_1` (`DepartmentId`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`DepartmentId`) REFERENCES `Department` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of User
-- ----------------------------
INSERT INTO `User` VALUES ('1', 'admin', '123456', 'Admin', '15554266653', '3', '1,2,3');

-- ----------------------------
-- Table structure for WorkLog
-- ----------------------------
DROP TABLE IF EXISTS `WorkLog`;
CREATE TABLE `WorkLog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) DEFAULT NULL,
  `TaskId` int(11) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` int(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `TaskId` (`TaskId`),
  KEY `CreatedBy` (`CreatedBy`),
  CONSTRAINT `worklog_ibfk_1` FOREIGN KEY (`TaskId`) REFERENCES `Task` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `worklog_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `User` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of WorkLog
-- ----------------------------
