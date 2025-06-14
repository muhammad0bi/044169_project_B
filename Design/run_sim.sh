#!/bin/bash

# Generate a file named testbench.sv in the same directory as the script
python3 assembler.py

# Compile all SystemVerilog and Verilog source files
xmvlog -sv -nowarn DLCPTH -nocopyright adder.sv
xmvlog -sv -nowarn DLCPTH -nocopyright dpram2048x32_CB.v
xmvlog -sv -nowarn DLCPTH -nocopyright dpram4096x8.v
xmvlog -sv -nowarn DLCPTH -nocopyright Memoria32.sv
xmvlog -sv -nowarn DLCPTH -nocopyright Memoria32Data.sv
xmvlog -sv -nowarn DLCPTH -nocopyright RegPack.sv
xmvlog -sv -nowarn DLCPTH -nocopyright RegFile.sv
xmvlog -sv -nowarn DLCPTH -nocopyright alu.sv
xmvlog -sv -nowarn DLCPTH -nocopyright ALUController.sv
xmvlog -sv -nowarn DLCPTH -nocopyright BranchUnit.sv
xmvlog -sv -nowarn DLCPTH -nocopyright Controller.sv
xmvlog -sv -nowarn DLCPTH -nocopyright flopr.sv
xmvlog -sv -nowarn DLCPTH -nocopyright ForwardingUnit.sv
xmvlog -sv -nowarn DLCPTH -nocopyright HazardDetection.sv
xmvlog -sv -nowarn DLCPTH -nocopyright imm_Gen.sv
xmvlog -sv -nowarn DLCPTH -nocopyright mux2.sv
xmvlog -sv -nowarn DLCPTH -nocopyright mux4.sv
xmvlog -sv -nowarn DLCPTH -nocopyright mux32.sv
xmvlog -sv -nowarn DLCPTH -nocopyright datamemory.sv
xmvlog -sv -nowarn DLCPTH -nocopyright instructionmemory.sv
xmvlog -sv -nowarn DLCPTH -nocopyright Datapath.sv
xmvlog -sv -nowarn DLCPTH -nocopyright DebugUnit.sv
xmvlog -sv -nowarn DLCPTH -nocopyright RISC_V.sv
xmvlog -sv -nowarn DLCPTH -nocopyright test_bench.sv

# Elaborate
xmelab -access +rwc test_bench

# Run simulation in GUI mode
xmsim -gui test_bench &

