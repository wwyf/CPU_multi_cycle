`timescale 1ns / 1ps

// 当时钟上升沿到达
// 根据输入的Opcode以及当前的state
// 输出下一个state， 并更新当前state
module Next_state(
    input CLK,
    input [5:0] Opcode,
    input [2:0] cur_state,
    output reg [2:0] n_state
);

    always@(*) begin
        case(cur_state)
            2'b000: begin
                n_state = 3'b001;
            end
            2'b001: begin
                if (Opcode == 6'b111000)
                    n_state = 3'b000;
                else
                    n_state = 3'b010;
            end
            // 2'b100
            2'b010: begin
                n_state = 3'b011;
            end
            2'b011: begin
                n_state = 3'b000;
            end
            default: begin
                n_state = 3'b000;
            end
        endcase
    end
endmodule
    

