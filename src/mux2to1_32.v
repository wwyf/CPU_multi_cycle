`timescale 1ns / 1ps

module mux2to1_32(
    input sel,
    input [31:0] DataIn1,
    input [31:0] DataIn2,
    output reg [31:0] DataOut
);
    always@(*) begin
    case(sel)
        1'b0: DataOut = DataIn1;
        1'b1: DataOut = DataIn2;
    endcase
end 
endmodule