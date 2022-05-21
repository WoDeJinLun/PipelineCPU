
module Ex_reg_Mem(
  input clk_EXMem,
  input rst_EXMem,
  input en_EXMem,
  input [31:0]inst_in_exmem,
  input [31:0]PC_in_EXMem,
  input [31:0]PC4_in_EXMem,
  input [4:0]Rd_addr_EXMem,
  input zero_in_EXMem,NOP,
  input [31:0]ALU_in_EXMem,
  input [31:0]Rs2_in_EXMem,
  input Branch_in_EXMem,
  input BranchN_in_EXMem,
  input MemRW_in_EXMem,
  input [1:0] Junp_in_EXMem,
  input [1:0]MemtoReg_in_EXMem,
  input [31:0] imm_in_EXMem,DMem_data_in_EXMem,
  input RegWrite_in_EXMem,
  output reg [31:0]inst_out_exmem,
  output reg [31:0]PC_out_EXMem,
  output reg [31:0]PC4_out_EXMem,
  output reg [4:0]Rd_addr_out_EXMem,
  output reg zero_out_EXMem,
  output reg [31:0]ALU_out_EXMem,
  output reg [31:0]Rs2_out_EXMem,
  output reg Branch_out_EXMem,
  output reg BranchN_out_EXMem,
  output reg MemRW_out_EXMem,
  output reg [1:0]Jump_out_EXMem,
  output reg [1:0]MemtoReg_out_EXMem,
  output reg RegWrite_out_EXMem,
  output reg [31:0] imm_out_EXMem,
  output wire [31:0] wt_data_exmem
  );
  Mux4to1_32bit mux (.sel(MemtoReg_out_EXMem),.in0(ALU_out_EXMem),
  .in1(DMem_data_in_EXMem),.in2(PC4_out_EXMem),.in3(imm_out_EXMem),
  .out(wt_data_exmem));

  always@(posedge clk_EXMem or posedge rst_EXMem)begin
    if(rst_EXMem==1||NOP==1)begin
      PC_out_EXMem <= 0;
      PC4_out_EXMem <= 0;
      Rd_addr_out_EXMem <= 0;
      zero_out_EXMem <= 0;
      ALU_out_EXMem <= 0;
      Rs2_out_EXMem <= 0;
      Branch_out_EXMem <= 0;
      BranchN_out_EXMem <= 0;
      MemRW_out_EXMem <= 0;
      Jump_out_EXMem <= 0;
      MemtoReg_out_EXMem <= 0;
      RegWrite_out_EXMem <= 0;
      inst_out_exmem <= 0;
      imm_out_EXMem <= 0;
    end else if(en_EXMem==0)begin
      PC_out_EXMem <= PC_out_EXMem;
      PC4_out_EXMem <= PC4_out_EXMem;
      Rd_addr_out_EXMem <= Rd_addr_out_EXMem;
      zero_out_EXMem <= zero_out_EXMem;
      ALU_out_EXMem <= ALU_out_EXMem;
      Rs2_out_EXMem <= Rs2_out_EXMem;
      Branch_out_EXMem <= Branch_out_EXMem;
      BranchN_out_EXMem <= BranchN_out_EXMem;
      MemRW_out_EXMem <= MemRW_out_EXMem;
      Jump_out_EXMem <= Jump_out_EXMem;
      MemtoReg_out_EXMem <= MemtoReg_out_EXMem;
      RegWrite_out_EXMem <= RegWrite_out_EXMem;
      inst_out_exmem <= inst_out_exmem;
      imm_out_EXMem <= imm_out_EXMem;
    end else begin 
      imm_out_EXMem <= imm_in_EXMem;
      inst_out_exmem <= inst_in_exmem;
      PC_out_EXMem <= PC_in_EXMem;
      PC4_out_EXMem <= PC4_in_EXMem;
      Rd_addr_out_EXMem <= Rd_addr_EXMem;
      zero_out_EXMem <= zero_in_EXMem;
      ALU_out_EXMem <= ALU_in_EXMem;
      Rs2_out_EXMem <= Rs2_in_EXMem;
      Branch_out_EXMem <= Branch_in_EXMem;
      BranchN_out_EXMem <= BranchN_in_EXMem;
      MemRW_out_EXMem <= MemRW_in_EXMem;
      Jump_out_EXMem <= Junp_in_EXMem;
      MemtoReg_out_EXMem <= MemtoReg_in_EXMem;
      RegWrite_out_EXMem <= RegWrite_in_EXMem;
    end 
  end
endmodule
