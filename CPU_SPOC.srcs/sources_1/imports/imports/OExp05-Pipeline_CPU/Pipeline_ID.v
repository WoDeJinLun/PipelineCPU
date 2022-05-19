module Pipeline_ID(
  input clk_ID,
  input rst_ID,
  input RegWrite_in_ID,
  input [4:0]Rd_addr_ID,
  input [31:0]Wt_data_ID,
  input [31:0]Inst_in_ID,
  output [31:0]Rd_addr_out_ID,
  output [31:0]Rs1_out_ID,
  output [31:0]Rs2_out_ID,
  output [31:0]Imm_out_ID,
  output ALUSrc_B_ID,
  output [3:0]ALU_control_ID,
  output Branch_ID,
  output BranchN_ID,
  output MemRW_ID,
  output [1:0] Jump_ID,
  output [1:0]MemtoReg_ID,
  output RegWrite_out_ID,
  output [1023:0] Reg_value,
  output [4:0] rs1_ex,rs2_ex
  );
//  wire RegWrite;
  wire [2:0] ImmSel;
  SCPU_ctrl_more ctrl_unit (.inst_field(Inst_in_ID),.MIO_ready(1'b1),.ecall(),.mret(),.ill_instr(),
  .ImmSel(ImmSel),.ALUSrc_B(ALUSrc_B_ID),.MemtoReg(MemtoReg_ID),.Jump(Jump_ID)
  ,.Branch(Branch_ID),.BranchN(BranchN_ID),.RegWrite(RegWrite_out_ID),.MemRW(MemRW_ID),
  .ALU_Control(ALU_control_ID),.CPU_MIO());

  immGen imm_generate (.ImmSel(ImmSel),.inst_field(Inst_in_ID),.Imm_out(Imm_out_ID));
  assign Rd_addr_out_ID = Inst_in_ID[11:7];
  RegFile reg_file (.clk(clk_ID),.rst(rst_ID),.RegWrite(RegWrite_in_ID),.restore(1'b0),
  .Rs1_addr(Inst_in_ID[19:15]),.Rs2_addr(Inst_in_ID[24:20]),.Wt_addr(Rd_addr_ID),
  .Wt_data(Wt_data_ID),.restore_data(1024'h0),
  .Rs1_data(Rs1_out_ID),.Rs2_data(Rs2_out_ID),.Reg_value(Reg_value));

    assign rs1_ex = Inst_in_ID[19:15];
    assign rs2_ex = Inst_in_ID[24:20];
endmodule
