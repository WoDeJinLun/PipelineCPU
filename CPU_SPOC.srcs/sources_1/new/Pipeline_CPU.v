`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/12 14:27:17
// Design Name: 
// Module Name: Pipeline_CPU
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


module Pipeline_CPU(
input wire [31:0] Data_in,
input wire rst,
input wire clk,
input wire [31:0] inst_IF,
output wire [31:0] PC_out_EX,
output wire [31:0] PC_out_ID,
output wire [31:0] inst_ID,
output wire [31:0] PC_out_IF,PC_out_idex,PC_out_exmem,PC_out_memwb,
output wire [31:0] Addr_out,Data_out,Data_out_WB,mem_w_data,imm_ex,reg_w_data,
output wire MemRW_Mem,MemRW_EX,reg_wen_wb,reg_wen_mem,mem_wen_mem,is_jal_mem,is_jalr_mem,
reg_wen_ex,is_imm_ex,mem_wen_ex,is_branch_ex,is_jal_ex,is_jalr_ex,is_auipc_ex,is_lui_ex,cmp_ctrl_ex,
output wire [1023:0] Reg_value,
output wire [3:0] alu_ctrl_ex,
output wire [4:0] rs1_ex,rs2_ex,rd_ex,rd_wb,rd_mem,
output wire [31:0] Rs1_val,
output wire [31:0] Rs2_val,
output wire [31:0] inst_idex,inst_exmem,inst_memwb
    );
wire [31:0] Rs2_out_MemWB;
// inst fetch
wire [31:0] PC_in_IF;
wire [1:0] PCSrc;
wire en_IF,en_IFID;
wire [1:0] NOP_IFID,NOP_IDEX,ForwardA,ForwardB;
Pipeline_IF Instruction_Fetch (.clk_IF(clk),.rst_IF(rst),
.en_IF(en_IF),.PC_in_IF(PC_in_IF),.Rs2_in_IF(Rs2_out_MemWB),.PCSrc(PCSrc),.PC_out_IF(PC_out_IF));

// if reg
wire [31:0] PC_out_IFID,inst_out_IFID;
IF_reg_ID if_reg_id (.clk_IFID(clk),.rst_IFID(rst),.en_IFID(en_IFID),.PC_in_IFID(PC_out_IF),
.inst_in_IFID(inst_IF),.PC_out_IFID(PC_out_IFID),.inst_out_IFID(inst_out_IFID));

// inst decoder
wire RegWrite_in_ID,ALUSrc_B_ID,Branch_ID,BranchN_ID,MemRW_ID,RegWrite_out_ID;
wire [3:0] ALU_control_ID;
wire [1:0] MemtoReg_ID,Jump_ID;
wire [4:0] Rd_addr_out_ID,Rd_addr_ID,Rd_addr_out_MemWB,rs1_ex_id,rs2_ex_id;
wire [31:0] Rs1_out_ID,Rs2_out_ID,Imm_out_ID;
wire [31:0] PC_out_IDEX,Rs1_out_IDEX,Rs2_out_IDEX,Imm_out_IDEX;
Pipeline_ID Instruction_Decoder (.clk_ID(clk),.rst_ID(rst),
.RegWrite_in_ID(RegWrite_in_ID),.Rd_addr_ID(Rd_addr_out_MemWB),
.Wt_data_ID(Data_out_WB),.Inst_in_ID(inst_out_IFID),
.Rd_addr_out_ID(Rd_addr_out_ID),.Rs1_out_ID(Rs1_out_ID),
.Rs2_out_ID(Rs2_out_ID),.Imm_out_ID(Imm_out_ID),.ALUSrc_B_ID(ALUSrc_B_ID),
.ALU_control_ID(ALU_control_ID),.Branch_ID(Branch_ID),.BranchN_ID(BranchN_ID),
.MemRW_ID(MemRW_ID),.Jump_ID(Jump_ID),.MemtoReg_ID(MemtoReg_ID),
.RegWrite_out_ID(RegWrite_out_ID),.Reg_value(Reg_value),.rs1_ex(rs1_ex_id),.rs2_ex(rs2_ex_id));
assign alu_ctrl_ex = ALU_control_ID;
// ID_reg_Ex
wire [4:0] Rd_addr_out_IDEX;
wire [1:0] MemtoReg_out_IDEX,Jump_out_IDEX;
wire ALUSrc_B_out_IDEX,Branch_out_IDEX,BranchN_out_IDEX,MemRW_out_IDEX,RegWrite_out_IDEX;
wire [3:0] ALU_control_out_IDEX;

ID_reg_Ex id_reg_ex (.clk_IDEX(clk),.rst_IDEX(rst),.en_IDEX(1'b1),
.PC_in_IDEX(PC_out_IFID),.Rd_addr_IDEX(Rd_addr_out_ID),.rs1_addr_in_idex(rs1_ex_id),
.rs2_addr_in_idex(rs2_ex_id),.rs1_addr_out_idex(rs1_ex),.rs2_addr_out_idex(rs2_ex),
.Rs1_in_IDEx(Rs1_out_ID),.Rs2_in_IDEX(Rs2_out_ID),.Imm_in_IDEX(Imm_out_ID),
.ALUSrc_B_in_IDEX(ALUSrc_B_ID),.ALU_control_in_IDEX(ALU_control_ID),
.Branch_in_IDEX(Branch_ID),.BranchN_in_IDEX(BranchN_ID),
.MemRW_in_IDEX(MemRW_ID),.inst_in_idex(inst_out_IFID),
.Jump_in_IDEX(Jump_ID),.MemtoReg_in_IDEX(MemtoReg_ID),.RegWrite_in_IDEX(RegWrite_out_ID),
.PC_out_IDEX(PC_out_IDEX),.Rd_addr_out_IDEX(Rd_addr_out_IDEX),
.Rs1_out_IDEX(Rs1_out_IDEX),.Rs2_out_IDEX(Rs2_out_IDEX),
.Imm_out_IDEX(Imm_out_IDEX),.ALUSrc_B_out_IDEX(ALUSrc_B_out_IDEX),
.ALU_control_out_IDEX(ALU_control_out_IDEX),.Branch_out_IDEX(Branch_out_IDEX),
.BranchN_out_IDEX(BranchN_out_IDEX),.MemRW_out_IDEX(MemRW_out_IDEX),
.Jump_out_IDEX(Jump_out_IDEX),.MemtoReg_out_IDEX(MemtoReg_out_IDEX),.inst_out_idex(inst_idex),
.RegWrite_out_IDEX(RegWrite_out_IDEX));
assign rd_ex = Rd_addr_out_IDEX;
assign Rs1_val = Rs1_out_IDEX;
assign Rs2_val = Rs2_out_IDEX;
assign PC_out_idex = PC_out_IDEX;
assign reg_wen_ex = RegWrite_out_IDEX;
assign is_imm_ex = ALUSrc_B_out_IDEX;
assign imm_ex = Imm_out_IDEX;
assign mem_wen_ex = MemRW_out_IDEX;
assign is_branch_ex = Branch_out_IDEX;
assign is_jal_ex = (Jump_out_IDEX==2'b1);
assign is_jalr_ex = (Jump_out_IDEX==2'b10);
assign is_lui_ex = (MemtoReg_out_IDEX==2'b11);
// EXCUTE
wire [31:0] PC4_out_EX,ALU_out_EX,Rs2_out_EX;
wire zero_out_EX;

Pipeline_Ex Excute(.PC_in_EX(PC_out_IDEX),.Rs1_in_EX(Rs1_out_IDEX),
.Rs2_in_EX(Rs2_out_IDEX),.Imm_in_EX(Imm_out_IDEX),
.ALUSrc_B_in_EX(ALUSrc_B_out_IDEX),.ALU_control_in_EX(ALU_control_out_IDEX),
.PC_out_EX(PC_out_EX),.PC4_out_EX(PC4_out_EX),.zero_out_EX(zero_out_EX),
.ALU_out_EX(ALU_out_EX),.Rs2_out_EX(Rs2_out_EX));

  

// EX_REG_MEM
wire zero_out_EXMem,Branch_out_EXMem,BranchN_out_EXMem,MemRW_out_EXMem,RegWrite_out_EXMem;
wire [1:0] Jump_out_EXMem;
wire [1:0] MemtoReg_out_EXMem;
wire [4:0] Rd_addr_out_EXMem;
wire [31:0] PC_out_EXMem,PC4_out_EXMem,ALU_out_EXMem,Rs2_out_EXMem,imm_out_EXMem;

Ex_reg_Mem ex_reg_mem (.clk_EXMem(clk),.rst_EXMem(rst),.inst_in_exmem(inst_idex),
.en_EXMem(1'b1),.PC_in_EXMem(PC_out_EX),.PC4_in_EXMem(PC4_out_EX),
.Rd_addr_EXMem(Rd_addr_out_IDEX),.zero_in_EXMem(zero_out_EX),
.ALU_in_EXMem(ALU_out_EX),.Rs2_in_EXMem(Rs2_out_EX),.imm_in_EXMem(Imm_out_IDEX),
.Branch_in_EXMem(Branch_out_IDEX),.BranchN_in_EXMem(BranchN_out_IDEX),
.MemRW_in_EXMem(MemRW_out_IDEX),.Junp_in_EXMem(Jump_out_IDEX),
.MemtoReg_in_EXMem(MemtoReg_out_IDEX),.RegWrite_in_EXMem(RegWrite_out_IDEX),
.PC_out_EXMem(PC_out_EXMem),.PC4_out_EXMem(PC4_out_EXMem),
.Rd_addr_out_EXMem(Rd_addr_out_EXMem),.zero_out_EXMem(zero_out_EXMem),
.ALU_out_EXMem(ALU_out_EXMem),.Rs2_out_EXMem(Rs2_out_EXMem),
.Branch_out_EXMem(Branch_out_EXMem),.BranchN_out_EXMem(BranchN_out_EXMem),
.Jump_out_EXMem(Jump_out_EXMem),.MemtoReg_out_EXMem(MemtoReg_out_EXMem),.inst_out_exmem(inst_exmem),
.MemRW_out_EXMem(MemRW_out_EXMem),.RegWrite_out_EXMem(RegWrite_out_EXMem)
,.imm_out_EXMem(imm_out_EXMem));
assign PC_out_exmem = PC4_out_EXMem - 32'h4;
assign PC_in_IF = PC_out_EXMem;
assign rd_mem = Rd_addr_out_EXMem;
assign reg_wen_mem = RegWrite_out_EXMem;
assign mem_w_data = Rs2_out_EXMem;
assign mem_wen_mem = MemRW_out_EXMem;
assign is_jal_mem = (Jump_out_EXMem==2'b01);
assign is_jalr_mem = (Jump_out_EXMem==2'b10);
// mem access
Pipeline_Mem Memory_Access (.zero_in_Mem(zero_out_EXMem),
.Branch_in_Mem(Branch_out_EXMem),.BranchN_in_Mem(BranchN_out_EXMem),
.Jump_in_Mem(Jump_out_EXMem),.PCSrc(PCSrc));

// Mem reg WB
wire [1:0] MemtoReg_out_MemWB;
wire [31:0] PC4_out_MemWB,ALU_out_MemWB,DMem_data_out_MemWB,imm_out_MemWB;
Mem_reg_WB mem_reg_wb (.clk_MemWB(clk),.rst_MemWB(rst),.en_MemWB(1'b1),.inst_in_memwb(inst_exmem),
.PC4_in_MemWB(PC4_out_EXMem),.Rd_addr_MemWB(Rd_addr_out_EXMem),.Rs2_in_MemWB(Rs2_out_EXMem),.ALU_in_MemWB(ALU_out_EXMem),
.DMem_data_MemWB(Data_in),.MemtoReg_in_MemWB(MemtoReg_out_EXMem),
.RegWrite_in_MemWB(RegWrite_out_EXMem),.imm_in_MemWB(imm_out_EXMem),.PC4_out_MemWB(PC4_out_MemWB),
.Rd_addr_out_MemWB(Rd_addr_out_MemWB),.ALU_out_MemWB(ALU_out_MemWB),.inst_out_memwb(inst_memwb),
.DMem_data_out_MemWB(DMem_data_out_MemWB),.MemtoReg_out_MemWB(MemtoReg_out_MemWB),
.RegWrite_out_MemWB(RegWrite_in_ID),.imm_out_MemWB(imm_out_MemWB)
,.Rs2_out_MemWB(Rs2_out_MemWB));

assign PC_out_memwb = PC4_out_MemWB - 32'h4;
// write back
Pipeline_WB write_back (.PC4_in_WB(PC4_out_MemWB),.ALU_in_WB(ALU_out_MemWB),
.imm_in_WB(imm_out_MemWB),
.DMem_data_WB(DMem_data_out_MemWB),.MemtoReg_in_WB(MemtoReg_out_MemWB),
.Data_out_WB(Data_out_WB));
assign reg_wen_wb = RegWrite_in_ID;
assign rd_wb = Rd_addr_out_MemWB;
assign MemRW_Mem = MemRW_out_EXMem;
assign MemRW_EX = MemRW_out_IDEX;
//assign Wt_data_ID = Data_out_WB;
assign reg_w_data = ALU_out_MemWB;
assign Addr_out = ALU_out_EXMem;
assign Data_out = Rs2_out_EXMem;
assign PC_out_ID = PC_out_IFID;
assign inst_ID = inst_out_IFID;




Stall check_hazard (
    .rst_stall(rst),.Rs1_addr_ID(Rs1_out_ID),.Rs2_addr_ID(Rs2_out_ID),
    .Rd_addr_out_ID0EX(Rd_addr_out_IDEX),.Rd_addr_out_EXMEM(Rd_addr_out_EXMem),
    .Rd_addr_out_MEMWB(Rd_addr_out_MemWB),.RegWrite_out_IDEX(RegWrite_out_IDEX),
    .RegWrite_out_EXMEM(RegWrite_out_EXMem),
    .RegWrite_out_MEMWB(RegWrite_in_ID),.MemtoReg_IDEX(MemtoReg_out_IDEX),
    .PCSrc(PCSrc),.en_IF(en_IF),
    .NOP_IDEX(NOP_IDEX),.NOP_IFID(NOP_IFID),.ForwardA(ForwardA),.ForwardB(ForwardB)
);
endmodule
