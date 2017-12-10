`timescale 1ns / 1ps

module Control_unit_tb();
    
    reg CLK;
    reg Reset;
    reg zero;
    reg sign;
    reg [5:0] Opcode;
    initial begin
        CLK = 0;
        Reset = 0;
        #40
        Reset = 1;
        Opcode = 6'b000000;
        zero = 0;
        sign = 0;
    end 

    always begin
        #20
        CLK <= ~CLK;
    end

    Control_unit test(
        .Opcode(Opcode),
        .CLK(CLK),
        .zero(zero),
        .sign(sign),
        .Reset(Reset),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .DBDataSrc(DBDataSrc),
        .PCWre(PCWre),
        .IRWre(IRWre),
        .RegWre(RegWre),
        .InsMemRW(InsMemRW),
        .nRD(nRD),
        .nWR(nWR), 
        .RegDst(RegDst),
        .ExtSel(ExtSel),
        .PCSrc(PCSrc),
        .ALUOp(ALUOp) 
    );
    
    
endmodule
