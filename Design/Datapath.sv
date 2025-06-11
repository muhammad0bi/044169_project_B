`timescale 1ns / 1ps

import Pipe_Buf_Reg_PKG::*;

module Datapath 
(
    input logic clk , enable_halt , reset , enable_load_ex_mem, // global clock
                              //enable halt
                              // reset , sets the PC to zero
                              //init mem units
    RegWrite , MemtoReg ,     // Register file writing enable   // Memory or ALU MUX
    ALUsrc , MemWrite ,       // Register file or Immediate MUX // Memroy Writing Enable
    MemRead ,                 // Memroy Reading Enable
    Branch ,                  // Branch Enable
    JalrSel ,                 // Jalr Mux Select
    input logic [1:0] ALUOp ,
    input logic [1:0] RWSel , // Mux4to1 Select
    input logic [3:0] ALU_CC, // ALU Control Code ( input of the ALU )
	
    input logic [8:0]DataExMemAddress, // debug and init mem unit
    input logic [31:0]DataExMemData1, 
    input logic [31:0]DataExMemData2, 

    input logic [8:0]InstExMemAddress, // debug and init inst mem unit
    input logic [31:0]InstExMemData1, 
    input logic [31:0]InstExMemData2, 

	// debug signals fetch stage
    output logic [6:0] opcode,
    output logic [8:0] PC_debug,

	// debug signals decode stage
    output logic [6:0] Funct7,
    output logic [2:0] Funct3,

	// debug signals exucute stage
    output logic [1:0] ALUOp_Current,
    output logic [31:0] ALUResult_debug,
    output logic PcSel_debug,
    output logic [8:0] BrPC_debug,
    output logic [31:0] FAmux_Result_debug,
    output logic [31:0] SrcB_debug,


    
	// debug signals Mem fetch stage
    output logic wr, // write enable
    output logic reade, // read enable
    output logic [8:0] addr, // address
    output logic [31:0] wr_data, // write data
    output logic [31:0] rd_data, // read data

    // Para depuração no tesbench:
    // used also for wr stage
    output logic [4:0] reg_num, //número do registrador que foi escrito
    output logic [31:0] reg_data,   //valor que foi escrito no registrador
    output logic reg_write_sig, //sinal de escrita no registrador
    output logic [31:0] WB_Data //Result After the last MUX
    );

logic [8:0] PC, PCPlus4, Next_PC;
logic [31:0] Instr;
logic [31:0] Reg1, Reg2;
logic [31:0] ReadData;
logic [31:0] SrcB, ALUResult;
logic [31:0] ExtImm,BrImm,Old_PC_Four,BrPC;
logic [31:0] WRMuxResult,WrmuxSrc;
logic PcSel;    // mux select / flush signal
logic [1:0] FAmuxSel;
logic [1:0] FBmuxSel;
logic [31:0] FAmux_Result;
logic [31:0] FBmux_Result;
logic Reg_Stall;    //1: PC fetch same, Register not update

if_id_reg A;
id_ex_reg B;
ex_mem_reg C;
mem_wb_reg D;


// next PC
    assign PC_debug = PC;
    adder pcadd(PC, 9'b100, PCPlus4);
    mux2 #(9) pcmux(PCPlus4, BrPC[8:0], PcSel, Next_PC);
    flopr pcreg(clk, reset || (enable_load_ex_mem), enable_halt , Next_PC, Reg_Stall, PC);
    instructionmemory instr_mem (clk, enable_halt, enable_load_ex_mem, PC, InstExMemAddress, InstExMemData1, InstExMemData2, Instr);

// IF_ID_Reg A;
always @(posedge clk) 
begin
    
     if (!enable_halt)
     begin

        if ((reset) || (PcSel) || (enable_load_ex_mem) )   // initialization or flush
        begin
            A.Curr_Pc <= 0;
            A.Curr_Instr <= 0;
        end
        else if (!Reg_Stall)    // stall
        begin
            A.Curr_Pc <= PC;
            A.Curr_Instr <= Instr;
        end

    end

end


    //--// The Hazard Detection Unit
    HazardDetection detect(A.Curr_Instr[19:15], A.Curr_Instr[24:20], B.rd, B.MemRead, Reg_Stall);

    // //Register File
    assign opcode = A.Curr_Instr[6:0];

    RegFile rf(clk, enable_halt, reset || (enable_load_ex_mem), D.RegWrite, D.rd, A.Curr_Instr[19:15], A.Curr_Instr[24:20],
            WRMuxResult, Reg1, Reg2);

    assign reg_num = D.rd;
    assign reg_data = WRMuxResult;
    assign reg_write_sig = D.RegWrite;

    // //sign extend
    imm_Gen Ext_Imm (A.Curr_Instr,ExtImm);

// ID_EX_Reg B;
always @(posedge clk) 
begin
    
    if (!enable_halt) 
    begin 
        if ((reset) || (Reg_Stall) || (PcSel) || (enable_load_ex_mem))   // initialization or flush or generate a NOP if hazard
        begin
            B.ALUSrc <= 0;
            B.MemtoReg <= 0;
            B.RegWrite <= 0;
            B.MemRead <= 0;
            B.MemWrite <= 0;
            B.ALUOp <= 0;
            B.Branch <= 0;
            B.JalrSel <= 0;
            B.RWSel <= 0;
            B.Curr_Pc <= 0;
            B.RD_One <= 0;
            B.RD_Two <= 0;
            B.RS_One <= 0;
            B.RS_Two <= 0;
            B.rd <= 0;
            B.ImmG <= 0;
            B.func3 <= 0;
            B.func7 <= 0;
            B.Curr_Instr <= A.Curr_Instr;   //debug tmp
        end
        else
        begin
            B.ALUSrc <= ALUsrc;
            B.MemtoReg <= MemtoReg;
            B.RegWrite <= RegWrite;
            B.MemRead <= MemRead;
            B.MemWrite <= MemWrite;
            B.ALUOp <= ALUOp;
            B.Branch <= Branch;
            B.JalrSel <= JalrSel;
            B.RWSel <= RWSel;
            B.Curr_Pc <= A.Curr_Pc;
            B.RD_One <= Reg1;
            B.RD_Two <= Reg2;
            B.RS_One <= A.Curr_Instr[19:15];
            B.RS_Two <= A.Curr_Instr[24:20];
            B.rd <= A.Curr_Instr[11:7];
            B.ImmG <= ExtImm;
            B.func3 <= A.Curr_Instr[14:12];
            B.func7 <= A.Curr_Instr[31:25];
            B.Curr_Instr <= A.Curr_Instr;   //debug tmp
        end
    end
end

    //--// The Forwarding Unit
    ForwardingUnit forunit(B.RS_One, B.RS_Two, C.rd, D.rd, C.RegWrite, D.RegWrite, FAmuxSel, FBmuxSel);

    // // //ALU
    assign Funct7 = B.func7;
    assign Funct3 = B.func3;
    assign ALUOp_Current = B.ALUOp;
    assign ALUResult_debug = ALUResult;
    assign PcSel_debug = PcSel;
    assign BrPC_debug = BrPC;
    assign FAmux_Result_debug = FAmux_Result;
    assign SrcB_debug = SrcB;

    mux4 FAmux(B.RD_One, WRMuxResult, C.Alu_Result, B.RD_One, FAmuxSel, FAmux_Result);
    mux4 FBmux(B.RD_Two, WRMuxResult, C.Alu_Result, B.RD_Two, FBmuxSel, FBmux_Result);
    mux2 #(32) srcbmux(FBmux_Result, B.ImmG, B.ALUSrc, SrcB);
    alu alu_module(FAmux_Result, SrcB, ALU_CC, ALUResult);
    BranchUnit brunit(B.Curr_Pc,B.ImmG,B.JalrSel,B.Branch,ALUResult,BrImm,Old_PC_Four,BrPC,PcSel);



// EX_MEM_Reg C;
always @(posedge clk) 
begin
    if (!enable_halt) 
    begin
        if (reset || (enable_load_ex_mem))   // initialization
        begin
            C.RegWrite <= 0;
            C.MemtoReg <= 0;
            C.MemRead <= 0;
            C.MemWrite <= 0;
            C.RWSel <= 0;
            C.Pc_Imm <= 0;
            C.Pc_Four <= 0;
            C.Imm_Out <= 0;
            C.Alu_Result <= 0;
            C.RD_Two <= 0;
            C.rd <= 0;
            C.func3 <= 0;
            C.func7 <= 0;
        end
        else
        begin
            C.RegWrite <= B.RegWrite;
            C.MemtoReg <= B.MemtoReg;
            C.MemRead <= B.MemRead;
            C.MemWrite <= B.MemWrite;
            C.RWSel <= B.RWSel;
            C.Pc_Imm <= BrImm;
            C.Pc_Four <= Old_PC_Four;
            C.Imm_Out <= B.ImmG;
            C.Alu_Result <= ALUResult;
            C.RD_Two <= FBmux_Result;
            C.rd <= B.rd;
            C.func3 <= B.func3;
            C.func7 <= B.func7;
            C.Curr_Instr <= B.Curr_Instr;   // debug tmp
        end
    end
end

    // // // // Data memory
	wire MemReadExternalLoad = (enable_load_ex_mem == 1'b1) ? 1'b0 : C.MemRead;
	wire MemWriteExternalLoad = (enable_load_ex_mem == 1'b1) ? 1'b1 : C.MemWrite;
	wire [8:0]MemAddr = (enable_load_ex_mem == 1'b1) ? DataExMemAddress[8:0] : C.Alu_Result[8:0];
	wire [31:0]MemWrData1 = (enable_load_ex_mem == 1'b1) ? DataExMemData1[31:0] : C.RD_Two;
	wire [31:0]MemWrData2 = (enable_load_ex_mem == 1'b1) ? DataExMemData2[31:0] : {{31{1'b0}}};
	wire [2:0] MemFunc3 = (enable_load_ex_mem == 1'b1) ? 3'b011 : C.func3; //make a parameter

	datamemory data_mem (clk, enable_halt, enable_load_ex_mem, MemReadExternalLoad, MemWriteExternalLoad, MemAddr, MemWrData1, MemWrData2, MemFunc3, ReadData);

    assign wr = C.MemWrite;
    assign reade = C.MemRead;
    assign addr = C.Alu_Result[8:0];
    assign wr_data = C.RD_Two;
    assign rd_data = ReadData;

// MEM_WB_Reg D;
always @(posedge clk) 
begin
    if (!enable_halt)
    begin
        if (reset || (enable_load_ex_mem))   // initialization
        begin
            D.RegWrite <= 0;
            D.MemtoReg <= 0;
            D.RWSel <= 0;
            D.Pc_Imm <= 0;
            D.Pc_Four <= 0;
            D.Imm_Out <= 0;
            D.Alu_Result <= 0;
            D.MemReadData <= 0;
            D.rd <= 0;
        end
        else
        begin
            D.RegWrite <= C.RegWrite;
            D.MemtoReg <= C.MemtoReg;
            D.RWSel <= C.RWSel;
            D.Pc_Imm <=C.Pc_Imm;
            D.Pc_Four <= C.Pc_Four;
            D.Imm_Out <= C.Imm_Out;
            D.Alu_Result <= C.Alu_Result;
            D.MemReadData <= ReadData;
            D.rd <= C.rd;
            D.Curr_Instr <= C.Curr_Instr;   //Debug Tmp
        end
   end
end

//--// The LAST Block
    mux2 #(32) resmux(D.Alu_Result, D.MemReadData, D.MemtoReg, WrmuxSrc);  
    mux4 wrsmux(WrmuxSrc, D.Pc_Four, D.Imm_Out, D.Pc_Imm, D.RWSel, WRMuxResult);
    assign WB_Data = WRMuxResult;
    

endmodule
