`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/25 17:08:02
// Design Name: 
// Module Name: RV_Int
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


module RV_Int(
input wire clk,
input wire reset,
input wire INT,
input wire ecall,
input wire mret,
input wire ill_instr,
input wire [31:0] pc_next,
output reg [31:0] pc,
output reg [31:0] mepc
    );
//reg [31:0] mtvec;
//reg [31:0] mepc;
wire [3:0] exc = {INT,ecall,mret,ill_instr};
// INT 0X0C 
// ECALL 0X08
// ILLEGAL 0X04
always@(posedge clk or posedge reset)begin
if(reset) begin
    mepc = 0;
    pc = 0;
end
else begin
case(exc)
    4'b1000:begin
        mepc <= pc_next;
        pc <= 32'hc;
    end
    4'b0100:begin
        mepc <= pc_next;
        pc <= 32'h08;
    end
    4'b0010:begin
        pc <= mepc;
    end
    4'b0001:begin
        mepc <= pc_next;
        pc <= 32'h4;
    end
    default:begin
        mepc <= mepc;
        pc <= pc_next;
    end
endcase
end
end

endmodule
