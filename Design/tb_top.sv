`timescale 1ns / 1ps

module tb_top;

  //clock and reset signal declaration
  logic tb_clk, reset, enable_load_ex_mem, enable_half; // external memory loading enable  

  logic [8:0]DataExMemAddress; // init data mem unit
  logic [31:0]DataExMemData1; 
  logic [31:0]DataExMemData2; 

  logic [8:0]InstExMemAddress; // init inst mem unit
  logic [31:0]InstExMemData1; 
  logic [31:0]InstExMemData2; 

  logic [4:0] DebugSel;
  logic [31:0] DebugOutput; 

  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;
  localparam NUM_CYCLES = 50;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .enable_load_ex_mem(enable_load_ex_mem), // debug enable 
      .enable_half(enable_half), // enable debug
      .DataExMemAddress(DataExMemAddress), // debug and init mem unit
      .DataExMemData1(DataExMemData1), 
      .DataExMemData2(DataExMemData2), 
      .InstExMemAddress(InstExMemAddress), // debug and init inst mem unit
      .InstExMemData1(InstExMemData1), 
      .InstExMemData2(InstExMemData2), 
      .DebugSel(DebugSel),
      .DebugOutput(DebugOutput) 
  );

  initial begin
    tb_clk = 0;
    reset  = 1;
    enable_half = 1'b0;
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
    DebugSel = 5'b11010;
    #(CLKPERIOD);
    reset  = 0; 
    enable_load_ex_mem = 1'b0;

    #(CLKPERIOD * 3);
    enable_half = 1'b0;

    #(CLKPERIOD);
    enable_half = 1'b0;

    #(CLKPERIOD);
    enable_half = 1'b0;

    #(CLKPERIOD * 4);
    enable_half = 1'b0;

    #(CLKPERIOD);
    enable_half = 1'b1;

    #(CLKPERIOD);
    enable_half = 1'b0;
    #(CLKPERIOD * NUM_CYCLES);


    $stop;
  end


always begin
  //clock generator
  #(CLKDELAY) tb_clk = ~tb_clk;
end

endmodule
