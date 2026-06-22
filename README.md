# RISC-V Linux 嵌入式实践课程

在 RISC-V Linux 开发板上，用 **RuyiSDK** 和 **C 语言** 做嵌入式应用。课程用两个小项目练手，最后做一个能演示的综合大项目。

## 查看课程大纲

**浏览器打开（分享用这个链接）：**

https://raw.githubusercontent.com/EnzoDing-rgb/riscv-embedded-course/master/docs/CourseOutline.html

仓库内路径：[`docs/CourseOutline.html`](docs/CourseOutline.html)

本地 clone 后也可：

```bash
git clone https://github.com/EnzoDing-rgb/riscv-embedded-course.git
cd riscv-embedded-course
./start.sh   # 浏览器打开 http://127.0.0.1:8765/
```

## 三个项目做什么

| 阶段 | 一句话 |
|------|--------|
| **实验 1** | 按配置文件里的温度上下限控风扇（写好的规则，不用模型）：超过上限开风扇，低于下限关风扇。 |
| **实验 2** | 手机发指令，远程开关板子上的 LED。 |
| **综合项目** | 把实验 1、2 合成一个监控盒；板载小模型根据最近温度走势判「环境异常」时，板上 LED 亮红灯、风扇加档，手机 MQTT App 收到一条告警消息——三项同时发生。 |

综合项目里的模型在**电脑上训练**，训练好后把权重拷到开发板；开发板上的 C 程序负责**运行模型、读传感器、控风扇和灯**。

## 课程结构

| 阶段 | 内容 |
|------|------|
| ch01–02 | 开发环境、交叉编译、Makefile |
| ch03 | GPIO、UART、温湿度传感器、PWM |
| **实验 1** | 温度阈值控制风扇 |
| ch04–05 | 文件与配置、日志、MQTT 联网 |
| **实验 2** | 手机 MQTT 远程控灯 |
| ch06 | 多线程与任务分工 |
| **综合项目** | 整合以上模块 + 温度走势异常检测 |

## 目录

```
riscv-embedded-course/
├── README.md
├── start.sh
└── docs/
    ├── CourseOutline.html   # 完整大纲（术语表、章节、物料等）
    ├── index.html           # 同 CourseOutline.html
    └── archive/             # 历史草案
```
