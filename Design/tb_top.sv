`timescale 1ns / 1ps

module tb_top;

  //clock and reset signal declaration
  logic tb_clk, reset, enable_load_ex_mem, enable_dubug; // external memory loading enable  

  logic [8:0]DataExMemAddress; // init data mem unit
  logic [31:0]DataExMemData1; 
  logic [31:0]DataExMemData2; 

  logic [8:0]InstExMemAddress; // init inst mem unit
  logic [31:0]InstExMemData1; 
  logic [31:0]InstExMemData2; 

       logic [6:0]opcodeFetch;
       logic [6:0]opcodeDecode;
       logic [6:0]opcodeExecute;
       logic [6:0]opcodeMem;
       logic [6:0]opcodeWb;
       logic [8:0]PC_Dout;
       logic [31:0]FAmux_Dout;
       logic [31:0]SrcB_Dout;
       logic [6:0]Funct7Decode_Dout;
       logic [2:0]Funct3Decode_Dout;
       logic [6:0]Funct7Execute_Dout;
       logic [2:0]Funct3Execute_Dout;
       logic [6:0]Funct7Mem_Dout;
       logic [2:0]Funct3Mem_Dout;
       logic [6:0]Funct7Wb_Dout;
       logic [2:0]Funct3Wb_Dout;
       logic PcSel_Dout;
       logic [8:0]BrPC_Dout;
       logic [31:0]ALUResult_Dout;
       logic [3:0]Operation_Dout;
       logic [8:0]addr_Dout;
       logic [31:0]wr_data_Dout;
       logic [31:0]rd_data_Dout;
       logic wr_Dout;
       logic rd_Dout;
       logic [4:0]reg_num_Dout;
       logic [31:0]reg_data_Dout;
       logic reg_write_sig_Dout;
       logic [31:0]WB_Data_Dout;
  

  localparam CLKPERIOD = 10;
  localparam CLKDELAY = CLKPERIOD / 2;
  localparam NUM_CYCLES = 50;

  riscv riscV (
      .clk(tb_clk),
      .reset(reset),
      .enable_load_ex_mem(enable_load_ex_mem), // debug enable 
      .enable_dubug(enable_dubug), // enable debug
      .DataExMemAddress(DataExMemAddress), // debug and init mem unit
      .DataExMemData1(DataExMemData1), 
      .DataExMemData2(DataExMemData2), 
      .InstExMemAddress(InstExMemAddress), // debug and init inst mem unit
      .InstExMemData1(InstExMemData1), 
      .InstExMemData2(InstExMemData2), 
      .opcodeFetch(opcodeFetch),
      .opcodeDecode(opcodeDecode),
      .opcodeExecute(opcodeExecute),
      .opcodeMem(opcodeMem),
      .opcodeWb(opcodeWb),
      .PC_Dout(PC_Dout),
      .FAmux_Dout(FAmux_Dout),
      .SrcB_Dout(SrcB_Dout),
      .Funct7Decode_Dout(Funct7Decode_Dout),
      .Funct3Decode_Dout(Funct3Decode_Dout),
      .Funct7Execute_Dout(Funct7Execute_Dout),
      .Funct3Execute_Dout(Funct3Execute_Dout),
      .Funct7Mem_Dout(Funct7Mem_Dout),
      .Funct3Mem_Dout(Funct3Mem_Dout),
      .Funct7Wb_Dout(Funct7Wb_Dout),
      .Funct3Wb_Dout(Funct3Wb_Dout),
      .PcSel_Dout(PcSel_Dout),
      .BrPC_Dout(BrPC_Dout),
      .ALUResult_Dout(ALUResult_Dout),
      .Operation_Dout(Operation_Dout),
      .addr_Dout(addr_Dout),
      .wr_data_Dout(wr_data_Dout),
      .rd_data_Dout(rd_data_Dout),
      .wr_Dout(wr_Dout),
      .rd_Dout(rd_Dout),
      .reg_num_Dout(reg_num_Dout),
      .reg_data_Dout(reg_data_Dout),
      .reg_write_sig_Dout(reg_write_sig_Dout),
      .WB_Data_Dout(WB_Data_Dout)
  );

  initial begin
    tb_clk = 0;
    reset  = 1;
    enable_dubug = 1'b0;
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

    #(CLKPERIOD * 3);
    enable_dubug = 1'b1;

    #(CLKPERIOD);
    enable_dubug = 1'b0;

    #(CLKPERIOD);
    enable_dubug = 1'b1;

    #(CLKPERIOD);
    enable_dubug = 1'b0;
    #(CLKPERIOD * NUM_CYCLES);

    $stop;
  end


always begin
  //clock generator
  #(CLKDELAY) tb_clk = ~tb_clk;
end

endmodule
