module Mem_reg_WB(
  input clk_MemWB,
  input rst_MemWB,
  input en_MemWB,
  input NOP,
  input [31:0]PC4_in_MemWB,
  input [4:0]Rd_addr_MemWB,
  input [31:0]ALU_in_MemWB,
  input [31:0]DMem_data_MemWB,
  input [31:0]imm_in_MemWB,
  input [31:0]Rs2_in_MemWB,
  input [1:0]MemtoReg_in_MemWB,
  input RegWrite_in_MemWB,
  input [31:0] inst_in_memwb,
  output reg [31:0]PC4_out_MemWB,
  output reg [4:0]Rd_addr_out_MemWB,
  output reg [31:0]ALU_out_MemWB,
  output reg [31:0]DMem_data_out_MemWB,
  output reg [1:0]MemtoReg_out_MemWB,
  output reg RegWrite_out_MemWB,
  output reg [31:0] imm_out_MemWB,
  output reg [31:0] Rs2_out_MemWB,
  output reg [31:0] inst_out_memwb,
  output wire [31:0] wt_data_exmem
  );
  
  always@(posedge clk_MemWB or posedge rst_MemWB)begin
    if(rst_MemWB == 1)begin
      PC4_out_MemWB <= 0;
      Rd_addr_out_MemWB <= 0;
      ALU_out_MemWB <= 0;
      DMem_data_out_MemWB <= 0;
      MemtoReg_out_MemWB <= 0;
      RegWrite_out_MemWB <= 0;
      imm_out_MemWB <= 0;
      Rs2_out_MemWB <= 0;
      inst_out_memwb <= 0;
    end else if(en_MemWB == 0)begin
      PC4_out_MemWB <= PC4_out_MemWB;
      Rd_addr_out_MemWB <= Rd_addr_out_MemWB;
      ALU_out_MemWB <= ALU_out_MemWB;
      DMem_data_out_MemWB <= DMem_data_out_MemWB;
      MemtoReg_out_MemWB <= MemtoReg_out_MemWB;
      RegWrite_out_MemWB <= RegWrite_out_MemWB;
      imm_out_MemWB <= imm_out_MemWB;
      Rs2_out_MemWB <= Rs2_out_MemWB;
      inst_out_memwb <= inst_out_memwb;
    end else begin
      PC4_out_MemWB <= PC4_in_MemWB;
      Rd_addr_out_MemWB <= Rd_addr_MemWB;
      ALU_out_MemWB <= ALU_in_MemWB;
      DMem_data_out_MemWB <= DMem_data_MemWB;
      MemtoReg_out_MemWB <= MemtoReg_in_MemWB;
      RegWrite_out_MemWB <= RegWrite_in_MemWB;
      imm_out_MemWB <= imm_in_MemWB;
      Rs2_out_MemWB <= Rs2_in_MemWB;
      inst_out_memwb <= inst_in_memwb;
    end
  end
endmodule
