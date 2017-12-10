`timescale 1ns / 1ps

module MultiReg_32(
    input CLK,
    input [31:0] Data_in,
    output [31:0] Data_out
);
    reg [31:0] data;
    always@(posedge CLK) begin
        data = Data_in;
    end

    assign Data_out = data;
endmodule