`timescale 1 ns / 1 ps

module Memoria32Data
    (input  wire  [11:0]address,// note that waddress = raddress
     input  wire  Clk,   
     input  wire  enable_half,      
     input  wire  [31:0]Datain1,
     input  wire  [31:0]Datain2,
     output wire  [31:0]Dataout,
     input  wire  [3:0]Wr,
     input  wire  enable_load_ex_mem
    );
    

    wire [11:0] usefullAddress = address[11:0];

    // Declare the address registers instead of wires
    reg [11:0] addS0, addS1, addS2, addS3;
    reg [11:0] addS0_2, addS1_2, addS2_2, addS3_2; // used only for mem init
    reg [7:0] inS0, inS1, inS2, inS3;
    reg [7:0] inS0_2, inS1_2, inS2_2, inS3_2; // used only for mem init
    reg Wr0, Wr1, Wr2, Wr3;
    wire [7:0] outS0, outS1, outS2, outS3;
    logic memory_init;

    // Determine the address offset based on the least significant bits
    wire [1:0] address_offset = address[1:0];

    // Assign Dataout based on the address offset
    assign Dataout = (address_offset == 2'b00) ? {outS3, outS2, outS1, outS0} :
                     (address_offset == 2'b01) ? {outS0, outS3, outS2, outS1} :
                     (address_offset == 2'b10) ? {outS1, outS0, outS3, outS2} :
                     {outS2, outS1, outS0, outS3};

    always_comb begin
      if (enable_load_ex_mem) begin
			addS0 = usefullAddress >> 2;
			addS1 = (usefullAddress + 1) >> 2;
			addS2 = (usefullAddress + 2) >> 2;
			addS3 = (usefullAddress + 3) >> 2;

			inS3 = Datain1[31:24];
			inS2 = Datain1[23:16];
			inS1 = Datain1[15:8];
			inS0 = Datain1[7:0];

			addS0_2 = (usefullAddress + 4) >> 2;
			addS1_2 = (usefullAddress + 4 + 1) >> 2;
			addS2_2 = (usefullAddress + 4 + 2) >> 2;
			addS3_2 = (usefullAddress + 4 + 3) >> 2;

			inS3_2 = Datain2[31:24];
			inS2_2 = Datain2[23:16];
			inS1_2 = Datain2[15:8];
			inS0_2 = Datain2[7:0];

				Wr0 = ~Wr[0];
				Wr1 = ~Wr[1];
				Wr2 = ~Wr[2];
				Wr3 = ~Wr[3];

	        		memory_init = 1'b0; // using the second slot X2 boosting the memory init 
					       // works only when debugging and initing mem -> ! since sram works on low active

      end 
      else begin 
		memory_init = 1'b1; // not using the second slot -> !enable
        case (usefullAddress[1:0])
            2'b00: begin
                addS0 = usefullAddress >> 2;
                addS1 = (usefullAddress + 1) >> 2;
                addS2 = (usefullAddress + 2) >> 2;
                addS3 = (usefullAddress + 3) >> 2;

                inS3 = Datain1[31:24];
                inS2 = Datain1[23:16];
                inS1 = Datain1[15:8];
                inS0 = Datain1[7:0];

				Wr0 = ~Wr[0];
				Wr1 = ~Wr[1];
				Wr2 = ~Wr[2];
				Wr3 = ~Wr[3];
            end
            2'b01: begin
                addS0 = (usefullAddress + 3) >> 2;
                addS1 = usefullAddress >> 2;
                addS2 = (usefullAddress + 1) >> 2;
                addS3 = (usefullAddress + 2) >> 2;

                inS0 = Datain1[31:24];
                inS3 = Datain1[23:16];
                inS2 = Datain1[15:8];
                inS1 = Datain1[7:0];

				Wr0 = ~Wr[3];
				Wr1 = ~Wr[0];
				Wr2 = ~Wr[1];
				Wr3 = ~Wr[2];
            end
            2'b10: begin
                addS0 = (usefullAddress + 2) >> 2;
                addS1 = (usefullAddress + 3) >> 2;
                addS2 = usefullAddress >> 2;
                addS3 = (usefullAddress + 1) >> 2;

                inS1 = Datain1[31:24];
                inS0 = Datain1[23:16];
                inS3 = Datain1[15:8];
                inS2 = Datain1[7:0];

				Wr0 = ~Wr[2];
				Wr1 = ~Wr[3];
				Wr2 = ~Wr[0];
				Wr3 = ~Wr[1];
            end
            default: begin
                addS0 = (usefullAddress + 1) >> 2;
                addS1 = (usefullAddress + 2) >> 2;
                addS2 = (usefullAddress + 3) >> 2;
                addS3 = usefullAddress >> 2;

                inS2 = Datain1[31:24];
                inS1 = Datain1[23:16];
                inS0 = Datain1[15:8];
                inS3 = Datain1[7:0];

				Wr0 = ~Wr[1];
				Wr1 = ~Wr[2];
				Wr2 = ~Wr[3];
				Wr3 = ~Wr[0];
            end
        endcase
      end
    end

    //SRAM Memory blocks size 4096 X 32 bit (each block has 4096 bytes)
    // Ensure you have the necessary dpram4096x8 modules
    dpram4096x8 memBlock0 (
        .A1(addS0), .A2(addS0_2), .CEB1(Clk & !enable_half), .CEB2(Clk & !enable_half), .WEB1(Wr0), .WEB2(memory_init),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS0), .I2(inS0_2), .O1(outS0), .O2()
    );
    dpram4096x8 memBlock1 (
        .A1(addS1), .A2(addS1_2), .CEB1(Clk & !enable_half), .CEB2(Clk & !enable_half), .WEB1(Wr1), .WEB2(memory_init),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS1), .I2(inS1_2), .O1(outS1), .O2()
    );
    dpram4096x8 memBlock2 (
        .A1(addS2), .A2(addS2_2), .CEB1(Clk & !enable_half), .CEB2(Clk & !enable_half), .WEB1(Wr2), .WEB2(memory_init),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS2), .I2(inS2_2), .O1(outS2), .O2()
    );
    dpram4096x8 memBlock3 (
        .A1(addS3), .A2(addS3_2), .CEB1(Clk & !enable_half), .CEB2(Clk & !enable_half), .WEB1(Wr3), .WEB2(memory_init),
        .OEB1(1'b0), .OEB2(1'b0), .CSB1(1'b0), .CSB2(1'b0), .I1(inS3), .I2(inS3_2), .O1(outS3), .O2()
    );

endmodule
