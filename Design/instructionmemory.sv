`timescale 1ns / 1ps

module instructionmemory (
    input logic clk,  // Clock
    input logic enable_debug,
    input logic enable_load_ex_mem,
    input logic [8:0] raddress,  // Read address of the instruction memory , comes from PC
    input logic [8:0] InstExMemAddress,
    input logic [31:0] InstExMemData1, // init instruct
    input logic [31:0] InstExMemData2, // init instruct

    output logic [31:0] rd  // Read Data
);

  logic [10:0] address;
  logic [31:0] Datain1;
  logic [31:0] Datain2; 
  logic [31:0] DataOut;  // Data output from the memory

  Memoria32 meminst (
      .address(address),
      .Clk(clk),
      .enable_debug(enable_debug),
      .Datain1(Datain1),
      .Datain2(Datain2),
      .Dataout(DataOut),
      .Wr(!(enable_load_ex_mem))
  );

  assign address = enable_load_ex_mem ? {{1'b0}, InstExMemAddress} : {{1'b0}, raddress};
  assign Datain1 = enable_load_ex_mem ? InstExMemData1[31:0] : 32'b0;
  assign Datain2 = enable_load_ex_mem ? InstExMemData2[31:0] : 32'b0; 
  assign rd = DataOut;

endmodule
