`timescale 1ns / 1ps

module RegFile
   (
   // Inputs 
   input  clk, //clock
   input enable_half,
   input  rst,//synchronous reset; if it is asserted (rst=1), all registers are reseted to 0
   input  rg_wrt_en, //write signal
   input  [4:0] rg_wrt_dest, //address of the register that supposed to written into
   input  [4:0] rg_rd_addr1, //first address to be read from
   input  [4:0] rg_rd_addr2, //second address to be read from
   input  [31:0] rg_wrt_data, // data that supposed to be written into the register file
         
   // Outputs
   output logic [31:0] rg_rd_data1,   //content of reg_file[rg_rd_addr1] is loaded into
   output logic [31:0] rg_rd_data2    //content of reg_file[rg_rd_addr2] is loaded into
   );

integer 	 i;

logic [31:0] register_file [31:0];

always @( negedge clk ) 
begin
    if (!enable_half)
    begin
    if( rst == 1'b1 )
        for (i = 0; i < 32 ; i = i + 1)
            register_file [i] <= 0;
    else if( rst ==1'b0 && rg_wrt_en ==1'b1 ) begin
        register_file [ rg_wrt_dest ] <= rg_wrt_data;
    end
    end
end

assign rg_rd_data1 = register_file[rg_rd_addr1];
assign rg_rd_data2 = register_file[rg_rd_addr2];

endmodule
