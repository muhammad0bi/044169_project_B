`timescale 1ns / 1ps

module tb_top;

  //clock and reset signal declaration
  logic tb_clk, reset, enable_debug; // debug enable 

  logic [8:0]DebugAddress; // debug and init mem unit
  logic [31:0]DebugData1; 
  logic [31:0]DebugData2; 

  logic [8:0]debug_inst_addr; // debug and init inst mem unit
  logic [31:0]debug_inst_data1; 
  logic [31:0]debug_inst_data2; 

  logic [31:0] tb_WB_Data;
  logic [4:0] reg_num;
  logic [31:0] reg_data;
  logic reg_write_sig;
  logic wr;
  logic rd;
  logic [8:0] addr;
  logic [31:0] wr_data;
  logic [31:0] rd_data;

  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;
  localparam NUM_CYCLES = 50;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .enable_debug(enable_debug), // debug enable 
      .DebugAddress(DebugAddress), // debug and init mem unit
      .DebugData1(DebugData1), 
      .DebugData2(DebugData2), 
      .debug_inst_addr(debug_inst_addr), // debug and init inst mem unit
      .debug_inst_data1(debug_inst_data1), 
      .debug_inst_data2(debug_inst_data2), 
      .WB_Data(tb_WB_Data),
      .reg_num(reg_num),
      .reg_data(reg_data),
      .reg_write_sig(reg_write_sig),
      .wr(wr),
      .rd(rd),
      .addr(addr),
      .wr_data(wr_data),
      .rd_data(rd_data)
  );

  initial begin
    tb_clk = 0;
    reset  = 1;
    @(posedge tb_clk);
    reset = 0;
    enable_debug = 1'b1;
    debug_inst_addr = 9'b0;
    debug_inst_data1 = 32'b00000000000100000000001110010011;
    debug_inst_data2 = 32'b00000000000000111000001100000011;
    DebugAddress = 9'b0;; // debug and init mem unit
    DebugData1 = 32'b00000000000000001000111100000000; 
    DebugData2 = 32'b00000000000000000000000011111111;
    #(CLKPERIOD);
    reset  = 1; 

    #(CLKPERIOD);
    reset  = 0; 
    enable_debug = 1'b0;
    #(CLKPERIOD * NUM_CYCLES);

    $stop;
  end
  
  always @(posedge tb_clk) begin : REGISTER
    if (reg_write_sig)
      $display($time, ": Register [%d] written with value: [%X] | [%d]\n", reg_num, reg_data, $signed(reg_data));
  end : REGISTER

  always @(posedge tb_clk) begin : MEMORY
    if (wr && ~rd)
      $display($time, ": Memory [%d] written with value: [%X] | [%d]\n", addr, wr_data, $signed(wr_data));

    else if (rd && ~wr)
      $display($time, ": Memory [%d] read with value: [%X] | [%d]\n", addr, rd_data, $signed(rd_data));
  end : MEMORY

always begin
  //clock generator
  #(CLKDELAY) tb_clk = ~tb_clk;
end

endmodule
