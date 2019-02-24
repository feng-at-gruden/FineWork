/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : finework

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 24/02/2019 12:08:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '项目部');
INSERT INTO `department` VALUES (2, '工程部');
INSERT INTO `department` VALUES (3, 'IT部');
INSERT INTO `department` VALUES (4, '办公室');

-- ----------------------------
-- Table structure for permission
-- ----------------------------
DROP TABLE IF EXISTS `permission`;
CREATE TABLE `permission`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of permission
-- ----------------------------
INSERT INTO `permission` VALUES (1, '新建项目', 'Project-Create');
INSERT INTO `permission` VALUES (2, '项目计划管理', 'Project-Plan');
INSERT INTO `permission` VALUES (3, '部门管理', 'System-Department');
INSERT INTO `permission` VALUES (4, '人员管理', 'System-User');
INSERT INTO `permission` VALUES (5, '项目阶段计划修改授权', 'Project-Plan-Edit-Authorize');
INSERT INTO `permission` VALUES (6, '工作汇报回复', 'Work-Replay');
INSERT INTO `permission` VALUES (7, '工作汇报', 'Work-Report');
INSERT INTO `permission` VALUES (8, '日志查看', 'View-Report');
INSERT INTO `permission` VALUES (9, '日志删除', 'Delete-WorkLog');
INSERT INTO `permission` VALUES (10, '项目删除', 'Delete-Project');

-- ----------------------------
-- Table structure for phase
-- ----------------------------
DROP TABLE IF EXISTS `phase`;
CREATE TABLE `phase`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Progress` decimal(3, 2) NULL DEFAULT NULL,
  `ProjectId` int(11) NULL DEFAULT NULL,
  `StartDate` datetime NULL DEFAULT NULL,
  `EndDate` datetime NULL DEFAULT NULL,
  `CreatedDate` datetime NULL DEFAULT NULL,
  `CreatedBy` int(255) NULL DEFAULT NULL,
  `Status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `ProjectId`(`ProjectId`) USING BTREE,
  INDEX `CreatedBy`(`CreatedBy`) USING BTREE,
  CONSTRAINT `phase_ibfk_1` FOREIGN KEY (`ProjectId`) REFERENCES `project` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `phase_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `user` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of phase
-- ----------------------------
INSERT INTO `phase` VALUES (25, '前端开发', 'UI设计、Vue实现', 0.86, 1, '2019-01-01 00:00:00', '2019-03-01 00:00:00', '2019-01-22 12:37:16', 1, '进行中');
INSERT INTO `phase` VALUES (26, '后端开发', 'REST API开发', 0.00, 1, '2019-01-26 00:00:00', '2019-03-01 00:00:00', '2019-01-22 12:38:32', 1, '进行中');
INSERT INTO `phase` VALUES (27, '系统测试', NULL, 0.00, 1, '2019-03-01 00:00:00', '2019-03-08 00:00:00', '2019-01-22 12:39:21', 1, '未开工');
INSERT INTO `phase` VALUES (28, '上线发布', NULL, 0.00, 1, '2019-03-05 00:00:00', '2019-03-12 00:00:00', '2019-01-22 12:39:56', 1, '未开工');
INSERT INTO `phase` VALUES (32, '需求调研', NULL, 0.00, 14, '2019-02-01 16:00:00', '2019-07-08 16:00:00', '2019-01-23 12:14:29', 1, '未开工');
INSERT INTO `phase` VALUES (33, '开发阶段', NULL, 0.00, 14, '2019-04-01 00:00:00', '2020-01-23 00:00:00', '2019-01-23 12:24:46', 1, '未开工');
INSERT INTO `phase` VALUES (35, '测试阶段', 'UAT测试', 0.00, 14, '2020-01-01 08:00:00', '2020-02-29 08:00:00', '2019-01-23 14:52:12', 1, '未开工');
INSERT INTO `phase` VALUES (36, '交付阶段', NULL, 0.00, 14, '2019-07-27 08:00:00', '2019-08-18 08:00:00', '2019-01-23 14:56:30', 1, '未开工');
INSERT INTO `phase` VALUES (38, '验收阶段', '客户验收', 0.00, 14, '2020-10-01 08:00:00', '2020-10-31 08:00:00', '2019-01-23 16:42:43', 1, '未开工');
INSERT INTO `phase` VALUES (39, '验收阶段', NULL, 0.00, 10, '2019-01-10 08:00:00', '2019-01-19 08:00:00', '2019-01-24 12:35:41', 1, '未开始');
INSERT INTO `phase` VALUES (40, '需求调研阶段', NULL, 0.00, 15, '2019-02-05 06:00:00', '2019-02-18 06:00:00', '2019-01-24 12:44:38', 1, '未开始');
INSERT INTO `phase` VALUES (41, 'UI设计阶段', NULL, 0.00, 15, '2019-02-12 00:00:00', '2019-03-01 00:00:00', '2019-01-24 12:44:56', 1, '未开始');
INSERT INTO `phase` VALUES (42, '前端开发阶段', NULL, 0.00, 15, '2019-02-26 05:00:00', '2019-03-19 05:00:00', '2019-01-24 12:56:01', 1, '未开始');
INSERT INTO `phase` VALUES (43, '后端开发阶段', NULL, 0.00, 15, '2019-03-08 16:00:00', '2019-03-29 16:00:00', '2019-01-24 12:57:46', 1, '未开始');
INSERT INTO `phase` VALUES (44, '验收阶段', NULL, 0.00, 12, '2019-01-24 08:00:00', '2019-01-31 08:00:00', '2019-01-24 16:44:24', 1, '未开始');
INSERT INTO `phase` VALUES (49, '基础工程', '111', 1.00, 17, '2019-02-02 08:00:00', '2019-02-06 08:00:00', '2019-01-24 17:02:43', 1, '已完工');
INSERT INTO `phase` VALUES (50, '主体工程', NULL, 0.00, 17, '2019-02-04 06:00:00', '2019-02-21 06:00:00', '2019-01-24 17:02:43', 1, '未开始');
INSERT INTO `phase` VALUES (51, '屋面工程', NULL, 0.00, 17, '2019-02-14 23:00:00', '2019-02-24 23:00:00', '2019-01-24 17:02:43', 1, '未开始');
INSERT INTO `phase` VALUES (52, '装饰装修工程', NULL, 0.00, 17, '2019-02-21 13:00:00', '2019-02-28 13:00:00', '2019-01-24 17:02:43', 1, '未开始');
INSERT INTO `phase` VALUES (53, '基础工程', NULL, 0.00, 5, '2019-01-13 08:00:00', '2019-01-24 08:00:00', '2019-01-24 17:07:57', 1, '未开始');
INSERT INTO `phase` VALUES (54, '建筑阶段', NULL, 0.00, 5, '2019-02-05 08:00:00', '2019-02-06 08:00:00', '2019-01-24 17:08:18', 1, '未开始');
INSERT INTO `phase` VALUES (56, '1111', NULL, 0.00, 5, '2019-01-14 00:00:00', '2019-01-22 00:00:00', '2019-01-24 17:20:58', 1, '未开始');
INSERT INTO `phase` VALUES (57, '222', NULL, 0.00, 5, '2019-01-13 08:00:00', '2019-01-13 08:00:00', '2019-01-24 17:21:40', 1, '未开始');
INSERT INTO `phase` VALUES (58, '基础工程', '内容', 0.00, 18, '2019-02-08 00:00:00', '2019-08-24 00:00:00', '2019-01-24 21:03:57', 1, '未开始');
INSERT INTO `phase` VALUES (59, '主体工程', NULL, 0.00, 18, '2019-07-31 08:00:00', '2020-02-14 08:00:00', '2019-01-24 21:03:57', 1, '未开始');
INSERT INTO `phase` VALUES (60, '屋面工程', NULL, 0.00, 18, '2019-11-22 18:00:00', '2020-08-22 18:00:00', '2019-01-24 21:03:57', 1, '未开始');
INSERT INTO `phase` VALUES (61, '装饰装修工程', NULL, 0.00, 18, '2020-02-29 07:00:00', '2020-12-15 07:00:00', '2019-01-24 21:03:57', 1, '未开始');
INSERT INTO `phase` VALUES (63, '需求调研', NULL, 0.00, 13, '2019-01-21 08:00:00', '2019-01-26 08:00:00', '2019-01-24 22:52:21', 1, '已完成');
INSERT INTO `phase` VALUES (64, '设计阶段', NULL, 0.00, 13, '2019-01-25 08:00:00', '2019-01-31 08:00:00', '2019-01-24 22:52:34', 1, '未开始');
INSERT INTO `phase` VALUES (66, 'h1', NULL, 0.00, 13, '2019-01-27 00:00:00', '2019-01-31 00:00:00', '2019-01-24 23:34:55', 1, '未开始');
INSERT INTO `phase` VALUES (67, '测试阶段', NULL, 0.00, 15, '2019-04-04 18:00:00', '2019-04-25 18:00:00', '2019-01-25 19:34:13', 1, '未开始');
INSERT INTO `phase` VALUES (71, '阶段1', NULL, 0.11, 11, '2019-02-13 03:00:00', '2019-03-01 03:00:00', '2019-01-27 17:01:24', 1, '未开始');
INSERT INTO `phase` VALUES (72, '阶段2', NULL, 0.00, 11, '2019-03-04 01:00:00', '2019-03-23 01:00:00', '2019-01-27 17:01:33', 1, '未开始');
INSERT INTO `phase` VALUES (73, '阶段3', NULL, 0.00, 11, '2019-03-29 14:00:00', '2019-04-10 14:00:00', '2019-01-27 17:02:00', 1, '未开始');
INSERT INTO `phase` VALUES (74, '阶段4', NULL, 0.00, 11, '2019-04-11 12:00:00', '2019-04-25 12:00:00', '2019-01-27 17:02:11', 1, '未开始');
INSERT INTO `phase` VALUES (75, '阶段5', NULL, 0.00, 11, '2019-04-27 05:00:00', '2019-06-07 05:00:00', '2019-01-27 17:02:39', 1, '未开始');
INSERT INTO `phase` VALUES (76, '阶段6', NULL, 0.00, 11, '2019-05-27 12:00:00', '2019-06-19 12:00:00', '2019-01-27 17:04:07', 1, '未开始');
INSERT INTO `phase` VALUES (77, '阶段2', NULL, 0.00, 12, '2019-01-01 08:00:00', '2019-01-30 08:00:00', '2019-01-27 20:15:21', 1, '未开始');
INSERT INTO `phase` VALUES (78, '111', NULL, 0.00, 12, '2019-01-01 08:00:00', '2019-01-01 08:00:00', '2019-01-27 20:15:41', 1, '未开始');
INSERT INTO `phase` VALUES (101, '阶段1', NULL, 0.00, 9, '2019-02-02 08:00:00', '2019-02-22 08:00:00', '2019-01-27 22:21:57', 1, '未开始');
INSERT INTO `phase` VALUES (102, '验收阶段', NULL, 0.00, 15, '2019-04-24 10:00:00', '2019-04-30 10:00:00', '2019-01-29 11:12:52', 1, '未开始');
INSERT INTO `phase` VALUES (103, '基础工程', NULL, 0.09, 19, '2019-02-14 00:00:00', '2019-05-22 00:00:00', '2019-02-23 21:48:20', 1, '施工中');
INSERT INTO `phase` VALUES (104, '主体工程', NULL, 0.52, 19, '2019-05-20 00:00:00', '2019-08-24 00:00:00', '2019-02-23 21:48:20', 1, '施工中');
INSERT INTO `phase` VALUES (105, '屋面工程', NULL, 0.00, 19, '2019-08-17 00:00:00', '2019-11-06 00:00:00', '2019-02-23 21:48:20', 1, '未开工');
INSERT INTO `phase` VALUES (106, '装饰装修工程', NULL, 0.00, 19, '2019-11-01 00:00:00', '2019-12-31 00:00:00', '2019-02-23 21:48:20', 1, '未开工');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Type` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `No` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Acreage` decimal(10, 2) NULL DEFAULT NULL,
  `Cost` decimal(10, 2) NULL DEFAULT NULL,
  `ContractNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `WarrantNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ArchiveNo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Location` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `FirstParty` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `StartDate` datetime NULL DEFAULT NULL,
  `EndDate` datetime NULL DEFAULT NULL,
  `Progress` decimal(3, 2) NULL DEFAULT NULL,
  `Status` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CreatedDate` datetime NULL DEFAULT NULL,
  `CreatedBy` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `CreatedBy`(`CreatedBy`) USING BTREE,
  CONSTRAINT `Project_ibfk_1` FOREIGN KEY (`CreatedBy`) REFERENCES `user` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES (1, '工程进度管理软件开发', '新建', '项目计划、甘特图、进度汇报', '2019001', 20.00, 7.00, '12412443432', NULL, '', '青岛', '中阳集团', '2019-01-01 08:00:00', '2019-03-15 08:00:00', 0.10, '在建中', '2019-01-18 11:08:04', 1);
INSERT INTO `project` VALUES (2, '市南拆迁项目', '新建', '土地征迁系统', NULL, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, '2019-03-01 08:00:00', '2019-05-31 08:00:00', 0.00, '已验收', '2019-01-18 14:12:19', 1);
INSERT INTO `project` VALUES (4, '铜陵拆迁项目', '新建', '铜陵一期项目', NULL, 0.00, 25.00, NULL, NULL, NULL, NULL, NULL, '2019-03-01 08:00:00', '2019-05-31 08:00:00', 0.00, '已验收', '2019-01-18 15:15:22', 1);
INSERT INTO `project` VALUES (5, '万科金色广场二期项目', '新建', '金色广场二期扩建项目', '2009011901', 20000.00, 5000.00, '000001', '000002', '00003', '重庆南路', '万科集团', '2019-01-13 08:00:00', '2019-09-30 08:00:00', 0.00, '已竣工', '2019-01-19 15:20:00', 1);
INSERT INTO `project` VALUES (9, '龙湖都市家园', '新建', '龙湖地产项目', '00001', 2000.00, 30000.00, '000001', '0000003', '0000003', '黑龙江路', '龙湖地产', '2019-02-02 00:00:00', '2019-12-31 00:00:00', 0.00, '筹备中', '2019-01-20 11:44:25', 1);
INSERT INTO `project` VALUES (10, '凯德MALL装修工程', '改建', '发布上线', '00001', 2000.00, 3000.00, NULL, NULL, NULL, NULL, NULL, '2019-01-10 08:00:00', '2019-05-01 08:00:00', 0.00, '已停工', '2019-01-20 17:34:56', 1);
INSERT INTO `project` VALUES (11, '碧桂园海星岛', '新建', '碧桂园', NULL, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, '2019-01-21 08:00:00', '2019-06-30 08:00:00', 0.00, '已验收', '2019-01-21 22:00:10', 1);
INSERT INTO `project` VALUES (12, '保利城中城', NULL, '保利地产项目', NULL, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, '2019-01-01 08:00:00', '2019-01-31 08:00:00', 0.00, '已竣工', '2019-01-21 22:00:43', 1);
INSERT INTO `project` VALUES (13, '海洋所数字图形化项目', '新建', '海洋所项目', NULL, 0.00, 26.00, NULL, NULL, NULL, NULL, '中科院海洋研究所', '2019-01-21 08:00:00', '2019-01-31 08:00:00', 0.00, '在建中', '2019-01-21 22:41:50', 1);
INSERT INTO `project` VALUES (14, 'AI论文分析系统', '新建', '论文自动识别', '20190002', 0.00, 67.00, '00001', '00002', '00003', NULL, NULL, '2019-05-01 08:00:00', '2020-12-31 08:00:00', 0.00, '筹备中', '2019-01-23 12:14:29', 1);
INSERT INTO `project` VALUES (15, 'WeChat-CRM系统', '新建', '基于微信生态的CRM集成', NULL, 0.00, 35.00, NULL, NULL, NULL, NULL, NULL, '2019-02-01 08:00:00', '2019-04-30 08:00:00', 0.00, '在建中', '2019-01-24 12:42:29', 1);
INSERT INTO `project` VALUES (17, '一个项目', '新建', '测试项目', NULL, 0.00, 0.00, NULL, NULL, NULL, NULL, NULL, '2019-02-01 08:00:00', '2019-03-31 08:00:00', 0.00, '筹备中', '2019-01-24 17:02:43', 1);
INSERT INTO `project` VALUES (18, '五四广场扩建工程', '改建', '五四广场扩建', NULL, 0.00, 0.00, '1', '2', '3', '市南区', '青岛市政府', '2019-02-01 08:00:00', '2020-12-31 08:00:00', 0.00, '已验收', '2019-01-24 21:03:57', 1);
INSERT INTO `project` VALUES (19, 'UAT测试项目', '新建', 'UAT测试数据', NULL, 0.00, 0.00, '00001', '0000001', '00000002', NULL, NULL, '2019-02-14 08:00:00', '2019-12-31 08:00:00', 0.00, '在建中', '2019-02-23 21:48:20', 1);

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Progress` decimal(3, 2) NULL DEFAULT 0.00,
  `PhaseId` int(11) NULL DEFAULT NULL,
  `ParentTaskId` int(11) NULL DEFAULT NULL,
  `PlanStartDate` datetime NULL DEFAULT NULL,
  `PlanEndDate` datetime NULL DEFAULT NULL,
  `ActualStartDate` datetime NULL DEFAULT NULL,
  `ActualEndDate` datetime NULL DEFAULT NULL,
  `Status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CreatedBy` int(11) NULL DEFAULT NULL,
  `CreatedDate` datetime NULL DEFAULT NULL,
  `LastUpdated` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `PhaseId`(`PhaseId`) USING BTREE,
  INDEX `ParentTaskId`(`ParentTaskId`) USING BTREE,
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`PhaseId`) REFERENCES `phase` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`ParentTaskId`) REFERENCES `task` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 158 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES (1, '了解需求', NULL, 0.00, 32, NULL, '2019-02-01 08:00:00', '2019-02-08 08:00:00', NULL, NULL, '未开工', 1, '2019-01-24 00:05:56', NULL);
INSERT INTO `task` VALUES (2, '估算报价', NULL, 0.00, 32, NULL, '2019-02-06 08:00:00', '2019-02-09 08:00:00', NULL, NULL, '未开工', 1, '2019-01-24 00:06:13', NULL);
INSERT INTO `task` VALUES (3, '需求建议书', NULL, 0.00, 32, NULL, '2019-02-11 00:00:00', '2019-02-16 00:00:00', NULL, NULL, '未开工', 1, '2019-01-24 00:06:27', NULL);
INSERT INTO `task` VALUES (4, '编写合同', NULL, 0.00, 32, NULL, '2019-02-18 08:00:00', '2019-02-22 08:00:00', NULL, NULL, '未开工', 1, '2019-01-24 00:06:51', NULL);
INSERT INTO `task` VALUES (5, '收集需求', NULL, 0.00, 40, NULL, '2019-02-09 00:00:00', '2019-02-15 00:00:00', NULL, NULL, '未开工', 1, '2019-01-24 15:01:24', NULL);
INSERT INTO `task` VALUES (8, '22222', NULL, 0.06, 40, NULL, '2019-02-13 00:00:00', '2019-02-18 00:00:00', '2019-02-14 00:00:00', NULL, '施工中', 1, '2019-01-24 15:01:51', NULL);
INSERT INTO `task` VALUES (11, '3333', NULL, 0.00, 40, NULL, '2019-02-05 00:00:00', '2019-02-18 00:00:00', NULL, NULL, '未开工', 1, '2019-01-24 16:15:45', NULL);
INSERT INTO `task` VALUES (12, '11', '12', 1.00, 49, NULL, '2019-02-04 00:00:00', '2019-02-05 00:00:00', NULL, NULL, '已完工', 1, '2019-01-24 17:03:21', NULL);
INSERT INTO `task` VALUES (13, '111111', '111', 0.00, 53, NULL, '2019-01-13 08:00:00', '2019-01-22 08:00:00', NULL, NULL, '已完成', 1, '2019-01-24 18:06:49', NULL);
INSERT INTO `task` VALUES (14, '12', '23', 0.00, 53, NULL, '2019-01-13 08:00:00', '2019-01-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-24 18:12:19', NULL);
INSERT INTO `task` VALUES (15, '11111', NULL, 0.00, 51, NULL, '2019-02-11 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-24 20:19:08', NULL);
INSERT INTO `task` VALUES (16, '1112', '22', 0.00, 51, 15, '2019-02-11 08:00:00', '2019-02-12 08:00:00', NULL, NULL, '进行中', 1, '2019-01-24 20:21:15', NULL);
INSERT INTO `task` VALUES (17, '12', NULL, 1.00, 49, 12, '2019-02-04 00:00:00', '2019-02-06 00:00:00', '2019-02-01 00:00:00', '2019-02-03 00:00:00', '施工中', 1, '2019-01-24 20:26:22', NULL);
INSERT INTO `task` VALUES (18, '土木工程', '内容', 0.00, 58, NULL, '2019-02-14 08:00:00', '2019-02-23 08:00:00', NULL, NULL, '未开始', 1, '2019-01-24 21:13:55', NULL);
INSERT INTO `task` VALUES (19, '基建工程', NULL, 0.00, 58, NULL, '2019-02-23 00:00:00', '2019-03-11 00:00:00', NULL, NULL, '未开始', 1, '2019-01-24 21:14:19', NULL);
INSERT INTO `task` VALUES (21, 'g1', NULL, 0.00, NULL, NULL, '2019-01-01 08:00:00', '2019-01-02 08:00:00', NULL, NULL, '未开始', 1, '2019-01-25 13:03:16', NULL);
INSERT INTO `task` VALUES (22, 'g2', NULL, 0.00, NULL, NULL, '2019-01-07 08:00:00', '2019-01-11 08:00:00', NULL, NULL, '未开始', 1, '2019-01-25 13:38:31', NULL);
INSERT INTO `task` VALUES (23, 'g22', NULL, 0.00, NULL, 22, '2019-01-08 00:00:00', '2019-01-10 00:00:00', NULL, NULL, '未开始', 1, '2019-01-25 13:38:40', NULL);
INSERT INTO `task` VALUES (24, 'g21', NULL, 0.00, NULL, 22, '2019-01-07 08:00:00', '2019-01-08 08:00:00', NULL, NULL, '未开始', 1, '2019-01-25 13:39:05', NULL);
INSERT INTO `task` VALUES (25, '任务1', NULL, 0.30, 71, NULL, '2019-02-13 08:00:00', '2019-02-21 08:00:00', '2019-02-11 11:18:06', NULL, '进行中', 1, '2019-01-27 17:09:17', NULL);
INSERT INTO `task` VALUES (26, '任务2', NULL, 1.00, 71, NULL, '2019-02-13 08:00:00', '2019-02-14 08:00:00', '2019-01-30 11:23:02', '2019-02-08 11:23:06', '已完成', 1, '2019-01-27 17:09:27', NULL);
INSERT INTO `task` VALUES (27, '任务3', NULL, 0.00, 71, NULL, '2019-02-18 00:00:00', '2019-02-19 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:09:40', NULL);
INSERT INTO `task` VALUES (28, '任务2.1', NULL, 1.00, 71, 26, '2019-02-15 00:00:00', '2019-02-17 00:00:00', '2019-02-05 11:24:33', '2019-02-08 11:24:37', '已完成', 1, '2019-01-27 17:13:20', NULL);
INSERT INTO `task` VALUES (29, '任务2.2', NULL, 0.00, 71, 26, '2019-02-16 00:00:00', '2019-02-17 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:16:03', NULL);
INSERT INTO `task` VALUES (30, '任务2.4', NULL, 0.00, 71, 26, '2019-02-14 00:00:00', '2019-02-16 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:24:01', NULL);
INSERT INTO `task` VALUES (31, 'TASK1', NULL, 0.00, 71, NULL, '2019-02-19 00:00:00', '2019-02-20 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:38:28', NULL);
INSERT INTO `task` VALUES (32, 'TAKS2', NULL, 0.20, 71, NULL, '2019-02-14 00:00:00', '2019-02-15 00:00:00', '2019-02-15 00:00:00', NULL, '施工中', 1, '2019-01-27 17:38:38', NULL);
INSERT INTO `task` VALUES (44, '111', NULL, 0.00, 71, NULL, '2019-02-13 00:00:00', '2019-02-21 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:47:18', NULL);
INSERT INTO `task` VALUES (45, '222', NULL, 0.00, 71, NULL, '2019-02-15 00:00:00', '2019-02-16 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:47:21', NULL);
INSERT INTO `task` VALUES (46, '3333', NULL, 0.00, 71, NULL, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:47:30', NULL);
INSERT INTO `task` VALUES (49, '111', NULL, 0.05, 71, NULL, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:48:14', NULL);
INSERT INTO `task` VALUES (52, '123', NULL, 0.00, 71, NULL, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:50:43', NULL);
INSERT INTO `task` VALUES (53, '123', NULL, 0.00, 71, NULL, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:50:57', NULL);
INSERT INTO `task` VALUES (58, '123', NULL, 0.00, 71, 44, '2019-02-14 00:00:00', '2019-02-18 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:57:55', NULL);
INSERT INTO `task` VALUES (59, '123', NULL, 0.60, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:58:01', NULL);
INSERT INTO `task` VALUES (60, '123', NULL, 0.00, 71, 52, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:58:06', NULL);
INSERT INTO `task` VALUES (61, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:58:12', NULL);
INSERT INTO `task` VALUES (62, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:58:27', NULL);
INSERT INTO `task` VALUES (63, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:58:34', NULL);
INSERT INTO `task` VALUES (64, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:58:40', NULL);
INSERT INTO `task` VALUES (65, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:58:59', NULL);
INSERT INTO `task` VALUES (66, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:59:05', NULL);
INSERT INTO `task` VALUES (67, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:59:14', NULL);
INSERT INTO `task` VALUES (68, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:59:25', NULL);
INSERT INTO `task` VALUES (69, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:59:33', NULL);
INSERT INTO `task` VALUES (70, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 17:59:54', NULL);
INSERT INTO `task` VALUES (71, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:00:01', NULL);
INSERT INTO `task` VALUES (72, '123', NULL, 0.00, 71, 49, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:00:09', NULL);
INSERT INTO `task` VALUES (73, '123', NULL, 0.00, 71, 44, '2019-02-15 00:00:00', '2019-02-16 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:01:56', NULL);
INSERT INTO `task` VALUES (75, '123', NULL, 0.00, 71, 44, '2019-02-17 00:00:00', '2019-02-18 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:02:26', NULL);
INSERT INTO `task` VALUES (76, '221', NULL, 0.00, 71, 45, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:15:51', NULL);
INSERT INTO `task` VALUES (77, '222', NULL, 0.00, 71, NULL, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:16:06', NULL);
INSERT INTO `task` VALUES (78, '222', NULL, 0.00, 71, 45, '2019-02-16 00:00:00', '2019-02-17 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:16:25', NULL);
INSERT INTO `task` VALUES (79, '333', NULL, 0.00, 71, 45, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:16:32', NULL);
INSERT INTO `task` VALUES (80, '123', NULL, 0.00, 71, 44, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:17:11', NULL);
INSERT INTO `task` VALUES (81, '444', NULL, 0.00, 71, 45, '2019-02-17 00:00:00', '2019-02-18 00:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:17:22', NULL);
INSERT INTO `task` VALUES (82, '123', NULL, 0.00, 71, 52, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:17:31', NULL);
INSERT INTO `task` VALUES (83, '123', NULL, 0.00, 71, 52, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 18:17:39', NULL);
INSERT INTO `task` VALUES (84, '123', NULL, 0.00, 71, 52, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 20:05:34', NULL);
INSERT INTO `task` VALUES (85, '123', NULL, 0.00, 71, 44, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 20:05:49', NULL);
INSERT INTO `task` VALUES (86, '123', NULL, 0.00, 71, 44, '2019-02-13 08:00:00', '2019-02-14 08:00:00', NULL, NULL, '未开始', 1, '2019-01-27 20:06:05', NULL);
INSERT INTO `task` VALUES (87, '1', NULL, 0.00, 58, 18, '2019-02-14 08:00:00', '2019-02-15 08:00:00', NULL, NULL, '未开始', 1, '2019-01-28 19:15:05', NULL);
INSERT INTO `task` VALUES (88, '2', NULL, 0.00, 58, 18, '2019-02-14 00:00:00', '2019-02-19 00:00:00', NULL, NULL, '未开始', 1, '2019-01-28 19:19:51', NULL);
INSERT INTO `task` VALUES (89, '11', NULL, 0.00, 58, 87, '2019-02-14 00:00:00', '2019-02-19 00:00:00', NULL, NULL, '未开始', 1, '2019-01-28 19:19:56', NULL);
INSERT INTO `task` VALUES (90, '22', NULL, 0.00, 58, 88, '2019-02-16 00:00:00', '2019-02-23 00:00:00', NULL, NULL, '未开始', 1, '2019-01-28 19:20:02', NULL);
INSERT INTO `task` VALUES (91, '1234', NULL, 0.00, 71, 59, '2019-02-13 00:00:00', '2019-02-16 00:00:00', '2019-02-16 00:00:00', NULL, '施工中', 1, '2019-01-29 10:29:32', NULL);
INSERT INTO `task` VALUES (92, '1234', NULL, 0.00, 71, 58, '2019-02-14 00:00:00', '2019-02-17 00:00:00', NULL, NULL, '未开始', 1, '2019-01-29 10:29:47', NULL);
INSERT INTO `task` VALUES (94, '任务1', NULL, 0.00, 72, NULL, '2019-03-04 08:00:00', '2019-03-07 08:00:00', NULL, NULL, '未开始', 1, '2019-01-29 12:44:16', NULL);
INSERT INTO `task` VALUES (95, '任务2', NULL, 0.00, 72, NULL, '2019-03-05 00:00:00', '2019-03-08 00:00:00', NULL, NULL, '未开始', 1, '2019-01-29 12:44:22', NULL);
INSERT INTO `task` VALUES (96, '任务3', NULL, 0.00, 72, NULL, '2019-03-06 00:00:00', '2019-03-09 00:00:00', NULL, NULL, '未开始', 1, '2019-01-29 12:44:32', NULL);
INSERT INTO `task` VALUES (97, '任务4', NULL, 0.00, 72, NULL, '2019-03-10 08:00:00', '2019-03-13 08:00:00', NULL, NULL, '未开始', 1, '2019-01-29 13:04:57', NULL);
INSERT INTO `task` VALUES (98, '111', NULL, 0.00, NULL, NULL, '2019-02-16 00:00:00', '2019-02-17 00:00:00', NULL, NULL, '未开工', 1, '2019-02-16 00:33:13', NULL);
INSERT INTO `task` VALUES (99, '222', NULL, 0.00, NULL, NULL, '2019-02-16 00:00:00', '2019-02-17 00:00:00', NULL, NULL, '未开工', 1, '2019-02-16 00:33:18', NULL);
INSERT INTO `task` VALUES (100, '333', NULL, 0.00, NULL, NULL, '2019-02-16 00:00:00', '2019-02-17 00:00:00', NULL, NULL, '未开工', 1, '2019-02-16 00:33:23', NULL);
INSERT INTO `task` VALUES (101, 'UI设计', 'UI设计、UX设计等', 1.00, 25, NULL, '2019-01-01 00:00:00', '2019-01-14 00:00:00', '2019-01-02 00:00:00', '2019-01-10 00:00:00', '已完工', 1, '2019-02-19 13:58:08', NULL);
INSERT INTO `task` VALUES (102, 'Vue基础架构搭建', '前端代码基础架构、Vue依赖引用、Router设置等等', 1.00, 25, NULL, '2019-01-03 00:00:00', '2019-01-13 00:00:00', '2019-01-02 00:00:00', '2019-01-16 00:00:00', '已完工', 1, '2019-02-19 13:59:03', NULL);
INSERT INTO `task` VALUES (103, '项目管理模块', '项目管理功能', 1.00, 25, NULL, '2019-01-04 00:00:00', '2019-01-11 00:00:00', NULL, NULL, '已完工', 1, '2019-02-19 13:59:25', NULL);
INSERT INTO `task` VALUES (104, '计划管理模块', '计划管理、进度查看等', 1.00, 25, NULL, '2019-01-21 00:00:00', '2019-01-27 00:00:00', NULL, NULL, '已完工', 1, '2019-02-19 13:59:34', NULL);
INSERT INTO `task` VALUES (105, '工作汇报模块', '工作汇报功能', 1.00, 25, NULL, '2019-01-31 00:00:00', '2019-02-06 00:00:00', NULL, NULL, '已完工', 1, '2019-02-19 13:59:47', NULL);
INSERT INTO `task` VALUES (106, '系统设置模块', '用户管理、权限管理', 1.00, 25, NULL, '2019-02-11 00:00:00', '2019-02-19 00:00:00', '2019-02-11 00:00:00', '2019-02-20 00:00:00', '已完工', 1, '2019-02-19 14:00:58', '2019-02-20 02:39:51');
INSERT INTO `task` VALUES (107, '个人设置模块', '账号设置、个性化设置', 1.00, 25, NULL, '2019-02-14 00:00:00', '2019-02-16 00:00:00', '2019-02-14 00:00:00', '2019-02-16 00:00:00', '已完工', 1, '2019-02-19 14:02:10', NULL);
INSERT INTO `task` VALUES (108, '项目列表', NULL, 1.00, 25, 103, '2019-01-04 00:00:00', '2019-01-06 00:00:00', '2019-01-04 00:00:00', '2019-01-06 00:00:00', '已完工', 1, '2019-02-19 14:02:19', NULL);
INSERT INTO `task` VALUES (109, '项目信息', '项目信息详情、修改', 1.00, 25, 103, '2019-01-06 00:00:00', '2019-01-10 00:00:00', '2019-01-06 00:00:00', '2019-01-09 00:00:00', '已完工', 2, '2019-02-19 14:09:22', NULL);
INSERT INTO `task` VALUES (110, '项目阶段计划', '甘特图、计划增删改查', 1.00, 25, 103, '2019-01-10 00:00:00', '2019-01-21 00:00:00', '2019-01-08 00:00:00', '2019-01-21 00:00:00', '已完工', 2, '2019-02-19 15:11:30', NULL);
INSERT INTO `task` VALUES (111, '阶段任务管理', '甘特图、任务管理', 1.00, 25, 104, '2019-01-21 00:00:00', '2019-01-30 00:00:00', '2019-01-20 00:00:00', '2019-01-29 00:00:00', '已完工', 2, '2019-02-19 15:15:16', NULL);
INSERT INTO `task` VALUES (112, '工作汇报', '进度更新、日志汇报', 1.00, 25, 105, '2019-01-31 00:00:00', '2019-02-04 00:00:00', '2019-01-29 00:00:00', '2019-02-03 00:00:00', '已完工', 2, '2019-02-19 15:15:35', NULL);
INSERT INTO `task` VALUES (114, '人员管理', NULL, 1.00, 25, 106, '2019-02-11 00:00:00', '2019-02-16 00:00:00', '2019-02-11 00:00:00', '2019-02-14 00:00:00', '已完工', 2, '2019-02-19 15:15:53', NULL);
INSERT INTO `task` VALUES (115, '权限设置', NULL, 1.00, 25, 106, '2019-02-15 00:00:00', '2019-02-19 00:00:00', '2019-02-16 00:00:00', '2019-02-20 00:00:00', '已完工', 2, '2019-02-19 15:16:00', '2019-02-20 02:39:51');
INSERT INTO `task` VALUES (119, '优化工作', NULL, 0.50, 25, NULL, '2019-02-19 00:00:00', '2019-03-01 00:00:00', '2019-01-03 00:00:00', NULL, '施工中', 2, '2019-02-19 16:19:18', '2019-01-04 02:45:38');
INSERT INTO `task` VALUES (120, '甘特图过滤显示', NULL, 1.00, 25, 119, '2019-02-19 00:00:00', '2019-02-21 00:00:00', '2019-02-20 00:00:00', '2019-02-23 00:00:00', '已完工', 2, '2019-02-19 16:19:34', NULL);
INSERT INTO `task` VALUES (121, '项目时间线', NULL, 0.00, 25, 119, '2019-02-19 00:00:00', '2019-02-20 00:00:00', NULL, NULL, '未开工', 2, '2019-02-19 16:19:47', NULL);
INSERT INTO `task` VALUES (122, '阶段统计', NULL, 0.00, 25, 119, '2019-02-20 00:00:00', '2019-02-22 00:00:00', NULL, NULL, '未开工', 2, '2019-02-19 16:20:01', NULL);
INSERT INTO `task` VALUES (123, '查看工作汇报', NULL, 1.00, 25, 119, '2019-02-24 00:00:00', '2019-02-27 00:00:00', '2019-02-22 00:00:00', '2019-02-23 00:00:00', '已完工', 2, '2019-02-19 16:20:32', NULL);
INSERT INTO `task` VALUES (124, '其他', NULL, 0.25, 25, 119, '2019-02-21 00:00:00', '2019-02-25 00:00:00', '2019-01-03 00:00:00', NULL, '施工中', 1, '2019-02-20 23:08:17', '2019-01-04 02:45:38');
INSERT INTO `task` VALUES (125, '任务1', NULL, 1.00, 25, 124, '2019-02-21 00:00:00', '2019-02-22 00:00:00', '2019-02-20 00:00:00', '2019-02-21 00:00:00', '已完工', 1, '2019-02-20 23:08:28', NULL);
INSERT INTO `task` VALUES (126, '任务2', NULL, 0.20, 25, 124, '2019-02-22 00:00:00', '2019-02-23 00:00:00', '2019-02-20 00:00:00', NULL, '已停工', 1, '2019-02-20 23:08:34', NULL);
INSERT INTO `task` VALUES (127, '任务3', NULL, 0.30, 25, 124, '2019-02-23 00:00:00', '2019-02-24 00:00:00', '2019-02-20 00:00:00', NULL, '施工中', 1, '2019-02-20 23:08:41', NULL);
INSERT INTO `task` VALUES (128, '任务4', NULL, 0.25, 25, 124, '2019-02-28 00:00:00', '2019-03-01 00:00:00', '2019-01-03 00:00:00', NULL, '施工中', 1, '2019-02-20 23:08:51', '2019-01-04 02:45:38');
INSERT INTO `task` VALUES (129, '任务5', NULL, 0.00, 25, 124, '2019-02-24 00:00:00', '2019-02-27 00:00:00', NULL, NULL, '未开工', 1, '2019-02-22 22:10:06', NULL);
INSERT INTO `task` VALUES (130, '13', NULL, 0.00, 49, 12, '2019-02-04 00:00:00', '2019-02-05 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 15:03:18', NULL);
INSERT INTO `task` VALUES (132, '14', NULL, 0.00, 49, 12, '2019-02-04 00:00:00', '2019-02-05 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 15:05:00', NULL);
INSERT INTO `task` VALUES (133, '任务组1', NULL, 0.25, 103, NULL, '2019-02-15 00:00:00', '2019-03-17 00:00:00', '2019-02-13 00:00:00', NULL, '施工中', 1, '2019-02-23 21:50:36', '2019-02-16 01:53:07');
INSERT INTO `task` VALUES (134, '任务1.1', NULL, 0.75, 103, 133, '2019-02-15 00:00:00', '2019-02-25 00:00:00', '2019-02-13 00:00:00', NULL, '施工中', 1, '2019-02-23 21:50:44', '2019-02-16 01:53:07');
INSERT INTO `task` VALUES (135, '任务1.2', NULL, 0.00, 103, 133, '2019-02-25 00:00:00', '2019-03-07 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 21:50:51', NULL);
INSERT INTO `task` VALUES (136, '任务1.3', NULL, 0.00, 103, 133, '2019-03-07 00:00:00', '2019-03-17 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:10:18', NULL);
INSERT INTO `task` VALUES (137, '任务组2', NULL, 0.02, 103, NULL, '2019-03-18 00:00:00', '2019-04-27 00:00:00', '2019-03-19 00:00:00', NULL, '施工中', 1, '2019-02-23 22:10:52', '2019-03-20 02:08:42');
INSERT INTO `task` VALUES (138, '任务2.1', NULL, 0.20, 103, 137, '2019-03-18 00:00:00', '2019-03-23 00:00:00', '2019-03-19 00:00:00', NULL, '施工中', 1, '2019-02-23 22:11:48', '2019-03-20 02:08:42');
INSERT INTO `task` VALUES (139, '任务2.2', NULL, 0.00, 103, 137, '2019-03-23 00:00:00', '2019-03-28 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:13:48', NULL);
INSERT INTO `task` VALUES (140, '任务2.3', NULL, 0.00, 103, 137, '2019-03-28 00:00:00', '2019-04-02 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:14:07', NULL);
INSERT INTO `task` VALUES (141, '任务2.4', NULL, 0.00, 103, 137, '2019-04-02 00:00:00', '2019-04-07 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:14:49', NULL);
INSERT INTO `task` VALUES (142, '任务2.5', NULL, 0.00, 103, 137, '2019-04-07 00:00:00', '2019-04-12 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:15:26', NULL);
INSERT INTO `task` VALUES (143, '任务2.6', NULL, 0.00, 103, 137, '2019-04-12 00:00:00', '2019-04-17 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:15:47', NULL);
INSERT INTO `task` VALUES (144, '任务2.7', NULL, 0.00, 103, 137, '2019-04-17 00:00:00', '2019-04-22 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:15:56', NULL);
INSERT INTO `task` VALUES (145, '任务2.8', NULL, 0.00, 103, 137, '2019-04-22 00:00:00', '2019-04-27 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:16:03', NULL);
INSERT INTO `task` VALUES (146, '任务组3', NULL, 0.00, 103, NULL, '2019-05-01 00:00:00', '2019-05-21 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:17:10', NULL);
INSERT INTO `task` VALUES (147, '任务3.1', NULL, 0.00, 103, 146, '2019-05-01 00:00:00', '2019-05-06 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:17:41', NULL);
INSERT INTO `task` VALUES (148, '任务3.2', NULL, 0.00, 103, 146, '2019-05-06 00:00:00', '2019-05-11 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:17:59', NULL);
INSERT INTO `task` VALUES (149, '任务3.3', NULL, 0.00, 103, 146, '2019-05-11 00:00:00', '2019-05-16 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:18:35', NULL);
INSERT INTO `task` VALUES (150, '任务3.4', NULL, 0.00, 103, 146, '2019-05-16 00:00:00', '2019-05-21 00:00:00', NULL, NULL, '未开工', 1, '2019-02-23 22:19:05', NULL);
INSERT INTO `task` VALUES (151, '任务组1', NULL, 0.00, 104, NULL, '2019-05-20 00:00:00', '2019-06-02 00:00:00', NULL, NULL, '未开工', 1, '2019-02-24 00:16:02', NULL);
INSERT INTO `task` VALUES (152, '任务1.1', NULL, 0.00, 104, 151, '2019-05-20 00:00:00', '2019-05-26 00:00:00', NULL, NULL, '未开工', 1, '2019-02-24 00:16:13', NULL);
INSERT INTO `task` VALUES (153, '任务1.2', NULL, 0.00, 104, 151, '2019-05-27 00:00:00', '2019-06-02 00:00:00', NULL, NULL, '未开工', 1, '2019-02-24 00:16:30', NULL);
INSERT INTO `task` VALUES (154, '任务组2', NULL, 0.96, 104, NULL, '2019-06-01 00:00:00', '2019-06-16 00:00:00', '2019-05-30 00:00:00', NULL, '施工中', 1, '2019-02-24 09:53:31', '2019-06-16 10:43:09');
INSERT INTO `task` VALUES (155, '任务2.1', NULL, 1.00, 104, 154, '2019-06-01 00:00:00', '2019-06-06 00:00:00', '2019-05-30 00:00:00', '2019-06-03 00:00:00', '已完工', 1, '2019-02-24 09:53:54', '2019-06-03 10:17:38');
INSERT INTO `task` VALUES (156, '任务2.2', NULL, 0.90, 104, 154, '2019-06-06 00:00:00', '2019-06-11 00:00:00', '2019-06-06 00:00:00', NULL, '施工中', 1, '2019-02-24 09:54:13', '2019-06-09 11:55:30');
INSERT INTO `task` VALUES (157, '任务2.3', NULL, 1.00, 104, 154, '2019-06-11 00:00:00', '2019-06-16 00:00:00', '2019-06-12 00:00:00', '2019-06-16 00:00:00', '已完工', 1, '2019-02-24 10:11:19', '2019-06-16 10:43:09');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `Password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `RealName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Mobile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DepartmentId` int(11) NULL DEFAULT NULL,
  `Permissions` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `LastLoginAt` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `User_ibfk_1`(`DepartmentId`) USING BTREE,
  CONSTRAINT `User_ibfk_1` FOREIGN KEY (`DepartmentId`) REFERENCES `department` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123456', 'Administrator', '15554266653', 3, '1,2,3,project-management,plan-management,progress-management,system-management', '2019-02-24 12:07:58');
INSERT INTO `user` VALUES (2, 'Test', '123456', 'Test User', '13111111111', NULL, 'plan-management,progress-management', '2019-02-20 13:25:13');
INSERT INTO `user` VALUES (3, 'Hello', '123456', 'Hello Kitty', '19999999999', NULL, 'project-management,system-management', '2019-02-18 23:11:42');
INSERT INTO `user` VALUES (4, 'Boss', '123456', 'Boss USER', '13999999999', NULL, '', '2019-02-22 21:41:39');

-- ----------------------------
-- Table structure for worklog
-- ----------------------------
DROP TABLE IF EXISTS `worklog`;
CREATE TABLE `worklog`  (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TaskId` int(11) NULL DEFAULT NULL,
  `CreatedDate` datetime NULL DEFAULT NULL,
  `CreatedBy` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `TaskId`(`TaskId`) USING BTREE,
  INDEX `CreatedBy`(`CreatedBy`) USING BTREE,
  CONSTRAINT `worklog_ibfk_1` FOREIGN KEY (`TaskId`) REFERENCES `task` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `worklog_ibfk_2` FOREIGN KEY (`CreatedBy`) REFERENCES `user` (`Id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 74 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of worklog
-- ----------------------------
INSERT INTO `worklog` VALUES (1, '政策施工中', NULL, 32, '2019-02-15 08:00:00', 1);
INSERT INTO `worklog` VALUES (2, '正常施工中', NULL, 91, '2019-02-16 08:00:00', 1);
INSERT INTO `worklog` VALUES (3, '正常施工中', NULL, 91, '2019-02-16 08:00:00', 1);
INSERT INTO `worklog` VALUES (4, '正常施工中', NULL, 91, '2019-02-17 08:00:00', 1);
INSERT INTO `worklog` VALUES (5, '111', NULL, 17, '2019-02-02 08:00:00', 1);
INSERT INTO `worklog` VALUES (6, '开始了', NULL, 8, '2019-02-14 08:00:00', 2);
INSERT INTO `worklog` VALUES (7, '大体完工', NULL, 101, '2019-01-10 08:00:00', 2);
INSERT INTO `worklog` VALUES (8, '完工', NULL, 102, '2019-01-16 08:00:00', 2);
INSERT INTO `worklog` VALUES (9, '完成', NULL, 108, '2019-01-06 08:00:00', 2);
INSERT INTO `worklog` VALUES (10, '完成', NULL, 109, '2019-01-09 08:00:00', 2);
INSERT INTO `worklog` VALUES (11, '完成', NULL, 110, '2019-01-21 08:00:00', 2);
INSERT INTO `worklog` VALUES (12, '刚开始', NULL, NULL, '2019-02-19 08:00:00', 2);
INSERT INTO `worklog` VALUES (13, '基本完工', NULL, 115, '2019-02-18 08:00:00', 2);
INSERT INTO `worklog` VALUES (14, '完成', NULL, 107, '2019-02-16 08:00:00', 2);
INSERT INTO `worklog` VALUES (15, '完成', NULL, 111, '2019-01-28 08:00:00', 2);
INSERT INTO `worklog` VALUES (16, '完成工作进度汇报', NULL, 112, '2019-02-03 08:00:00', 2);
INSERT INTO `worklog` VALUES (17, '人员管理完成', NULL, 114, '2019-02-14 08:00:00', 2);
INSERT INTO `worklog` VALUES (18, '完工', NULL, 110, '2019-01-21 08:00:00', 2);
INSERT INTO `worklog` VALUES (19, '完工', NULL, 112, '2019-02-03 08:00:00', 2);
INSERT INTO `worklog` VALUES (20, '完工', NULL, 111, '2019-01-28 08:00:00', 2);
INSERT INTO `worklog` VALUES (21, 'DONE', NULL, 110, '2019-01-21 08:00:00', 1);
INSERT INTO `worklog` VALUES (22, 'DONE', NULL, 111, '2019-01-28 08:00:00', 1);
INSERT INTO `worklog` VALUES (23, 'DONE', NULL, 112, '2019-02-03 08:00:00', 1);
INSERT INTO `worklog` VALUES (24, 'DONE', NULL, 110, '2019-01-21 08:00:00', 1);
INSERT INTO `worklog` VALUES (25, 'DONE', NULL, 111, '2019-01-29 08:00:00', 1);
INSERT INTO `worklog` VALUES (26, 'DONE', NULL, 112, '2019-02-03 08:00:00', 1);
INSERT INTO `worklog` VALUES (27, 'Start', NULL, 120, '2019-02-20 08:00:00', 1);
INSERT INTO `worklog` VALUES (28, 'DONE', NULL, 125, '2019-02-20 08:00:00', 1);
INSERT INTO `worklog` VALUES (29, 'DONEWORK', NULL, 126, '2019-02-20 08:00:00', 1);
INSERT INTO `worklog` VALUES (30, 'WORKING', NULL, 127, '2019-02-20 08:00:00', 1);
INSERT INTO `worklog` VALUES (31, 'WORKINGWORK', NULL, 126, '2019-02-20 08:00:00', 1);
INSERT INTO `worklog` VALUES (32, 'STOP', NULL, 126, '2019-02-20 08:00:00', 1);
INSERT INTO `worklog` VALUES (33, 'DONE', NULL, 125, '2019-02-21 08:00:00', 1);
INSERT INTO `worklog` VALUES (34, '基本完成', NULL, 120, '2019-02-21 08:00:00', 1);
INSERT INTO `worklog` VALUES (35, '测试日志', '80.00', 120, '2019-02-22 08:00:00', 1);
INSERT INTO `worklog` VALUES (36, '测试日志', '90.00%#90.00%#施工中#施工中', 120, '2019-02-22 18:48:26', 1);
INSERT INTO `worklog` VALUES (37, ' 截至目前，该功能已全部完成。\n实现了甘特图任务过滤显示的功能。', '90.00%#90.00%#施工中#施工中', 120, '2019-02-23 21:25:25', 1);
INSERT INTO `worklog` VALUES (38, '完工', '90.00%#100.00%#施工中#已完工', 120, '2019-02-23 21:25:46', 1);
INSERT INTO `worklog` VALUES (39, '进度更新', '21.00%#30.00%#施工中#施工中', 127, '2019-02-21 21:45:47', 1);
INSERT INTO `worklog` VALUES (40, '暂无进度更新', '90.00%#90.00%#施工中#施工中', 115, '2019-02-19 21:46:05', 1);
INSERT INTO `worklog` VALUES (41, '开工', '0.00%#10.00%#未开工#施工中', 128, '2019-01-03 21:51:43', 1);
INSERT INTO `worklog` VALUES (42, '调查Calendar UI框架：SpanCalendar、FullCalendar。效果不理想，前者Drawer冲突，后者css样式有问题。\n\n目前还在调查中。', '0.00%#10.00%#未开工#施工中', 123, '2019-02-22 01:50:40', 1);
INSERT INTO `worklog` VALUES (43, '引用dhtmlx scheduler组件可满足需要。\n完成UI及后端集成。\n工作日志显示换行符有待完善。', '10%#90%#施工中#施工中', 123, '2019-02-23 01:58:22', 1);
INSERT INTO `worklog` VALUES (44, '完成查看工作汇报功能：<br/>1. 工作日志查看<br/>2. 工作进度及状态变更<br/>3. Dhtmlx-Scheduler<br/><br/>', '90%#100%#施工中#已完工', 123, '2019-02-23 10:59:04', 1);
INSERT INTO `worklog` VALUES (45, '完工', '4%#100%#施工中#已完工', 17, '2019-02-03 15:02:14', 1);
INSERT INTO `worklog` VALUES (46, '开工：<br/><br/>1. 提前2天<br/>2. 工作情况<br/>3. 进度10%', '0%#10%#未开工#施工中', 134, '2019-02-13 22:23:21', 1);
INSERT INTO `worklog` VALUES (47, '进度更新至百分之二十五', '10%#25%#施工中#施工中', 134, '2019-02-14 22:24:27', 1);
INSERT INTO `worklog` VALUES (48, 'Progress Updated', '25%#50%#施工中#施工中', 134, '2019-02-15 22:34:17', 1);
INSERT INTO `worklog` VALUES (49, 'UPDATE', '50%#75%#施工中#施工中', 134, '2019-02-16 23:10:06', 1);
INSERT INTO `worklog` VALUES (50, 'NOTHING', '75%#75%#施工中#施工中', 134, '2019-02-16 23:13:47', 1);
INSERT INTO `worklog` VALUES (51, 'TEST', '75%#75%#施工中#施工中', 134, '2019-02-16 23:23:19', 1);
INSERT INTO `worklog` VALUES (52, 'START', '0%#10%#未开工#施工中', 138, '2019-03-19 23:46:24', 1);
INSERT INTO `worklog` VALUES (53, 'NOTHING', '75%#75%#施工中#施工中', 134, '2019-02-16 01:53:07', 1);
INSERT INTO `worklog` VALUES (54, 'UPDATE', '10%#20%#施工中#施工中', 138, '2019-03-20 02:08:42', 1);
INSERT INTO `worklog` VALUES (55, 'UPDATE', '10%#25%#施工中#施工中', 128, '2019-01-04 02:37:49', 1);
INSERT INTO `worklog` VALUES (56, 'FINISHED', '90%#100%#施工中#已完工', 115, '2019-02-20 02:39:51', 1);
INSERT INTO `worklog` VALUES (57, '5th Update', '25%#25%#施工中#施工中', 128, '2019-01-05 02:44:56', 1);
INSERT INTO `worklog` VALUES (58, 'Make up 4th', '25%#25%#施工中#施工中', 128, '2019-01-04 02:45:38', 1);
INSERT INTO `worklog` VALUES (59, '提前开工', '0%#10%#未开工#施工中', 155, '2019-05-30 10:13:07', 1);
INSERT INTO `worklog` VALUES (60, '进度更新', '10%#25%#施工中#施工中', 155, '2019-05-31 10:14:37', 1);
INSERT INTO `worklog` VALUES (61, '进度更新', '25%#50%#施工中#施工中', 155, '2019-06-01 10:15:42', 1);
INSERT INTO `worklog` VALUES (62, '进度更新', '50%#80%#施工中#施工中', 155, '2019-06-02 10:16:52', 1);
INSERT INTO `worklog` VALUES (63, '完工了', '80%#100%#施工中#已完工', 155, '2019-06-03 10:17:38', 1);
INSERT INTO `worklog` VALUES (64, '如期开工', '0%#10%#未开工#施工中', 156, '2019-06-06 10:32:30', 1);
INSERT INTO `worklog` VALUES (65, '第四天', '10%#85%#施工中#施工中', 156, '2019-06-09 10:34:05', 1);
INSERT INTO `worklog` VALUES (66, '延迟开工一天', '0%#20%#未开工#施工中', 157, '2019-06-12 10:37:17', 1);
INSERT INTO `worklog` VALUES (67, '按时完成', '20%#100%#施工中#已完工', 157, '2019-06-16 10:43:09', 1);
INSERT INTO `worklog` VALUES (68, '工作汇报补登8号', '85%#50%#施工中#施工中', 156, '2019-06-08 10:46:17', 1);
INSERT INTO `worklog` VALUES (69, '补登7号', '50%#30%#施工中#施工中', 156, '2019-06-07 11:47:16', 1);
INSERT INTO `worklog` VALUES (70, '补登8号', '50%#60%#施工中#施工中', 156, '2019-06-08 11:53:10', 1);
INSERT INTO `worklog` VALUES (71, '补登7号', '40%#40%#施工中#施工中', 156, '2019-06-07 11:54:16', 1);
INSERT INTO `worklog` VALUES (72, '进度更新', '60%#90%#施工中#施工中', 156, '2019-06-09 11:55:30', 1);
INSERT INTO `worklog` VALUES (73, '补登8号', '75%#75%#施工中#施工中', 156, '2019-06-08 11:56:23', 1);

SET FOREIGN_KEY_CHECKS = 1;
