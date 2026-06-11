# RISC-V 嵌入式 MLSys 课程

RISC-V Linux 开发板上的嵌入式 + 机器学习系统课程：ch01–07 平台与数据基础，ch08 Pre-train，ch09 Post-train，ch10 Inference。主线任务为 **MNIST 0–9 数字识别**，**板载 CPU 训练与推理**。

## 快速开始

```bash
git clone <repo-url>
cd riscv-embedded-course
./start.sh
```

浏览器打开 **http://127.0.0.1:8765/** 即课程大纲表格（`./start.sh` 会先释放端口再起服务）。

Remote-SSH：Cursor **Ports** 面板 → 8765 → Open in Browser。

停止预览：终端 `Ctrl+C`。

## 目录结构

```
riscv-embedded-course/
├── README.md
├── start.sh
└── docs/
    ├── CourseOutline.html   # 正式大纲（唯一主文档）
    └── old/                 # 归档
        └── README.md
```

## 课程主线

```
ch01–07  平台 / GPIO / UART / MNIST 数据 / 日志 / 线程
    ↓
ch08     Pre-train   板载 CPU 训练 tiny CNN（MNIST，80–90% acc）
ch09     Post-train  量化 / 剪枝 / QAT / 蒸馏 → int8
ch10     Inference   自写 int8 算子部署、profile、GPIO + UART 闭环
```
