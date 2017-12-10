`timescale 1ns / 1ps
module RegFile(
    input CLK, 
    input RegWre,// 控制寄存器能够被写，低电平有效
    input [4:0] ReadReg1,
    input [4:0] ReadReg2,
    input [4:0] WriteReg, // 写寄存器号
    input [31:0] WriteData, // 写寄存器的数据
    output [31:0] ReadData1,
    output [31:0] ReadData2,
    input RST // 低电平有效 
);
    reg [31:0] regFile[1:31]; // 
    integer i;
    assign   ReadData1 = (ReadReg1 == 0) ? 0 : regFile[ReadReg1]; // 如果寄存器号是0，就输出0，否则输出对应寄存器号的的值
    assign   ReadData2 = (ReadReg2 == 0) ? 0 : regFile[ReadReg2]; // 同上

    always @ (negedge CLK or negedge RST) begin   // 时钟下降沿触发写寄存器
        if (RST==0) begin
            for(i=1;i<32;i=i+1) regFile[i] <= 0; // 如果RST低电平，就把寄存器清零
        end
        else if(RegWre == 1 && WriteReg != 0)   // 如果可写，并且写的寄存器号不为0
            regFile[WriteReg] <= WriteData;  // 实际上写的寄存器号如果是0的话，是无效写入
    end
endmodule

