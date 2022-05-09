`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/28 16:58:57
// Design Name: 
// Module Name: immGen
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


module immGen(
    input wire [2:0] ImmSel,
    input wire [31:0] inst_field,
    output reg [31:0]   Imm_out
    );
    
    always @* begin
        case(ImmSel)
            // i
            3'b000:Imm_out = {{20{inst_field[31]}},inst_field[31:20]};
            // s
            3'b001:Imm_out = {{20{inst_field[31]}},inst_field[31:25],inst_field[11:7]};
            // sb
            3'b010:Imm_out = {{29{inst_field[31]}},inst_field[31],inst_field[7],inst_field[30:25],inst_field[11:8],1'b0};
            // uj
            3'b011:Imm_out = {{11{inst_field[31]}},inst_field[31],inst_field[19:12],inst_field[20],inst_field[30:21],1'b0};
            // u
            3'b100:Imm_out = {inst_field[31:12],12'h0};
            default: Imm_out = 31'h0;
        endcase
    end
endmodule
