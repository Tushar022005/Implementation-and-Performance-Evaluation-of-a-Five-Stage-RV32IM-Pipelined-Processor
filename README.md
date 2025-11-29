# Implementation-and-Performance-Evaluation-of-a-Five-Stage-RV32IM-Pipelined-Processor

Five-Stage RV32IM Pipelined RISC-V Processor in Verilog

This repository contains the complete RTL implementation and simulation work for the project:

Implementation and Performance Evaluation of a Five-Stage RV32IM Pipelined Processor in Verilog with CPI ≈ 1.

The processor is developed fully in Verilog HDL using a classic 5-stage pipeline architecture and verified through simulation in Icarus Verilog and Xilinx Vivado.

The design demonstrates high pipeline efficiency through forwarding and hazard-handling mechanisms, achieving near ideal CPI.
________________________________________
Project Overview

•	Designed a complete 32-bit RV32IM pipelined RISC-V processor

•	Implemented classical pipeline stages

IF → ID → EX → MEM → WB

<img width="508" height="372" alt="image" src="https://github.com/user-attachments/assets/12886859-be9d-4a21-8f91-13ea037829dd" />


•	Built full datapath including program counter, instruction fetch, register file, ALU, control logic, immediate generator, pipeline registers, and write-back logic

•	Added Forwarding Unit and Hazard Detection Unit to resolve data dependencies and prevent unnecessary stalls

•	Verified functionality using custom RISC-V assembly programs and waveform analysis

•	Measured performance using cycle and instruction retirement counters
________________________________________
Features

•	5-stage pipeline datapath (IF, ID, EX, MEM, WB)

•	RV32IM ALU instruction support:

o	ADD, SUB

o	AND, OR, XOR

o	SLL, SRL, SLT

o	MUL, DIV, REM

•	Forwarding logic from EX/MEM and MEM/WB to eliminate RAW hazards

•	Load-use and pipeline stall handling using hazard detection unit

•	PC mux with branch control support

•	Cycle and instruction retirement counters for CPI evaluation

•	Verified under dependent instruction streams without pipeline breakdown
________________________________________
Performance

Performance is evaluated using real-time CPI measurement:

CPI = Total Cycles / Total Instructions Retired

Simulation results:

•	Mixed arithmetic instruction program

CPI ≈ 1.06

•	Logical, shift and remainder instruction program

CPI ≈ 1.10

This confirms near-ideal pipeline behavior and effective hazard management.
________________________________________
Repository Structure

riscv_rv32im_pipeline/

│

├── src/

│   ├── risc_top.v          # Top-level core integration

│   ├── datapath_unit.v    # Main pipelined datapath

│   ├── rv32im_alu.v       # ALU implementation

│   ├── aludec.v           # ALU decoding logic

│   ├── maindec.v          # Main control decoder

│   ├── control_unit.v

│   ├── regfile.v          # 32x32 Register file

│   ├── imm_gen.v          # Immediate generator

│   ├── pc.v               # Program counter

│   ├── pc_mux.v           # Next PC selection logic

│   ├── branch_unit.v

│   ├── forwarding_unit.v # RAW data hazard bypass logic

│   ├── hazard_unit.v     # Load-use stall logic

│   ├── IF_ID.v            # IF/ID pipeline register

│   ├── ID_EX.v            # ID/EX pipeline register

│   ├── EX_MEM.v           # EX/MEM pipeline register

│   ├── MEM_WB.v           # MEM/WB pipeline register

│   ├── imem.v             # Instruction memory

│   ├── dmem.v             # Data memory

│   └── result_mux.v

│

└── doc/

    └── ResearchPaper.pdf  # IEEE formatted project paper
    
________________________________________
Simulation and Verification

The processor was verified using:

•	Icarus Verilog

•	Xilinx Vivado simulation

Verification steps:

•	Individual RTL block testing (ALU, Register File, Memories, Control)

•	Pipeline integration testing with dependent instruction sequences

•	Observation of forward paths and hazard stall signals in waveforms

•	Register file value checking for correctness

•	CPI measurement using testbench counters:

o	cycle_count increments every clock cycle

o	instr_retired increments at each valid writeback
________________________________________
Instruction Coverage

The project supports a focused RV32IM subset sufficient for performance and pipeline validation:

•	Arithmetic and logical: ADD, SUB, AND, OR, XOR

•	Shifts: SLL, SRL

•	Compare: SLT

•	Multiply and divide: MUL, DIV, REM

These instructions stress the execution pipeline and validate forwarding correctness across multi-cycle operations.
________________________________________
Possible Extensions

•	Branch prediction and control hazard optimization

•	Load/store pipeline extensions

•	Instruction and data cache integration

•	FPGA deployment on boards such as Basys-3

•	Support for floating-point instructions (RV32F)

•	RISC-V compliance testing suites
________________________________________
Tools Used
•	Verilog HDL
•	Icarus Verilog
•	GTKWave
•	Xilinx Vivado Simulator

