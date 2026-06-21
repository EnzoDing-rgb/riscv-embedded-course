# RISC-V Linux 嵌入式实践课程

RISC-V 开发板 · RuyiSDK · **C 语言** · 两个小项目 + 一个综合大项目（智能环境终端，含 PC 训练 / 板载推理）。

## 查看大纲

```bash
git clone <repo-url>
cd riscv-embedded-course
```

- 浏览器直接打开 [`docs/CourseOutline.html`](docs/CourseOutline.html)
- 或本地预览：`./start.sh` → http://127.0.0.1:8765/

## 课程结构（一览）

| 阶段 | 内容 |
|------|------|
| ch01–02 | RuyiSDK 环境、交叉编译、Makefile |
| ch03 | GPIO、UART、温湿度、PWM |
| **实验 1** | 温度阈值 → 风扇控制 |
| ch04–05 | 文件/配置/日志、MQTT |
| **实验 2** | 手机 MQTT 远程控灯 |
| ch06 | 线程与任务协同 |
| **综合项目** | 整合上述模块 + 时序异常检测（PC 训、板 C 推理） |

## 目录

```
riscv-embedded-course/
├── README.md
├── start.sh                 # 本地预览大纲
└── docs/
    ├── CourseOutline.html   # 课程全貌（主文档）
    ├── index.html           # → CourseOutline.html（start.sh 自动链接）
    └── archive/             # 历史草案（MNIST、KWS、旧拼盘大纲等）
```
