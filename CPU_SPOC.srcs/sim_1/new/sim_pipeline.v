`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 10:50:35
// Design Name: 
// Module Name: sim_pipeline
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


module sim_pipeline;
reg [31:0] Data_in,Inst_in;
reg rst,clk;
wire [31:0] PC_out_IF,PC_out_EX,PC_out_ID,PC_out_idex,PC_out_exmem,PC_out_memwb,inst_ID,Addr_out,Data_out,
Data_out_WB,Rs1_val,Rs2_val,imm_ex,inst_idex,inst_exmem,inst_memwb;
wire MemRW_Mem,MemRW_EX,reg_wen_mem,reg_wen_ex,
reg_wen_wb,is_imm_ex,mem_wen_ex,mem_wen_mem,is_branch_ex,is_jal_ex,
is_jal_mem,is_jalr_ex,is_jalr_mem,is_lui_ex;
wire [31:0] Reg0,Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,Reg8,Reg9,Reg10,Reg11,Reg12,Reg13,
Reg14,Reg15,Reg16,Reg17,Reg18,Reg19,Reg20,Reg21,Reg22,Reg23,Reg24,Reg25,Reg26,Reg27,Reg28,Reg29,Reg30,Reg31;
wire [4:0] rd_ex,rs1_ex,rs2_ex,rd_mem,rd_wb;
Pipeline_CPU U1 (.Data_in(Data_in),.rst(rst),.clk(clk),.inst_IF(Inst_in),.PC_out_EX(PC_out_EX),.PC_out_ID(PC_out_ID),
.inst_ID(inst_ID),.PC_out_IF(PC_out_IF),.Addr_out(Addr_out),.Data_out(Data_out),
.Data_out_WB(Data_out_WB),.MemRW_Mem(MemRW_Mem),.MemRW_EX(MemRW_EX),.Reg_value({Reg0,Reg1,Reg2,Reg3,Reg4,Reg5,Reg6,Reg7,
Reg8,Reg9,Reg10,Reg11,Reg12,Reg13,Reg14,Reg15,
Reg16,Reg17,Reg18,Reg19,Reg20,Reg21,Reg22,Reg23,Reg24,Reg25,Reg26,Reg27,Reg28,Reg29,Reg30,Reg31}),
.Rs1_val(Rs1_val),.Rs2_val(Rs2_val),.rd_ex(rd_ex),.rs1_ex(rs1_ex),.rs2_ex(rs2_ex),.rd_mem(rd_mem),
.rd_wb(rd_wb),.imm_ex(imm_ex),.PC_out_idex(PC_out_idex),.PC_out_exmem(PC_out_exmem),
.PC_out_memwb(PC_out_memwb),.reg_wen_ex(reg_wen_ex),.reg_wen_mem(reg_wen_mem),.reg_wen_wb(reg_wen_wb),
.is_imm_ex(is_imm_ex),.mem_wen_ex(mem_wen_ex),.mem_wen_mem(mem_wen_mem),
.is_branch_ex(is_branch_ex),.is_jal_ex(is_jal_ex),.inst_idex(inst_idex),.inst_exmem(inst_exmem),
.inst_memwb(inst_memwb),
.is_jal_mem(is_jal_mem),.is_jalr_ex(is_jalr_ex),.is_jalr_mem(is_jalr_mem),.is_lui_ex(is_lui_ex));

/*
PC	Machine Code	Basic Code	Original Code
0x0	0x00500093	addi x1 x0 5	addi x1 x0 5
0x4	0x00108133	add x2 x1 x1	test:add x2 x1 x1
0x8	0x002081B3	add x3 x1 x2	add x3 x1 x2
0xc	0x0000A203	lw x4 0(x1)	lw x4 0(x1)
0x10	0x002202B3	add x5 x4 x2	add x5 x4 x2
0x14	0xFE0098E3	bne x1 x0 -16	bne x1 x0 test
0x18	0x000000B3	add x1 x0 x0	add x1 x0 x0
0x1c	0x00000133	add x2 x0 x0	add x2 x0 x0
0x20	0x00700413	addi x8 x0 7	addi x8 x0 7
*/
initial begin
    Data_in = 32'h3f3f3f3f;
    clk = 0;
    rst = 1;
    #100;
    rst = 0;
    Inst_in = 32'h00500093;
    #20;
    Inst_in = 32'h00108133;
    #20;
    Inst_in = 32'h002081B3;
    #20;
    Inst_in = 32'h0000A203;
    #20;
    Inst_in = 32'h002202B3;
    #20;
    Inst_in = 32'h00000033;
    #20;
    Inst_in = 32'hFE0098E3;
    #20;
    Inst_in = 32'h000000B3;
    #20;
    Inst_in = 32'h00000133;
    #20;
    Inst_in = 32'h00700413;
    #20;
    Inst_in = 32'h04D00493;
    #20;
    Inst_in = 32'h00000033;
    #20;
end
always begin
    clk = ~clk; #10;
end
endmodule
