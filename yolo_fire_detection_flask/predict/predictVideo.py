import os
import time
import cv2
import threading
import queue
from ultralytics import YOLO


class VideoPredictor:
    def __init__(self, weights_path, video_path, out_path, temp_output, conf=0.5, show=False):
        self.model = YOLO(weights_path)
        self.video_path = video_path
        self.conf = conf
        self.show = show
        self.out_path = out_path
        self.temp_output = temp_output

        # 打开视频文件
        self.cap = cv2.VideoCapture(self.video_path)
        if not self.cap.isOpened():
            raise ValueError(f"无法打开视频文件: {self.video_path}")

        # 获取视频属性
        self.width = int(self.cap.get(cv2.CAP_PROP_FRAME_WIDTH))
        self.height = int(self.cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
        self.fps = int(self.cap.get(cv2.CAP_PROP_FPS))

        # 视频写入器
        self.video_writer = cv2.VideoWriter(
            self.temp_output,
            cv2.VideoWriter_fourcc(*'XVID'),
            self.fps,
            (self.width, self.height)
        )

        # 帧队列（增大队列容量）
        self.frame_queue = queue.Queue(maxsize=100)

        # 是否完成标志
        self.finished = False

    def process_frame(self, frame):
        """处理单帧视频，返回处理后的帧"""
        results = self.model(frame, conf=self.conf)
        annotated_frame = results[0].plot()
        return annotated_frame

    def process_video(self):
        """读取并处理视频，生成处理后的视频帧"""
        try:
            while self.cap.isOpened():
                ret, frame = self.cap.read()
                if not ret:
                    self.finished = True
                    break

                # 处理单帧
                processed_frame = self.process_frame(frame)

                # 将处理后的帧写入队列用于实时显示
                ret, jpeg = cv2.imencode('.jpg', processed_frame)
                if ret:
                    try:
                        # 设置超时时间，避免阻塞
                        self.frame_queue.put(jpeg.tobytes(), timeout=0.1)
                    except queue.Full:
                        print("Frame queue is full, dropping frame.")

                # 将处理后的帧写入临时 AVI 文件
                self.video_writer.write(processed_frame)

        except Exception as e:
            print(f"处理视频时发生错误: {str(e)}")
        finally:
            # 无论是否发生错误，都确保资源被正确释放
            self.cap.release()
            self.video_writer.release()
            cv2.destroyAllWindows()

            # 检查 AVI 文件是否保存成功
            if os.path.exists(self.temp_output):
                print(f"AVI 临时文件已保存至 {self.temp_output}")
            else:
                print("AVI 临时文件保存失败！")

    def get_frame(self):
        """从队列中获取最新处理帧"""
        return self.frame_queue.get() if not self.frame_queue.empty() else None

    def is_finished(self):
        """检查视频处理是否完成"""
        return self.finished


if __name__ == '__main__':
    # 定义路径
    weights_path = "../weights/best.pt"  # 模型权重文件路径
    video_path = "../test.mp4"  # 输入视频路径
    out_path = "../output.mp4"  # 最终输出视频路径
    temp_output = "../temp_output.avi"  # 临时输出视频路径

    # 创建检测对象
    predictor = VideoPredictor(weights_path, video_path, out_path, temp_output, show=False)

    # 启动视频处理线程
    processing_thread = threading.Thread(target=predictor.process_video)
    processing_thread.start()

    # 实时获取处理后的帧
    while not predictor.is_finished():
        frame = predictor.get_frame()
        if frame:
            # 这里可以将帧数据传输到前端
            print("传输一帧数据到前端...")
        time.sleep(0.01)

    # 等待视频处理完成
    processing_thread.join()
    print("视频处理完成！")