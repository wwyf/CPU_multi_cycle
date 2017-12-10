
`timescale 1ns / 1ps

module test(
    input CLK, 
    input Reset,
    output [15:0] out_sign1,
    output [15:0] out_sign2,
    output [15:0] out_sign3,
    output [15:0] out_sign4
);

    reg [15:0] sign1 = 1;
    reg [15:0] sign2 = 1<<4;
    reg [15:0] sign3 = 1<<8;
    reg [15:0] sign4 = 1<<12;

    always@(posedge CLK or negedge Reset) begin 
        if (Reset == 0) begin
            sign1 = 1;
            sign2 = 1<<4;
            sign3 = 1<<8;
            sign4 = 1<<12;
        end
        else begin
            sign1 = sign1 + 1;
            sign2 = sign2 + (1<<4);
            sign3 = sign3 + (1<<8);
            sign4 = sign4 + (1<<12);
        end

    end

    assign out_sign1 = sign1;
    assign out_sign2 = sign2;
    assign out_sign3 = sign3;
    assign out_sign4 = sign4;


endmodule