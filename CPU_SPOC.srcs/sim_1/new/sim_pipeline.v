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
Data_out_WB,Rs1_val,Rs2_val,imm_ex;
wire MemRW_Mem,MemRW_EX,reg_wen_mem,reg_wen_ex,
reg_wen_wb,is_imm_ex,mem_wen_ex,mem_wen_mem,is_branch_ex,is_jal_ex,
is_jal_mem,is_jalr_ex,is_jalr_mem,is_lui_ex;
wire [1023:0] Reg_value;
wire [4:0] rd_ex,rs1_ex,rs2_ex,rd_mem,rd_wb;
Pipeline_CPU U1 (.Data_in(Data_in),.rst(rst),.clk(clk),.inst_IF(Inst_in),.PC_out_EX(PC_out_EX),.PC_out_ID(PC_out_ID),
.inst_ID(inst_ID),.PC_out_IF(PC_out_IF),.Addr_out(Addr_out),.Data_out(Data_out),
.Data_out_WB(Data_out_WB),.MemRW_Mem(MemRW_Mem),.MemRW_EX(MemRW_EX),.Reg_value(Reg_value),
.Rs1_val(Rs1_val),.Rs2_val(Rs2_val),.rd_ex(rd_ex),.rs1_ex(rs1_ex),.rs2_ex(rs2_ex),.rd_mem(rd_mem),
.rd_wb(rd_wb),.imm_ex(imm_ex),.PC_out_idex(PC_out_idex),.PC_out_exmem(PC_out_exmem),
.PC_out_memwb(PC_out_memwb),.reg_wen_ex(reg_wen_ex),.reg_wen_mem(reg_wen_mem),.reg_wen_wb(reg_wen_wb),
.is_imm_ex(is_imm_ex),.mem_wen_ex(mem_wen_ex),.mem_wen_mem(mem_wen_mem),
.is_branch_ex(is_branch_ex),.is_jal_ex(is_jal_ex),
.is_jal_mem(is_jal_mem),.is_jalr_ex(is_jalr_ex),.is_jalr_mem(is_jalr_mem),.is_lui_ex(is_lui_ex));

initial begin
    clk = 0;
    rst = 1;
    #100;
    rst = 0;
    Inst_in = 32'h00100093;
    #20;
    Inst_in = 	32'h00000033;
    #20;
    Inst_in =     32'h00000033;
    #20;
    Inst_in =     32'h00000033;
    #20;
    Inst_in = 32'h00108113;
end
always begin
    clk = ~clk; #10;
end
endmodule
