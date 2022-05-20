`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/11 16:00:22
// Design Name: 
// Module Name: sim_ctrolunit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_ctrolunit;
//reg [6:0] OPcode;
//reg [2:0] Fun3;
//reg Fun7;
reg [31:0] inst_field;
reg MIO_ready;
wire [2:0] ImmSel;
wire ALUSrc_B;
wire [1:0] MemtoReg;
wire [1:0] Jump;
wire Branch;
wire BranchN;
wire RegWrite;
wire MemRW;
wire [3:0] ALU_Control;
wire CPU_MIO;
wire ecall,ill_instr,mret;
SCPU_ctrl_more test0 (.inst_field(inst_field),.ImmSel(ImmSel),.ALUSrc_B(ALUSrc_B),.MemtoReg(MemtoReg),
.Jump(Jump),.Branch(Branch),.mret(mret),.ecall(ecall),.ill_instr(ill_instr),
.BranchN(BranchN),.RegWrite(RegWrite),.MemRW(MemRW),.ALU_Control(ALU_Control)); 

initial begin
inst_field = 32'h00108113;
#100;
inst_field = 32'h00100093;
#100;
end


endmodule
