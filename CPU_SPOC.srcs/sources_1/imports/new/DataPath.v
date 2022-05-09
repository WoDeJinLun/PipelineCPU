`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/03/28 16:22:57
// Design Name: 
// Module Name: DataPath
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

module Data_path_more
( 
    input clk, //寄存器时钟
    input rst, //寄存器复位
    input[31:0]inst_field, //指令数据域[31:7]    
    input ALUSrc_B, //ALU端口B输入选择
    input [1:0]MemtoReg, //Regs写入数据源控制
    input [1:0]Jump, //J指令
    input Branch, //Beq指令
    input BranchN, //Bne指令
    input RegWrite, //寄存器写信号
    input[31:0]Data_in, //存储器输入
    input[3:0]ALU_Control, //ALU操作控制
    input[2:0]ImmSel, //ImmGen操作控制
    input INT, // 中断信号
    input ecall, // 软中断信号
    input mret, // 中断返回信号
    input ill_instr, // 非法指令信号
    output[31:0]ALU_out, //ALU运算输出
    output[31:0]Data_out, //CPU数据输出
    output[31:0]PC_out, //PC指针输出
    output wire [1023:0] Reg_value,
    output reg [31:0] mepc
);
    parameter _supervisor = 1'b1, _user = 1'b0;
    // register file output line
    wire [31:0] rs1_data,rs2_data;
    // data to be write 
    wire [31:0] register_in;
    // 32 * 32 register file
    RegFile cpu_regfile (.clk(clk),.rst(rst),.RegWrite(RegWrite),.Rs1_addr(inst_field[19:15]),
    .Rs2_addr(inst_field[24:20]),.Wt_addr(inst_field[11:7]),.Wt_data(register_in),.Rs1_data(rs1_data),
    .Rs2_data(rs2_data),.Reg_value(Reg_value));
    // imm signed extension
    wire [31:0] imm;
    immGen cpu_imm (.ImmSel(ImmSel),.inst_field(inst_field),.Imm_out(imm));
    // imm or rigister data 2 to one mux
    wire [31:0] alu_op2 = (ALUSrc_B) ? (imm) : (rs2_data);
    // ALU
    wire zero;
    ALU cpu_alu (.S(ALU_Control),.A(rs1_data),.B(alu_op2),.C(ALU_out),.ZERO(zero));
    // pc
    reg [31:0] pc;
    assign PC_out = pc;
    wire [31:0] pc_in;
    wire [31:0] pc_increase = pc + 32'h4;
    // jal
    wire [31:0] pc_offset = pc + imm;
    // beq,bne
    wire [31:0] pc_check_beq = ((Branch&zero)|(BranchN&(~zero))) ? (pc_offset) : pc_increase;
    // jump-mux
    Mux_2to1_32bit sel_jmp (.s(Jump),.in0(pc_check_beq),.in1(pc_offset),
    .in2(ALU_out),.in3(pc_check_beq),.out(pc_in));
    // pc update
    // hundle interrupt
    wire [3:0] exc = {INT,ecall,mret,ill_instr};
//    reg mode = _user;
//    RV_Int cpu_pc (
//        .clk(clk),.reset(rst),.INT(INT),.ecall(ecall),.mepc(mepc),
//        .mret(mret),.ill_instr(ill_instr),.pc_next(pc_in),.pc(pc_int)
//    );
    always@(posedge clk or posedge rst)begin
        if(rst==1'b1)begin
            pc <= 0;
            mepc <= 0;
//            mode <= _user;
        end
        else begin
// INT 0X0C 
// ECALL 0X08
// ILLEGAL 0X04
        case(exc)
        4'b0001:begin 
            mepc = pc + 32'h4 ;
            pc = 32'h4;
            
        end
        4'b0010:begin
            pc = mepc;
        end
        4'b0100:begin
            mepc = pc + 32'h4 ;
            pc = 32'h8;
        end
        4'b1000:begin
            mepc = pc + 32'h4 ;
            pc = 32'hC;
        end
        default:begin
            pc = pc_in;
        end
        endcase
    end
    end
    // control write data to the register file
    Mux_2to1_32bit sel_reg_in (.s(MemtoReg),.in0(ALU_out),.in1(Data_in),
    .in2(pc_increase),.in3(imm),.out(register_in));
    // data to be write to memory
    assign Data_out = rs2_data;
endmodule
