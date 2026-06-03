# 基于YOLOv8改进的多场景火灾检测系统

本项目面向建筑、森林、室内、隧道等多场景火灾检测任务，在 YOLOv8s 基础上引入 CBAM 注意力模块，并将边界框回归损失由 CIoU 改为 MPDIoU。项目同时提供 Web 系统，支持图像、视频和摄像头实时检测，并记录检测历史。

## 项目结构

```text
.
├── yolo_fire_detection_flask/       # Flask 推理服务、训练脚本、数据集、模型权重
│   ├── data/fire_dataset/           # YOLO 格式火灾数据集
│   ├── predict/                     # 图像和视频预测封装
│   ├── weights/                     # baseline、CBAM、MPDIoU、CBAM+MPDIoU 权重
│   └── main.py                      # Flask API 服务
├── yolo_fire_detection_springboot/  # Spring Boot 后端，负责用户、文件、记录等业务
├── yolo_fire_detection_vue/         # Vue3 前端页面
└── yolo_detect.sql                  # MySQL 数据库表结构
```

## 数据集

数据集已放置在 `yolo_fire_detection_flask/data/fire_dataset` 目录下，采用 YOLO 标注格式，包含图像和标签两部分，目录结构如下：

```text
yolo_fire_detection_flask/data/fire_dataset/
├── data.yaml
├── images/
│   ├── train/
│   ├── val/
│   └── test/
└── labels/
    ├── train/
    ├── val/
    └── test/
```

本项目实验使用的数据集规模如下：

- 训练集：4509 张
- 验证集：501 张
- 测试集：557 张

类别如下：

- `fire_smoke`：火焰和烟雾混合
- `nofire_smoke`：只有烟雾
- `fire_nosmoke`：只有火焰

## 运行环境

- Python 3.8，PyTorch，Ultralytics，Flask，Flask-SocketIO，OpenCV，Requests
- JDK 1.8，Maven，Spring Boot 2.3.7
- MySQL 8/9
- Node.js >= 16，npm >= 7
- FFmpeg，视频检测结果转码时使用

## 启动步骤

1. 创建 MySQL 数据库并导入表结构：

```bash
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS yolo_detect DEFAULT CHARACTER SET utf8mb4;"
mysql -u root -p yolo_detect < yolo_detect.sql
```

2. 启动 Spring Boot 后端，默认端口为 `9999`：

```bash
cd yolo_fire_detection_springboot
mvn spring-boot:run
```

数据库连接配置位于 `yolo_fire_detection_springboot/src/main/resources/application.properties`，如本机 MySQL 用户名或密码不同，请先修改配置。

3. 启动 Flask 推理服务，默认端口为 `5000`：

```bash
cd yolo_fire_detection_flask
python main.py
```

4. 启动 Vue 前端，默认端口为 `8888`：

```bash
cd yolo_fire_detection_vue
npm install
npm run dev
```

浏览器访问前端地址后，可以在页面中选择模型权重、设置置信度阈值，并进行图像、视频或摄像头检测。

## 训练说明

数据集配置文件位于 `yolo_fire_detection_flask/data/fire_dataset/data.yaml`。复现实验时可使用 YOLOv8s 官方预训练权重，并参考以下训练参数：输入尺寸 `640x640`，训练轮次 `300`，批次大小 `24`，优化器 `SGD`，初始学习率 `0.01`，最终学习率 `0.0001`，Mosaic 概率 `0.5`。

```bash
cd yolo_fire_detection_flask
yolo detect train model=yolov8s.pt data=data/fire_dataset/data.yaml epochs=300 imgsz=640 batch=24 optimizer=SGD
```

## 已提供模型权重

- `1.YOLOv8s-CBAM-MPDIoU.pt`
- `2.YOLOv8s-CBAM.pt`
- `3.YOLOv8s-MPDIoU.pt`
- `4.YOLOv8s(baseline).pt`

实验中，CBAM+MPDIoU 改进模型的 mAP50 为 96.60%，mAP50-95 为 81.10%。
