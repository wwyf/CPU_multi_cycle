`timescale 1ns / 1ps
module Data_Memory(
    input CLK,
    input [31:0] DAddr,
    input [31:0] DataIn,// [31:24], [23:16], [15:8], [7:0]
    output [31:0] Dataout,
    input nRD, // 低电平有效，读控制信号
    input nWR // 西电平有效，写控制信号
);
    reg [7:0] ram [0:120]; 

    assign Dataout[7:0] = (nRD==0)?ram[DAddr + 3]:8'bz;
    assign Dataout[15:8] = (nRD==0)?ram[DAddr + 2]:8'bz;
    assign Dataout[23:16] = (nRD==0)?ram[DAddr + 1]:8'bz;
    assign Dataout[31:24] = (nRD==0)?ram[DAddr]:8'bz;

    always@( negedge CLK ) begin
        if( nWR==0 ) begin
            ram[DAddr] <= DataIn[31:24];
            ram[DAddr+1] <= DataIn[23:16];
            ram[DAddr+2] <= DataIn[15:8];
            ram[DAddr+3] <= DataIn[7:0];
        end
    end
endmodule
