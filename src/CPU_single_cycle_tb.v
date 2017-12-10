`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/11/16 20:36:52
// Design Name: 
// Module Name: CPU_single_cycle_tb
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


module CPU_single_cycle_tb();
    reg CLK;
    reg Reset; // low 
    CPU_single_cycle My_CPU(
        .CLK(CLK),
        .Reset(Reset)
    );
    initial begin
        CLK = 1;
        Reset = 0;
        #10
        Reset = 1;
        #1000
        Reset = 0;
        #20
        Reset = 1;
    end
    always begin
        #10
        CLK = ~CLK;
    end
endmodule