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
    parameter [2:0] sIF = 3'b000, // 
                     sID = 3'b001, // 
                     sEXE = 3'b010, //
                     sMEM = 3'b100, // 
                     sWB = 3'b011; // 
    parameter [5:0] addi = 6'b000010,
                     ori = 6'b010010,
                     sll = 6'b011000,
                     add = 6'b000000,
                     sub = 6'b000001,
                     slt = 6'b100110,
                     slti = 6'b100111,
                     sw = 6'b110000,
                     lw = 6'b110001,
                     beq = 6'b110100,
                     bne = 6'b110101,
                     bgtz = 6'b110110,
                     j = 6'b111000,
                     jr = 6'b111001,
                     Or = 6'b010000,
                     And = 6'b010001,
                     jal = 6'b111010,
                     halt = 6'b111111;

    always@(*) begin
        case(cur_state)
            sIF: begin
                n_state = sID;
            end

            sID: begin
                if (Opcode == j|| Opcode == jr || Opcode == halt)
                    n_state = sIF;
                else if (Opcode == jal)
                    n_state = sWB;
                else
                    n_state = sEXE;
            end
            
            sEXE: begin
                if (Opcode == beq || Opcode == bne || Opcode == bgtz) begin
                    n_state = sIF;
                end
                else begin
                    if (Opcode == sw || Opcode == lw) begin
                        n_state = sMEM;
                    end
                    else begin
                        n_state = sWB;
                    end
                end
            end

            sMEM: begin
                if (Opcode == sw)
                    n_state = sIF;
                else 
                    n_state = sWB; 
            end

            sWB: begin
                n_state = 3'b000;
            end

            default: begin
                n_state = 3'b000;
            end
        endcase
    end
endmodule
    

