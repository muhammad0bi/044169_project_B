`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Omar Sharafi & muhammad Biadsy
// 
// Create Date: 12/01/2025 
// Design Name: 
// Module Name: DebugUnit
// Project Name: BackenedRsic-v
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DebugUnit
( 
	input logic clk,
	input logic reset,      
	input logic [8:0]PC_debug,
	input logic [6:0]opcode,
	input logic [31:0]FAmux_Result_debug,
	input logic [31:0]SrcB_debug,
	input logic [6:0]Funct7,
	input logic [2:0]Funct3,
	input logic PcSel_debug,
	input logic [8:0]BrPC_debug,
	input logic [31:0]ALUResult_debug,
	input logic [3:0]Operation,
	input logic [8:0]addr,
	input logic [31:0]wr_data,
	input logic [31:0]rd_data,
	input logic wr,
	input logic rd,
	input logic [4:0]reg_num,
	input logic [31:0]reg_data,
	input logic reg_write_sig,
	input logic [31:0]WB_Data,
	
	input logic [4:0] DebugSel,
	output logic [31:0] DebugOutput 
);

	logic [6:0]opcodeFetch;
	logic [6:0]opcodeDecode;
        logic [6:0]opcodeExecute;
	logic [6:0]opcodeMem;
	logic [6:0]opcodeWb;
	logic [6:0]Funct7Decode_Dout;
	logic [2:0]Funct3Decode_Dout;
	logic [6:0]Funct7Execute_Dout;
	logic [2:0]Funct3Execute_Dout;
	logic [6:0]Funct7Mem_Dout;
	logic [2:0]Funct3Mem_Dout;
	logic [6:0]Funct7Wb_Dout;
	logic [2:0]Funct3Wb_Dout;

    always @(posedge clk) 
    begin
	if (reset) begin
		opcodeFetch <= 0;
		opcodeDecode <= 0;
		opcodeExecute <= 0;
		opcodeMem <= 0;
		opcodeWb <= 0;

	end
	else begin
		opcodeFetch <= opcode;
		opcodeDecode <= opcodeFetch;
		opcodeExecute <= opcodeDecode;
		opcodeMem <= opcodeExecute;
		opcodeWb <= opcodeMem;

		Funct7Decode_Dout <= Funct7;
		Funct3Decode_Dout <= Funct3;
		Funct7Execute_Dout <= Funct7Decode_Dout;
		Funct3Execute_Dout <= Funct3Decode_Dout;
		Funct7Mem_Dout <= Funct7Execute_Dout;
		Funct3Mem_Dout <= Funct3Execute_Dout;
		Funct7Wb_Dout <= Funct7Mem_Dout;
		Funct3Wb_Dout <= Funct3Mem_Dout;


		
	end
    end

mux32 DebugMux({25'b0,opcodeFetch},
		{25'b0,opcodeDecode},
		{25'b0,opcodeExecute},
		{25'b0,opcodeMem},
		{25'b0,opcodeWb},
		{25'b0,Funct7Decode_Dout},
		{29'b0,Funct3Decode_Dout},
		{25'b0,Funct7Execute_Dout},
		{29'b0,Funct3Execute_Dout},
		{25'b0,Funct7Mem_Dout},
		{29'b0,Funct3Mem_Dout},
		{25'b0,Funct7Wb_Dout},
		{29'b0,Funct3Wb_Dout},
		{23'b0,PC_debug},
		FAmux_Result_debug,
		SrcB_debug,
		{31'b0,PcSel_debug},
		{23'b0,BrPC_debug},
		ALUResult_debug,
		{28'b0,Operation},
		{23'b0,addr},
		wr_data,
		rd_data,
		{31'b0,wr},
		{31'b0,rd},
		{27'b0,reg_num},
		reg_data,
		{31'b0,reg_write_sig},
		WB_Data,
                {32'b0},
                {32'b0},
                {32'b0},
		DebugSel,
		DebugOutput);


endmodule
