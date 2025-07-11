`timescale 1 ns / 1 ps

module Memoria32 
    (input  wire  [10:0]address,
     input  wire  Clk,
     input  wire  enable_halt,         
     input  wire  [31:0]Datain1,
     input  wire  [31:0]Datain2,
     output wire  [31:0]Dataout,
     input  wire  Wr // enables writes while debug unit working, else only read to the PC
    );
    
    wire [10:0]usefullAddress = address[10:0]; 

    reg [31:0] inS0;
    reg [31:0] inS1;
    logic mem_clk;

    assign inS0 = Datain1[31:0]; 
    assign inS1 = Datain2[31:0]; 

    wire [31:0]outS0; 
    assign Dataout[31:0] = outS0;
    assign mem_clk = Clk & !enable_halt;

    wire [10:0] addS0 = usefullAddress << 2;
    wire [10:0] addS1 = (usefullAddress + 4) << 2; // for init memory perpurse



    //SRAM Memory block size 2048 X 32 bit
	// Ensure you have the necessary dpram2048x32_CB modules
    dpram2048x32_CB inst_memBlock (
        .A1(addS0), .A2(addS1), .CEB1(mem_clk), .CEB2(mem_clk), .WEB1(Wr), .WEB2(Wr),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS0), .I2(inS1), .O1(outS0), .O2()
    );
        
endmodule
    
    
    
