`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 18:45:53
// Design Name: 
// Module Name: Mux4to1_32bit
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


module Mux4to1_32bit(
input wire [1:0] sel,
input wire [31:0] in0,in1,in2,in3,
output reg [31:0] out
    );
always@* begin
case(sel)
2'b00: out <= in0;
2'b01: out <= in1;
2'b10: out <= in2;
2'b11: out <= in3;
endcase
end
endmodule
