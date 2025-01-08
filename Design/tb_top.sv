`timescale 1ns / 1ps

module tb_top;

  //clock and reset signal declaration
  logic tb_clk, reset, enable_load_ex_mem; // external memory loading enable  

  logic [8:0]DataExMemAddress; // init data mem unit
  logic [31:0]DataExMemData1; 
  logic [31:0]DataExMemData2; 

  logic [8:0]InstExMemAddress; // init inst mem unit
  logic [31:0]InstExMemData1; 
  logic [31:0]InstExMemData2; 

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
      .enable_load_ex_mem(enable_load_ex_mem), // debug enable 
      .DataExMemAddress(DataExMemAddress), // debug and init mem unit
      .DataExMemData1(DataExMemData1), 
      .DataExMemData2(DataExMemData2), 
      .InstExMemAddress(InstExMemAddress), // debug and init inst mem unit
      .InstExMemData1(InstExMemData1), 
      .InstExMemData2(InstExMemData2), 
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
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b0;
    InstExMemData1 = 32'b00000000000100000000001110010011;
    InstExMemData2 = 32'b00000000000000111000001100000011;
    DataExMemAddress = 9'b0;; // debug and init mem unit
    DataExMemData1 = 32'b00000000000000001000111100000000; 
    DataExMemData2 = 32'b00000000000000000000000011111111;
    #(CLKPERIOD);
    reset  = 1; 

    #(CLKPERIOD);
    reset  = 0; 
    enable_load_ex_mem = 1'b0;
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
