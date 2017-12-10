`timescale 1ns / 1ps


module clkdiv_190hz(
    input wire CLK,
    input wire clr,
    output wire CLK_190hz
);

reg [19:0] q = 0;
always@(posedge CLK) begin
        q = q + 1;
end

assign CLK_190hz = q[18];

endmodule // clkdiv