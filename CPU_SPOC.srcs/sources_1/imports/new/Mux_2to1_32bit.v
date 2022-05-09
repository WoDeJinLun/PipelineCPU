`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/28 18:43:21
// Design Name: 
// Module Name: Mux_2to1_32bit
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


module Mux_2to1_32bit(
    input wire [1:0] s,
    input wire [31:0] in0,
    input wire [31:0] in1,
    input wire [31:0] in2,
    input wire [31:0] in3,
    output reg [31:0] out
    );
    always @* begin
        case(s)
            2'b00:out <= in0;
            2'b01:out <= in1;
            2'b10:out <= in2;
            2'b11:out <= in3;
        endcase
    end
endmodule
