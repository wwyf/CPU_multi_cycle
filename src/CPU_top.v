`timescale 1ns / 1ps

module CPU_single_cycle(
    input CLK, // 负脉冲
    input Reset, // 低电平有效
    output [15:0] out_sign1,// 当前指令地址PC，下条指令地址PC
    output [15:0] out_sign2,// RS寄存器地址：RS寄存器数据
    output [15:0] out_sign3,// RT寄存器地址：RT寄存器数据
    output [15:0] out_sign4 // ALU结果输出：DB总线数据
);

    // control unit wire
    wire PCWre;
    wire ALUSrcA;
    wire ALUSrcB;
    wire DBDataSrc;
    wire RegWre;
    wire nRD;
    wire nWR;
    wire RegDst;
    wire ExtSel;
    wire [1:0] PCSrc;
    wire [2:0] ALUOp;




    wire [31:0] PCData;
    wire [31:0] Addr;
    


    PC mypc(
        .CLK(CLK),
        .Reset(Reset),
        .PCWre(PCWre), 
        .PCData(PCData), 
        .Addr(Addr)
    );

    wire [5:0] Op_code;
    wire [4:0] Rs_reg;
    wire [4:0] Rt_reg;
    wire [4:0] Rd_reg;
    wire [4:0] Sa_number;
    wire [15:0] Imm_number;
    Ins_Memory ins(
        .IAddr(Addr),
        .Op_code(Op_code),
        .Rs_reg(Rs_reg),
        .Rt_reg(Rt_reg),
        .Rd_reg(Rd_reg),
        .Sa_number(Sa_number),
        .Imm_number(Imm_number)
    );


    



    wire [4:0] Wre_reg;

    mux2to1_5 mux2to1_1(
        .sel(RegDst),
        .DataIn1(Rt_reg),
        .DataIn2(Rd_reg),
        .DataOut(Wre_reg)
    );

    wire [31:0] Re_Data_1;
    wire [31:0] Re_Data_2;
    wire [31:0] Wre_back_data;

    RegFile myregfile(
        .CLK(CLK),
        .RegWre(RegWre), 
        .ReadReg1(Rs_reg),
        .ReadReg2(Rt_reg),
        .WriteReg(Wre_reg),
        .WriteData(Wre_back_data),
        .ReadData1(Re_Data_1),
        .ReadData2(Re_Data_2),
        .RST(Reset)
    );


    wire [31:0] Ext_Sa_number = {27'b000000000000000000000000000, Sa_number};
    wire [31:0] Ext_Imm_number;
    Extend MY_Extend(
        .ExtSel(ExtSel), 
        .DataIn(Imm_number),
        .DataOut(Ext_Imm_number)
    );

    wire [31:0] ALU_a;
    wire [31:0] ALU_b;


    mux2to1_32 Select_ALU_srcA(
        .sel(ALUSrcA), 
        .DataIn1(Re_Data_1),
        .DataIn2(Ext_Sa_number),
        .DataOut(ALU_a)
    );

    mux2to1_32 Select_ALU_srcB(
        .sel(ALUSrcB),  
        .DataIn1(Re_Data_2),
        .DataIn2(Ext_Imm_number),
        .DataOut(ALU_b)
    );

    wire [31:0] ALU_result;
    wire sign;
    wire zero;

    ALU32 My_ALU32(
        .ALUopcode(ALUOp),
        .rega(ALU_a),
        .regb(ALU_b),
        .result(ALU_result),
        .sign(sign),
        .zero(zero) 
    );

    wire [31:0] Re_Mem_Data;

    Data_Memory MY_Data_Memory(
        .CLK(CLK),
        .DAddr(ALU_result),
        .DataIn(Re_Data_2),
        .nRD(nRD),
        .nWR(nWR), 
        .Dataout(Re_Mem_Data)
    );

    

    mux2to1_32 Select_Wre_back_data(
        .sel(DBDataSrc), 
        .DataIn1(ALU_result),
        .DataIn2(Re_Mem_Data),
        .DataOut(Wre_back_data)
    );

    // PC
    // PC+4
    // PC+4+偏移
    // PC+4与地址前四位拼接
    wire [31:0] PC4 = Addr+4;
    wire [31:0] PC4_move = PC4+(Ext_Imm_number << 2);
    wire [31:0] PC4_jump = {PC4[31:28], Ext_Imm_number,2'b00};

    mux4to1 My_mux4to1(
        .sel(PCSrc), 
        .Reset(Reset),
        .DataIn1(PC4),
        .DataIn2(PC4_move),
        .DataIn3(PC4_jump),
        .DataOut(PCData)
    );
    
    
    Control_unit my_control_unit(
        .Opcode(Op_code),
        .zero(zero),
        .sign(sign),
        .PCWre(PCWre),
        .RegDst(RegDst),
        .RegWre(RegWre),
        .ALUOp(ALUOp),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ExtSel(ExtSel),
        .PCSrc(PCSrc),
        .nRD(nRD),
        .nWR(nWR),
        .DBDataSrc(DBDataSrc)
    );


    assign out_sign2 = {3'b000,Rs_reg,Re_Data_1[7:0]};
    assign out_sign3 = {3'b000,Rt_reg,Re_Data_2[7:0]};
    assign out_sign4 = {ALU_result[7:0], Wre_back_data[7:0]};
    assign out_sign1 = {Addr[7:0], PCData[7:0]};

    

endmodule
