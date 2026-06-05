# RISC-V 嵌入式系统与边缘推理 — 教学大纲

> **推荐教材**
>
> 1. David A. Patterson, John L. Hennessy — **《计算机组成与设计：硬件/软件接口 (RISC-V版)》** 原书第2版  
>    *Computer Organization and Design: The Hardware/Software Interface, RISC-V Edition*  
>    两位图灵奖得主撰写，RISC-V 领域首选教材，配套中国大学 MOOC。
>
> 2. David Patterson, Andrew Waterman — **《RISC-V开放架构设计之道》**（中译本, 2024）  
>    *The RISC-V Reader: An Open Architecture Atlas*  
>    RISC-V 基金会核心成员撰写，深入指令集架构技术细节。

```text
┌─────────────────── 8 周 × 15h — 全程单板 ──────────────────────────────┐
│  W1–W2 【工具链】      W3–W4 【外设与采集】    W5–W8 【训练到推理闭环】       │
│  交叉编译 · QEMU · GDB   GPIO/I2C · ringbuf     numpy 训练 → int8 推理       │
│  ruyi 环境 · Makefile    shell · 数据流水线      量化对比 · 环境监测演示       │
└──────────────────────────────────────────────────────────────────────┘
        全班统一课题：环境监测 — I2C 温湿度 → MLP 判正常/异常 → LED + shell
        ⚠ 全部采集、训练、量化、推理在同一块 RISC-V Linux 板上完成
```

---

**学时**：8 周 × 15 小时 = 120 小时  
**前提**：C 语言 + 计算机组成原理  
**硬件**：RISC-V 开发板运行 Linux（推荐 Lichee Pi 4A / Milk-V Meles，参考 [support-matrix](https://github.com/ruyisdk/support-matrix)）+ I2C 温湿度传感器（SHT30/AHT20）+ 1 颗 LED；无板可用 QEMU  
**工具**：`ruyi` 包管理器、PLCT GNU/LLVM 工具链、QEMU、GDB、Git、GNU Make、Python + numpy

**课程性质**：嵌入式系统工程课。以 RuyiSDK 为统一工具入口，在 RISC-V Linux 板上完成外设驱动、数据采集、tiny ML 训练与 int8 推理部署。计组/汇编是手段，不是目的。

---

## 课程要回答的问题

| 问题 | 答案 |
|------|------|
| 学嵌入式能干嘛？ | 写传感采集与推理程序：驱动、缓冲、数据处理流水线 |
| RuyiSDK 省了什么？ | 一条命令装全部工具链，不再手工编译 GCC/binutils/OpenOCD |
| 和计组课差在哪？ | 强调外设时序、驱动分层、实时与内存预算、功耗意识 |
| 和 AI 课差在哪？ | 模型必须部署到实际硬件：量化、静态内存、采样与推理并行 |
| 项目要求？ | 手写 I2C 驱动、ringbuf、int8 推理循环、shell 控制台；自写 ≥60% |

---

## 单板全流程

全部内容在同一块 RISC-V Linux 板上完成。tiny MLP（2 输入、几十个神经元、几百条数据）用 Python + numpy 在板上几十秒训练完毕。不需要 GPU、不需要 x86、不需要机器间传数据。

| 阶段 | 在板上做什么 |
|------|-------------|
| W1–W2 | `ruyi` 装工具链；交叉编译或本地编译；QEMU/GDB 调试 |
| W3–W4 | GPIO/I2C 驱动；传感器采集；ringbuf；shell 控制台 |
| W5–W6 | Python + numpy 训练 tiny MLP；int8 量化；导出 `weights.h`；生成参考输出 |
| W7–W8 | C 程序读 `weights.h` → int8 推理；LED 告警；答辩 |

**数据流**（全程板本地，零跨机传输）：

```text
  W4 采集 → CSV（板本地磁盘）
              ↓
  W5 同板 Python 读 CSV → 训练 MLP → 量化 → 导出 weights.h
              ↓
  W7 同板 C 程序读 weights.h → int8 推理 → LED + shell
```

无硬件板卡的学生用 QEMU + 串口注入 CSV 模拟传感器，训练与推理逻辑完全一致。

---

## 学完你能做什么

**第 4 周末**：用 `ruyi` 管理 RISC-V 工具链；Linux 用户空间 GPIO/I2C 驱动；自写 ringbuf；说清 .text/.data/.bss/栈的内存布局；完成传感采集系统。

**第 8 周末**：在 RISC-V 板上独立完成 tiny MLP 训练、int8 量化、C 推理部署；能演示环境异常检测 + 量化对比数据。

---

## 课规

| 时段 | 要求 |
|------|------|
| W1–W2 | 工具链环境搭建、交叉编译、QEMU 仿真关键路径手写 |
| W3–W4 | 外设驱动、ringbuf、数据采集流水线自写 ≥60% |
| W5–W8 | ≥1 个 int8 算子自写；W6 交量化对比表；W7–W8 板上可演示 |
| 期末 | 自写 ≥60%；能说明驱动层与推理层接口 |

---

## 总览：8 周 × 15h

| 周 | 主题 | Lab 产出 |
|---|------|----------|
| **1** | RISC-V 生态、`ruyi` 安装 | `ruyi` 环境可用 + QEMU 首个程序 + 内存图 |
| **2** | 交叉编译、工具链管理、GDB | Makefile 工程 + QEMU/GDB 调试 |
| **3** | Linux 外设编程（GPIO/I2C/SPI） | GPIO 点灯 + I2C 扫描传感器 |
| **4** | 传感驱动、ringbuf、数据流水线 | 温湿度采集 + ringbuf + shell 控制台 |
| **5** | TinyML、训练、PTQ 入门 | `weights.h` + 参考推理输出 |
| **6** | 量化 / 剪枝 | 对比表 + 报告 |
| **7** | 推理部署、采样-推理流水线 | 板上 `infer` / `latency` |
| **8** | 环境监测集成 + 答辩 | 异常触发 LED + `infer` 演示 |

每周：理论 ~4h，Lab ~8h，复盘 ~3h。

---

## 全班统一课题：环境监测

8 周连续完成，无分支选修。

| 阶段 | 做什么 | 演示内容 |
|------|--------|----------|
| W4 | I2C 温湿度 → ringbuf → shell `print`/`dump` | 串口刷温湿度曲线 |
| W5–6 | 用采集窗口训 tiny MLP，PTQ → `weights.h` | 训练收敛曲线 + 参考输出一致 |
| W7–8 | 采样 + 推理双线程；`infer`/`latency`；异常亮红灯 | 哈气/热风/捂板 → 灯变 + 分类输出 |

采样：固定间隔读温度+湿度，取最近 N 次统计量（min/max/均值）构成特征向量。  
功能：设备判断环境正常/异常，正常绿灯，异常红灯+shell 打印置信度。限定为二分类，不涉及物体识别或语音。

---

# 第 1 周：RISC-V 生态与开发环境（15h）

**学什么**

- RISC-V ISA 概览：RV64I 指令、调用约定、寄存器模型（辅助直觉，非主线）
- RuyiSDK：`ruyi` 包管理器 + IDE + PLCT 工具链生态
- 安装 `ruyi`（预编译二进制 / pip），配镜像源 `mirror.iscas.ac.cn`
- Git 分支提交；GNU Make 组织交叉编译
- RV64I 汇编小练（Ripes 辅助）；C 程序 → QEMU 用户模式运行
- 内存段速写：`.text` / `.rodata` / `.data` / `.bss` / 栈

**Lab 1**：装 `ruyi` → 浏览包 → 交叉编译 hello.c → QEMU 运行 → 交付 Makefile + 内存段地址表 + 截图。

---

# 第 2 周：交叉编译与调试（15h）

**学什么**

- 交叉编译：host vs target、tuple（`riscv64-unknown-linux-gnu`）、sysroot
- `ruyi install toolchain/gnu-plct`（GCC 15+） / `toolchain/llvm-plct`（LLVM 21+）
- `ruyi venv` 创建虚拟环境，锁定工具链版本
- 链接脚本入门：section 布局、entry point；`objdump -h` / `readelf` 对照
- GDB + QEMU 远程调试：断点、寄存器、内存查看
- 编译优化选项（-O0/-O2/-Os）对体积与性能影响

**Lab 2**：`ruyi venv` 创建项目 → Makefile（显式 CC/CFLAGS/LDFLAGS）→ QEMU + GDB 调试 → map 文件标注 text/data/bss。

---

# 第 3 周：RISC-V Linux 外设编程（15h）

**学什么**

- Linux 设备模型：sysfs、/dev、设备树角色
- GPIO：libgpiod / sysfs — 点灯、读按键
- I2C 用户空间：`/dev/i2c-N`、`ioctl`、SMBus 协议
- SPI（选做）：`/dev/spidevN.M`
- 用户空间 vs 内核驱动对比
- 驱动分层：`hal_gpio` / `drv_i2c` / `app` — 即使 Linux 用户空间也保持这习惯

**Lab 3**：libgpiod 点灯 + 按键 → 扫描 I2C 传感器地址 → 读温湿度寄存器（SHT30/AHT20 等）→ 交付分层代码目录 + 截图。

---

# 第 4 周：传感器驱动、ringbuf 与数据流水线（15h）

**学什么**

- I2C 温湿度驱动：寄存器读写、数据解析、CRC/超时处理
- **环形缓冲**（独立 `ringbuf.c/h`，可移植可单测）— 核心数据结构
- 采样率与缓冲深度、溢出策略（丢最旧/停采）
- 数据流水线：采集 → ringbuf → CSV/JSON → 存档
- Shell 控制台：命令解析（`help`/`dump`/`print`/`rate`/`status`）
- 专题：功耗（关传感器/降采样）、可靠性（超时恢复/CRC）、量产调试

**Lab 4 + 阶段项目**：I2C 温湿度 → 自写 ringbuf → shell 周期 `print`/`dump` → 按键改采样率。要求 ringbuf 模块独立、shell ≥4 命令、分层清晰、自写 ≥60%。W4 末检查：演示 `dump` 最近 N 次数据 + 说明缓冲深度与采样率关系。

---

# 第 5 周：TinyML 训练与模型导出（15h）

**全部在 RISC-V Linux 板上完成。**

- 边缘约束：Flash/RAM/MACs 预算表，模型为设备而缩
- 在板上用 **Python + numpy** 训练 tiny MLP（W4 采集的温湿度窗口 → 正常/异常二分类）
- PTQ 入门：per-tensor int8 量化，生成 `weights.h`
- 生成参考推理输出（numpy 浮点前向结果作为 golden）

**Lab 5**：板上完成训练 + PTQ + 导出 `weights.h` + 预算表。提交收敛曲线截图与数据说明。

> 模型参数量 < 10K，numpy 纯 CPU 训练足够。若学生自选 PyTorch/RISC-V 编译版本，加分但不强制。

---

# 第 6 周：量化与压缩（15h）

**全部在 RISC-V Linux 板上完成。**

- per-channel PTQ、校准、逐层误差分析
- 结构化剪枝 + 再量化
- QAT 简介（加分）
- 自写 int8 C 推理算子（先在板上编译验证 → W7 链入采集程序）
- CMSIS-NN / muRISCV-NN 作选学对照

**Lab 6**：Baseline / per-channel / 剪枝+PTQ 三组对比表（体积、精度、RAM、ms）+ 1 页报告。

---

# 第 7 周：板上推理部署（15h）

**在 RISC-V Linux 板上链入 W5–W6 产出的 `weights.h` 和 C 推理算子。**

- 静态内存：权重放 `.rodata`，激活 buffer 从栈/静态区分配
- 多线程：采集线程 + 推理线程（或协作调度）
- Shell 扩展：`infer` / `latency` / `quant_info`
- 板上实测 RAM 占用与推理延迟

交叉编译：`riscv64-unknown-linux-gnu-gcc -O2 main.c ringbuf.c mlp_infer.c weights.c -lpthread`

---

# 第 8 周：环境监测 — 集成与答辩（15h）

1. 实际开发板：自写 I2C 驱动 + GPIO LED 告警 + int8 MLP 推理
2. 采集不停，周期 `infer`；现场哈气/热风/捂板触发异常
3. 提交 W6 对比表 + 板上 `latency` + 1 页设计说明（特征窗口、采样率、量化取舍）
4. 答辩 5 分钟：演示正常→异常灯变 + shell 输出

**评分**：异常触发演示 30 / 采集-推理集成 25 / 代码分层 20 / 量化对比表 15 / 稳定性与说明 10

---

## 课程边界

**课上会教**：`ruyi` 工具链、RISC-V Linux 外设（GPIO/I2C/SPI）、传感采集与 ringbuf 数据流水线、tiny MLP 训练与 int8 量化部署。

**课上不讲**（可选修，不占课时）：
- 嵌入式 Linux 系统构建（Buildroot/Yocto）、内核模块开发（参考 Bootlin/百问网）
- 裸机编程：MMIO 驱动、中断控制器、OpenOCD — 见附录 A
- 完整 RTOS 移植、大模型训练/云端 MLOps、NAS

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

### 在线资源

| 资源 | 用途 |
|------|------|
| [RuyiSDK](https://ruyisdk.org/) / [社区](https://ruyisdk.cn/) | 全课核心工具 |
| [RuyiSDK support-matrix](https://github.com/ruyisdk/support-matrix) | 板卡选型 |
| [Stanford CS107e](https://cs107e.github.io/) | 裸机 RISC-V 教学法（附录 A 参考） |
| [MIT 6.5940 TinyML](https://efficientml.ai/) | 量化/剪枝/MCU 部署 |
| TinyML (Warden & Situnayake, O'Reilly) | TinyML 标准参考 |
| arXiv:2403.19076 | TinyML 综述 |
| SoC 手册 | 外设寄存器唯一真源 |
| Ripes / Compiler Explorer | W1 汇编可视化 |

---

## 检查清单

- **W2 末**：`ruyi venv` 可用；Makefile 交叉编译无警告；QEMU + GDB 通过
- **W4 末**：驱动分层清楚；ringbuf 可演示 `dump`；能讲内存段与采样率
- **W8 末**：板上 `infer` + 延迟数据；W6 量化对比表完成；参考输出一致

---

## 讲师备注

- 对外口径：RISC-V 嵌入式课，RuyiSDK 为统一工具链；计组是前置
- 课前统一装 `ruyi`（二进制/pip），配 ISCAS 镜像源；禁止学生手工编译 GNU 工具链
- 答辩核心问题：驱动在哪层？采样率与缓冲？量化 tradeoff？推理 for 在哪？
- 机房预装 RuyiSDK VS Code 插件 + `ruyi`
- 无板学生：QEMU 用户模式全程可替代，精度一致，延迟不同（答辩时注明）

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
- 参考接线：[board-docs · DHT22](https://github.com/ruyisdk/board-docs/tree/main/Duo_S/Dht22)（固件须自写）

**Lab**：I2C 温湿度 → 自写 ringbuf → shell `print`/`dump`。

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

**参考**：[Stanford CS107e](https://cs107e.github.io/)、SoC 手册、裸机例程（lichee-rv-samples 等，须改写）。

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

常用命令：

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
