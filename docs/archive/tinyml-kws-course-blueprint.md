# RISC-V 嵌入式系统与边缘推理 — TinyML KWS 课程蓝图

> 历史设计文档。对标 MIT 6.5940 TinyML (MLPerf Tiny)，8 周全单板闭环：采集 → 训练 → 量化 → 推理部署。
>
> 此蓝图来自 `docs/outline.md`（commit `64d4fe3`），于 2026-06-11 被当前 CourseOutline.html 替代。保留作为 TinyML 方向的完整参考。

---

## 课程推荐教材

1. David A. Patterson, John L. Hennessy — **《计算机组成与设计：硬件/软件接口 (RISC-V版)》** 原书第2版
2. David Patterson, Andrew Waterman — **《RISC-V开放架构设计之道》**（中译本, 2024）

---

## 课程概览

```text
┌─────────────────── 8 周 × 15h — 全程单板 ──────────────────────────────┐
│  W1–W2 【工具链】      W3–W4 【外设与采集】    W5–W8 【训练到推理闭环】       │
│  交叉编译 · QEMU · GDB   I2C/I2S · 音频缓冲     numpy 训练 → int8 推理       │
│  ruyi 环境 · Makefile    shell · 数据流水线       量化对比 · KWS 控灯演示      │
└──────────────────────────────────────────────────────────────────────┘
        全班统一课题：语音关键词识别 — 麦克风 → KWS → 关键词 → LED 控灯
        ⚠ 全部采集、训练、量化、推理在同一块 RISC-V Linux 板上完成
```

**学时**：8 周 × 15 小时 = 120 小时  
**前提**：C 语言 + 计算机组成原理  
**硬件**：RISC-V 开发板运行 Linux（推荐 Lichee Pi 4A / Milk-V Meles）+ I2S 数字麦克风（INMP441/SPH0645；无 I2S 可用 USB 麦克风）+ 1 颗 LED；无板可用 QEMU  
**工具**：`ruyi` 包管理器、PLCT GNU/LLVM 工具链、QEMU、GDB、Git、GNU Make、Python + numpy

**课程性质**：嵌入式系统工程课。以 RuyiSDK 为统一工具入口，在 RISC-V Linux 板上完成外设驱动、音频采集、tiny KWS 模型训练与 int8 推理部署。计组/汇编是手段，不是目的。

---

## 课程要回答的问题

| 问题 | 答案 |
|------|------|
| 学嵌入式能干嘛？ | 写传感采集与推理程序：驱动、缓冲、音频/传感器数据处理流水线 |
| RuyiSDK 省了什么？ | 一条命令装全部工具链，不再手工编译 GCC/binutils/OpenOCD |
| 和计组课差在哪？ | 强调外设时序、驱动分层、实时与内存预算、功耗意识 |
| 和 AI 课差在哪？ | 模型必须部署到实际硬件：量化、静态内存、采集与推理并行 |
| 项目要求？ | 手写音频采集驱动、ringbuf、int8 推理循环、shell 控制台；自写 ≥60% |

---

## 单板全流程（三阶段）

全部内容在同一块 RISC-V Linux 板上完成。tiny KWS 模型（DS-CNN，< 20K 参数）用 Python + numpy 在板上训练，不需要 GPU、不需要 x86、不需要机器间传数据。

### 阶段一：预训练准备（W1–W4）

| 阶段 | 在板上做什么 |
|------|-------------|
| W1–W2 | `ruyi` 装工具链；交叉编译或本地编译；QEMU/GDB 调试 |
| W3–W4 | GPIO/I2C 外设基础；I2S 麦克风驱动；音频 ringbuf；shell 控制台 |

**第 4 周末**：用 `ruyi` 管理 RISC-V 工具链；Linux 用户空间 GPIO/I2C 驱动；音频采集与 ringbuf；说清 .text/.data/.bss/栈的内存布局；完成音频采集系统。

### 阶段二：训练与后训练（W5–W6）

| 阶段 | 在板上做什么 |
|------|-------------|
| W5 | Python + numpy 训练 KWS（DS-CNN）；MFCC 预处理；int8 量化；导出 `weights.h` |
| W6 | per-channel PTQ、校准、逐层误差分析；结构化剪枝 + 再量化；自写 int8 C 推理算子 |

**第 6 周末**：Baseline / per-channel / 剪枝+PTQ 三组对比表（体积、精度、RAM、ms）+ 1 页报告。

### 阶段三：推理部署（W7–W8）

| 阶段 | 在板上做什么 |
|------|-------------|
| W7–W8 | C 程序读 `weights.h` → int8 推理 → 检测到关键词 → LED 亮灭/变色 |

**第 8 周末**：在 RISC-V 板上独立完成 KWS 模型训练、MFCC 预处理、int8 量化、C 推理部署；能现场演示语音指令控制 LED。

### 数据流（全程板本地，零跨机传输）

```text
  W4 麦克风采集 → 音频 ringbuf（板本地）
              ↓
  W5 同板 Python 读音频 → MFCC → 训练 DS-CNN → 量化 → 导出 weights.h
              ↓
  W7 同板 C 程序：麦克风 → MFCC → int8 KWS → 匹配关键词 → LED 动作
```

无硬件板卡的学生用 QEMU + 预录音频文件注入模拟，训练与推理逻辑完全一致。

---

## 课规

| 时段 | 要求 |
|------|------|
| W1–W2 | 工具链环境搭建、交叉编译、QEMU 仿真关键路径手写 |
| W3–W4 | 外设驱动、音频 ringbuf、数据采集流水线自写 ≥60% |
| W5–W8 | ≥1 个 int8 算子自写（含 MFCC 或卷积）；W6 交量化对比表；W7–W8 板上可演示 |
| 期末 | 自写 ≥60%；能说明驱动层与推理层接口 |

---

## 8 周详细设计

### 第 1 周：RISC-V 生态与开发环境（15h）

- RISC-V ISA 概览：RV64I 指令、调用约定、寄存器模型
- RuyiSDK：`ruyi` 包管理器 + IDE + PLCT 工具链生态
- 安装 `ruyi`（预编译二进制 / pip），配镜像源 `mirror.iscas.ac.cn`
- Git 分支提交；GNU Make 组织交叉编译
- RV64I 汇编小练（Ripes 辅助）；C 程序 → QEMU 用户模式运行
- 内存段速写：`.text` / `.rodata` / `.data` / `.bss` / 栈

**Lab 1**：装 `ruyi` → 浏览包 → 交叉编译 hello.c → QEMU 运行 → 交付 Makefile + 内存段地址表 + 截图。

### 第 2 周：交叉编译与调试（15h）

- 交叉编译：host vs target、tuple（`riscv64-unknown-linux-gnu`）、sysroot
- `ruyi install toolchain/gnu-plct`（GCC 15+） / `toolchain/llvm-plct`（LLVM 21+）
- `ruyi venv` 创建虚拟环境，锁定工具链版本
- 链接脚本入门：section 布局、entry point；`objdump -h` / `readelf` 对照
- GDB + QEMU 远程调试：断点、寄存器、内存查看
- 编译优化选项（-O0/-O2/-Os）对体积与性能影响

**Lab 2**：`ruyi venv` 创建项目 → Makefile（显式 CC/CFLAGS/LDFLAGS）→ QEMU + GDB 调试 → map 文件标注 text/data/bss。

### 第 3 周：RISC-V Linux 外设编程（15h）

- Linux 设备模型：sysfs、/dev、设备树角色
- GPIO：libgpiod / sysfs — LED 点灯、按键读取（为 W8 控灯打基础）
- I2C 用户空间：`/dev/i2c-N`、`ioctl`、SMBus 协议
- I2S 简介（讲授）：BCLK/LRCLK/DIN 引脚、ALSA 设备模型（为 W4 做铺垫）
- 用户空间 vs 内核驱动对比
- 驱动分层：`hal_gpio` / `drv_audio` / `app` — 保持分层习惯

**Lab 3**：libgpiod LED 点灯/闪灯 → I2C 扫描总线设备 → 交付分层代码目录 + 截图。

### 第 4 周：麦克风驱动、音频缓冲与数据流水线（15h）

- I2S 麦克风驱动（INMP441/SPH0645）：ALSA 用户空间录音（`arecord` / `snd_pcm_readi`）
- USB 麦克风备选路径（`pyaudio` / ALSA，无 I2S 引脚时）
- **环形缓冲**（独立 `ringbuf.c/h`，存原始 PCM 帧）— 核心数据结构
- 采样率（16kHz）与缓冲深度、溢出策略（丢最旧/停采）
- 数据流水线：录音 → ringbuf → 导出 WAV/CSV → 存档
- Shell 控制台：`record`（采 N 秒）/ `play`（回放）/ `dump`（统计）/ `rate`（改采样率）
- 专题：实时音频链路延迟、DMA 概念、量产调试

**Lab 4 + 阶段项目**：I2S 麦克风（或 USB mic）→ 自写 ringbuf → shell 录音/回放/统计。要求 ringbuf 模块独立、shell ≥4 命令、分层清晰、自写 ≥60%。

### 第 5 周：KWS 训练与模型导出 — 预训练（15h）

**全部在 RISC-V Linux 板上完成。对标 MIT 6.5940 Lab 1 (Keyword Spotting)。**

- 边缘约束：Flash/RAM/MACs 预算表
- **MFCC 预处理**：在板上用 Python + numpy 提取梅尔频率倒谱系数（40 维 × 10 帧窗口）
- **数据集**：学生每人录 50 条/关键词 → 全班共建；Google Speech Commands 子集作预训练参考
- **模型**：tiny DS-CNN（depthwise separable CNN），参数量 < 20K
- PTQ 入门：per-tensor int8 量化 → 导出 `weights.h`
- 生成参考推理输出（numpy 浮点前向结果作为验证基准）

**Lab 5**：板上完成录音 → MFCC → 训练 DS-CNN → PTQ → 导出 `weights.h` + 预算表。提交训练收敛曲线与混淆矩阵。

### 第 6 周：量化与压缩 — 后训练（15h）

**全部在 RISC-V Linux 板上完成。**

- per-channel PTQ、校准、逐层误差分析
- 结构化剪枝 + 再量化
- QAT 简介（加分）
- 自写 int8 C 推理算子（含 MFCC 特征提取 + DS-CNN 前向；先在板上编译验证 → W7 链入采集程序）
- CMSIS-NN / muRISCV-NN 作选学对照

**Lab 6**：Baseline / per-channel / 剪枝+PTQ 三组对比表（体积、精度、RAM、ms）+ 1 页报告。

### 第 7 周：板上 KWS 推理部署 — 推理（15h）

**在 RISC-V Linux 板上链入 W5–W6 产出的 `weights.h` 和 C 推理算子。**

- 静态内存：权重放 `.rodata`，激活 buffer 和 MFCC 中间量从栈/静态区分配
- 多线程：音频采集线程 + KWS 推理线程（或协作调度）
- Shell 扩展：`listen`（持续监听）/ `infer`（单次推理）/ `latency` / `quant_info`
- 板上实测 RAM 占用与推理延迟（目标 < 10ms）

交叉编译：`riscv64-unknown-linux-gnu-gcc -O2 main.c ringbuf.c mfcc.c kws_infer.c weights.c -lpthread -lasound`

### 第 8 周：KWS 控灯 — 集成与答辩（15h）

1. 实际开发板：麦克风实时监听 → MFCC → int8 KWS → 关键词匹配
2. 检测到"开"→ LED 亮；"关"→ LED 灭；"闪"→ LED 闪烁；"换"→ 颜色切换
3. 多线程：音频采集不停，周期 `infer`；shell 显示最近检测结果与置信度
4. 提交 W6 对比表 + 板上 `latency` + 1 页设计说明（MFCC 参数、模型架构、量化取舍）
5. 答辩 5 分钟：现场喊关键词 → LED 响应 + shell 输出置信度

**评分**：KWS 控灯演示 30 / 采集-推理集成 25 / 代码分层 20 / 量化对比表 15 / 稳定性与说明 10

---

## 全班统一课题：语音关键词识别控灯

8 周连续完成，无分支选修。对标 MIT 6.5940 Keyword Spotting lab（MLPerf Tiny 基准）。

| 阶段 | 做什么 | 演示内容 |
|------|--------|----------|
| W4 | I2S 麦克风采音频 → ringbuf → shell `record`/`play`/`dump` | 串口出音频波形统计 |
| W5–6 | MFCC 预处理 → 训 DS-CNN → PTQ → `weights.h` | 训练收敛曲线 + 混淆矩阵 |
| W7–8 | 实时麦克风 → MFCC → int8 KWS → 匹配关键词 → LED | 喊"开"→灯亮、"关"→灯灭 |

**关键词集合**（4 个，可扩展）："开"（亮灯）、"关"（灭灯）、"闪"（LED 闪烁）、"换"（切换颜色，若有多色 LED）。

**模型**：tiny DS-CNN（depthwise separable CNN），MFCC 输入 40×10，参数量 < 20K，int8 推理 < 10ms。  
**数据**：学生每人录 50 条/词 → 全班共建数据集；也可用 Google Speech Commands 子集做预训练。

---

## 检查清单

- **W2 末**：`ruyi venv` 可用；Makefile 交叉编译无警告；QEMU + GDB 通过
- **W4 末**：驱动分层清楚；音频 ringbuf 可演示 `record`/`dump`；能讲内存段与采样率
- **W8 末**：板上实时 KWS + LED 控灯可演示；W6 量化对比表完成

---

## 课程边界

**课上会教**：`ruyi` 工具链、RISC-V Linux 外设（GPIO/I2C/SPI/I2S）、音频采集与 ringbuf 流水线、MFCC 特征提取、DS-CNN 训练与 int8 量化部署。

**课上不讲**（可选修，不占课时）：
- 嵌入式 Linux 系统构建（Buildroot/Yocto）、内核模块开发（参考 Bootlin/百问网）
- 裸机编程：MMIO 驱动、中断控制器、OpenOCD — 见附录 A
- 完整 RTOS 移植、大模型训练/云端 MLOps、NAS、端到端 ASR（CTC/RNN-T）

**选学资源**（不考）：TinyMLedu、mcunet、micrograd、CMSIS-NN、muRISCV-NN。

---

## 参考资源

### 教材

| 书名 | 作者/年份 | 用途 |
|------|----------|------|
| 《计算机组成与设计 (RISC-V版)》原书第2版 | Patterson & Hennessy, 2020 | 首选教材 |
| 《RISC-V开放架构设计之道》 | Patterson & Waterman, 2024 | ISA 深入 |
| 《RISC-V体系结构编程与实践》第2版 | 笨叔, 2024 | 嵌入式实战 |
| RISC-V Assembly Language Programming | Stephen Smith (Apress), 2024 | 汇编编程 |
| Mastering RISC-V Computer Architecture | Hugh Clark, 2025 | 体系结构进阶 |
| RISC-V Unlocked | Phil P. Dasilva, 2025 | 裸机/RTOS/Linux 全栈 |
| TinyML (Warden & Situnayake, O'Reilly) | 2019 | TinyML 标准参考 |

### 在线资源

| 资源 | 用途 |
|------|------|
| [RuyiSDK](https://ruyisdk.org/) / [社区](https://ruyisdk.cn/) | 全课核心工具 |
| [RuyiSDK support-matrix](https://github.com/ruyisdk/support-matrix) | 板卡选型 |
| [MIT 6.5940 TinyML](https://efficientml.ai/) | KWS 量化/剪枝/MCU 部署（W5–W6 主参考） |
| [MLPerf Tiny](https://github.com/mlcommons/tiny) | KWS 参考实现、预训练模型 |
| [Google Speech Commands](https://arxiv.org/abs/1804.03209) | KWS 标准数据集 |
| [Stanford CS107e](https://cs107e.github.io/) | 裸机 RISC-V 教学法（附录参考） |
| arXiv:2403.19076 | TinyML 综述 |
| SoC 手册 | 外设寄存器唯一真源 |
| Ripes / Compiler Explorer | W1 汇编可视化 |

---

## 讲师备注

- 对外口径：RISC-V 嵌入式课，RuyiSDK 为统一工具链；计组是前置
- 课前统一装 `ruyi`（二进制/pip），配 ISCAS 镜像源；禁止学生手工编译 GNU 工具链
- 关键词集可灵活调整（中文/英文/自定义），建议统一 4 词起步
- 答辩核心：驱动在哪层？MFCC 怎么算？量化对精度影响？KWS for 循环在哪？
- 机房预装 RuyiSDK VS Code 插件 + `ruyi`
- 无板学生：QEMU 用户模式 + 预录 WAV 文件，训练与推理逻辑完全一致
- 备用课题：若语音方向实施困难，附录 C 提供温湿度环境监测方案作为 fallback

---

# 附录 A：Advanced Track — RISC-V 裸机编程

> 原课程 W1–W4 裸机固件内容，移至附录作为进阶选修。适合深入理解 MMIO、中断控制器、OpenOCD 烧录等底层机制的学生。**不纳入 8 周主课考核。**

**前提**：完成主课 W1–W4（已掌握交叉编译与 Linux 外设编程）。  
**额外硬件**：JTAG 调试器 + 支持 OpenOCD 的 RISC-V 板。

## AT1：裸机 Bring-up、内存布局与 GPIO（~15h）

- 裸机工具链 `riscv64-unknown-elf-gcc`、链接脚本手写
- 启动流程：复位向量 → `_start` → `main`；BSS 清零、数据段拷贝
- GPIO：MMIO 寄存器点灯，不用厂商闭源 HAL
- OpenOCD 烧录 + GDB 硬件调试

**Lab**：裸机 Makefile + 链接脚本 → `make flash` → 开发板点灯 + 启动流程图 + 内存段表。

## AT2：MMIO、UART 与驱动分层（~15h）

- `volatile`、位域、MMIO 读写时序
- 自写 UART 驱动（寄存器级）；收发缓冲
- 驱动分层：`hal_gpio` / `drv_uart` / `app_shell`
- 表驱动 shell：`help` / `led` / `echo` / `peek`（地址白名单）/ `ms`

## AT3：中断、时间与实时行为（~15h）

- 异常/中断、PLIC/CLINT（按 SoC 手册）
- ISR 禁忌、中断延迟、与主循环分工
- 定时器中断；协作式多任务（手写实现）
- FreeRTOS 任务/队列工业角色（讲授对比）
- 看门狗（加分）

**Lab**：秒表 + 按键消抖 + 双任务（采集打印 + LED）。

## AT4：总线、传感与嵌入式集成（~15h）

- I2C/SPI 时序、MMIO 寻址、传感器寄存器
- ADC 采样、滑动平均滤波
- ringbuf；功耗（睡眠/时钟门控）；可靠性（看门狗/复位原因）

**Lab**：I2C 传感器 → 自写 ringbuf → shell `print`/`dump`。

## 主课 vs Advanced Track 对照

| 主课（W1–W4） | Advanced Track |
|--------------|----------------|
| `ruyi` 包管理器 + venv | 裸机工具链 + 手写链接脚本 |
| Linux 用户空间 GPIO/I2C | MMIO 寄存器级 |
| libgpiod / /dev/i2c-N | volatile 位域 + 手册寄存器 |
| 多线程/进程 | 中断 + ISR + 协作调度 |
| VS Code 插件 | OpenOCD + GDB 硬件调试 |
| Linux OS | 无 OS，裸机启动 |

建议路径：先完成主课 8 周 → 选做 AT1+AT2 或 AT1+AT3，体会有无 OS 两种模式差异。

**参考**：[Stanford CS107e](https://cs107e.github.io/)、SoC 手册。

---

# 附录 B：`ruyi` 快速安装参考

```bash
# 安装（预编译二进制，推荐）
wget https://mirror.iscas.ac.cn/ruyisdk/ruyi/tags/0.41.0/ruyi-0.41.0.amd64
chmod +x ./ruyi-0.41.0.amd64
sudo cp -v ./ruyi-0.41.0.amd64 /usr/local/bin/ruyi
ruyi version

# 或 pip 安装
pipx install ruyi

# 配国内镜像源
ruyi config set repo.remote "https://mirror.iscas.ac.cn/git/ruyisdk/packages-index.git"
ruyi update
```

```bash
ruyi list                                   # 浏览可用包
ruyi install toolchain/gnu-plct             # 装 GNU 工具链
ruyi install emulator/qemu-user-riscv-xthead # 装 QEMU
ruyi venv --toolchain gnu-plct --emulator qemu riscv-dev ./my-project
source ./my-project/bin/activate            # 激活虚拟环境
```

## 推荐硬件平台

以下 RISC-V 开发板可运行标准 Linux，适合本课程：
Lichee Pi 4A、Milk-V Meles、Lichee Cluster 4A、Lichee Console 4A、Lichee Book 4A、Milk-V Pioneer、Sophgo SG2044 SRD3、Beagle-Ahead、Huiwei Book。

选型参考：[RuyiSDK support-matrix](https://github.com/ruyisdk/support-matrix)

---

# 附录 C：备用课题 — 温湿度环境监测

> 若语音关键词识别方向因硬件（麦克风缺货/板卡 I2S 不兼容）或教学进度原因难以实施，以下温湿度环境监测方案作为完全等效的 fallback。与主课题同样满足 TinyML 训练→量化→部署全流程。

## 课题概述

I2C 温湿度传感器（SHT30/AHT20）→ ringbuf 采集窗口 → tiny MLP 二分类（正常/异常环境）→ int8 推理 → LED 告警。

## 硬件差异

将 I2S 麦克风替换为 I2C 温湿度传感器 + 1 颗 LED。接线更简单（仅 VCC/GND/SCL/SDA），所有 RISC-V 板均兼容。

## 周次调整

| 周 | 主课题（KWS） | 备用课题 |
|----|-------------|---------|
| W3 | GPIO/I2C + I2S 铺垫 | GPIO/I2C（无 I2S） |
| W4 | 麦克风 + 音频 ringbuf | 温湿度传感器 + ringbuf |
| W5 | MFCC + KWS 训练 | 特征窗口（min/max/均值）+ MLP 训练 |
| W6 | KWS 量化 | MLP 量化 |
| W7–W8 | KWS 推理控灯 | 异常检测推理 + LED |

## 模型

tiny MLP：N 次采样统计量（min/max/均值）→ 2–3 层全连接 → 正常/异常二分类。参数量 < 5K，int8 推理 < 1ms。

## 演示

W8 答辩：哈气/热风枪/捂板触发异常 → 红灯亮 + shell 打印置信度；正常环境绿灯。
