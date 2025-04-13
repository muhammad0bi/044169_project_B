`timescale 1ns / 1ps

module tb_top;

  // Clock and reset signal declaration
  logic tb_clk, reset, enable_load_ex_mem; // External memory loading enable

  logic [8:0] InstExMemAddress; // Initialize instruction memory unit
  logic [31:0] InstExMemData1;
  logic [31:0] InstExMemData2;

  logic [8:0] DataExMemAddress; // Initialize data memory unit
  logic [31:0] DataExMemData1;
  logic [31:0] DataExMemData2;
  logic [31:0] tb_WB_Data;
  logic [31:0] reg_data;
  logic [4:0] reg_num;
  logic reg_write_sig; // Initialize data memory unit
  logic rd;
  logic wr;
  logic [8:0] addr; // Initialize data memory unit
  logic [31:0] wr_data;
  logic [31:0] rd_data;

  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;
  localparam NUM_CYCLES = 50;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .enable_load_ex_mem(enable_load_ex_mem),
      .DataExMemAddress(DataExMemAddress),
      .DataExMemData1(DataExMemData1),
      .DataExMemData2(DataExMemData2),
      .InstExMemAddress(InstExMemAddress),
      .InstExMemData1(InstExMemData1),
      .InstExMemData2(InstExMemData2),
      .WB_Data(WB_Data),
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
    InstExMemAddress = 9'b000000000;
    InstExMemData1 = 32'b00000000000100000000001110010011;
    InstExMemData2 = 32'b00000000010000000000000100010011;
    DataExMemAddress = 9'd0;
    DataExMemData1 = 32'b11111111111111111010101010000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b000001000;
    InstExMemData1 = 32'b00000000000000010000001000110011;
    InstExMemData2 = 32'b00000000000000111000001100000011;
    DataExMemAddress = 9'd8;
    DataExMemData1 = 32'b10000000000000000000000000000000;
    DataExMemData2 = 32'b01000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b000010000;
    InstExMemData1 = 32'b00000000000000100000001100110011;
    InstExMemData2 = 32'b00000000000000110000001110000011;
    DataExMemAddress = 9'd16;
    DataExMemData1 = 32'b00000000010000000000000000000000;
    DataExMemData2 = 32'b00000000010000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b000011000;
    InstExMemData1 = 32'b00000000000000110001010000000011;
    InstExMemData2 = 32'b00000000000000110010010010000011;
    DataExMemAddress = 9'd24;
    DataExMemData1 = 32'b00000000000000000010000000000000;
    DataExMemData2 = 32'b00000000001000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b000100000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd32;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b000101000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd40;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b000110000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd48;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b000111000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd56;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001000000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd64;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001001000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd72;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001010000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd80;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001011000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd88;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001100000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd96;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001101000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd104;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001110000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd112;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b001111000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd120;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010000000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd128;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010001000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd136;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010010000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd144;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010011000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd152;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010100000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd160;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010101000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd168;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010110000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd176;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b010111000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd184;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011000000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd192;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011001000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd200;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011010000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd208;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011011000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd216;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011100000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd224;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011101000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd232;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011110000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd240;
    DataExMemData1 = 32'b00000000000000000000000000000000;
    DataExMemData2 = 32'b00000000000000000000000000000000;
    #(CLKPERIOD);

    @(posedge tb_clk);
    InstExMemAddress = 9'b011111000;
    InstExMemData1 = 32'b00000000000000000000000000000000;
    InstExMemData2 = 32'b00000000000000000000000000000000;
    DataExMemAddress = 9'd248;
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
