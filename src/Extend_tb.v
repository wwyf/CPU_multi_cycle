`timescale 1ns / 1ps

module Extend_tb(
);
    reg Extsel;
    reg [15:0] DataIn;
    wire [31:0] DataOut;
    Extend e(
        .Extsel(Extsel),
        .DataIn(DataIn),
        .DataOut(DataOut)
    );

    initial begin 
    #10
    Extsel = 0;
    DataIn = 16'b1000_0000_1001_0110;

    #10
    Extsel = 1;
    DataIn = 16'b1000_0000_1001_0110;

    #10
    Extsel = 0;
    DataIn = 16'b1000_0000_1001_0110;
    end

endmodule
