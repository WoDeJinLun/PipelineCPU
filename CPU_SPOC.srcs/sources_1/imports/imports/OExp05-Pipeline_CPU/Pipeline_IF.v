module Pipeline_IF(
  input clk_IF,
  input rst_IF,
  input en_IF,
  input [31:0]PC_in_IF,
  input [31:0]Rs2_in_IF,
  input [1:0] PCSrc,
  output [31:0]PC_out_IF
);
  reg [31:0] pc;
  always@(posedge clk_IF or posedge rst_IF)begin
    if(rst_IF==1)begin
      pc <= 0;
    end else if(en_IF==0)begin
      pc <= pc;
    end else begin
      case(PCSrc)
      2'b00:pc <= pc + 32'h4;
      2'b01:pc <= PC_in_IF;
      2'b10:pc <= Rs2_in_IF;
      2'b11:pc <= pc + 32'h4;
      endcase
    end
  end

  assign PC_out_IF = pc;
endmodule

