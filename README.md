# Backend for Pipelined RISC-V Processor

This repository contains a SystemVerilog implementation of a RISC-V processor project.
The main objective of this project is to replace & integrate Tower SRAM memories into an existing Pipelined RISC-V, and do a simplifed bakcend prosses to the new RISC-V in the Techino VLSI Lab.

## Repository Structure
The repository is structured as follows:
- [`design`](/design): Contains the source code of the RISC-V processor project.
- [`Presintaions and Reports`](/doc): Contains the presntaion & reports.
- [`sim`](/sim): Contains the simulation files and its results.
- [`verif`](/verif): Contains the testbench files.

## Resources
- For additional information on the Original implementation, please refer to  [https://github.com/estufa-cin-ufpe/RISC-V-Pipeline/tree/master]
- For additional information on the implementation, code changes and backend results, please refer to the [Report_VLSI project 7880.pdf](doc/report.pdf).
- To get started with the RISC-V instruction set, please refer to:
  - [The RISC-V Instruction Set Manual Volume I: User-Level ISA - Document Version 2.2](https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf)
  - [The RISC-V Instruction Set Manual Volume I: Unprivileged ISA - Document Version 20191213](https://riscv.org/wp-content/uploads/2019/12/riscv-spec-20191213.pdf)
- To simulate and test the RISC-V processor project, please use the following software: [ModelSim-Intel® FPGAs Standard Edition Software Version 20.1.1](https://www.intel.com/content/www/us/en/software-kit/750666/modelsim-intel-fpgas-standard-edition-software-version-20-1-1.html)

## Instructions
The following table lists the implemented instructions and their status. The instructions are listed in the order they appear in the RISC-V ISA manual.

| # | Instruction | Implemented | Tested | Working |
|---|-------------|:-----------:|:------:|:-------:|
| 1 | `LUI`       |     ✅     |   ✅   |   ✅   | 
| 2 | `AUIPC`     |     ✅     |   ✅   |   ✅   | 
| 3 | `JAL`       |     ✅     |   ✅   |   ✅   | 
| 4 | `JALR`      |     ✅     |   ✅   |   ✅   | 
| 5 | `BEQ`       |     ✅     |   ✅   |   ✅   | 
| 6 | `BNE`       |     ✅     |   ✅   |   ✅   | 
| 7 | `BLT`       |     ✅     |   ✅   |   ✅   | 
| 8 | `BGE`       |     ✅     |   ✅   |   ✅   | 
| 9 | `BLTU`      |     ✅     |   ✅   |   ✅   | 
| 10| `BGEU`      |     ✅     |   ✅   |   ✅   | 
| 11| `LB`        |     ✅     |   ✅   |   ✅   | 
| 12| `LH`        |     ✅     |   ✅   |   ✅   | 
| 13| `LW`        |     ✅     |   ✅   |   ✅   | 
| 14| `LBU`       |     ✅     |   ✅   |   ✅   | 
| 15| `LHU`       |     ✅     |   ✅   |   ✅   | 
| 16| `SB`        |     ✅     |   ✅   |   ✅   | 
| 17| `SH`        |     ✅     |   ✅   |   ✅   | 
| 18| `SW`        |     ✅     |   ✅   |   ✅   | 
| 19| `ADDI`      |     ✅     |   ✅   |   ✅   | 
| 20| `SLTI`      |     ✅     |   ✅   |   ✅   | 
| 21| `SLTIU`     |     ✅     |   ✅   |   ✅   | 
| 22| `XORI`      |     ✅     |   ✅   |   ✅   | 
| 23| `ORI`       |     ✅     |   ✅   |   ✅   | 
| 24| `ANDI`      |     ✅     |   ✅   |   ✅   | 
| 25| `SLLI`      |     ✅     |   ✅   |   ✅   | 
| 26| `SRLI`      |     ✅     |   ✅   |   ✅   | 
| 27| `SRAI`      |     ✅     |   ✅   |   ✅   | 
| 28| `ADD`       |     ✅     |   ✅   |   ✅   | 
| 29| `SUB`       |     ✅     |   ✅   |   ✅   | 
| 30| `SLL`       |     ✅     |   ✅   |   ✅   | 
| 31| `SLT`       |     ✅     |   ✅   |   ✅   | 
| 32| `SLTU`      |     ✅     |   ✅   |   ✅   | 
| 33| `XOR`       |     ✅     |   ✅   |   ✅   | 
| 34| `SRL`       |     ✅     |   ✅   |   ✅   | 
| 35| `SRA`       |     ✅     |   ✅   |   ✅   | 
| 36| `OR`        |     ✅     |   ✅   |   ✅   | 
| 37| `AND`       |     ✅     |   ✅   |   ✅   | 
| 38| `FENCE`     |     ❌     |   ❌   |   ❌   | 
| 39| `ECALL`     |     ❌     |   ❌   |   ❌   | 
| 40| `EBREAK`    |     ❌     |   ❌   |   ❌   | 

- note that memory operations support all of our memory space addresses.

## Acknowledgements

We extend our appreciation to - 
[https://github.com/estufa-cin-ufpe/RISC-V-Pipeline/tree/master]
[joaopmarinho](https://github.com/joaopmarinho)
[nathaliafab](https://github.com/nathaliafab)
 for their project, which provided the groundwork for this repository.
