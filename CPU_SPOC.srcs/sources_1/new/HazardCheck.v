`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/20 18:48:52
// Design Name: 
// Module Name: HazardCheck
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


module Stall(
    input wire rst_stall,
    input wire [4:0] Rs1_addr_ID,Rs2_addr_ID,
    Rd_addr_out_IDEX,Rd_addr_out_EXMEM,Rd_addr_out_MEMWB,
    input wire RegWrite_out_IDEX,RegWrite_out_EXMEM,RegWrite_out_MEMWB,MemtoReg_IDEX,
    input wire [1:0] PCSrc,
    output reg en_IF,en_IFID,NOP_IDEX,NOP_IFID,
    output reg [1:0] ForwardA,ForwardB
    );
        
    always@* begin
        if(rst_stall==1'b1)begin
            en_IF <= 1;en_IFID <= 1;NOP_IDEX <= 0;NOP_IFID<=0;ForwardA <= 0;ForwardB <= 0;
        end else begin
        if(Rs1_addr_ID == Rd_addr_out_IDEX && RegWrite_out_IDEX==1 && Rd_addr_out_IDEX!=0)begin
            ForwardA <= 2'b01;
        end else if(Rs1_addr_ID == Rd_addr_out_EXMEM && RegWrite_out_EXMEM==1 && Rd_addr_out_EXMEM!=0)begin
            ForwardA <= 2'b10;
        end else if(Rs1_addr_ID == Rd_addr_out_MEMWB && RegWrite_out_MEMWB==1 && Rd_addr_out_MEMWB!=0)begin
            ForwardA <= 2'b11;
        end else ForwardA <= 2'b00;
        
        if(Rs2_addr_ID == Rd_addr_out_IDEX && RegWrite_out_IDEX==1 && Rd_addr_out_IDEX!=0)begin
            ForwardB <= 2'b01;
        end else if(Rs2_addr_ID == Rd_addr_out_EXMEM && RegWrite_out_EXMEM==1 && Rd_addr_out_EXMEM!=0)begin
            ForwardB <= 2'b10;
        end else if(Rs2_addr_ID == Rd_addr_out_MEMWB && RegWrite_out_MEMWB==1 && Rd_addr_out_MEMWB!=0)begin
            ForwardB <= 2'b11;
        end else ForwardB <= 2'b00;
       
        if(PCSrc!=0)begin
            en_IF <= 1;
            en_IFID <= 1;
            NOP_IDEX <= 1;
            NOP_IFID <= 1;
        end else if(MemtoReg_IDEX==2'b01) begin
            en_IF <= 0;
            en_IFID <= 0;
            NOP_IDEX <= 1;
            NOP_IFID <= 0;
        end else begin
            en_IF <= 1;
            en_IFID <= 1;
            NOP_IDEX <= 0;
            NOP_IFID <= 0;
        end
        end
    end
endmodule
