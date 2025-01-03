/*-----------------------------------------------------------------------------
-- Title		: Memória da CPU
-- Project		: CPU 
--------------------------------------------------------------------------------
-- File			: memoria64.sv
-- Author		: Lucas Fernando da Silva Cambuim <lfsc@cin.ufpe.br>
-- Organization : Universidade Federal de Pernambuco
-- Created		: 20/09/2018
-- Last update	: 20/09/2018
-- Plataform	: DE2
-- Simulators	: ModelSim
-- Synthesizers	: 
-- Targets		: 
-- Dependency	: 
--------------------------------------------------------------------------------
-- Description	: Entidade responsável pela leitura e escrita em memória (dados de 64 bits).
--------------------------------------------------------------------------------
-- Copyright (c) notice
--		Universidade Federal de Pernambuco (UFPE).
--		CIn - Centro de Informatica.
--		Developed by computer science researchers.
--		This code may be used for educational and non-educational purposes as 
--		long as its copyright notice remains unchanged. 
------------------------------------------------------------------------------*/
`timescale 1 ns / 1 ps

module Memoria32Data
    (input  wire  [31:0]raddress,
     input  wire  [31:0]waddress,// note that waddress = raddress
     input  wire  Clk,         
     input  wire  [31:0]Datain,
     output wire  [31:0]Dataout,
     input  wire  [3:0]Wr
    );
    

    wire [11:0] readUsefullAddress = raddress[11:0];

    // Declare the address registers instead of wires
    reg [11:0] addS0, addS1, addS2, addS3;
    reg [7:0] inS0, inS1, inS2, inS3;
    reg Wr0, Wr1, Wr2, Wr3;
    wire [7:0] outS0, outS1, outS2, outS3;

    // Determine the address offset based on the least significant bits
    wire [1:0] address_offset = raddress[1:0];

    // Assign Dataout based on the address offset
    assign Dataout = (address_offset == 2'b00) ? {outS3, outS2, outS1, outS0} :
                     (address_offset == 2'b01) ? {outS0, outS3, outS2, outS1} :
                     (address_offset == 2'b10) ? {outS1, outS0, outS3, outS2} :
                     {outS2, outS1, outS0, outS3};

    always_comb begin
        case (readUsefullAddress[1:0])
            2'b00: begin
                addS0 = readUsefullAddress >> 2;
                addS1 = (readUsefullAddress + 1) >> 2;
                addS2 = (readUsefullAddress + 2) >> 2;
                addS3 = (readUsefullAddress + 3) >> 2;

                inS3 = Datain[31:24];
                inS2 = Datain[23:16];
                inS1 = Datain[15:8];
                inS0 = Datain[7:0];

		Wr0 = ~Wr[0];
		Wr1 = ~Wr[1];
		Wr2 = ~Wr[2];
		Wr3 = ~Wr[3];
            end
            2'b01: begin
                addS0 = (readUsefullAddress + 3) >> 2;
                addS1 = readUsefullAddress >> 2;
                addS2 = (readUsefullAddress + 1) >> 2;
                addS3 = (readUsefullAddress + 2) >> 2;

                inS0 = Datain[31:24];
                inS3 = Datain[23:16];
                inS2 = Datain[15:8];
                inS1 = Datain[7:0];

		Wr0 = ~Wr[3];
		Wr1 = ~Wr[0];
		Wr2 = ~Wr[1];
		Wr3 = ~Wr[2];
            end
            2'b10: begin
                addS0 = (readUsefullAddress + 2) >> 2;
                addS1 = (readUsefullAddress + 3) >> 2;
                addS2 = readUsefullAddress >> 2;
                addS3 = (readUsefullAddress + 1) >> 2;

                inS1 = Datain[31:24];
                inS0 = Datain[23:16];
                inS3 = Datain[15:8];
                inS2 = Datain[7:0];

		Wr0 = ~Wr[2];
		Wr1 = ~Wr[3];
		Wr2 = ~Wr[0];
		Wr3 = ~Wr[1];
            end
            default: begin
                addS0 = (readUsefullAddress + 1) >> 2;
                addS1 = (readUsefullAddress + 2) >> 2;
                addS2 = (readUsefullAddress + 3) >> 2;
                addS3 = readUsefullAddress >> 2;

                inS2 = Datain[31:24];
                inS1 = Datain[23:16];
                inS0 = Datain[15:8];
                inS3 = Datain[7:0];

		Wr0 = ~Wr[1];
		Wr1 = ~Wr[2];
		Wr2 = ~Wr[3];
		Wr3 = ~Wr[0];
            end
        endcase
    end

    // Memory blocks (each bank has 4096*4 bytes)
    // Ensure you have the necessary dpram4096x8 modules
    dpram4096x8 memBlock0 (
        .A1(addS0), .A2(addS0), .CEB1(Clk), .CEB2(Clk), .WEB1(Wr0), .WEB2(1'b1),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS0), .I2(8'b0), .O1(outS0), .O2()
    );
    dpram4096x8 memBlock1 (
        .A1(addS1), .A2(addS0), .CEB1(Clk), .CEB2(Clk), .WEB1(Wr1), .WEB2(1'b1),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS1), .I2(8'b0), .O1(outS1), .O2()
    );
    dpram4096x8 memBlock2 (
        .A1(addS2), .A2(addS0), .CEB1(Clk), .CEB2(Clk), .WEB1(Wr2), .WEB2(1'b1),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS2), .I2(8'b0), .O1(outS2), .O2()
    );
    dpram4096x8 memBlock3 (
        .A1(addS3), .A2(addS0), .CEB1(Clk), .CEB2(Clk), .WEB1(Wr3), .WEB2(1'b1),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS3), .I2(8'b0), .O1(outS3), .O2()
    );

endmodule
