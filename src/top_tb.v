`timescale 1ns / 1ps

module top_tb();
    reg CLK;
    reg clr;
    reg Reset;
    reg button_in;
    reg [1:0] select_sign;
    top my_top(
        .CLK(CLK),
        .clr(clr),
        .Reset(Reset),
        .button_in(button_in),
        .select_sign(select_sign)
//        .out_display_data(out_display_data)
    );


    initial begin
        CLK = 0;
        clr = 1;
        Reset = 0;
        button_in = 0;
        select_sign = 0;
        #20
        clr = 0;
        Reset = 1;
        #20
        button_in = 0;
        #10
        button_in = 1;
        #10
        button_in = 0;
        #30
        button_in = 1;
        #10
        button_in = 0;
        #10
        button_in = 1;
        #10
        button_in = 0;
    end


    always begin 
        #1
        CLK <= ~CLK;
    end



endmodule