`timescale 1ns / 1ps

module Ins_memory_tb(
);

    reg [31:0] Addr;
//    reg nRD;
    wire [5:0] Op_code;
    wire [4:0] Rs_reg;
    wire [4:0] Rt_reg;
    wire [4:0] Rd_reg;
    wire [4:0] Sa_number;
    wire [15:0] Imm_number;
    Ins_Memory ins(
        .IAddr(Addr),
    //        .IDataOut(Ins_Data)
        .Op_code(Op_code),
        .Rs_reg(Rs_reg),
        .Rt_reg(Rt_reg),
        .Rd_reg(Rd_reg),
        .Sa_number(Sa_number),
        .Imm_number(Imm_number)
    );
    
    initial begin
//        nRD = 0;
        #10 
        Addr = 0;
        #10
        Addr = 4;
    end
endmodule
