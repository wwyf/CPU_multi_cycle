`timescale 1ns / 1ps

module Control_unit(
    input [5:0] Opcode,
    input CLK,
    input zero,
    input sign,
    input Reset,// lower-active 
    output ALUSrcA,
    output ALUSrcB,
    output DBDataSrc,
    output PCWre,
    output IRWre,
    output RegWre,
    output InsMemRW,
    output nRD, 
    output nWR, 
    output RegDst,
    output ExtSel,// 
    output [1:0] PCSrc, // 
    output [2:0] ALUOp //
);
    
    reg [2:0] current_state;
    wire [2:0] n_state;
    Next_state my_next_state(
        .CLK(CLK),
        .Opcode(Opcode),
        .cur_state(current_state),
        .n_state(n_state)
    );

    always@(posedge CLK) begin
        if (Reset == 0)
            current_state = 3'b000;
        else
            current_state = n_state;
    end 

    Get_output my_get_output(
        .Opcode(Opcode),
        .State(current_state),
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