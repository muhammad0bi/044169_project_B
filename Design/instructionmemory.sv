`timescale 1ns / 1ps

module instructionmemory #(
    parameter INS_ADDRESS = 9,
    parameter INS_W = 32
) (
    input logic clk,  // Clock
    input logic enable_debug,
    input logic [INS_ADDRESS -1:0] raddress,  // Read address of the instruction memory , comes from PC
    input logic [INS_ADDRESS -1:0] debug_address,
    input logic [INS_W -1:0] debug_inst_data1, // init instruct
    input logic [INS_W -1:0] debug_inst_data2, // init instruct

    output logic [INS_W -1:0] rd  // Read Data
);

  logic [31:0] address;
  logic [31:0] Datain1;
  logic [31:0] Datain2; 
  logic [31:0] DataOut;  // Data output from the memory

  Memoria32 meminst (
      .address(address),
      .Clk(clk),
      .Datain1(Datain1),
      .Datain2(Datain2),
      .Dataout(DataOut),
      .Wr(!(enable_debug))
  );

  assign address = enable_debug ? {{23{1'b0}}, debug_address} : {{23{1'b0}}, raddress};
  assign Datain1 = enable_debug ? debug_inst_data1[INS_W -1:0] : 32'b0;
  assign Datain2 = enable_debug ? debug_inst_data2[INS_W -1:0] : 32'b0; 
  assign rd = DataOut;

endmodule
