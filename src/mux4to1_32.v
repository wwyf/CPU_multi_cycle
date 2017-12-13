`timescale 1ns / 1ps


// 四选一
module mux4to1_32(
    input [1:0] sel,
    input Reset,
    input [31:0] DataIn1,
    input [31:0] DataIn2,
    input [31:0] DataIn3,
    input [31:0] DataIn4,
    output reg [31:0] DataOut
    );
    always@(*) begin
        if (Reset == 0) begin
            DataOut = 0;
        end 
        else begin
            case(sel)
                2'b00: DataOut = DataIn1;
                2'b01: DataOut = DataIn2;
                2'b10: DataOut = DataIn3;
                2'b11: DataOut = DataIn4;
            endcase
        end
    end
endmodule
