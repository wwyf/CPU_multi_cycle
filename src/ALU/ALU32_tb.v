`timescale 1ns / 1ps
module ALU32_tb(
);
    reg [2:0] opcode;
    reg [31:0] rega;
    reg [31:0] regb;
    wire [31:0] result;
    wire sign;
    wire zero;
    ALU32 alu(
        .ALUopcode(opcode),
        .rega(rega),
        .regb(regb),
        .result(result),
        .sign(sign),
        .zero(zero)
    );
initial begin
    opcode = 0;
    rega = 10;// 0a
    regb = 22;// 16
#10
    opcode = 001;// sub
    rega = 10;
    regb = 11;
#10
    opcode = 010;// sll
    rega = 3;
    regb = 17;// 00001001
#10
    opcode = 110;
    rega = 10;
    regb = -6;
#10
    opcode = 110;
    rega = 23;
    regb = 234;
end



endmodule