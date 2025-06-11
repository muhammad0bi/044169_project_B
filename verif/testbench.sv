`timescale 1ns / 1ps

module tb_top;

  // Clock and reset signal declaration
  logic tb_clk, reset, enable_load_ex_mem; // External memory loading enable

  logic [8:0] InstExMemAddress; // Initialize instruction memory unit
  logic [31:0] InstExMemData1;
  logic [31:0] InstExMemData2;

  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;
  localparam NUM_CYCLES = 50;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .enable_load_ex_mem(enable_load_ex_mem),
      .InstExMemAddress(InstExMemAddress),
      .InstExMemData1(InstExMemData1),
      .InstExMemData2(InstExMemData2)
  );

  initial begin
    tb_clk = 0;
    reset  = 1;
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000000000;
    InstExMemData1 = 32'b00000000000100000000001110010011;
    InstExMemData2 = 32'b00000000010000000000000100010011;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000001000;
    InstExMemData1 = 32'b00000000000000010000001000110011;
    InstExMemData2 = 32'b00000000000000111000001100000011;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000010000;
    InstExMemData1 = 32'b00000000000000100000001100110011;
    InstExMemData2 = 32'b00000000000000110000001110000011;
    #(CLKPERIOD);
    @(posedge tb_clk);
    reset = 0;
    enable_load_ex_mem = 1'b1;
    InstExMemAddress = 9'b000011000;
    InstExMemData1 = 32'b00000000000000110001010000000011;
    InstExMemData2 = 32'b00000000000000110010010010000011;
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
