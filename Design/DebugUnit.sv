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


module DebugUnit #(
    parameter DATA = 32, // Data width
    parameter ADDRESS = 9 // Data/Instruction Memory Address width
  )( 
	input logic clk,
	input logic reset,      
	input logic enable_dubug, // input from the user 
	input logic [ADDRESS-1:0]PC_debug,
	input logic [6:0]opcode,
	input logic [DATA-1:0]FAmux_Result_debug,
	input logic [DATA-1:0]SrcB_debug,
	input logic [6:0]Funct7,
	input logic [2:0]Funct3,
	input logic PcSel_debug,
	input logic [ADDRESS-1:0]BrPC_debug,
	input logic [DATA-1:0]ALUResult_debug,
	input logic [3:0]Operation,
	input logic [ADDRESS-1:0]addr,
	input logic [DATA-1:0]wr_data,
	input logic [DATA-1:0]rd_data,
	input logic wr,
	input logic rd,
	input logic [4:0]reg_num,
	input logic [DATA-1:0]reg_data,
	input logic reg_write_sig,
	input logic [DATA-1:0]WB_Data,
	output logic [6:0]opcodeFetch,
	output logic [6:0]opcodeDecode,
	output logic [6:0]opcodeExecute,
	output logic [6:0]opcodeMem,
	output logic [6:0]opcodeWb,
	output logic [ADDRESS-1:0]PC_Dout,
	output logic [DATA-1:0]FAmux_Dout,
	output logic [DATA-1:0]SrcB_Dout,
	output logic [6:0]Funct7Decode_Dout,
	output logic [2:0]Funct3Decode_Dout,
	output logic [6:0]Funct7Execute_Dout,
	output logic [2:0]Funct3Execute_Dout,
	output logic [6:0]Funct7Mem_Dout,
	output logic [2:0]Funct3Mem_Dout,
	output logic [6:0]Funct7Wb_Dout,
	output logic [2:0]Funct3Wb_Dout,
	output logic PcSel_Dout,
	output logic [ADDRESS-1:0]BrPC_Dout,
	output logic [DATA-1:0]ALUResult_Dout,
	output logic [3:0]Operation_Dout,
	output logic [ADDRESS-1:0]addr_Dout,
	output logic [DATA-1:0]wr_data_Dout,
	output logic [DATA-1:0]rd_data_Dout,
	output logic wr_Dout,
	output logic rd_Dout,
	output logic [4:0]reg_num_Dout,
	output logic [DATA-1:0]reg_data_Dout,
	output logic reg_write_sig_Dout,
	output logic [DATA-1:0]WB_Data_Dout
);

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

assign PC_Dout = PC_debug;
assign FAmux_Dout = FAmux_Result_debug;
assign SrcB_Dout = SrcB_debug;
assign PcSel_Dout = PcSel_debug;
assign BrPC_Dout= BrPC_debug;
assign ALUResult_Dout = ALUResult_debug;
assign Operation_Dout = Operation;
assign addr_Dout = addr;
assign wr_data_Dout = wr_data;
assign rd_data_Dout = rd_data;
assign wr_Dout = wr;
assign rd_Dout = rd;
assign reg_num_Dout = reg_num;
assign reg_data_Dout = reg_data;
assign reg_write_sig_Dout = reg_write_sig;
assign WB_Data_Dout = WB_Data;



endmodule
