`timescale 1ns / 1ps

module Ins_Memory(
    // input nRD,// 读使能端有效 低电平有�??
    // input [31:0] IDataIn, //  [31:24], [23:16], [15:8], [7:0]
    input [31:0] IAddr,
    output [31:0] IDataOut // [31:24], [23:16], [15:8], [7:0]
);
    reg [7:0] ram [0:240]; // 指令存储�??
    reg [31:0] Ins_Data;
    initial begin
        $readmemb("E:/code/CPU_multi_cycle/src/Ins_Memory/code.mem", ram);
    end
    
    always@(*) begin
        Ins_Data[7:0] = ram[IAddr + 3];
        Ins_Data[15:8] = ram[IAddr + 2];
        Ins_Data[23:16] = ram[IAddr + 1];
        Ins_Data[31:24] = ram[IAddr];
    end

    assign IDataOut = Ins_Data;


endmodule
