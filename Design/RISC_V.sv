`timescale 1ns / 1ps

module riscv #(
    parameter DATA_W = 32, // Data WriteData
    parameter DM_ADDRESS = 9 // Data Memory Address
) (
    input logic clk,
    reset,  // clock and reset signals
    enable_load_ex_mem, // external memory loading enable 
    enable_dubug, // enable debug

    input logic [DM_ADDRESS-1:0]DataExMemAddress, // debug and init mem unit
    input logic [DATA_W-1:0]DataExMemData1, 
    input logic [DATA_W-1:0]DataExMemData2, 

    input logic [DM_ADDRESS-1:0]InstExMemAddress, // debug and init inst mem unit
    input logic [DATA_W-1:0]InstExMemData1, 
    input logic [DATA_W-1:0]InstExMemData2, 

      output logic [6:0]opcodeFetch,
      output logic [6:0]opcodeDecode,
      output logic [6:0]opcodeExecute,
      output logic [6:0]opcodeMem,
      output logic [6:0]opcodeWb,
      output logic [8:0]PC_Dout,
      output logic [31:0]FAmux_Dout,
      output logic [31:0]SrcB_Dout,
      output logic [6:0]Funct7Decode_Dout,
      output logic [2:0]Funct3Decode_Dout,
      output logic [6:0]Funct7Execute_Dout,
      output logic [2:0]Funct3Execute_Dout,
      output logic [6:0]Funct7Mem_Dout,
      output logic [2:0]Funct3Mem_Dout,
      output logic [6:0]Funct7Wb_Dout,
      output logic [2:0]Funct3Wb_Dout,
      output logic PcSel_Dout,
      output logic [8:0]BrPC_Dout,
      output logic [31:0]ALUResult_Dout,
      output logic [3:0]Operation_Dout,
      output logic [8:0]addr_Dout,
      output logic [31:0]wr_data_Dout,
      output logic [31:0]rd_data_Dout,
      output logic wr_Dout,
      output logic rd_Dout,
      output logic [4:0]reg_num_Dout,
      output logic [31:0]reg_data_Dout,
      output logic reg_write_sig_Dout,
      output logic [31:0]WB_Data_Dout
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
  logic [DATA_W-1:0] wr_data;
  logic [DATA_W-1:0] rd_data;
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
      (clk & !enable_dubug) , // DEUBG ENABLE
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
      enable_dubug, // input from the user 
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
      opcodeFetch,
      opcodeDecode,
      opcodeExecute,
      opcodeMem,
      opcodeWb,
      PC_Dout,
      FAmux_Dout,
      SrcB_Dout,
      Funct7Decode_Dout,
      Funct3Decode_Dout,
      Funct7Execute_Dout,
      Funct3Execute_Dout,
      Funct7Mem_Dout,
      Funct3Mem_Dout,
      Funct7Wb_Dout,
      Funct3Wb_Dout,
      PcSel_Dout,
      BrPC_Dout,
      ALUResult_Dout,
      Operation_Dout,
      addr_Dout,
      wr_data_Dout,
      rd_data_Dout,
      wr_Dout,
      rd_Dout,
      reg_num_Dout,
      reg_data_Dout,
      reg_write_sig_Dout,
      WB_Data_Dout
  );

endmodule
