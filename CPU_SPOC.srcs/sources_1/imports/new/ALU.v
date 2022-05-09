`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/28 16:33:41
// Design Name: 
// Module Name: ALU
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


module ALU(
    input wire [3:0] S,
    input wire [31:0] A,
    input wire [31:0] B,
    output reg [31:0] C,
    output wire ZERO
    );
    integer i;
    assign ZERO = ~(|C);
    always@(*)begin
        case(S)
            4'b0000:C<=A&B; // and
            4'b0001:C<=A|B;// sub
            4'b1111:C <= ($signed(A)) >>> B[4:0]; // sra
            4'b1001:C <= ($unsigned(A)) < ($unsigned(B)); // sltu
            4'b1110:C <= A << B[4:0]; // sll
            4'b0010:C<=A+B; // add
            4'b1100:C<=A^B; // xor
            4'b0100:C<=~(A|B); // nor
            4'b1101:C <= A >> B[4:0]; // srl
            4'b0110:C<=A-B; // sub
            4'b0111:C<=($signed(A)) < ($signed(B)); //slt
        endcase
    end

endmodule
