/*
 Navicat Premium Data Transfer

 Source Server         : 林枫
 Source Server Type    : MySQL
 Source Server Version : 90000 (9.0.0)
 Source Host           : localhost:3306
 Source Schema         : yolo_detect

 Target Server Type    : MySQL
 Target Server Version : 90000 (9.0.0)
 File Encoding         : 65001

 Date: 14/01/2025 16:46:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for camerarecords
-- ----------------------------
DROP TABLE IF EXISTS `camerarecords`;
CREATE TABLE `camerarecords`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `weight` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `conf` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `out_video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of camerarecords
-- ----------------------------
INSERT INTO `camerarecords` VALUES (44, 'helmet_best.pt', '0.56', 'admin', '2025-01-14 16:42:13', 'http://localhost:9999/files/3e5de50b1e9f4510b63f7f46ddb511e4_output.mp4');

-- ----------------------------
-- Table structure for imgrecords
-- ----------------------------
DROP TABLE IF EXISTS `imgrecords`;
CREATE TABLE `imgrecords`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `input_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `out_img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `confidence` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `all_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `conf` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `weight` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of imgrecords
-- ----------------------------
INSERT INTO `imgrecords` VALUES (101, 'http://localhost:9999/files/480305a08a0a4cb8858f68569b7df328_000000.jpg', 'http://localhost:9999/files/5a89df758a8f4bf185ab206556eb2966_result.jpg', '[\"94.19%\"]', '2.880秒', '0.29', 'helmet_best.pt', 'admin', '2025-01-14 16:40:29', '[\"helmet\"]');
INSERT INTO `imgrecords` VALUES (102, 'http://localhost:9999/files/9725c617d4b14cd6a5a14e640e259950_000009.jpg', 'http://localhost:9999/files/c84cbf7c2e99485293314c3bbfadc7d8_result.jpg', '[\"91.94%\", \"85.94%\", \"85.35%\", \"81.84%\", \"73.39%\"]', '0.240秒', '0.29', 'helmet_best.pt', 'admin', '2025-01-14 16:40:39', '[\"helmet\", \"without helmet\", \"without helmet\", \"helmet\", \"without helmet\"]');
INSERT INTO `imgrecords` VALUES (103, 'http://localhost:9999/files/419faa1b362f407d81e5b1195bcf5d46_part2_001157.jpg', 'http://localhost:9999/files/e369a930384146b9ad180a83f9b4da50_result.jpg', '[\"91.11%\", \"90.38%\"]', '0.270秒', '0.29', 'helmet_best.pt', 'admin', '2025-01-14 16:40:48', '[\"helmet\", \"helmet\"]');
INSERT INTO `imgrecords` VALUES (104, 'http://localhost:9999/files/8d04924fcc02485693244b2e677d8f49_PartB_00128.jpg', 'http://localhost:9999/files/f02e803bcd4d448d8fc608ba7386f218_result.jpg', '[\"86.77%\", \"83.15%\", \"82.62%\", \"82.18%\", \"80.32%\", \"78.81%\", \"77.25%\"]', '0.266秒', '0.29', 'helmet_best.pt', 'admin', '2025-01-14 16:40:53', '[\"without helmet\", \"without helmet\", \"without helmet\", \"without helmet\", \"without helmet\", \"without helmet\", \"without helmet\"]');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Table \'.\\demo\\user\' is marked as crashed and should be repaired' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'admin', '张三', '男', '123@qq.com', '1234567889', 'admin', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', NULL);
INSERT INTO `user` VALUES (2, '123', '123', '张三', '男', '123@qq.com', '1234567889', 'common', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', NULL);

-- ----------------------------
-- Table structure for videorecords
-- ----------------------------
DROP TABLE IF EXISTS `videorecords`;
CREATE TABLE `videorecords`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `input_video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `out_video` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `start_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `conf` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `weight` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of videorecords
-- ----------------------------
INSERT INTO `videorecords` VALUES (71, 'http://localhost:9999/files/6d7fd11816ee4a6b90101283b98deab6_测试.mp4', 'http://localhost:9999/files/60485d94838c4aca9e68306a49b03d2f_output.mp4', 'admin', '2025-01-14 16:41:17', '0.51', 'helmet_best.pt');

SET FOREIGN_KEY_CHECKS = 1;
