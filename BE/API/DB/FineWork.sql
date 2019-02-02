/*
Navicat MySQL Data Transfer

Source Server         : MySQL-Local
Source Server Version : 50636
Source Host           : localhost:3306
Source Database       : finework

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2019-02-01 16:42:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '项目部');
INSERT INTO `department` VALUES ('2', '工程部');
INSERT INTO `department` VALUES ('3', 'IT部');
INSERT INTO `department` VALUES ('4', '办公室');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) DEFAULT NULL,
  `Value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES ('1', '新建项目', 'Project-Create');
INSERT INTO `permission` VALUES ('2', '项目计划管理', 'Project-Plan');
INSERT INTO `permission` VALUES ('3', '部门管理', 'System-Department');
INSERT INTO `permission` VALUES ('4', '人员管理', 'System-User');
INSERT INTO `permission` VALUES ('5', '项目阶段计划修改授权', 'Project-Plan-Edit-Authorize');
INSERT INTO `permission` VALUES ('6', '工作汇报回复', 'Work-Replay');
INSERT INTO `permission` VALUES ('7', '工作汇报', 'Work-Report');
INSERT INTO `permission` VALUES ('8', '日志查看', 'View-Report');
INSERT INTO `permission` VALUES ('9', '日志删除', 'Delete-WorkLog');
INSERT INTO `permission` VALUES ('10', '项目删除', 'Delete-Project');

-- ----------------------------
-- Table structure for phase
-- ----------------------------
DROP TABLE IF EXISTS `phase`;
CREATE TABLE `phase` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Progress` decimal(3,2) DEFAULT NULL,
  `ProjectId` int(11) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` int(255) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ProjectId` (`ProjectId`),
  KEY `CreatedBy` (`CreatedBy`),
  CONSTRAINT `phase_ibfk_1` FOREIGN KEY (`ProjectId`) REFERENCES `project` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `phase_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `user` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of phase
-- ----------------------------
INSERT INTO `phase` VALUES ('25', '前端开发', 'UI设计、Vue实现', '0.74', '1', '2019-01-01 00:00:00', '2019-02-15 00:00:00', '2019-01-22 12:37:16', '1', '施工中');
INSERT INTO `phase` VALUES ('26', '后端开发', 'REST API开发', '0.11', '1', '2019-01-28 00:00:00', '2019-02-22 00:00:00', '2019-01-22 12:38:32', '1', '施工中');
INSERT INTO `phase` VALUES ('27', '系统测试', null, '0.00', '1', '2019-02-19 00:00:00', '2019-02-26 00:00:00', '2019-01-22 12:39:21', '1', '未开工');
INSERT INTO `phase` VALUES ('28', '上线发布', null, '0.00', '1', '2019-02-24 00:00:00', '2019-03-03 00:00:00', '2019-01-22 12:39:56', '1', '未开工');
INSERT INTO `phase` VALUES ('32', '需求调研', null, '0.00', '14', '2019-02-01 16:00:00', '2019-07-08 16:00:00', '2019-01-23 12:14:29', '1', '未开工');
INSERT INTO `phase` VALUES ('33', '开发阶段', null, '0.00', '14', '2019-04-01 00:00:00', '2020-01-23 00:00:00', '2019-01-23 12:24:46', '1', '未开工');
INSERT INTO `phase` VALUES ('35', '测试阶段', 'UAT测试', '0.00', '14', '2020-01-01 08:00:00', '2020-02-29 08:00:00', '2019-01-23 14:52:12', '1', '未开工');
INSERT INTO `phase` VALUES ('36', '交付阶段', null, '0.00', '14', '2019-07-27 08:00:00', '2019-08-18 08:00:00', '2019-01-23 14:56:30', '1', '未开工');
INSERT INTO `phase` VALUES ('38', '验收阶段', '客户验收', '0.00', '14', '2020-10-01 08:00:00', '2020-10-31 08:00:00', '2019-01-23 16:42:43', '1', '未开工');
INSERT INTO `phase` VALUES ('39', '验收阶段', null, '0.00', '10', '2019-01-10 08:00:00', '2019-01-19 08:00:00', '2019-01-24 12:35:41', '1', '未开始');
INSERT INTO `phase` VALUES ('40', '需求调研阶段', null, '0.00', '15', '2019-02-03 00:00:00', '2019-02-16 00:00:00', '2019-01-24 12:44:38', '1', '未开始');
INSERT INTO `phase` VALUES ('41', 'UI设计阶段', null, '0.00', '15', '2019-02-13 00:00:00', '2019-03-02 00:00:00', '2019-01-24 12:44:56', '1', '未开始');
INSERT INTO `phase` VALUES ('42', '前端开发阶段', null, '0.00', '15', '2019-02-26 00:00:00', '2019-03-19 00:00:00', '2019-01-24 12:56:01', '1', '未开始');
INSERT INTO `phase` VALUES ('43', '后端开发阶段', null, '0.00', '15', '2019-03-11 00:00:00', '2019-04-01 00:00:00', '2019-01-24 12:57:46', '1', '未开始');
INSERT INTO `phase` VALUES ('44', '验收阶段', null, '0.00', '12', '2019-01-24 08:00:00', '2019-01-31 08:00:00', '2019-01-24 16:44:24', '1', '未开始');
INSERT INTO `phase` VALUES ('49', '基础工程', '111', '0.00', '17', '2019-02-02 08:00:00', '2019-02-06 08:00:00', '2019-01-24 17:02:43', '1', '未开始');
INSERT INTO `phase` VALUES ('50', '主体工程', null, '0.00', '17', '2019-02-04 06:00:00', '2019-02-21 06:00:00', '2019-01-24 17:02:43', '1', '未开始');
INSERT INTO `phase` VALUES ('51', '屋面工程', null, '0.00', '17', '2019-02-14 23:00:00', '2019-02-24 23:00:00', '2019-01-24 17:02:43', '1', '未开始');
INSERT INTO `phase` VALUES ('52', '装饰装修工程', null, '0.00', '17', '2019-02-21 13:00:00', '2019-02-28 13:00:00', '2019-01-24 17:02:43', '1', '未开始');
INSERT INTO `phase` VALUES ('53', '基础工程', null, '0.00', '5', '2019-01-13 08:00:00', '2019-01-24 08:00:00', '2019-01-24 17:07:57', '1', '未开始');
INSERT INTO `phase` VALUES ('54', '建筑阶段', null, '0.00', '5', '2019-02-05 08:00:00', '2019-02-06 08:00:00', '2019-01-24 17:08:18', '1', '未开始');
INSERT INTO `phase` VALUES ('56', '1111', null, '0.00', '5', '2019-01-14 00:00:00', '2019-01-22 00:00:00', '2019-01-24 17:20:58', '1', '未开始');
INSERT INTO `phase` VALUES ('57', '222', null, '0.00', '5', '2019-01-13 08:00:00', '2019-01-13 08:00:00', '2019-01-24 17:21:40', '1', '未开始');
INSERT INTO `phase` VALUES ('58', '基础工程', '内容', '0.00', '18', '2019-02-08 00:00:00', '2019-08-24 00:00:00', '2019-01-24 21:03:57', '1', '未开始');
INSERT INTO `phase` VALUES ('59', '主体工程', null, '0.00', '18', '2019-07-31 08:00:00', '2020-02-14 08:00:00', '2019-01-24 21:03:57', '1', '未开始');
INSERT INTO `phase` VALUES ('60', '屋面工程', null, '0.00', '18', '2019-11-22 18:00:00', '2020-08-22 18:00:00', '2019-01-24 21:03:57', '1', '未开始');
INSERT INTO `phase` VALUES ('61', '装饰装修工程', null, '0.00', '18', '2020-02-29 07:00:00', '2020-12-15 07:00:00', '2019-01-24 21:03:57', '1', '未开始');
INSERT INTO `phase` VALUES ('63', '需求调研', null, '0.00', '13', '2019-01-21 08:00:00', '2019-01-26 08:00:00', '2019-01-24 22:52:21', '1', '已完成');
INSERT INTO `phase` VALUES ('64', '设计阶段', null, '0.00', '13', '2019-01-25 08:00:00', '2019-01-31 08:00:00', '2019-01-24 22:52:34', '1', '未开始');
INSERT INTO `phase` VALUES ('66', 'h1', null, '0.00', '13', '2019-01-21 08:00:00', '2019-01-22 08:00:00', '2019-01-24 23:34:55', '1', '未开始');
INSERT INTO `phase` VALUES ('67', '测试阶段', null, '0.00', '15', '2019-04-01 00:00:00', '2019-04-22 00:00:00', '2019-01-25 19:34:13', '1', '未开始');
INSERT INTO `phase` VALUES ('71', '阶段1', null, '0.00', '11', '2019-02-13 03:00:00', '2019-03-01 03:00:00', '2019-01-27 17:01:24', '1', '未开始');
INSERT INTO `phase` VALUES ('72', '阶段2', null, '0.00', '11', '2019-03-04 01:00:00', '2019-03-23 01:00:00', '2019-01-27 17:01:33', '1', '未开始');
INSERT INTO `phase` VALUES ('73', '阶段3', null, '0.00', '11', '2019-03-29 14:00:00', '2019-04-10 14:00:00', '2019-01-27 17:02:00', '1', '未开始');
INSERT INTO `phase` VALUES ('74', '阶段4', null, '0.00', '11', '2019-04-11 12:00:00', '2019-04-25 12:00:00', '2019-01-27 17:02:11', '1', '未开始');
INSERT INTO `phase` VALUES ('75', '阶段5', null, '0.00', '11', '2019-04-27 05:00:00', '2019-06-07 05:00:00', '2019-01-27 17:02:39', '1', '未开始');
INSERT INTO `phase` VALUES ('76', '阶段6', null, '0.00', '11', '2019-05-27 12:00:00', '2019-06-19 12:00:00', '2019-01-27 17:04:07', '1', '未开始');
INSERT INTO `phase` VALUES ('77', '阶段2', null, '0.00', '12', '2019-01-01 08:00:00', '2019-01-30 08:00:00', '2019-01-27 20:15:21', '1', '未开始');
INSERT INTO `phase` VALUES ('78', '111', null, '0.00', '12', '2019-01-01 08:00:00', '2019-01-01 08:00:00', '2019-01-27 20:15:41', '1', '未开始');
INSERT INTO `phase` VALUES ('101', '阶段1', null, '0.00', '9', '2019-02-02 00:00:00', '2019-07-01 00:00:00', '2019-01-27 22:21:57', '1', '未开工');
INSERT INTO `phase` VALUES ('102', '验收阶段', null, '0.00', '15', '2019-04-19 00:00:00', '2019-04-28 00:00:00', '2019-01-29 11:12:52', '1', '未开始');
INSERT INTO `phase` VALUES ('103', '阶段2', null, '0.00', '9', '2019-06-30 00:00:00', '2019-09-29 00:00:00', '2019-02-01 13:37:26', '1', '未开工');
INSERT INTO `phase` VALUES ('104', '阶段3', null, '0.00', '9', '2019-09-01 00:00:00', '2019-12-02 00:00:00', '2019-02-01 13:38:00', '1', '未开工');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Type` varchar(50) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `No` varchar(50) DEFAULT NULL,
  `Acreage` decimal(10,2) DEFAULT NULL,
  `Cost` decimal(10,2) DEFAULT NULL,
  `ContractNo` varchar(50) DEFAULT NULL,
  `WarrantNo` varchar(50) DEFAULT NULL,
  `ArchiveNo` varchar(50) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL,
  `FirstParty` varchar(100) DEFAULT NULL,
  `StartDate` datetime DEFAULT NULL,
  `EndDate` datetime DEFAULT NULL,
  `Progress` decimal(3,2) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `CreatedBy` (`CreatedBy`),
  CONSTRAINT `Project_ibfk_1` FOREIGN KEY (`CreatedBy`) REFERENCES `user` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('1', '工程进度管理软件开发', '新建', '项目计划、甘特图、进度汇报', '2019001', '20.00', '7.00', '12412443432', null, '', '青岛', '中阳集团', '2019-01-01 08:00:00', '2019-03-15 08:00:00', '0.10', '在建中', '2019-01-18 11:08:04', '1');
INSERT INTO `project` VALUES ('2', '市南拆迁项目', '新建', '市南土地征收信息系统', null, '0.00', '0.00', null, null, null, null, null, '2019-03-01 08:00:00', '2019-05-31 08:00:00', '0.00', '已验收', '2019-01-18 14:12:19', '1');
INSERT INTO `project` VALUES ('4', '铜陵拆迁项目', '新建', '安徽铜陵土地征收系统', null, '0.00', '25.00', null, null, null, null, null, '2019-03-01 08:00:00', '2019-05-31 08:00:00', '0.00', '已验收', '2019-01-18 15:15:22', '1');
INSERT INTO `project` VALUES ('5', '万科金色广场二期项目', '新建', '金色广场二期扩建项目', '2009011901', '20000.00', '5000.00', '000001', '000002', '00003', '重庆南路', '万科集团', '2019-01-13 08:00:00', '2019-09-30 08:00:00', '0.00', '已竣工', '2019-01-19 15:20:00', '1');
INSERT INTO `project` VALUES ('9', '龙湖都市家园', '新建', '龙湖地产项目', '00001', '2000.00', '30000.00', '000001', '0000003', '0000003', '黑龙江路', '龙湖地产', '2019-02-02 00:00:00', '2019-12-31 00:00:00', '0.00', '筹备中', '2019-01-20 11:44:25', '1');
INSERT INTO `project` VALUES ('10', '凯德MALL装修工程', '改建', '发布上线', '00001', '2000.00', '3000.00', null, null, null, null, null, '2019-01-10 08:00:00', '2019-05-01 08:00:00', '0.00', '已停工', '2019-01-20 17:34:56', '1');
INSERT INTO `project` VALUES ('11', '碧桂园海星岛', '新建', '碧桂园海南项目', null, '0.00', '0.00', null, null, null, null, null, '2019-01-21 08:00:00', '2019-06-30 08:00:00', '0.00', '已验收', '2019-01-21 22:00:10', '1');
INSERT INTO `project` VALUES ('12', '保利城中城', null, '保利地产的一个项目', null, '0.00', '0.00', null, null, null, null, null, '2019-01-01 08:00:00', '2019-01-31 08:00:00', '0.00', '已竣工', '2019-01-21 22:00:43', '1');
INSERT INTO `project` VALUES ('13', '海洋所数字图形化项目', '新建', '海洋所项目', null, '0.00', '26.00', null, null, null, null, '中科院海洋研究所', '2019-01-21 08:00:00', '2019-01-31 08:00:00', '0.00', '在建中', '2019-01-21 22:41:50', '1');
INSERT INTO `project` VALUES ('14', 'AI论文分析系统', '新建', '利用人工智能分析论文公式', '20190002', '0.00', '67.00', '00001', '00002', '00003', null, null, '2019-05-01 08:00:00', '2020-12-31 08:00:00', '0.00', '筹备中', '2019-01-23 12:14:29', '1');
INSERT INTO `project` VALUES ('15', 'WeChat-CRM系统', '新建', '基于微信生态的CRM集成', null, '0.00', '35.00', null, null, null, null, null, '2019-02-01 08:00:00', '2019-04-30 08:00:00', '0.00', '在建中', '2019-01-24 12:42:29', '1');
INSERT INTO `project` VALUES ('17', '一个项目', '新建', '项目介绍', null, '0.00', '0.00', null, null, null, null, null, '2019-02-01 08:00:00', '2019-03-31 08:00:00', '0.00', '筹备中', '2019-01-24 17:02:43', '1');
INSERT INTO `project` VALUES ('18', '五四广场扩建工程', '改建', '五四广场扩建', null, '0.00', '0.00', '1', '2', '3', '市南区', '青岛市政府', '2019-02-01 08:00:00', '2020-12-31 08:00:00', '0.00', '已验收', '2019-01-24 21:03:57', '1');

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) DEFAULT NULL,
  `Progress` decimal(3,2) DEFAULT '0.00',
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
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`PhaseId`) REFERENCES `phase` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`ParentTaskId`) REFERENCES `task` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('1', '了解需求', null, '0.00', '32', null, '2019-02-01 08:00:00', '2019-02-08 08:00:00', null, null, '未开工', '1', '2019-01-24 00:05:56');
INSERT INTO `task` VALUES ('2', '估算报价', null, '0.00', '32', null, '2019-02-06 08:00:00', '2019-02-09 08:00:00', null, null, '未开工', '1', '2019-01-24 00:06:13');
INSERT INTO `task` VALUES ('3', '需求建议书', null, '0.00', '32', null, '2019-02-11 00:00:00', '2019-02-16 00:00:00', null, null, '未开工', '1', '2019-01-24 00:06:27');
INSERT INTO `task` VALUES ('4', '编写合同', null, '0.00', '32', null, '2019-02-18 08:00:00', '2019-02-22 08:00:00', null, null, '未开工', '1', '2019-01-24 00:06:51');
INSERT INTO `task` VALUES ('5', '收集需求', null, '0.00', '40', null, '2019-02-05 00:00:00', '2019-02-11 00:00:00', null, null, '未开始', '1', '2019-01-24 15:01:24');
INSERT INTO `task` VALUES ('8', '22222', null, '0.00', '40', null, '2019-02-08 00:00:00', '2019-02-12 00:00:00', null, null, '未开始', '1', '2019-01-24 15:01:51');
INSERT INTO `task` VALUES ('11', '3333', null, '0.00', '40', null, '2019-02-11 00:00:00', '2019-02-18 00:00:00', null, null, '未开始', '1', '2019-01-24 16:15:45');
INSERT INTO `task` VALUES ('12', '11', '12', '0.00', '49', null, '2019-02-04 00:00:00', '2019-02-05 00:00:00', null, null, '未开始', '1', '2019-01-24 17:03:21');
INSERT INTO `task` VALUES ('13', '111111', '111', '0.00', '53', null, '2019-01-13 08:00:00', '2019-01-22 08:00:00', null, null, '已完成', '1', '2019-01-24 18:06:49');
INSERT INTO `task` VALUES ('14', '12', '23', '0.00', '53', null, '2019-01-13 08:00:00', '2019-01-14 08:00:00', null, null, '未开始', '1', '2019-01-24 18:12:19');
INSERT INTO `task` VALUES ('15', '11111', null, '0.00', '51', null, '2019-02-11 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-24 20:19:08');
INSERT INTO `task` VALUES ('16', '1112', '22', '0.00', '51', '15', '2019-02-11 08:00:00', '2019-02-12 08:00:00', null, null, '进行中', '1', '2019-01-24 20:21:15');
INSERT INTO `task` VALUES ('17', '12', null, '0.00', '49', '12', '2019-02-04 00:00:00', '2019-02-05 00:00:00', null, null, '未开始', '1', '2019-01-24 20:26:22');
INSERT INTO `task` VALUES ('18', '土木工程', '内容', '0.00', '58', null, '2019-02-14 08:00:00', '2019-02-23 08:00:00', null, null, '未开始', '1', '2019-01-24 21:13:55');
INSERT INTO `task` VALUES ('19', '基建工程', null, '0.00', '58', null, '2019-03-06 08:00:00', '2019-03-22 08:00:00', null, null, '未开始', '1', '2019-01-24 21:14:19');
INSERT INTO `task` VALUES ('21', 'g1', null, '0.00', null, null, '2019-01-01 08:00:00', '2019-01-02 08:00:00', null, null, '未开始', '1', '2019-01-25 13:03:16');
INSERT INTO `task` VALUES ('22', 'g2', null, '0.00', null, null, '2019-01-07 08:00:00', '2019-01-11 08:00:00', null, null, '未开始', '1', '2019-01-25 13:38:31');
INSERT INTO `task` VALUES ('23', 'g22', null, '0.00', null, '22', '2019-01-08 00:00:00', '2019-01-10 00:00:00', null, null, '未开始', '1', '2019-01-25 13:38:40');
INSERT INTO `task` VALUES ('24', 'g21', null, '0.00', null, '22', '2019-01-07 08:00:00', '2019-01-08 08:00:00', null, null, '未开始', '1', '2019-01-25 13:39:05');
INSERT INTO `task` VALUES ('25', '任务1', null, '0.30', '71', null, '2019-02-13 08:00:00', '2019-02-21 08:00:00', '2019-02-11 11:18:06', null, '进行中', '1', '2019-01-27 17:09:17');
INSERT INTO `task` VALUES ('26', '任务2', null, '0.00', '71', null, '2019-02-13 00:00:00', '2019-02-21 00:00:00', '2019-01-30 11:23:02', '2019-02-08 11:23:06', '已完成', '1', '2019-01-27 17:09:27');
INSERT INTO `task` VALUES ('27', '任务3', null, '0.00', '71', null, '2019-02-13 00:00:00', '2019-02-17 00:00:00', '2019-02-15 17:33:10', '2019-02-17 17:33:16', '未开始', '1', '2019-01-27 17:09:40');
INSERT INTO `task` VALUES ('28', '任务2.1', null, '1.00', '71', '26', '2019-02-15 00:00:00', '2019-02-17 00:00:00', '2019-01-29 11:24:33', '2019-01-31 11:24:37', '已完成', '1', '2019-01-27 17:13:20');
INSERT INTO `task` VALUES ('29', '任务2.2', null, '0.00', '71', '26', '2019-02-13 00:00:00', '2019-02-14 00:00:00', null, null, '未开始', '1', '2019-01-27 17:16:03');
INSERT INTO `task` VALUES ('30', '任务2.4', null, '0.00', '71', '26', '2019-02-14 00:00:00', '2019-02-16 00:00:00', null, null, '未开始', '1', '2019-01-27 17:24:01');
INSERT INTO `task` VALUES ('31', 'TASK1', null, '0.00', '71', null, '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:38:28');
INSERT INTO `task` VALUES ('32', 'TAKS2', null, '0.00', '71', null, '2019-02-13 08:00:00', '2019-02-26 08:00:00', null, null, '未开始', '1', '2019-01-27 17:38:38');
INSERT INTO `task` VALUES ('44', '111', null, '0.00', '71', null, '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:47:18');
INSERT INTO `task` VALUES ('45', '222', null, '0.00', '71', null, '2019-02-15 00:00:00', '2019-02-16 00:00:00', null, null, '未开始', '1', '2019-01-27 17:47:21');
INSERT INTO `task` VALUES ('46', '3333', null, '0.00', '71', null, '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:47:30');
INSERT INTO `task` VALUES ('49', '111', null, '0.00', '71', null, '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:48:14');
INSERT INTO `task` VALUES ('53', '123', null, '0.00', '71', null, '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:50:57');
INSERT INTO `task` VALUES ('58', '123', null, '0.00', '71', '44', '2019-02-15 00:00:00', '2019-02-16 00:00:00', null, null, '未开始', '1', '2019-01-27 17:57:55');
INSERT INTO `task` VALUES ('59', '123', null, '0.00', '71', '49', '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:58:01');
INSERT INTO `task` VALUES ('61', '123', null, '0.00', '71', '49', '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:58:12');
INSERT INTO `task` VALUES ('70', '123', null, '0.00', '71', '49', '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 17:59:54');
INSERT INTO `task` VALUES ('71', '123', null, '0.00', '71', '49', '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 18:00:01');
INSERT INTO `task` VALUES ('73', '123', null, '0.00', '71', '44', '2019-02-15 00:00:00', '2019-02-16 00:00:00', null, null, '未开始', '1', '2019-01-27 18:01:56');
INSERT INTO `task` VALUES ('76', '221', null, '0.00', '71', '45', '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 18:15:51');
INSERT INTO `task` VALUES ('77', '222', null, '0.00', '71', null, '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-27 18:16:06');
INSERT INTO `task` VALUES ('87', '1', null, '0.00', '58', '18', '2019-02-14 08:00:00', '2019-02-15 08:00:00', null, null, '未开始', '1', '2019-01-28 19:15:05');
INSERT INTO `task` VALUES ('88', '2', null, '0.00', '58', '18', '2019-02-14 08:00:00', '2019-02-15 08:00:00', null, null, '未开始', '1', '2019-01-28 19:19:51');
INSERT INTO `task` VALUES ('89', '11', null, '0.00', '58', '87', '2019-02-14 08:00:00', '2019-02-15 08:00:00', null, null, '未开始', '1', '2019-01-28 19:19:56');
INSERT INTO `task` VALUES ('90', '22', null, '0.00', '58', '88', '2019-02-14 08:00:00', '2019-02-15 08:00:00', null, null, '未开始', '1', '2019-01-28 19:20:02');
INSERT INTO `task` VALUES ('91', '1234', null, '0.00', '71', '59', '2019-02-13 08:00:00', '2019-02-14 08:00:00', null, null, '未开始', '1', '2019-01-29 10:29:32');
INSERT INTO `task` VALUES ('92', '1234', null, '0.00', '71', '58', '2019-02-15 08:00:00', '2019-02-16 08:00:00', null, null, '未开始', '1', '2019-01-29 10:29:47');
INSERT INTO `task` VALUES ('94', 'UI设计', null, '0.60', '25', null, '2019-01-02 00:00:00', '2019-01-06 00:00:00', '2019-01-03 00:00:00', null, '施工中', '1', '2019-01-30 21:13:33');
INSERT INTO `task` VALUES ('95', 'Vue程序架构', null, '1.00', '25', null, '2019-01-07 00:00:00', '2019-01-12 08:00:00', '2019-01-05 00:00:00', '2019-01-10 00:00:00', '已完工', '1', '2019-01-30 21:14:05');
INSERT INTO `task` VALUES ('96', 'Vue集成', null, '0.83', '25', null, '2019-01-14 00:00:00', '2019-01-31 00:00:00', '2019-01-17 00:00:00', null, '施工中', '1', '2019-01-30 21:18:12');
INSERT INTO `task` VALUES ('97', '项目管理模块', null, '0.70', '25', '96', '2019-01-15 00:00:00', '2019-01-26 00:00:00', '2019-01-17 00:00:00', null, '施工中', '1', '2019-01-30 21:18:30');
INSERT INTO `task` VALUES ('98', '计划管理模块', null, '1.00', '25', '96', '2019-01-18 00:00:00', '2019-01-31 00:00:00', '2019-01-19 00:00:00', '2019-01-26 00:00:00', '已完工', '1', '2019-01-30 21:18:41');
INSERT INTO `task` VALUES ('99', '进度管理模块', null, '0.75', '25', '96', '2019-01-21 00:00:00', '2019-01-31 00:00:00', '2019-01-24 00:00:00', null, '施工中', '1', '2019-01-30 21:18:49');
INSERT INTO `task` VALUES ('100', '部门管理模板', null, '0.60', '25', null, '2019-01-11 00:00:00', '2019-01-18 08:00:00', '2019-01-13 00:00:00', null, '施工中', '1', '2019-01-30 22:22:45');
INSERT INTO `task` VALUES ('101', '个人设置模板', null, '0.50', '25', null, '2019-01-07 00:00:00', '2019-01-12 00:00:00', '2019-01-08 00:00:00', null, '已停工', '1', '2019-01-30 22:23:01');
INSERT INTO `task` VALUES ('102', '权限管理模板', null, '0.00', '25', null, '2019-01-29 00:00:00', '2019-02-01 00:00:00', null, null, '未开工', '1', '2019-01-30 23:01:53');
INSERT INTO `task` VALUES ('103', '登录Token', null, '0.80', '26', null, '2019-01-19 00:00:00', '2019-01-22 00:00:00', '2019-01-18 00:00:00', null, '施工中', '1', '2019-01-30 23:14:59');
INSERT INTO `task` VALUES ('104', '项目管理API', null, '0.00', '26', null, '2019-01-22 00:00:00', '2019-01-26 00:00:00', null, null, '未开工', '1', '2019-01-30 23:15:16');
INSERT INTO `task` VALUES ('105', '计划管理API', null, '0.00', '26', null, '2019-01-25 00:00:00', '2019-01-28 00:00:00', null, null, '未开工', '1', '2019-01-30 23:15:29');
INSERT INTO `task` VALUES ('106', '进度管理API', null, '0.00', '26', null, '2019-01-28 00:00:00', '2019-02-02 00:00:00', null, null, '未开工', '1', '2019-01-30 23:15:46');
INSERT INTO `task` VALUES ('107', '部门管理API', null, '0.00', '26', null, '2019-02-01 00:00:00', '2019-02-04 00:00:00', null, null, '未开工', '1', '2019-01-30 23:15:58');
INSERT INTO `task` VALUES ('108', '个人设置API', null, '0.00', '26', null, '2019-02-04 00:00:00', '2019-02-06 00:00:00', null, null, '未开工', '1', '2019-01-30 23:16:07');
INSERT INTO `task` VALUES ('109', '权限管理API', null, '0.00', '26', null, '2019-02-07 00:00:00', '2019-02-09 00:00:00', null, null, '未开工', '1', '2019-01-30 23:16:15');
INSERT INTO `task` VALUES ('110', '其他', null, '0.00', '25', null, '2019-01-24 00:00:00', '2019-01-28 00:00:00', null, null, '未开工', '1', '2019-01-31 22:09:55');
INSERT INTO `task` VALUES ('111', '了解需求', null, '0.00', '63', null, '2019-01-21 00:00:00', '2019-01-24 00:00:00', null, null, '未开工', '1', '2019-01-31 22:49:55');
INSERT INTO `task` VALUES ('112', '编写需求建议书', null, '0.00', '63', null, '2019-01-23 00:00:00', '2019-01-26 00:00:00', null, null, '未开工', '1', '2019-01-31 22:50:18');
INSERT INTO `task` VALUES ('113', '报价', null, '0.00', '63', null, '2019-01-25 00:00:00', '2019-01-26 00:00:00', null, null, '未开工', '1', '2019-01-31 22:50:39');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `RealName` varchar(255) DEFAULT NULL,
  `Mobile` varchar(255) DEFAULT NULL,
  `DepartmentId` int(11) DEFAULT NULL,
  `Permissions` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `User_ibfk_1` (`DepartmentId`),
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`DepartmentId`) REFERENCES `department` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'admin', '123456', 'Admin', '15554266653', '3', '1,2,3');

-- ----------------------------
-- Table structure for worklog
-- ----------------------------
DROP TABLE IF EXISTS `worklog`;
CREATE TABLE `worklog` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) DEFAULT NULL,
  `TaskId` int(11) DEFAULT NULL,
  `CreatedDate` datetime DEFAULT NULL,
  `CreatedBy` int(255) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `TaskId` (`TaskId`),
  KEY `CreatedBy` (`CreatedBy`),
  CONSTRAINT `worklog_ibfk_1` FOREIGN KEY (`TaskId`) REFERENCES `task` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `worklog_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `user` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of worklog
-- ----------------------------
INSERT INTO `worklog` VALUES ('1', '开始设置基础内容', '94', '2019-01-03 08:00:00', '1');
INSERT INTO `worklog` VALUES ('2', '开始设置基础内容', '95', '2019-01-05 08:00:00', '1');
INSERT INTO `worklog` VALUES ('3', '开始设置基础内容', '95', '2019-01-05 08:00:00', '1');
INSERT INTO `worklog` VALUES ('4', '开始设置基础内容', '95', '2019-01-05 08:00:00', '1');
INSERT INTO `worklog` VALUES ('5', '开始设置基础内容', '95', '2019-01-10 08:00:00', '1');
INSERT INTO `worklog` VALUES ('6', '开始设置基础内容', '94', '2019-01-04 08:00:00', '1');
INSERT INTO `worklog` VALUES ('7', '开始设置基础内容', '96', '2019-01-17 08:00:00', '1');
INSERT INTO `worklog` VALUES ('8', '开始设置基础内容', '97', '2019-01-17 08:00:00', '1');
INSERT INTO `worklog` VALUES ('9', '开始设置基础内容', '97', '2019-01-26 08:00:00', '1');
INSERT INTO `worklog` VALUES ('10', '开始设置基础内容', '98', '2019-01-19 08:00:00', '1');
INSERT INTO `worklog` VALUES ('11', '开始设置基础内容', '98', '2019-01-20 08:00:00', '1');
INSERT INTO `worklog` VALUES ('12', '开始设置基础内容', '98', '2019-01-21 08:00:00', '1');
INSERT INTO `worklog` VALUES ('13', '开始设置基础内容', '98', '2019-01-22 08:00:00', '1');
INSERT INTO `worklog` VALUES ('14', '开始设置基础内容', '99', '2019-01-24 08:00:00', '1');
INSERT INTO `worklog` VALUES ('15', '开始设置基础内容', '99', '2019-01-31 08:00:00', '1');
INSERT INTO `worklog` VALUES ('16', '开始设置基础内容', '97', '2019-01-14 08:00:00', '1');
INSERT INTO `worklog` VALUES ('17', '开始设置基础内容', '97', '2019-01-14 08:00:00', '1');
INSERT INTO `worklog` VALUES ('18', '开始设置基础内容', '100', '2019-01-13 08:00:00', '1');
INSERT INTO `worklog` VALUES ('19', '开始设置基础内容', '101', '2019-01-08 08:00:00', '1');
INSERT INTO `worklog` VALUES ('20', '开始设置基础内容', '101', '2019-01-10 08:00:00', '1');
INSERT INTO `worklog` VALUES ('21', '开始设置基础内容', '98', '2019-01-23 08:00:00', '1');
INSERT INTO `worklog` VALUES ('22', '开始设置基础内容', '98', '2019-01-26 08:00:00', '1');
INSERT INTO `worklog` VALUES ('23', '开始设置基础内容', '100', '2019-01-14 08:00:00', '1');
INSERT INTO `worklog` VALUES ('24', '开始设置基础内容', '100', '2019-01-14 08:00:00', '1');
INSERT INTO `worklog` VALUES ('25', '开始设置基础内容', '103', '2019-01-18 08:00:00', '1');
INSERT INTO `worklog` VALUES ('26', '开始设置基础内容', '103', '2019-01-20 08:00:00', '1');
