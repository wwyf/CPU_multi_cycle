`timescale 1ns / 1ps
module RegFile_tb(
);

    reg CLK;
    reg RegWre;// �Ĵ���дʹ�ܶ�
    reg [4:0] ReadReg1;
    reg [4:0] ReadReg2;
    reg [4:0] WriteReg; // д�Ĵ�����
    reg [31:0] WriteData; // д�Ĵ���������
    wire [31:0] ReadData1;
    wire [31:0] ReadData2;
    reg RST; // ���㣬����

    RegFile regfile(
    .CLK(CLK), 
    .RegWre(RegWre),// �Ĵ���дʹ�ܶ�
    .ReadReg1(ReadReg1),
    .ReadReg2(ReadReg2),
    .WriteReg(WriteReg), // д�Ĵ�����
    .WriteData(WriteData), // д�Ĵ���������
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .RST(RST) // ���㣬����
);

initial begin
    CLK = 0;
    RST = 1;
end

always  begin 
#10
    CLK = ~CLK;
    
end

initial begin
    RST = 0;
    #50
    RST = 1;
#20
    RegWre = 1;
    WriteReg = 2;
    WriteData = 10;
end

endmodule

