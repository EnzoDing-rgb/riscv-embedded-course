# RISC-V 嵌入式系统与边缘推理 — 教学大纲

> **推荐教材**
>
> 1. David A. Patterson, John L. Hennessy — **《计算机组成与设计：硬件/软件接口 (RISC-V版)》** 原书第2版  
>    *Computer Organization and Design: The Hardware/Software Interface, RISC-V Edition*  
>    两位图灵奖得主撰写，RISC-V 领域首选教材，配套中国大学 MOOC 课程。
>
> 2. David Patterson, Andrew Waterman — **《RISC-V开放架构设计之道》**（中译本, 2024）  
>    *The RISC-V Reader: An Open Architecture Atlas*  
>    RISC-V 基金会核心成员撰写，深入指令集架构技术细节，理解 ISA 设计的必读之作。

```text
┌──────────────────── 8 周 × 15h — RuyiSDK 工具链全覆盖 ───────────────────────────────┐
│  W1–W2 【Linux PC】                W3–W4 【RISC-V Linux 板】  W5–W8 【PC + 板 完整流程】      │
│  RuyiSDK 环境 · 交叉编译           GPIO/I2C · 传感采集          TinyML 训/量化 → 推理    │
│  QEMU 仿真 · GDB 调试              ringbuf · shell · 数据流水线  环境监测 · 量化对比表    │
└────────────────────────────────────┴────────────────────────────────────────────────┘
        全班统一课题：环境监测 — I2C 温湿度窗口 → MLP 判正常/异常 → LED + shell
        ⚠ 训练/量化只在 PC；RISC-V 板只做采集 + 推理（见下「双机分工」）

正文结构：要答的问题 → 学完能力 / 课规 → 8 周总览表 → W1–W8 详述 → 边界与参考 → 附录
```

## 全班统一课题：环境监测

**8 周连续完成，无分支选修。**

| 阶段 | 做什么 | 课堂演示内容 |
|------|--------|----------------|
| W4 | I2C 温湿度 → 环形缓冲 → shell `print` / `dump` | 串口刷温湿度曲线 |
| W5–6 | 用采集窗口训 tiny MLP（**正常 / 异常环境**），PTQ → `weights.h` | PC 验证与参考输出一致 |
| W7–8 | 采样任务 + 推理任务；`infer` / `latency`；异常亮红灯 | 哈气、热风枪、捂板 → 灯变 + 串口出分类 |

**采样内容**：每隔固定间隔读 **温度 + 湿度**（可再加滑动平均），凑成一小段 **特征向量**（例如最近 N 次的 min/max/均值）喂给模型。  
**完成功能**：设备自行判断环境状态——正常亮绿灯，异常亮红灯并在 shell 打印置信度。功能限定为环境二分类，不涉及物体识别或语音任务。

**硬件（全班统一）**：RISC-V 开发板（推荐 [RuyiSDK 支持矩阵](https://github.com/ruyisdk/support-matrix) 中的 Lichee Pi 4A / Milk-V Meles / 同档次板卡，运行 Linux）+ I2C 温湿度（如 SHT30/AHT20）+ 1 颗 LED（异常指示）。无硬件板卡可用 QEMU 仿真。

---

## RuyiSDK 在课程中的角色

本课程由 **中国科学软件研究所（ISCAS）RuyiSDK 小组** 设计，RuyiSDK 是贯穿全课程的核心工具包：

| RuyiSDK 组件 | 何时用 | 作用 |
|-------------|--------|------|
| **Ruyi 包管理器** (`ruyi`) | W1–W8 | 一键安装/管理 GNU/LLVM 工具链、QEMU、调试器；创建虚拟开发环境 |
| **RuyiSDK IDE / VS Code 插件** | W1–W8 | 工程管理、交叉编译配置、远程调试 |
| **RISC-V Linux 板** | W3–W4, W7–W8 | 运行 Linux 的 RISC-V 开发板，提供完整 Linux 用户空间（GPIO/I2C/SPI） |
| **QEMU (via ruyi)** | W1–W2, W7 | 软件仿真：`ruyi install emulator/qemu` |
| **PLCT GNU/LLVM 工具链** | W1–W8 | 交叉编译器 + binutils，持续更新（GCC 15+ / LLVM 21+） |

**一句话**：学生装好 `ruyi`，就能获得全套 RISC-V 开发工具链——不再手工拼凑 GCC、OpenOCD、QEMU。

---

## 双机分工（必读）

本课有 **两台环境**，职责固定，不可互换：

| 环境 | 何时用 | 做什么 | 不做什么 |
|------|--------|--------|----------|
| **Linux PC**（x86_64 或 arm64 主机） | **W1–W2, W5–W6** | 安装 RuyiSDK、交叉编译、QEMU 仿真、GDB 调试；**Python + PyTorch** 训练与量化；导出 `weights.h` | ❌ 不直接操控外设（无 GPIO/I2C 物理接口） |
| **RISC-V Linux 板**（运行标准 Linux 发行版） | **W3–W4, W7–W8** | C 固件/用户态程序：传感器驱动、ringbuf、shell；**int8 推理**；GPIO/I2C 真外设 | ❌ 不安装 PyTorch；❌ 不在板上做反向传播训练 |

**数据怎么流**：

```text
  RISC-V 板 W4 采集 ──导出 CSV/日志──→  Linux PC W5 训练 + 量化
                                               │
                                               ↓ weights.h
  RISC-V 板 W7–W8 ←──scp/烧录含权重的程序─────  PC 上用 ref_inference.c 验证输出一致
```

**明确边界**：课上 **不要求** 在 RISC-V 板上用 C 复现 PyTorch 训练；若自选 on-device 训练，仅作课外加分，**不能替代** W5–W6 的 PC 训练与量化对比表。

---

**学时**：8 周 × 15 小时 = 120 小时  
**结构**：第 1–2 周 **RuyiSDK 环境 + 交叉编译基础** → 第 3–4 周 **RISC-V Linux 外设与数据采集** → 第 5–8 周 **边缘 AI 推理部署**  
**前提**：C 语言 + 计算机组成原理  
**硬件**：RISC-V 开发板（班内统一型号）；无硬件板卡可用 QEMU  
**工具**：Git、GNU Make、**RuyiSDK 包管理器**、PLCT GNU/LLVM 工具链、QEMU、GDB；**W5–W6 另需 Linux PC + PyTorch**

**课程性质**：**嵌入式系统工程课**（外设驱动、数据流水线、资源约束下的推理部署），以 **RuyiSDK 为统一工具入口**，降低环境搭建门槛，聚焦工程实践。RISC-V 计组/汇编是手段，不是目的。

---

## 课程要回答的问题

| 问题 | 本课怎么答 |
|------|------------|
| 学嵌入式能干嘛？ | 写 **传感采集与推理程序**：驱动、缓冲、数据处理流水线，为产品开发打基础 |
| RuyiSDK 帮我省了什么？ | 一条命令安装全部工具链+仿真器+IDE，**不再手工编译 GCC/binutils/OpenOCD** |
| 和计组/系统课差在哪？ | 强调 **外设时序、信号、驱动分层、实时与内存预算、功耗意识** — 而不是仅完成汇编实验 |
| 和纯 AI 课差在哪？ | 模型必须 **部署到实际硬件**：量化、静态内存、采样与推理并行 |
| 项目要硬核吗？ | ≥60% 自写；可接 AI，须能讲清驱动与推理边界 |
| Lab 要扎实吗？ | 手写 I2C 驱动、ringbuf、int8 推理循环、shell 控制台 |

**一句话**：培养能在 **RISC-V 设备** 上，借助 **RuyiSDK 工具链**，完成 **传感采集 + 边缘推理** 的嵌入式工程师。

---

## 学完你能干嘛

**第 4 周末（RuyiSDK + 数据采集段）**

- 用 **RuyiSDK** 搭建 RISC-V 交叉编译环境，管理工具链版本；用 **Git + Makefile** 管理工程  
- 在 RISC-V Linux 板上编写 GPIO/I2C 外设驱动（用户空间或内核模块）  
- 自写 **环形缓冲** 等嵌入式数据结构；搭建传感器→采集→存储数据流水线  
- 说清 **.text/.data/.bss/栈** 各放什么，能读链接脚本与 map 文件  
- 完成 **传感采集系统**（阶段项目）

**第 8 周末（+ 推理段）**

- tiny 模型训练、量化/剪枝，与 PC 参考输出对比验证  
- RISC-V 设备上 int8 推理部署，`infer` / `latency`  
- 期末 **环境监测**：温湿度采集 + 异常检测 + 量化对比数据  

---

## 课规

| 时段 | 要求 |
|------|------|
| 第 1–2 周 | RuyiSDK 环境搭建、交叉编译、QEMU 仿真 **关键路径手写** |
| 第 3–4 周 | 外设驱动、ringbuf、数据采集流水线 **自写 ≥60%** |
| 第 5–8 周 | 与参考输出对齐；≥1 个 int8 算子自写；第 6 周交量化对比表；第 7–8 周板上可演示 |
| 期末 | ≥60% 自写；作业须能说明驱动层与推理层接口 |

---

## 总览：8 周 × 15h

| 周 | 段 | 主题 | Lab 产出 |
|---|-----|------|----------|
| **1** | RuyiSDK | RISC-V 生态、RuyiSDK 安装与初探 | `ruyi` 环境可用 + 首个 QEMU 程序 + 内存图 |
| **2** | RuyiSDK | 交叉编译、工具链管理、GDB 调试 | Makefile 工程 + 交叉编译 + QEMU/GDB 截图 |
| **3** | 采集 | RISC-V Linux 外设编程（GPIO/I2C/SPI） | GPIO 点灯 + I2C 扫描传感器 |
| **4** | 采集 | 传感器驱动、ringbuf、数据流水线、**阶段项目** | 温湿度采集 + ringbuf + shell 控制台 |
| **5** | 推理 | TinyML、内存预算、训练、入门 PTQ | `weights.h` + PC `ref_inference.c` |
| **6** | 推理 | 量化 / 剪枝 | 对比表 + 报告 |
| **7** | 推理 | RISC-V 板上推理部署、采样—推理流水线 | 板上 `infer` / `latency` |
| **8** | 推理 | **环境监测** 集成 + 答辩 | 异常触发 LED + `infer` 演示 |

每周：理论 ~4h，Lab ~8h，复盘 ~3h。W1–W2 可用 QEMU；W3 起用实际开发板；W5–W6 先在 PC 验证参考输出，W7 再上板。

---

# 第一部分：第 1–2 周（RuyiSDK 环境与交叉编译）

**本段目标**：掌握 **RuyiSDK 工具链安装与管理**、RISC-V 交叉编译、QEMU 仿真与 GDB 调试。  
**通过标准**：`ruyi` 环境正常运行，可交叉编译并在 QEMU 中运行/调试 C 程序。

---

## 第 1 周：RISC-V 生态与 RuyiSDK 环境搭建（15h）

### 学什么

- RISC-V ISA 概览：RV64I 基础指令、调用约定、寄存器模型 — 建立 ISA 直觉（辅助）  
- **RuyiSDK 全景**：包管理器 (`ruyi`) + IDE + 社区生态  
- 安装方式：预编译二进制 / pip / 系统包管理器（Arch `yay` / Gentoo overlay）  
- 配置：切换国内镜像源 `mirror.iscas.ac.cn`、`ruyi update`  
- **嵌入式工程习惯**：Git 分支与提交；GNU Make 组织构建  
- RV64I 汇编小练（Ripes / Compiler Explorer 辅助理解）  
- C 程序在 QEMU 用户模式下运行（`riscv64-linux-gnu-gcc → qemu-riscv64`）

### 为什么

RuyiSDK 是统一工具入口——以往学生花 2–3 天手工编译工具链，现在一条命令搞定。本周围绕「装好 `ruyi`、跑通第一个程序」建立对 RISC-V 开发全流程的体感。

### Lab 1

1. 安装 `ruyi`，配置镜像源，`ruyi list` 浏览可用包  
2. 编写 C 程序 (`hello.c`)，用 RuyiSDK GNU 工具链交叉编译，QEMU 运行  
3. Ripes 汇编小练（可选）；RISC-V 内存段速写（text/data/bss/stack）  
4. 交付：`ruyi version` 截图 + Makefile 工程 + QEMU 运行截图 + 内存段地址范围表

---

## 第 2 周：RuyiSDK 工具链管理与交叉编译（15h）

### 学什么

- **交叉编译深入**：host vs target、tuple 命名（`riscv64-unknown-linux-gnu`）、sysroot  
- **`ruyi install`**：安装 GNU/LLVM 工具链、QEMU 模拟器  
  - `toolchain/gnu-plct`（GCC 15.1+ + binutils 2.45+ + glibc 2.40+）  
  - `toolchain/llvm-plct`（LLVM 21+，含 RVP 扩展支持）  
  - `emulator/qemu-user-riscv-xthead`
- **`ruyi venv`**：创建虚拟开发环境，锁定工具链版本 → 可复现构建  
- 链接脚本入门：sections 布局、entry point、`objdump -h` / `readelf` 对照  
- GDB + QEMU 远程调试：断点、单步、寄存器/内存查看  
- 编译优化选项（`-O0/-O2/-Os`）对代码体积与性能的影响  

### 为什么

工业项目要求 **可复现构建** + **版本锁定**。`ruyi venv` 确保全班工具链版本一致，避免「我机器上能跑」问题。

### Lab 2

1. `ruyi install` 安装 GNU 工具链 + QEMU  
2. `ruyi venv` 创建项目虚拟环境，编写 Makefile（`CC`, `CFLAGS`, `LDFLAGS` 显式指定）  
3. 在 QEMU 中运行并 GDB 连接调试：设断点、单步、打印寄存器  
4. 读 `.map` 文件，标注 text/data/bss 边界；用 `objdump -h` 验证  
5. 交付：Makefile + `ruyi venv` 目录结构说明 + GDB 调试截图 + map 文件标注

---

# 第二部分：第 3–4 周（RISC-V Linux 外设与数据采集）

**本段目标**：在 RISC-V Linux 板上完成 **外设驱动 → 传感器采集 → ringbuf 缓冲 → shell 控制台** 数据流水线。  
**通过标准**：I2C 温湿度数据可通过 shell 命令实时查看、dump 历史记录。

**硬件环境**：RISC-V 开发板运行 Linux，通过 RuyiSDK 工具链交叉编译用户态程序部署到板上。

---

## 第 3 周：RISC-V Linux 外设编程（15h）

### 学什么

- RISC-V Linux 设备模型概述：sysfs、/dev、设备树（DT）角色  
- **GPIO 编程**：libgpiod / sysfs 接口 — 点灯、读按键  
- **I2C 从用户空间**：`/dev/i2c-N`、`ioctl`、SMBus 协议；扫描总线设备地址  
- **SPI**（讲授+选做）：`/dev/spidevN.M`、传输模式  
- 用户空间 vs 内核驱动：什么时候用 `/dev`，什么时候需要写 kernel module（简要对比）  
- 驱动分层思想：`hal_gpio` / `drv_i2c` / `app` 职责划分（即使在用户空间也保持分层习惯）

### 为什么

在 RISC-V Linux 板上开发外设驱动，比裸机 MMIO 更接近实际产品开发模式——用标准 Linux 接口，可移植、可调试、可复用。

### Lab 3

1. GPIO：libgpiod 点灯 + 按键读取  
2. I2C：扫描传感器地址，读取温湿度传感器寄存器（SHT30/AHT20 等班内统一型号）  
3. 交付：GPIO 亮灭视频/GIF + I2C 扫描结果截图 + 分层代码目录

---

## 第 4 周：传感器驱动、ringbuf 与数据流水线（15h）

### 学什么

- **I2C 温湿度传感器驱动**：读写寄存器、数据解析、错误处理  
- **环形缓冲**（独立 `ringbuf.c/h`，可移植、可单测）— 阶段项目核心数据结构  
- 采样率与缓冲深度、溢出策略（丢最旧 / 停采）  
- **数据流水线**：采集 → ringbuf → 格式输出（CSV/JSON 行）→ 存档  
- **Shell 控制台**：串口/UART 命令解析（`help`, `dump`, `print`, `rate`, `status`）  
- 嵌入式专题（讲授+短练）：  
  - 功耗意识：何时关传感器、降采样  
  - 可靠性：传感器超时、CRC 校验、复位恢复  
  - 量产调试：shell 命令设计、日志格式  
- **阶段项目**：W1–W3 集成

### Lab 4 + 阶段项目（环境监测 · 采集半环）

**固定路径**：I2C 温湿度（班内统一型号）→ **自写 ring buffer** → shell 周期 `print` / `dump`；按键改采样间隔。为 W5 攒「正常环境」数据；异常样本可 W5 用串口注入或现场制造。

**要求**：**自写 ring buffer 模块**（`ringbuf.c/h`）；扩展 shell ≥4 命令（含 `dump` / `rate` / `status`）；`hal` / `drv_i2c` / `app_shell` 分层清晰；自写 ≥60%。

**第 4 周末检查**：演示 `dump` 最近 N 次温湿度 + 说明缓冲深度与采样率关系。

---

# 第三部分：第 5–8 周（边缘推理部署）

**本段目标**：在 **第 1–4 周数据采集系统** 上部署 **自写 int8 推理**，完成从采集到推理的完整流程。  
**参考**：MIT 6.5940（TinyML）量化与 MCU 约束、[TinyML 综述](https://arxiv.org/abs/2403.19076) 系统–算法协同。

---

## 第 5 周：TinyML 与模型导出（15h）

> **运行环境：Linux PC（PyTorch + RuyiSDK 工具链）** — 本周 **不上板**；RISC-V 板仅提供 W4 已采集的数据文件。

| 主题 | 内容 |
|------|------|
| 边缘约束 | Flash/RAM/MACs 预算表；模型为 **目标设备** 而缩 |
| 训练 | 在 **Linux** 上用 PyTorch 训 **环境监测** tiny MLP（W4 导出的温湿度窗口 → 正常/异常） |
| PTQ 入门 | PC 上 per-tensor int8 → 生成 `weights.h` |
| 推理 | PC 上 `ref_inference.c` 作为 int8 参考实现；用 RuyiSDK 工具链编译验证 |

**Lab 5**：Linux 完成训练 + PTQ + ref C + 预算表；提交 `weights.h` 与数据说明。**本周不上板。**

---

## 第 6 周：量化与压缩（15h）

> **运行环境：量化与对比表在 Linux PC 完成**；**自写 C 算子**可在 PC 先通过参考输出验证，W7 再链入 RISC-V 工程。

- per-channel PTQ、校准、逐层误差；结构化剪枝 + 再 PTQ；QAT 简介（加分）  
- 推理实现：课内 **自写 C 算子**（PC 测通 → W7 上板）；CMSIS-NN / muRISCV-NN 类库作 **选学对照**

**Lab 6**：PC 上完成 Baseline / per-channel / 剪枝+PTQ；**对比表**（体积、精度、RAM、ms）+ 1 页报告。

---

## 第 7 周：RISC-V 板上推理部署（15h）

> **运行环境：RISC-V Linux 板** — 将 W5–W6 的 `weights.h` 与自写 int8 推理 **链入 W4 数据采集程序**，板上 **仅推理、不训练**。交叉编译通过 RuyiSDK 工具链完成。

- 静态内存部署：权重放 `.rodata`，激活 buffer 从栈/静态区分配  
- 采样任务 + 推理任务（多线程或协作式调度）  
- shell 扩展：`infer`、`latency`、`quant_info`  
- 板上 RAM/延迟实测；project 原型  

**交叉编译与部署命令（示例）**：
```bash
source ~/ruyi-venv/bin/activate
riscv64-unknown-linux-gnu-gcc -O2 -o env_sentinel main.c ringbuf.c mlp_infer.c weights.c -lpthread
scp env_sentinel user@milkv:/home/user/
```

---

## 第 8 周：环境监测 — 期末集成与答辩（15h）

1. 实际开发板：**自写 I2C 温湿度驱动** + **GPIO LED 告警** + int8 MLP 推理（for 循环可指认）  
2. 多任务：采集不停，周期性 `infer`；现场哈气/热风/捂板触发 **异常**  
3. 提交 W6 对比表 + 板上 `latency` + 1 页设计说明（特征窗口、采样率、量化取舍）  
4. 答辩 5 分钟：演示正常→异常灯变 + shell 输出  

**评分**：异常触发演示 30 / 采集—推理集成 25 / 代码与分层 20 / 量化对比表 15 / 稳定性与说明 10  

---

## 课程专注范围（边界说明）

本 8 周 **课上会教**：

- RuyiSDK 工具链：安装、管理、虚拟环境、交叉编译  
- RISC-V Linux 外设编程：GPIO、I2C、SPI、传感器驱动  
- 数据流水线：ringbuf、采集、存储、shell 控制台  
- 边缘推理：训练（PC）、量化/剪枝、RISC-V 板上 int8 部署  

**课上不讲、放在延伸课/自学**（需要可自行选修，不占本大纲课时）：

- 完整 **嵌入式 Linux 系统构建**：Buildroot/Yocto、内核模块、字符设备驱动框架（可参考 Bootlin、百问网）  
- **裸机编程**：MMIO 驱动、中断控制器（PLIC/CLINT）、OpenOCD 烧录 — 见 **附录 A：Advanced Track**  
- **完整 RTOS 产品级移植**（FreeRTOS+ 中间件栈）— 本课只讲模型与对比  
- 大模型训练与云端 MLOps  
- 自动 NAS / 大规模分布式训练  

**选学资源**（不考）：TinyMLedu、mcunet、micrograd、CMSIS-NN、muRISCV-NN；下节慕课对照。

---

## 与常见课程脉络（采纳 / 延伸）

| 来源 | 有用处 | 本课落地 | 不照搬 | 备注 |
|------|--------|----------|--------|------|
| **RuyiSDK**（[ruyisdk.org](https://ruyisdk.org/) / [ruyisdk.cn](https://ruyisdk.cn/)） | 统一工具入口 | **W1–W8** 全课程工具链管理 + 交叉编译 + IDE | — | **本课程特色**：不以 ARM 生态工具为默认，全程使用 ISCAS PLCT 维护的 RISC-V 工具链 |
| **Stanford CS107e**（[cs107e.github.io](https://cs107e.github.io/)） | 裸机 RISC-V 教学法 | **附录 A** Advanced Track 参考 | Mango Pi 作业/图形/键盘/网络 | 见附录 A 详细对照 |
| **MIT 6.5940 TinyML**（[efficientml.ai](https://efficientml.ai/)） | 资源约束下推理；剪枝；量化（PTQ/QAT） | **W5–W6** 主参考；**W7–W8** 仅约束与对比表 | LLM 压缩/部署 lab、NAS 全章、分布式训练 | W5：Flash/RAM/MACs 预算、模型为设备而缩。W6：per-channel PTQ、剪枝后再量化、体积–精度–延迟 tradeoff |
| Colorado **嵌入式软件与开发环境** | Git、Make、GCC、内存段、构建系统 | **W1–W2** | ARM/Linux 主机开发流 | 工程化构建系统讲解，与本课 RuyiSDK 互补 |
| Colorado **嵌入式软件与硬件架构** | 可移植 C、**环形缓冲** | **W4** | MSP432 平台作业 | ringbuf 专题 |
| Colorado **实时嵌入式系统** | 实时分析、RTOS、任务分配 | **W3–W4 讲授** + 延伸选学 | Linux RT、四门专项全做 | |
| Edge Impulse 嵌入式 ML | 采集→训练→部署流程 | **W5–8** 思路 | 云平台一键部署当作业 | 流程对齐；实现必须自写 int8 |

---

## 推理在嵌入式中的位置

```text
  I2C 温湿度 (W4 drv) ──→ 环形缓冲（最近 N 次）
        ↓ 特征窗口（均值/极差等）
  采样线程 ←→ 推理线程 (W7)
        ↓
  int8 MLP：正常 / 异常 (W7–W8)
        ↓
  LED 告警 + shell：infer / latency / status
```

---

## 参考资料

### 推荐教材与书籍

#### RISC-V 体系结构入门（必读）

| 书名 | 作者 | 出版年 | 说明 |
|------|------|--------|------|
| **《计算机组成与设计：硬件/软件接口 (RISC-V版)》** 原书第2版 | David A. Patterson, John L. Hennessy | 2020 | **首选教材**。两位图灵奖得主撰写，RISC-V 领域首选教材。配套中国大学 MOOC 课程。英文版 *Computer Organization and Design: The Hardware/Software Interface, RISC-V Edition* |
| **《RISC-V开放架构设计之道》** | David Patterson, Andrew Waterman | 2024（中译本） | RISC-V 基金会核心成员撰写，深入 ISA 技术细节。英文原版 *The RISC-V Reader: An Open Architecture Atlas* |

#### RISC-V 嵌入式实战

| 书名 | 作者 | 出版年 | 说明 |
|------|------|--------|------|
| **《RISC-V体系结构编程与实践》** 第2版 | 笨叔（奔跑吧Linux社区） | 2024 | 国内最受欢迎的 RISC-V 实战书，从指令集到内核移植，配套视频 |
| **《基于RISC-V架构的嵌入式系统开发》** | 李正军、李潇然 | 2025 | 基于 CH32 微控制器，覆盖中断/异常、最小系统设计 |
| **RISC-V Assembly Language Programming** | Stephen Smith (Apress) | 2024 | 专注汇编级编程，C 互操作，硬件交互 |

#### RISC-V 进阶与体系结构

| 书名 | 作者 | 出版年 | 说明 |
|------|------|--------|------|
| **Mastering RISC-V Computer Architecture** | Hugh Clark | 2025 | 深入流水线、缓存、内存子系统微架构设计 |
| **RISC-V Unlocked: A Practical Guide** | Phil P. Dasilva | 2025 | 跨软硬件边界，裸机编程、固件启动、RTOS、嵌入式 Linux |

#### 边缘 AI / TinyML

| 资源 | 说明 |
|------|------|
| **MIT 6.5940 TinyML**（[efficientml.ai](https://efficientml.ai/)） | W5–W6 核心参考，量化/剪枝/MCU 部署讲义 |
| **TinyML: Machine Learning with TensorFlow Lite** (Warden & Situnayake, O'Reilly) | TinyML 领域标准参考书 |
| **arXiv:2403.19076** | TinyML 综述，系统–算法协同 |

### 工具与在线资源

| 资源 | 用途 | 备注 |
|------|------|------|
| [RuyiSDK 官网](https://ruyisdk.org/) / [中文社区](https://ruyisdk.cn/) | 包管理器安装、文档、教程 | **全课核心工具** |
| [RuyiSDK support-matrix](https://github.com/ruyisdk/support-matrix) | 板卡选型 | 开课硬件选型参考 |
| [RuyiSDK VS Code 插件](https://marketplace.visualstudio.com/items?itemName=RuyiSDK.ruyisdk-vscode-extension) | IDE 集成 | 实验机房统一安装 |
| 开发板 SoC 手册 | MMIO、外设寄存器 | W3–W4 硬件真源 |
| Ripes / Compiler Explorer | RISC-V 汇编可视化 | W1 辅助理解 ISA |
| Bootlin / 百问网 | Linux 驱动延伸 | 8 周外选修 |
| lichee-rv-samples 等裸机例程 | 寄存器对照 | 附录 A Advanced Track 参考 |

本课主线：**RuyiSDK 工具链 → RISC-V Linux 外设与数据采集 → 边缘推理部署**，以 ISCAS RuyiSDK 为统一工具入口。

---

## 检查清单

**第 2 周末**：`ruyi venv` 可用；Makefile 交叉编译无警告；QEMU + GDB 通过。  
**第 4 周末**：驱动分层清楚；**ring buffer** 可演示 `dump`；能讲内存段与采样率。  
**第 8 周末**：曾与参考输出一致；板上 `infer` + 延迟；W6 对比表完成。

---

## 讲师备注

- 对外口径：**RISC-V 嵌入式课**，以 **RuyiSDK 为统一工具链**；计组是前置  
- RuyiSDK 推广：课前统一安装 `ruyi`（二进制/pip），配置 ISCAS 镜像源；禁止学生手工编译 GNU 工具链  
- RTOS/Linux：用 **1–2 学时讲授 + 延伸课预告** 回应工业缺口，避免整学期变纯系统课  
- 答辩：**驱动在哪层？采样率与缓冲？量化 tradeoff？推理 for 在哪？RuyiSDK 帮你省了什么？**  
- 实验机房 Linux 主机：预装 [RuyiSDK VS Code 插件](https://marketplace.visualstudio.com/items?itemName=RuyiSDK.ruyisdk-vscode-extension) + `ruyi` 包管理器  
- 无硬件板卡的学生：W1–W2 用 QEMU 用户模式；W3 起建议至少 2 人一块板；W7–W8 可用 QEMU 系统模式仿真推理（精度一致，延迟不同，答辩时注明）

---

# 附录 A：Advanced Track — RISC-V 裸机编程

> **说明**：以下内容为原课程第 1–4 周裸机固件部分，移至附录作为进阶选修。适合希望深入理解 MMIO、中断控制器、OpenOCD 烧录等底层机制的学生。**不作为 8 周主课考核内容。**

**前提**：完成主课 W1–W4（已掌握 RuyiSDK 工具链、交叉编译、Linux 外设编程）。  
**额外硬件**：需 JTAG 调试器 + 支持 OpenOCD 的 RISC-V 开发板。  
**工具**：RuyiSDK 裸机工具链（`riscv64-unknown-elf-`）+ OpenOCD + 串口。

---

## AT1：裸机 Bring-up、内存布局与 GPIO（~15h）

### 学什么

- RuyiSDK 裸机工具链：`riscv64-unknown-elf-gcc`、链接脚本手写  
- C 在嵌入式里的 **内存段**：`.text` / `.rodata` / `.data` / `.bss` / 栈 — 链接脚本与 `objdump -h` 对照  
- 启动流程：复位向量 → `_start` → `main`；BSS 清零、数据段拷贝  
- GPIO：手册寄存器点灯（MMIO），不用厂商闭源 HAL  
- OpenOCD 烧录与 GDB 调试

### Lab

1. 裸机 Makefile + 链接脚本，生成 `.elf`，`make flash` 烧录  
2. 开发板点灯（MMIO GPIO）；画启动流程图 + 内存段地址表  
3. 交付：工程 + 点灯视频 + 内存段标注

---

## AT2：MMIO、UART 与驱动分层（~15h）

### 学什么

- `volatile`、位域操作、MMIO 读写时序注意点  
- **自写 UART 驱动**（寄存器级）；发送/接收缓冲  
- 简易 **驱动分层**：`hal_gpio` / `drv_uart` / `app_shell` 职责划分  
- 表驱动 **shell**：固件调试与产测入口（工业常见手段）

### Lab

| 命令 | 行为 |
|------|------|
| `help` / `led` / `echo` / `peek` / `ms` | 串口命令行；`peek` 带地址白名单 |

交付：分层目录 + 串口日志；简短说明各层职责。

---

## AT3：中断、时间与实时行为（~15h）

### 学什么

- 异常/中断、PLIC/CLINT（按 SoC 手册）  
- **实时性**：中断延迟、ISR 禁忌、与主循环/任务分工  
- 定时器：tick、超时、软定时器思路  
- **协作式多任务**（课内手写实现）  
- **实时基础（讲授）**：周期任务、抖动、最坏情况延迟；FreeRTOS 任务/队列在业界的角色  
- 看门狗（可选加分）

> 实时系统理论（速率单调、Linux RT 扩展等）见选学慕课脉络，本附录只练「ISR 短、缓冲解耦」。

### Lab

秒表（定时器中断）；按键消抖 + 外部中断；双任务（采集打印 + LED）；交付：时序/ISR 分工说明（半页）。

---

## AT4：总线、传感与嵌入式集成（~15h）

### 学什么

- **I2C 或 SPI**：时序、寻址、读传感器寄存器 — 驱动手写（MMIO 位操作）  
- 模拟信号链入门：ADC 采样、简单滤波（滑动平均）  
- **环形缓冲**（独立 `ringbuf.c/h`）  
- 采样率与缓冲深度、溢出策略  
- **嵌入式专题（讲授+短练）**：功耗（睡眠/时钟门控）、可靠性（看门狗、复位原因）、量产调试（shell 命令设计）  
- 参考接线：DHT22 接线可参考 [RuyiSDK board-docs · DHT22](https://github.com/ruyisdk/board-docs/tree/main/Duo_S/Dht22)（固件须裸机 MMIO/I2C 自写）

### Lab + 阶段项目

**固定路径**：I2C 温湿度 → **自写 ring buffer** → shell 周期 `print` / `dump`；按键改采样间隔。

**要求**：自写 ring buffer 模块；shell ≥2 命令；`hal` / `drv_i2c` / `app_shell` 分层清晰；OpenOCD 烧录与串口日志。

---

## Advanced Track 与主课对照

| 主课（W1–W4） | Advanced Track（AT1–AT4） |
|--------------|--------------------------|
| RuyiSDK 包管理器 + venv | 裸机工具链 + 链接脚本手写 |
| Linux 用户空间 GPIO/I2C | MMIO 寄存器级 GPIO/I2C |
| libgpiod / /dev/i2c-N | volatile 位域 + 手册寄存器 |
| 多线程/进程 | 中断 + ISR + 协作调度 |
| RuyiSDK IDE / VS Code | OpenOCD + GDB 硬件调试 |
| Linux 运行环境 | 无 OS，裸机启动 |
| 内核处理传感器超时 | 自己写看门狗 + 复位恢复 |

**建议路径**：先完成主课 8 周 → 再选做 Advanced Track 1–2 个模块（推荐 AT1+AT2 或 AT1+AT3），体会「有 OS」和「无 OS」两种开发模式的差异。

---

## Advanced Track 参考资料

| 资源 | 用途 | 备注 |
|------|------|------|
| **Stanford CS107e**（[课程站](https://cs107e.github.io/)） | 裸机 RISC-V 教学法权威 | AT1–AT4 主要参考脉络 |
| 开发板 SoC 手册 | MMIO、中断、外设寄存器 | **唯一硬件真源** |
| 裸机例程（lichee-rv-samples 等） | 寄存器对照 | 须改写，不可整包提交 |
| [RuyiSDK board-docs](https://github.com/ruyisdk/board-docs) | 引脚接线参考 | 仅文档参考，固件自写 |

---

# 附录 B：RuyiSDK 快速安装参考

## 安装 ruyi 包管理器

```bash
# 方式一：预编译二进制（推荐）
wget https://mirror.iscas.ac.cn/ruyisdk/ruyi/tags/0.41.0/ruyi-0.41.0.amd64
chmod +x ./ruyi-0.41.0.amd64
sudo cp -v ./ruyi-0.41.0.amd64 /usr/local/bin/ruyi
ruyi version

# 方式二：pip 安装
pipx install ruyi

# 配置国内镜像源（中国大陆学生必做）
ruyi config set repo.remote "https://mirror.iscas.ac.cn/git/ruyisdk/packages-index.git"
ruyi update
```

## 常用命令速查

```bash
ruyi list                              # 浏览可用软件包
ruyi list --name-contains gnu          # 搜索 GNU 工具链
ruyi install toolchain/gnu-plct        # 安装 PLCT GNU 工具链
ruyi install emulator/qemu-user-riscv-xthead  # 安装 QEMU
ruyi venv --toolchain gnu-plct --emulator qemu riscv-dev ./my-project
source ./my-project/bin/activate       # 激活虚拟环境
```

## 推荐的 RISC-V 硬件平台

以下 RISC-V 开发板可运行标准 Linux 发行版，适合本课程使用，包括：
Lichee Pi 4A、Milk-V Meles、Lichee Cluster 4A、Lichee Console 4A、Lichee Book 4A、Milk-V Pioneer、Sophgo SG2044 SRD3、Beagle-Ahead、Huiwei Book 等。

板卡选型参考：[RuyiSDK support-matrix](https://github.com/ruyisdk/support-matrix)
