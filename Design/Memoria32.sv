`timescale 1 ns / 1 ps

module Memoria32 
    (input  wire  [31:0]address,
     input  wire  Clk,         
     input  wire  [31:0]Datain1,
     input  wire  [31:0]Datain2,
     output wire  [31:0]Dataout,
     input  wire  Wr // enables writes while debug unit working, else only read to the PC
    );
    
    wire [10:0]usefullAddress = address[10:0]; 

    reg [31:0] inS0;
    reg [31:0] inS1;

    assign inS0 = Datain1[31:0]; 
    assign inS1 = Datain2[31:0]; 

    wire [31:0]outS0; 
    assign Dataout[31:0] = outS0;

    reg [10:0] addS0 = usefullAddress;
    reg [10:0] addS1 = usefullAddress + 1;



    //SRAM Memory block size 2048 X 32 bit
	// Ensure you have the necessary dpram2048x32_CB modules
    dpram2048x32_CB inst_memBlock (
        .A1(addS0), .A2(addS0), .CEB1(Clk), .CEB2(Clk), .WEB1(!Wr), .WEB2(!Wr),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS0), .I2(inS1), .O1(outS0), .O2()
    );
        
endmodule
    
    
    
