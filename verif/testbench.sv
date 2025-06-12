`timescale 1ns / 1ps

module tb_top;

  // Clock and reset signal declaration
  logic tb_clk, reset, enable_load_ex_mem; // External memory loading enable

  logic [8:0]  InstExMemAddress; // Initialize instruction memory unit
  logic [31:0] InstExMemData1;
  logic [31:0] InstExMemData2;

  logic [8:0]  DataExMemAddress; // Initialize data memory unit
  logic [31:0] DataExMemData1;
  logic [31:0] DataExMemData2;
  logic [4:0]  DebugSel;
  logic [31:0] DebugOutput;
  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;
  localparam NUM_CYCLES = 50;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .enable_load_ex_mem(enable_load_ex_mem),
      .enable_halt(enable_halt), // enable debug
      .DataExMemAddress(DataExMemAddress),
      .DataExMemData1(DataExMemData1),
      .DataExMemData2(DataExMemData2),
      .InstExMemAddress(InstExMemAddress),
      .InstExMemData1(InstExMemData1),
      .InstExMemData2(InstExMemData2),
      .DebugSel(DebugSel),
      .DebugOutput(DebugOutput),
  );

  initial begin
    tb_clk = 0;
    reset  = 1;
    enable_halt  = 0;
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000000000;
    InstExMemData1 = 32'b00000000000100000000001110010011;
    InstExMemData2 = 32'b00000000010000000000000100010011;
    DataExMemAddress = 9'b000000000;
    DataExMemData1 = 32'b11111111111111111010101010000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000001000;
    InstExMemData1 = 32'b00000000000000010000001000110011;
    InstExMemData2 = 32'b00000000000000111000001100000011;
    DataExMemAddress = 9'b000001000;
    DataExMemData1 = 32'b10000000000000000000000000000000;
    DataExMemData2 = 32'b01000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000010000;
    InstExMemData1 = 32'b00000000000000100000001100110011;
    InstExMemData2 = 32'b00000000000000110000001110000011;
    DataExMemAddress = 9'b000010000;
    DataExMemData1 = 32'b00000000010000000000000000000000;
    DataExMemData2 = 32'b00000000010000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000011000;
    InstExMemData1 = 32'b00000000000000110001010000000011;
    InstExMemData2 = 32'b00000000000000110010010010000011;
    DataExMemAddress = 9'b000011000;
    DataExMemData1 = 32'b00000000000000000010000000000000;
    DataExMemData2 = 32'b00000000001000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b000100000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b000101000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b000110000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b000111000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001000000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001001000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001010000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001011000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001100000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001101000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001110000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b001111000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010000000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010001000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010010000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010011000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010100000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010101000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010110000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b010111000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011000000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011001000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011010000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011011000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011100000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011101000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011110000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    DataExMemAddress = 9'b011111000;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);
    reset  = 1;
    #(CLKPERIOD);
    reset  = 0;
    enable_load_ex_mem = 1'b0;
    #(CLKPERIOD * NUM_CYCLES);

    $stop;
  end

  always begin
    #(CLKDELAY) tb_clk = ~tb_clk;
  end

endmodule
