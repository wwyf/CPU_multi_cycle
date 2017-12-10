`timescale 1ns / 1ps

module IR(
    input CLK,
    input [31:0] Data_in,
    input IRWre,
    output reg [5:0] Op_code,
    output reg [4:0] Rs_reg,
    output reg [4:0] Rt_reg,
    output reg [4:0] Rd_reg,
    output reg [4:0] Sa_number,
    output reg [15:0] Imm_number
);

    reg [31:0] Ins_Data;
    always@(negedge CLK) begin
        if (IRWre == 1)
            Ins_Data = Data_in;
        else 
            Ins_Data = Ins_Data;
    end

    always@(*) begin
        Op_code =  Ins_Data[31:26];
        Rs_reg = Ins_Data[25:21];
        Rt_reg = Ins_Data[20:16];
        Rd_reg = Ins_Data[15:11];
        Sa_number = Ins_Data[10:6];
        Imm_number = Ins_Data[15:0];   
    end

endmodule