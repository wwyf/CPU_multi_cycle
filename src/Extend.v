
`timescale 1ns / 1ps

module Extend(
    input ExtSel,
    input [15:0] DataIn,
    output [31:0] DataOut
);
    wire [15:0] ext_bit;
    assign ext_bit =(DataIn[15] == 0)?16'b0000_0000_0000_0000:16'b1111_1111_1111_1111;
    assign DataOut = (ExtSel == 0)?{16'b0000_0000_0000_0000, DataIn}:{ext_bit, DataIn};
endmodule
