
1. 需求
我的需求：
我要开发一个riscv + 嵌入式的课程
我现在不知道应该如何开始，设置几个学习模块，要符合学生的认知顺序；尤其是课程的产出project是什么，并且每个学习模块要设置一个动手的lab
我可以给学生提供milk S之类的riscv开发板，当然可以用别的，但最重要的是学生要动手学到东西
问题是，学到什么？学到指令集？学到如何接线？这都不够问题导向，学生学了之后能怎么样呢？你要知道，学AI可以去open AI训练大模型，学嵌入式能干嘛？你得帮我justify
我期待学生的唯一基础知识就是c语言 + 计算机组成原理
你可以去看看x86或者arm有没有嵌入式课程，国外迭代到哪里了，可以搜搜一些youtube或者什么
你也可以直接看看斯坦福cs107e，我觉得很有帮助：https://cs107e.github.io/schedule/

显然 你的课程得有一定难度，并且使用模拟器也是很好的思想
你先思考 cs107e 是不是合适的参考

其他资料
以下是 RISCV版本 Linux嵌入式开发课程  的参考资料 欢迎补充
1. 百问网Linux学习指南：https://linux.100ask.net/
2. Linux和驱动开发相关：https://www.bilibili.com/video/BV1fJ411i7PB
3. Xv6公开课：https://pdos.csail.mit.edu/6.828/2025/xv6.html
4. bootlin Linux嵌入式开源的课件和实验代码：https://bootlin.com/training/embedded-linux/
5.《RISC-V开放架构设计之道》
6. 《计算机组成与设计——硬件/软件接口》 RISC-V版本，第五版
7. 《RISC-V体系结构编程与实践》

Appendix

CS107e Spring 2026 Home Assignments Labs Resources 🗓 Schedule 🔍 Search Project gallery Our students have delighted us with a cornucopia of creative projects each quarter. This gallery shares a sampling of that awesomeness. What cool thing will YOU be inspired to create? Below are two short highlight reels from the project demos. Spring quarter 2017 (Raspberry Pi) Fall quarter 2024 (Mango Pi) Here are short descriptions of some projects from past years: Noob cube Graphical viewer for a 3D wireframe Pi selfie mirror Take a selfie with animations displayed on a mirror-monitor Chess but cool Chess board that can record & visualize moves on a screen (using Hall-effect sensors) Threading system Multi-threading system so Pi can simulate running code in parallel Keyboard orchestra Record/play music using keyboard Sunlight lamp Lamp that mirrors natural sunlight intensity throughout day Drum hero Electronic drumset with piezoelectric vibration sensors SPI network with device-device communication Communication between Pis (display received data, store to memory, run received code) Fruit Ninja arcade game controlled by user hand gestures (sonar sensors) Theremins visualized Translate time-of-flight distance to pitch and output sound and visualization Synthetic music Synthetic instrument using piezo sensors on fingers, and output sound and visualization Light-up dress Dress which lights up with electroluminescent wires when you move (based on gyroscope) Etch-a-sketch Takes input from two knobs, accelerometer, and push buttons: controls menu UI and paint program ArduCAM library A library to retrieve images from ArduCAM, along with an interactive control shell Robo-Turtle A robotic turtle with servo motors and ultrasonic sensor, controllable with an NES controller Raspberry Pi GPU An assembler which targets the Pi GPU and guide to using the GPU from bare metal Intruder detection system Detect motion using network of passive infrared sensors DMX lighting console and receiver User interface to set/read lighting controls 2-player basketball arcade game Sensors detects when ball goes into basket and which player to award point (by color of ball) Sensor visualizer Car dashboard-like visualization of MCP3008 ADC, including a GL library Clappy bird Arcade game controlled by sound Finger-spelling recognition Recognize letters spelled while wearing sensor-equipped glove Walking weatherman Wearable shirt with environment sensors and informational display via leds Post-it printer User paints picture on Pi which is then drawn on a Post-It using a pen controlled by stepper motors Vintage boombox Plays music through a refitted vintage radio case with LED visualization LED leggings Leggings with sewn-in LEDs that respond to movement of wearer Magic organ Multiple stops that shape frequency signature of sound akin to pipe organ Gesture-controlled car Car is wirelessly controlled via a glove outfitted with sensors Text-a-sketch Pi receives texted photo and drives stepper motors to dial a physical Etch-a-Sketch to replicate photo PiCycle Automatic brake and turn signals for your bike Boba maker Swipe your Stanford ID and receive your preferred beverage mixed to order Gun of the sentry Nerf gun that tracks and shoots at moving target Pi-rat Sensing and mobile robot that can autonomously solve a maze Laser harp Strings of made of light that you can pluck POV sphere Rotating strip of leds to create illusion of spherical image Workout buddy Wearable sensors to count reps at the gym Dance steps arcade game Step on pads in correct pattern/timing to win game Lie detector Biometric sensors evaluate truthfulness of speaker Custom font Draw letters on screen to create custom handwriting font BattleDarts Battleship game where shot is fired by throwing dart onto board Midi stepper synth Midi from piano keyboard is visualized on screen, drive stepper motors to sound notes of correct frequency Bop-it game Sensors to detect various actions Lego printer Print image via pick-and-place of lego pixels on grid board Jelly bean sorter Use color sensor and servo motors to sort jelly beans by color Escalating challenge snooze Each use of snooze alarm is harder to shut off Gesture tetris Game controlled via hand gestures Zen garden Trace patterns in sandbox by moving magnet via stepper motors Drawing stylus Track moving magnet atop field of analog Hall effect sensors and use as input device Midi-controlled music box Servo motors used to pluck tines and play midi input Graphing calculator Handheld with integrated LCD display, keypad, battery power, sd card boot Firefighter guidance system Wearable vest with IR/ToF sensors and haptic feedback to guide rescuer to trapped person Laser communication full-duplex transmit/receive, custom encoding Mediation buddy Lighted,moving flower that provides biofeedback on heart and breath rate Beat saber arcade game swipe in time to the music to score points Music visualizer cube analyze sound input in real-time and render as visual display on 8x8x8 LED cube CS107e Spring 2026 · Site generated 2026-05-28 03:06


Demos and Tools --- Here we have gathered links to demos and visualization tools that CS107E students have found useful. Check them out! RISC-V - Ripes simulator, simulator/visualizer/assembly editor for RISC-V - Run it in your brower: https://ripes.me/ - Or download original version as desktop application (Qt) - Source code on github https://github.com/mortbopet/Ripes, pre-built binaries are available https://github.com/mortbopet/Ripes/releases - Rars simulator, adapted from MARS, popular for teaching MIPS - Desktop application (java) https://github.com/TheThirdOne/rars - Cornell simulator - Created for a course at Cornell, somewhat simplified. https://www.cs.cornell.edu/courses/cs3410/2019sp/riscv/interpreter/ - Instruction encoder/decoder from Luplab UC Davis - https://luplab.gitlab.io/rvcodecjs/#q=fffff06f&abi=true&isa=RV64I C language - Matt Godbolt's Compiler Explorer is an awesome tool for seeing how the compiler translates from C to assembly - https://gcc.godbolt.org/ Configure the settings for the C language, compiler RISC-V(64-bits) gcc 12.20 and flags -Og -ffreestanding to approximate the toolchain we are using. Here is a preconfigured link https://gcc.godbolt.org/z/Eod3jo3bb. - Use Rextester to compile and execute C program in a virtual environment. https://rextester.com/l/c_online_compiler_gcc - Very handy for quickly running a C snippet to see what it does. - C Tutor is a nifty tool where you can step through a C program and visualize its execution, including showing the contents of the stack and heap memory. http://pythontutor.com/c.html#mode=edit - (also available for python, javascript, java). From Philip Guo UC San Diego - The famed cdecl.org http://cdecl.org/ is your go-to when you need to convert a cryptic C declaration to English. CS107e Spring 2026 · Site generated 2026-05-28 03:06 CS107e Spring 2026 Home Assignments Labs Resources 🗓 Schedule 🔍 Search Informational resources Here are links to various external resources with information about the Mango Pi, RISC-V assembly, C, and more. Mango Pi Manufacturer's site Mango Pi MQ-Pro https://widora.cn/mqpro Mango Pi schematic/pinout Tour the Mango Pi board using its interactive BOM The Mango Pi uses an Allwinner D1-H chip. The peripherals are documented in the Allwinner D1-H User Manual The user manual is 1400 pages of nitty-gritty goodness (addresses, layouts, behaviors). It's a tome for sure, but keep this one bookmarked, you'll be looking at it often. The D1 has a single RV64GCV core XuanTie C906 made by T-Head Semiconductors. Processor overview https://www.riscfive.com/2023/03/09/t-head-xuantie-c906-risc-v/ Full documentation XuanTie-Openc906-UserManual RISC-V architecture The RISC-V Reader: An Open Architecture Atlas, Patterson & Waterman https://www.amazon.com/dp/0999249118/ Amazingly succinct yet thorough coverage of the architecture, with backstory on how the design came to be. Riscv.org website https://riscv.org/technical/specifications/ RISC-V specification Vol. 1 and Vol. 2 Computer Organization and Design: The Hardware Software Interface https://www.amazon.com/dp/0128203315/ Patterson and Hennessy's classic text, RISC-V edition An Overview of the RISC-V Instruction Set Architecture, Harry Porter https://web.cecs.pdx.edu/~harry/riscv/ Andrew Waterman's 2016 PhD thesis "Design of the RISC-V Instruction Set Architecuture" https://people.eecs.berkeley.edu/~krste/papers/EECS-2016-1.pdf RISC-V assembly ChibiAliens has a series of video tutorials on RISC-V https://www.chibialiens.com/riscv/ RISC-V Assembly Programmer's Manual https://github.com/riscv-non-isa/riscv-asm-manual/blob/master/riscv-asm.md RISC-V Assembly for Beginners, blog post from Eric Engheim https://medium.com/swlh/risc-v-assembly-for-beginners-387c6cd02c49 Eric Engheim's one-page cheatsheet http://blog.translusion.com/images/posts/RISC-V-cheatsheet-RV32I-4-3.pdf See our Demos page for simulators/tools. Bare metal programming David Welch has extensive github repository of bare metal programming examples for a wide variety of architectures. Check out https://github.com/dwelch67/lichee-rv-samples, the lichee RV is using the same AllWinner D1 chip as Mango Pi. Embedded Systems Developer RISC-V Blog https://five-embeddev.com/quickref/ (Phil Mulholland) C language Nick Parlante's EssentialC The C Programming Language, 2nd Ed., B. Kernighan and D. Ritchie. A digital copy of K&R is available to Stanford students via Safari Books Online Developer tools The Definitive Guide to GCC, 2nd Ed., William von Hagen, Apress, 2006 pdf Mango Pi RISC-V architecture RISC-V assembly Bare metal programming C language Developer tools CS107e Spring 2026 · Site generated 2026-05-28 03:06



性感的课程设计：RISC-V + AI 边缘智能
基于搜索结果，当前最前沿的方向是 TinyML（在微控制器上跑AI模型）和 边缘智能（不依赖云端的本地AI推理）。
---
课程定位：从嵌入式到边缘AI
核心卖点：学生学完后能 在手掌大小的设备上跑AI，不需要联网、不需要GPU，就能做人脸识别、语音助手、自动驾驶小车。
---
课程模块（12周）
模块1: 裸机基础与RISC-V (Week 1-2)
- 内容：ISA基础、汇编、GPIO控制
- Lab：LED呼吸灯、按键输入
- 产出：理解硬件如何被软件控制
模块2: C语言与硬件交互 (Week 3-4)
- 内容：C到汇编映射、内存映射、volatile
- Lab：直接操作寄存器，实现UART串口通信
- 产出：与电脑串口对话的设备
模块3: 传感器与数据采集 (Week 5-6)
- 内容：I2C/SPI协议、ADC/DAC、传感器驱动
- Lab：温湿度+光照+声音传感器数据采集
- 产出：环境感知器
模块4: TinyML基础 (Week 7-8)
- 内容：量化、剪枝、TensorFlow Lite Micro
- Lab：在RISC-V上跑MNIST手写数字识别
- 产出：在16KB RAM设备上识别手写数字
模块5: 边缘AI应用 (Week 9-10)
- 内容：CNN推理、语音关键词检测、异常检测
- Lab：关键词唤醒（"Hey Siri"类）
- 产出：本地语音助手原型
模块6: 系统集成与项目 (Week 11-12)
- 内容：项目冲刺
- 产出：完整项目演示
---
项目方向（由学生选择）
方向A：自动驾驶小车
- 线性摄像头 + RISC-V + 电机控制
- 跑TinyCNN做车道检测
- 参考：NXP Cup、KAIST RE540
- 难度：★★★★☆
方向B：智能无人机
- Crazyflie四旋翼 + GAP9 RISC-V SoC
- 视觉避障、目标跟踪
- 参考：GAP9Shield论文
- 难度：★★★★★
方向C：AI语音助手
- 麦克风阵列 + RISC-V
- 本地关键词检测 + 命令执行
- 无需联网，隐私安全
- 难度：★★★☆☆
方向D：智能监控摄像头
- 摄像头 + RISC-V
- 本地人脸检测、物体识别
- 低功耗，电池供电
- 难度：★★★★☆
方向E：手势控制音乐
-ToF传感器 + 手势识别
- 实时音频合成
- 超酷的交互体验
- 难度：★★★☆☆
---
为什么这个课程更性感？
传统嵌入式课程	本课程
学接线、点亮LED	学跑AI模型
做环境监测	做自动驾驶
用现成库	理解底层原理
作品是温度计	作品是能看的智能设备
学完不知道干嘛	学完能做AIoT产品
---
技术栈
层级	工具
开发板	Milk-V Duo / Mango Pi / VSDSquadron Pro
模拟器	Ripes (ISA可视化) + QEMU (系统级)
AI框架	TensorFlow Lite Micro / ONNX Runtime
训练	PyTorch (PC端) → 量化 → 部署到RISC-V
调试	GDB + 串口日志
---
参考资源整合
资源	用途
CS107e	裸机编程教学法
Bootlin	嵌入式Linux工业实践
MIT 6.S081	OS概念
Efinix TinyML	RISC-V + TFLite Micro
GAP9论文	边缘AI案例
VSDSquadron课程	16KB RAM约束下的AI部署
---
需要我详细展开某个模块的具体内容吗？比如TinyML模块的详细lab设计？

结论: CS107e是优秀的"计算机系统导论"课程，但不是"嵌入式系统开发"课程。需要补充工业级内容。
课程设计建议
1. 课程定位与价值主张
嵌入式系统学习价值:
维度	价值
职业	IoT/汽车/医疗/机器人/消费电子 - 市场规模$2000亿+
技能	全栈理解：硬件→固件→OS→应用
RISC-V	开源ISA，中国/欧洲战略重点，未来10年爆发
问题解决	资源约束下的优雅工程
创新	物理计算：创造与真实世界交互的产品

模拟器策略
阶段	工具	用途
学习初期	Ripes	ISA可视化、单步调试
中期	QEMU RISC-V	系统级仿真、驱动开发
后期	真实硬件	项目开发、性能优化

# RISC-V嵌入式系统设计课程方案（基于CS107e教学理念）
## 一、课程定位与价值论证
### 核心定位
**"从晶体管到系统：RISC-V裸机开发全流程实战"**  
面向已掌握C语言和计算机组成原理的学生，从最底层的指令集和硬件寄存器出发，逐步构建完整的嵌入式系统能力。区别于"接线式"Arduino教学和"应用层"Linux教学，本课程聚焦**软件如何真正控制硬件**这一核心问题，培养学生的系统级思维和工程实践能力。

### 为什么学RISC-V嵌入式？（课程价值Justify）
1.  **产业爆发的人才缺口**：RISC-V已成为物联网、边缘计算、工业控制、汽车电子乃至服务器芯片的主流架构，全球RISC-V相关岗位年增长率超过300%，但懂裸机开发的人才极度稀缺。
2.  **不可替代的系统能力**：学完本课程，学生将理解：
    - 一行C代码如何最终变成CPU执行的指令
    - 一个按键按下如何被操作系统感知
    - 一个中断如何打断正在执行的程序
    这种从晶体管到应用的完整知识链条，是只会做上层开发永远无法获得的。
3.  **从消费者到创造者的转变**：学生不再是只能使用别人写好的库和API，而是能自己编写驱动、设计系统，把任何创意变成实际的硬件产品。
4.  **开源生态的无限可能**：RISC-V完全开源的特性让学生可以自由修改架构、参与开源项目，甚至自己设计芯片，这是x86和ARM永远无法提供的机会。

### 参考课程分析
斯坦福CS107e是本课程的核心参考，其成功之处在于：
- 完全从裸机出发，不依赖任何现成的操作系统或库
- 每个实验都有明确的、可演示的产出
- 最终项目给予学生极大的创意空间
- 强调"理解原理"而非"复制代码"

本课程在CS107e基础上做了以下优化：
- 采用更具未来前景的RISC-V架构替代ARM
- 增加了RTOS实时操作系统模块
- 强化了RISC-V指令集和特权模式的讲解
- 提供了更完善的模拟器支持，降低硬件门槛

## 二、硬件与工具选择
### 推荐开发板（按优先级排序）
1.  **Mango Pi MQ-Pro**（CS107e 2024-2026官方指定）
    - 芯片：全志D1-H（单核玄铁C906 RV64GCV）
    - 资源：512MB DDR3，WiFi+蓝牙，USB OTG，GPIO引脚齐全
    - 优势：资料最丰富，社区活跃，价格便宜（约100元）
2.  **Milk-V Duo**
    - 芯片：CV1800B（双核RV64GC + 单核RV64IMAC）
    - 资源：64MB DDR2，GPIO丰富，支持PoE
    - 优势：体积小，价格极低（约50元），适合批量采购
3.  **Lichee RV Dock**
    - 芯片：全志D1-H
    - 资源：512MB DDR3，HDMI输出，USB Host
    - 优势：接口丰富，适合做显示类项目

### 必备工具链
- 模拟器：**Ripes**（浏览器/桌面端，可视化RISC-V CPU执行过程）、**RARS**（类MARS的汇编模拟器）
- 开发工具：RISC-V GNU工具链（`riscv64-unknown-elf-gcc`）、OpenOCD（调试器）、minicom（串口工具）
- 辅助工具：Compiler Explorer（C到汇编在线转换）、GTKWave（波形查看器）

## 三、课程模块与实验设计（共16周）
### 模块1：课程导论与开发环境搭建（第1周）
**核心目标**：理解RISC-V的历史与生态，掌握完整的嵌入式开发流程
- 理论内容：
  - RISC-V架构的诞生与优势
  - 嵌入式系统的分层结构
  - 交叉编译、烧录、调试的基本概念
- **Lab 1：第一个裸机程序**
  - 任务1：搭建RISC-V交叉编译环境和Ripes模拟器
  - 任务2：编写最简单的汇编程序，在模拟器上运行并观察寄存器变化
  - 任务3：在开发板上运行第一个裸机程序，点亮板载LED
  - 拓展任务：实现LED呼吸灯效果（通过PWM或延时循环）

### 模块2：RISC-V指令集与汇编语言（第2-3周）
**核心目标**：掌握RV64I基础指令集，理解C与汇编的对应关系
- 理论内容：
  - RV64I整数指令集详解（数据处理、加载存储、分支跳转）
  - RISC-V寄存器模型与函数调用约定
  - 汇编伪指令与宏定义
  - C语言编译过程：预处理→编译→汇编→链接
- **Lab 2：汇编语言实战**
  - 任务1：用汇编实现斐波那契数列计算
  - 任务2：实现C与汇编的互相调用（C调用汇编函数，汇编调用C函数）
  - 任务3：分析函数调用的栈帧结构，画出栈帧图
  - 拓展任务：用汇编实现字符串拷贝函数`strcpy`

### 模块3：裸机编程基础与内存映射I/O（第4-5周）
**核心目标**：理解裸机程序的结构，掌握通过寄存器控制硬件的方法
- 理论内容：
  - 链接脚本与内存布局
  - RISC-V启动流程（从复位到main函数）
  - 内存映射I/O（MMIO）的原理
  - GPIO控制器的工作原理
- **Lab 3：命令行LED控制台**
  - 任务1：编写GPIO驱动，实现LED的亮灭控制
  - 任务2：编写UART串口驱动，实现字符的输入输出
  - 任务3：实现一个简单的命令行解释器，支持以下命令：
    - `led on <n>`：点亮第n个LED
    - `led off <n>`：熄灭第n个LED
    - `led blink <n> <interval>`：让第n个LED以interval毫秒间隔闪烁
  - 拓展任务：添加`help`命令，显示所有可用命令的帮助信息

### 模块4：中断与异常处理（第6-7周）
**核心目标**：理解RISC-V特权模式，掌握中断和异常的处理机制
- 理论内容：
  - RISC-V特权模式（M模式、S模式、U模式）
  - 中断与异常的区别
  - 向量表与中断服务程序
  - 平台级中断控制器（PLIC）
  - 定时器中断
- **Lab 4：定时器秒表与按键中断**
  - 任务1：配置RISC-V内核定时器，实现毫秒级延时函数
  - 任务2：实现一个秒表程序，支持开始、暂停、清零功能（通过串口命令控制）
  - 任务3：配置外部中断，实现按键中断处理（按下按键翻转LED状态）
  - 拓展任务：实现长按和短按的区分

### 模块5：串行通信协议与外设驱动（第8-9周）
**核心目标**：掌握I2C和SPI协议，能够驱动常用的外部传感器和显示设备
- 理论内容：
  - I2C协议原理与时序
  - SPI协议原理与时序
  - 外设驱动的分层设计思想
- **Lab 5：环境监测站**
  - 任务1：编写I2C驱动，驱动OLED显示屏（SSD1306）
  - 任务2：编写I2C驱动，驱动温湿度传感器（SHT30）
  - 任务3：实现一个环境监测站，在OLED上实时显示当前温度和湿度
  - 拓展任务：添加光照传感器（BH1750），显示光照强度

### 模块6：实时操作系统（RTOS）基础（第10-12周）
**核心目标**：理解RTOS的基本概念，掌握多任务编程方法
- 理论内容：
  - RTOS与通用操作系统的区别
  - 任务调度算法（抢占式调度、时间片轮转）
  - 任务间通信：信号量、消息队列、互斥锁
  - FreeRTOS内核原理
- **Lab 6：多任务环境监测系统**
  - 任务1：在开发板上移植FreeRTOS
  - 任务2：创建三个任务：
    - 采集任务：每隔1秒采集一次温湿度和光照数据
    - 显示任务：在OLED上实时显示最新数据
    - 命令任务：处理串口输入的命令（如设置采集间隔）
  - 任务3：使用消息队列在任务间传递数据
  - 拓展任务：添加数据存储功能，将历史数据存储到SD卡

### 模块7：系统集成与高级主题（第13-14周）
**核心目标**：掌握系统级调试技巧，了解RISC-V高级特性
- 理论内容：
  - JTAG/SWD调试原理与使用
  - 低功耗设计基础
  - RISC-V扩展指令集（M/A/F/D/C）
  - 嵌入式系统的可靠性设计
- **Lab 7：低功耗数据记录器**
  - 任务1：实现系统低功耗模式，在没有数据采集时进入休眠
  - 任务2：使用JTAG调试器调试程序，设置断点、查看寄存器和内存
  - 任务3：实现数据的定时采集和SD卡存储，支持CSV格式导出
  - 拓展任务：添加RTC实时时钟，记录数据的时间戳

### 模块8：最终项目（第15-16周）
**核心目标**：综合运用所学知识，完成一个完整的嵌入式系统项目
- 项目要求：
  - 必须使用RISC-V开发板
  - 必须包含至少3个外设（如传感器、显示屏、按键、电机等）
  - 必须使用中断和多任务
  - 必须有明确的应用场景和实用价值
- 推荐项目方向（参考CS107e项目库）：
  1.  **智能生活类**：
      - 智能闹钟：带OLED显示、按键设置、闹钟响铃、贪睡功能
      - 手势控制灯：使用红外手势传感器控制灯的开关和亮度
      - 迷你游戏机：实现俄罗斯方块、贪吃蛇等经典游戏
  2.  **数据采集类**：
      - 便携式气象站：采集温度、湿度、气压、光照，生成历史曲线
      - 土壤湿度监测系统：自动检测土壤湿度，控制水泵浇水
      - 心率监测仪：使用心率传感器实时监测心率并显示
  3.  **机器人与控制类**：
      - 智能小车：实现循迹、避障、蓝牙遥控功能
      - 机械臂控制：控制3自由度机械臂抓取物体
      - 激光竖琴：用激光管和光敏电阻实现虚拟乐器
  4.  **通信与网络类**：
      - 蓝牙遥控器：控制手机或电脑的音乐播放和PPT翻页
      - 无线传感器网络：多个节点之间通过LoRa通信，采集分布式数据
- 项目评估：
  - 演示效果（40%）：功能完整性、稳定性、用户体验
  - 代码质量（30%）：代码规范、模块化设计、注释
  - 项目报告（20%）：需求分析、系统设计、遇到的问题与解决方案
  - 创新点（10%）：独特的功能或设计

## 四、课程评估方式
- 平时实验（60%）：每个实验按时提交，通过演示和代码检查
- 最终项目（40%）：项目演示、代码提交、项目报告
- 加分项：参与开源项目贡献、实现特别有创意的功能

## 五、参考资料
### 教材
1.  《计算机组成与设计——硬件/软件接口》（RISC-V版，第五版），Patterson & Hennessy
2.  《RISC-V开放架构设计之道》，Patterson & Waterman
3.  《RISC-V体系结构编程与实践》，奔跑吧Linux社区

### 在线资源
1.  斯坦福CS107e官网：https://cs107e.github.io/
2.  RISC-V官方规范：https://riscv.org/technical/specifications/
3.  Bootlin嵌入式Linux课程：https://bootlin.com/training/embedded-linux/
4.  Ripes模拟器：https://ripes.me/
5.  Compiler Explorer：https://gcc.godbolt.org/

需要我把每个lab的**详细实验指导书大纲**和**最终项目的评分标准**整理成可直接使用的文档吗？

CS107e是一个非常合适的参考蓝本。它最核心的价值在于，其课程路径完美契合了“**从裸机到系统**”的认知逻辑，通过一步步从底层构建一个完整的计算机系统（从点亮LED到完成一个可交互的游戏机/乐器），能为“学嵌入式能干嘛”提供一个强有力的回答。

### 🆚 CS107e与主流路径对比

为了更清晰地定位，我将CS107e与常见的ARM嵌入式和MIT 6.828等课程进行了对比：

| 特征 | CS107e (Stanford) | 主流ARM嵌入式课程 | MIT 6.828 (xv6) |
| :--- | :--- | :--- | :--- |
| **核心逻辑** | **从下到上**：自底向上构建系统 | **从上到下**：先学应用，再深入内核/驱动 | **内核聚焦**：深入修改一个小型操作系统内核 |
| **硬件平台** | RISC-V (Mango Pi) 或 ARM (Raspberry Pi) | ARM Cortex-M 系列微控制器 | RISC-V (QEMU模拟器) |
| **编程范式** | 裸金属编程，无操作系统 | 常见为裸机或RTOS（实时操作系统） | 内核编程，在xv6上进行系统调用和内核修改 |
| **课程产出** | 富有创意的**交互式系统** (游戏机/乐器等) | 特定功能的**原型机** (如智能车/气象站) | 具备新功能的**操作系统内核** |
| **独特价值** | **深度理解计算机全栈，激发创造力** | **贴近工业界MCU开发现实** | **系统掌握操作系统核心原理** |

我建议可以充分汲取CS107e的精髓，并结合RISC-V生态和嵌入式Linux的特点进行扩展。

### 💎 核心定位：你学到的是什么？

这门课的核心定位是：**成为打通“软件”与“物理世界”的创造者**。

你将学到的不仅仅是知识，更是一种能力。当你学习AI，你能训练模型；而学习嵌入式，你将获得将AI模型部署到一个实实在在的、能与环境交互的“身体”上的能力。你将学会：

*   **构建系统的“骨架”**：理解计算机如何从一堆沙子（硅）变成能执行指令的机器。
*   **赋予系统“感官”与“肌肉”**：掌握让计算机感知光线、声音、运动，并控制电机、屏幕、网络进行反馈的能力。
*   **注入系统的“灵魂”**：学会在资源受限的硬件上，编写高效、实时、可靠的软件，最终创造出一个按你意愿行动、能与世界互动的完整系统。

### 🗺️ 课程模块蓝图：8个模块构建完整知识体系

课程围绕一个核心问题展开：**“如何从零开始，构建一个能与物理世界交互的智能系统？”**

整个课程以**个人或小组项目 (Final Project)** 为最终目标，贯穿始终。每个模块的学习都为最终项目添砖加瓦。

1.  **启航：工具、模拟器与“Hello, RISC-V!”**
    *   **知识点**：RISC-V架构，GCC交叉编译，RISC-V汇编基础，QEMU等模拟器使用。
    *   **动手实验**：使用Ripes等工具，编写第一个RISC-V汇编程序，实现字符串输出。

2.  **点亮世界：从裸机到C语言的“Hello, World”**
    *   **知识点**：裸机编程概念，链接脚本，内存映射I/O（MMIO），GPIO原理。
    *   **动手实验**：在Milk-V Duo等真实开发板上，用C语言编写一个“闪烁的LED”（Blink）程序，点亮物理世界。

3.  **系统的“脉搏”：中断、异常与定时器**
    *   **知识点**：RISC-V中断模型，异常处理流程，定时器中断原理。
    *   **动手实验**：利用定时器中断实现精确的LED呼吸灯效果，让学生“看见”时间的流逝。

4.  **系统的“感官”：串行通信与外设驱动**
    *   **知识点**：UART、I2C、SPI总线协议原理，设备树，传感器驱动。
    *   **动手实验**：通过I2C读取温湿度传感器数据，并通过UART打印到PC串口终端，让系统拥有感知能力。

5.  **系统的“大脑”：内存管理与进程调度**
    *   **知识点**：RISC-V页表，虚拟内存管理，上下文切换，简单调度器。
    *   **动手实验**：实现一个极简的协作式多任务调度器，让两个LED以不同频率闪烁。

6.  **进阶之路：文件系统与Shell**
    *   **知识点**：FAT32/ext2文件系统，块设备驱动，简易Shell的实现。
    *   **动手实验**：在开发板上实现一个简单的命令行解释器（Shell），能够执行`ls`, `cat`等命令。

7.  **更广阔的天地：运行嵌入式Linux**
    *   **知识点**：嵌入式Linux系统构建，交叉编译工具链，Bootloader、内核、根文件系统编译，基础Linux驱动框架。
    *   **动手实验**：为你的RISC-V开发板从源码构建并运行一个完整的嵌入式Linux系统。

8.  **🤖 终极挑战：最终项目 (Final Project)**
    *   **目标**：自由组队，利用所学知识完成一个解决实际问题的嵌入式系统。
    *   **参考项目**：制作一个`Bad Apple!!`音乐视频播放器，或实现一个`GB模拟器`，设计一个`智能家居传感器网关`，甚至是将一个`手势识别`模块与执行机构结合，创造出能与人互动的装置。

### 💡 给课程设计者的特别建议

*   **善用模拟器**：课程初期，尤其在模块1，使用Ripes、QEMU等模拟器可以帮助学生快速上手，降低硬件调试门槛。
*   **Lab即阶梯**：每个Lab的设计都应为最终的Final Project提供基础。例如，Lab的UART通信可以直接用于Final Project的调试或数据传输。
*   **拥抱社区**：RISC-V拥有活跃的开源社区。课程可以鼓励学生查阅和贡献开源项目，培养他们的工程协作能力。
*   **善用你提供的资源**：你提供的参考资料极具价值。《RISC-V Reader》和《计算机组成与设计》是绝佳的教材。MIT 6.828的xv6 Labs可以作为模块5（内存管理/调度）的拓展实验。

### 💎 总结：为什么这条路是可行的？

这门课程的核心思想是让学生体验从一个晶体管的抽象，到一个可以与人互动的、充满创意的完整系统的构建过程。

它能完整地回答“学嵌入式能干嘛？”这个问题。最终的产出，不仅仅是学到一堆零散的知识点，而是**一个能定义问题、设计系统、并用软硬件协同方案解决问题的完整能力和自信**。当学生能亲手创造出类似CS107e Project Gallery中那些充满想象力的项目时，他们自然会找到学习这门课程的意义和无限可能。

这个基于CS107e精髓并融合RISC-V生态的课程框架，你觉得怎么样？如果对其中某个模块（比如“终极挑战”的项目设计，或RISC-V与ARM的交叉学习）想了解更多细节，我们可以继续深入探讨。