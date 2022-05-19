
module VGA (
    input wire clk_25m,
    input wire clk_100m,
    input wire rst,
    input wire [1023:0] Reg_value,
    input wire [31:0] PC_IF,
    input wire [31:0] inst_IF,
    input wire [31:0] PC_ID,
    input wire [31:0] inst_ID,
    input wire [31:0] PC_Ex,
    input wire [4:0] rd_ex,rs1_ex,rs2_ex,rd_mem,rd_wb,
    input wire [31:0] imm_ex,PC_out_idex,PC_out_exmem,PC_out_memwb,
    input wire reg_wen_ex,reg_wen_mem,reg_wen_wb,is_imm_ex,mem_wen_ex,
    mem_wen_mem,is_branch_ex,is_jal_ex,
    is_jal_mem,is_jalr_ex,is_jalr_mem,is_lui_ex,
    input wire [3:0] alu_ctrl_ex,
    input wire [31:0] Rs1_val,Rs2_val,
    input wire MemRW_Ex,
    input wire MemRW_Mem,
    input wire [31:0] Data_out,
    input wire [31:0] Addr_out,
    input wire [31:0] Data_out_WB,
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
        .clk(clk_25m),
        .rst(rst),
        .vga_x(vga_x),
        .vga_y(vga_y),
        .hs(hs),
        .vs(vs),
        .video_on(video_on)
    );

    wire display_wen;
    wire [11:0] display_w_addr;
    wire [7:0] display_w_data;
    VgaDisplay vga_display(
        .clk(clk_100m),
        .video_on(video_on),
        .vga_x(vga_x),
        .vga_y(vga_y),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b),
        .wen(display_wen),
        .w_addr(display_w_addr),
        .w_data(display_w_data)
    );
    

    VgaDebugger vga_debugger(
        // DEBUG
        .pc(PC_IF),
        .inst(inst_IF),
        .IfId_pc(PC_ID),
        .IfId_inst(inst_ID),
        .IfId_valid(),
        .IdEx_pc(PC_out_idex),
        .IdEx_inst(),
        .IdEx_valid(),
        .IdEx_rd(rd_ex),
        .IdEx_rs1(rs1_ex),
        .IdEx_rs2(rs2_ex),
        .IdEx_rs1_val(Rs1_val),
        .IdEx_rs2_val(Rs2_val),
        .IdEx_reg_wen(reg_wen_ex),
        .IdEx_is_imm(is_imm_ex),
        .IdEx_imm(imm_ex),
        .IdEx_mem_wen(mem_wen_ex),
        .IdEx_mem_ren(~mem_wen_ex),
        .IdEx_is_branch(is_branch_ex),
        .IdEx_is_jal(is_jal_ex),
        .IdEx_is_jalr(is_jalr_ex),
        .IdEx_is_auipc(),
        .IdEx_is_lui(is_lui_ex),
        .IdEx_alu_ctrl(alu_ctrl_ex),
        .IdEx_cmp_ctrl(),
        .ExMa_pc(PC_out_exmem),
        .ExMa_inst(),
        .ExMa_valid(),
        .ExMa_rd(rd_mem),
        .ExMa_reg_wen(reg_wen_mem),
        .ExMa_mem_w_data(Data_out),
        .ExMa_alu_res(Addr_out),
        .ExMa_mem_wen(mem_wen_mem),
        .ExMa_mem_ren(~mem_wen_mem),
        .ExMa_is_jal(is_jal_mem),
        .ExMa_is_jalr(is_jalr_mem),
        .MaWb_pc(PC_out_memwb),
        .MaWb_inst(),
        .MaWb_valid(),
        .MaWb_rd(rd_wb),
        .MaWb_reg_wen(reg_wen_wb),
        .MaWb_reg_w_data(Data_out_WB),
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
        .clk(clk_100m),
        .display_wen(display_wen),
        .display_w_addr(display_w_addr),
        .display_w_data(display_w_data)
    );


    
endmodule