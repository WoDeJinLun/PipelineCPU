module IF_reg_ID(
  input clk_IFID,
  input rst_IFID,
  input en_IFID,NOP,
  input [31:0]PC_in_IFID,
  input [31:0]inst_in_IFID,
  output [31:0]PC_out_IFID,
  output [31:0]inst_out_IFID
  );
  reg [31:0] pc;
  reg [31:0] inst;
  always@(posedge clk_IFID or posedge rst_IFID)begin
    if(rst_IFID==1||NOP==1)begin
      pc <= 32'h00000000;
      inst <= 32'h00000033;
    end else if(en_IFID==0)begin
      pc <= pc;
      inst <= inst;
    end else begin
      pc <= PC_in_IFID;
      inst <= inst_in_IFID;
    end
  end
  assign inst_out_IFID = inst;
  assign PC_out_IFID = pc;
endmodule
