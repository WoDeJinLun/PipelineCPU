module Pipeline_Mem(
  input zero_in_Mem,
  input Branch_in_Mem,
  input BranchN_in_Mem,
  input [1:0] Jump_in_Mem,
  output reg [1:0] PCSrc);
  wire check_beq = zero_in_Mem & Branch_in_Mem;
  wire check_bne = (~zero_in_Mem) & BranchN_in_Mem;
  assign check_branch = check_beq | check_bne;
  always@* begin 
    case(Jump_in_Mem)
    2'b00:PCSrc <= check_branch;
    2'b01:PCSrc <= 1;
    2'b10:PCSrc <= 2;
    2'b11:PCSrc <= check_beq;
  endcase
  end


endmodule
