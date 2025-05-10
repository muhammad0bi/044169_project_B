`timescale 1ns / 1ps

module riscv
(
    input logic clk,
    reset,  // clock and reset signals
    enable_load_ex_mem, // external memory loading enable 
    enable_half, // enable debug

    input logic [8:0]DataExMemAddress, // debug and init mem unit
    input logic [31:0]DataExMemData1, 
    input logic [31:0]DataExMemData2, 

    input logic [8:0]InstExMemAddress, // debug and init inst mem unit
    input logic [31:0]InstExMemData1, 
    input logic [31:0]InstExMemData2, 
    input logic [4:0] DebugSel,
    output logic [31:0] DebugOutput
);

  logic [6:0] opcode;
  logic ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, JalrSel;
  logic [1:0] RWSel;

  logic [1:0] ALUop;
  logic [1:0] ALUop_Reg;
  logic [6:0] Funct7;
  logic [2:0] Funct3;
  logic [3:0] Operation;
  
  logic [4:0] reg_num;
  logic [31:0] reg_data;
  logic reg_write_sig;

  logic wr;
  logic rd;
  logic [8:0] addr;
  logic [31:0] wr_data;
  logic [31:0] rd_data;
  logic [8:0]PC_debug;
  logic [31:0]ALUResult_debug;
  logic PcSel_debug;
  logic [8:0]BrPC_debug;
  logic [31:0]FAmux_Result_debug;
  logic [31:0]SrcB_debug;
  logic [31:0]WB_Data;

  Controller c (
      opcode,
      ALUSrc,
      MemtoReg,
      RegWrite,
      MemRead,
      MemWrite,
      ALUop,
      Branch,
      JalrSel,
      RWSel
  );

  ALUController ac (
      ALUop_Reg,
      Funct7,
      Funct3,
      Operation
  );



  Datapath dp (
      clk, 
      enable_half, // DEUBG ENABLE
      reset,
      enable_load_ex_mem, // init mem enable
      RegWrite,
      MemtoReg,
      ALUSrc,
      MemWrite,
      MemRead,
      Branch,
      JalrSel,
      ALUop,
      RWSel,
      Operation,
      DataExMemAddress, // init mem
      DataExMemData1,
      DataExMemData2,
      InstExMemAddress, // init inst mem unit
      InstExMemData1, 
      InstExMemData2, 
      opcode,
      PC_debug, // added for debug
      Funct7,
      Funct3,
      ALUop_Reg,
      ALUResult_debug, // added for debug
      PcSel_debug, // added for debug
      BrPC_debug, // added for debug
      FAmux_Result_debug, // added for debug
      SrcB_debug, // added for debug
      wr,
      rd,
      addr,
      wr_data,
      rd_data,
      reg_num,
      reg_data,
      reg_write_sig,
      WB_Data
  );

  DebugUnit du (
      clk,
      reset,
      PC_debug,
      opcode,
      FAmux_Result_debug,
      SrcB_debug,
      Funct7,
      Funct3,
      PcSel_debug,
      BrPC_debug,
      ALUResult_debug,
      Operation,
      addr,
      wr_data,
      rd_data,
      wr,
      rd,
      reg_num,
      reg_data,
      reg_write_sig,
      WB_Data,
      DebugSel,
      DebugOutput
  );

endmodule
