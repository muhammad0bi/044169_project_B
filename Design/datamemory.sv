`timescale 1ns / 1ps

module datamemory(
    input logic clk, enable_debug,
    input logic enable_load_ex_mem,
    input logic MemRead,  // comes from control unit
    input logic MemWrite,  // Comes from control unit
    input logic [8:0] a,  // Read / Write address - 9 LSB bits of the ALU output
    input logic [31:0] wd,  // Write Data
    input logic [31:0] wd2,  // Write Data - used in debug to speed up mem init
    input logic [2:0] Funct3,  // bits 12 to 14 of the instruction
    output logic [31:0] rd  // Read Data
);

  logic [11:0] address;
  logic [31:0] Datain1;
  logic [31:0] Datain2; // used in debug to speed up mem init
  logic [31:0] Dataout;
  logic [3:0] Wr;

  Memoria32Data mem32 (
      .address(address),
      .Clk(clk),
      .enable_debug(enable_debug),
      .Datain1(Datain1),
      .Datain2(Datain2), // used in debug to speed up mem init
      .Dataout(Dataout),
      .Wr(Wr),
      .enable_load_ex_mem(enable_load_ex_mem)
  );


always_comb 
begin
    address <= {{2{1'b0}}, a}; //allow wrriting to all adresses
    Datain1 <= wd;
    Datain2 <= wd2;
    Wr <= 4'b0000;

    if (MemRead) begin
      case (Funct3)
        3'b000:  //LB
        rd <= {Dataout[7] ? 24'hFFFFFF : 24'b0, Dataout[7:0]};
        3'b001:  //LH
        rd <= {Dataout[15] ? 16'hFFFF : 16'b0, Dataout[15:0]};
        3'b010:  //LW
        rd <= Dataout;
        3'b100:  //LBU
        rd <= {24'b0, Dataout[7:0]};
        3'b101:  //LHU
        rd <= {16'b0, Dataout[15:0]};
        default: rd <= Dataout;
      endcase
    end else if (MemWrite) begin
      case (Funct3)
        3'b000: begin  //SB
          Wr <= 4'b0001;
          Datain1 <={{24{1'b0}}, wd[7:0]};
        end
        3'b001: begin  //SH
          Wr <= 4'b0011;
          Datain1 <= {{16{1'b0}}, wd[15:0]};
        end
        default: begin  //SW
          Wr <= 4'b1111;
          Datain1 <= wd;
          Datain2 <= wd2; //relavinte only when init mem
        end
      endcase
    end
end

endmodule
