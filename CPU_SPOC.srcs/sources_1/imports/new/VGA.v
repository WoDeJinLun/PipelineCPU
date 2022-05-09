`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/02/20 18:40:52
// Design Name: 
// Module Name: VGA
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


module VGA(
    input wire clk_25m,
    input wire clk_100m,
    input wire rst,
    input wire [31:0] pc,
    input wire [31:0] mepc,
    input wire [31:0] inst,
    input wire [31:0] alu_res,
    input wire mem_wen,
    input wire [31:0] dmem_o_data,
    input wire [31:0] dmem_i_data,
    input wire [31:0] dmem_addr,
    input wire [1023:0] Reg_value,
    output wire hs,
    output wire vs,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b
    );
    wire [9:0] vga_x;
    wire [8:0] vga_y;
    wire video_on;
    VgaController vga_controller(
           .clk          (clk_25m      ),
           .rst          (rst          ),
           .vga_x        (vga_x        ),
           .vga_y        (vga_y        ),
           .hs           (hs           ),
           .vs           (vs           ),
           .video_on     (video_on     )
      );
 wire display_wen;
 wire [11:0] display_w_addr;
 wire [7:0] display_w_data;
 VgaDisplay vga_display(
          .clk          (clk_100m      ),
          .video_on     (video_on      ),
          .vga_x        (vga_x         ),
          .vga_y        (vga_y         ),
          .vga_r        (vga_r         ),
          .vga_g        (vga_g         ),
          .vga_b        (vga_b         ),
          .wen          (display_wen   ),
          .w_addr       (display_w_addr),
          .w_data       (display_w_data)
      );
 VgaDebugger vga_debugger(
         .clk           (clk_100m      ),
         .display_wen   (display_wen   ),
         .display_w_addr(display_w_addr),
         .display_w_data(display_w_data),
         .pc            (pc             ),
         .inst          (inst           ),
         .rs1           (               ),
         .rs1_val       (               ),
         .rs2           (               ),
         .rs2_val       (               ),
         .rd            (               ),
         .reg_i_data    (               ),
         .reg_wen       (               ),
         .is_imm        (               ),
         .is_auipc      (               ),
         .is_lui        (               ),
         .imm           (               ),
         .a_val         (               ),
         .b_val         (               ),
         .alu_ctrl      (               ),
         .cmp_ctrl      (               ),
         .alu_res       (alu_res        ),
         .cmp_res       (               ),
         .is_branch     (               ),
         .is_jal        (               ),
         .is_jalr       (               ),
         .do_branch     (               ),
         .pc_branch     (               ),
         .mem_wen       (mem_wen        ),
         .mem_ren       (               ),
         .dmem_o_data   (dmem_o_data    ),
         .dmem_i_data   (dmem_i_data    ),
         .dmem_addr     (dmem_addr      ),
         .csr_wen       (               ),
         .csr_ind       (               ),
         .csr_ctrl      (               ),
         .csr_r_data    (               ),
         .x0            (Reg_value[1023:992]),
         .ra            (Reg_value[991:960]),
         .sp            (Reg_value[959:928]),
         .gp            (Reg_value[927:896]),
         .tp            (Reg_value[895:864]),
         .t0            (Reg_value[863:832]),
         .t1            (Reg_value[831:800]),
         .t2            (Reg_value[799:768]),
         .s0            (Reg_value[767:736]),
         .s1            (Reg_value[735:704]),
         .a0            (Reg_value[703:672]),
         .a1            (Reg_value[671:640]),
         .a2            (Reg_value[639:608]),
         .a3            (Reg_value[607:576]),
         .a4            (Reg_value[575:544]),
         .a5            (Reg_value[543:512]),
         .a6            (Reg_value[511:480]),
         .a7            (Reg_value[479:448]),
         .s2           (Reg_value[447:416]),
         .s3           (Reg_value[415:384]),
         .s4            (Reg_value[383:352]),
         .s5            (Reg_value[351:320]),
         .s6            (Reg_value[319:288]),
         .s7            (Reg_value[287:256]),
         .s8            (Reg_value[255:224]),
         .s9            (Reg_value[223:192]),
         .s10           (Reg_value[191:160]),
         .s11           (Reg_value[159:128]),
         .t3            (Reg_value[127:96]),
         .t4            (Reg_value[95:64]),
         .t5           (Reg_value[63:32]),
         .t6            (Reg_value[31:0]),
         .mstatus_o     (               ),
         .mcause_o      (               ),
         .mepc_o        (        mepc       ),
         .mtval_o       (               ),
         .mtvec_o       (               ),
         .mie_o         (               ),
         .mip_o         (               )
     );
endmodule
