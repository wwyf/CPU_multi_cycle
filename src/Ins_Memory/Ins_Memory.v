`timescale 1ns / 1ps

module Ins_Memory(
    // input nRD,// 读使能端有效 低电平有�??
    // input [31:0] IDataIn, //  [31:24], [23:16], [15:8], [7:0]
    input [31:0] IAddr,
    output reg [5:0] Op_code,
    output reg [4:0] Rs_reg,
    output reg [4:0] Rt_reg,
    output reg [4:0] Rd_reg,
    output reg [4:0] Sa_number,
    output reg [15:0] Imm_number
    //output [31:0] IDataOut // [31:24], [23:16], [15:8], [7:0]
);
    reg [7:0] ram [0:240]; // 指令存储�??
    reg [31:0] Ins_Data;
    initial begin
        $readmemh("D:/code/CPU_single_cycle/src/Ins_Memory/code.mem", ram);
    end
    
    always@(*) begin
        Ins_Data[7:0] = ram[IAddr + 3];
        Ins_Data[15:8] = ram[IAddr + 2];
        Ins_Data[23:16] = ram[IAddr + 1];
        Ins_Data[31:24] = ram[IAddr];
        
        Op_code =  Ins_Data[31:26];
        Rs_reg = Ins_Data[25:21];
        Rt_reg = Ins_Data[20:16];
        Rd_reg = Ins_Data[15:11];
        Sa_number = Ins_Data[10:6];
        Imm_number = Ins_Data[15:0];   
    end


endmodule
