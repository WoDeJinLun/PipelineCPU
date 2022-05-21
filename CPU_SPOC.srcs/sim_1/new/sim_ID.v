`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 11:28:55
// Design Name: 
// Module Name: sim_ID
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


module sim_ID;
reg clk,rst,RegWrite_in_ID;
reg [31:0] Data_out_WB,inst_out_IFID;
reg [4:0] Rd_addr_out_MemWB;

wire [4:0] Rd_addr_out_ID,rs1_ex,rs2_ex;
wire [31:0] Imm_out_ID,Rs1_out_ID,Rs2_out_ID;
wire ALUSrc_B_ID,Branch_ID,BranchN_ID,MemRW_ID,Jump_ID,MemtoReg_ID,RegWrite_out_ID;
wire [3:0] ALU_control_ID;
wire [1023:0] Reg_value;
Pipeline_ID Instruction_Decoder (.clk_ID(clk),.rst_ID(rst),
.RegWrite_in_ID(RegWrite_in_ID),.Rd_addr_ID(Rd_addr_out_MemWB),
.Wt_data_ID(Data_out_WB),.Inst_in_ID(inst_out_IFID),
.Rd_addr_out_ID(Rd_addr_out_ID),.Rs1_out_ID(Rs1_out_ID),
.Rs2_out_ID(Rs2_out_ID),.Imm_out_ID(Imm_out_ID),.ALUSrc_B_ID(ALUSrc_B_ID),
.ALU_control_ID(ALU_control_ID),.Branch_ID(Branch_ID),.BranchN_ID(BranchN_ID),
.MemRW_ID(MemRW_ID),.Jump_ID(Jump_ID),.MemtoReg_ID(MemtoReg_ID),
.RegWrite_out_ID(RegWrite_out_ID),.Reg_value(Reg_value),.rs1_ex(rs1_ex),.rs2_ex(rs2_ex));


initial begin
rst = 1;
clk = 0;
#100;
rst = 0;
RegWrite_in_ID = 1;
inst_out_IFID = 32'h0000B203;
Rd_addr_out_MemWB = 3;
Data_out_WB = 25;
end
always begin
    clk = ~clk;#10;
end
endmodule
