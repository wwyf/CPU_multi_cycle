`timescale 1ns / 1ps

// 根据当前的state还有opcode输出对应的控制信号
module Get_output(
    input [5:0] Opcode,
    input [2:0] State,
    input zero,
    input sign,
    input Reset,// 
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg DBDataSrc,
    output reg PCWre,
    output reg IRWre,
    output reg RegWre,
    output reg InsMemRW,
    output reg nRD, 
    output reg nWR, 
    output reg [1:0] RegDst,
    output reg WrRegDSrc,
    output reg ExtSel,// 
    output reg [1:0] PCSrc, // 
    output reg [2:0] ALUOp // 
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

    always@(*)
    begin
        if (State == sID) begin
            IRWre <= 1;
        end
        else begin 
            IRWre <= 0;
        end
        if (State == sIF && Opcode != halt)
            PCWre <= 1;
        else 
            PCWre <= 0;

        if (State == sWB) 
            RegWre <= 1;
        else 
            RegWre <= 0;

        case(Opcode)
            6'b000000: begin // add
                RegDst <= 2'b10;
                if (State == 3'b011)
                    RegWre <= 1;
                else
                    RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b000;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                PCSrc <= 0;
                nRD <= 1;
                nWR <= 1;
            end
            6'b000001: begin // sub
                RegDst <= 2'b10;
                // if (State == 3'b011)
                //     RegWre <= 1;
                // else
                //     RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b001;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                PCSrc <= 0;
                nRD <= 1;
                nWR <= 1;
            end
            6'b000010: begin // addi
                RegDst <= 2'b01;
                // if (State == 3'b011)
                //     RegWre <= 1;
                // else
                //     RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b000;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                ExtSel <= 1; // 符号拓展
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b010000: begin  // or
                RegDst <= 2'b10;
                // if (State == 3'b011)
                //     RegWre <= 1;
                // else
                //     RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b011;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b010001: begin // and
                RegDst <= 2'b10;
                // if (State == 3'b011)
                //     RegWre <= 1;
                // else 
                //     RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b100;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            ori: begin // ori
                RegDst <= 2'b01;
                // if (State == 3'b011)
                //     RegWre <= 1;
                // else 
                //     RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b011;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                ExtSel <= 0; // 0拓展
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end

            sll: begin // sll
                RegDst <= 2'b10;
                // if (State == 3'b011)
                //     RegWre <= 1;
                // else 
                //     RegWre <= 0;
                ALUSrcA <= 1;// Sa_number
                ALUSrcB <= 0;
                ALUOp <= 3'b010;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                // ExtSel <= ;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            slt: begin // slt
                RegDst <= 2'b10;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b110;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b100111: begin // slti
                RegDst <= 2'b01;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b110;
                DBDataSrc <= 0;
                WrRegDSrc <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            sw: begin // sw rt, imm(rs)
                RegDst <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b000;
//                DBDataSrc <= 1;
                ExtSel <= 1;
                nRD <= 1;
                if (State == 3'b100)
                    nWR <= 0;
                else
                    nWR <= 1;
                PCSrc <= 2'b00;
            end
            lw: begin // lw rt, imm(rs)
                RegDst <= 2'b01;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b000;
                // DBDataSrc <= 1;
                WrRegDSrc <= 1;
                ExtSel <= 1;
                if (State == 3'b100)
                    nRD <= 0;
                else 
                    nRD <= 1;
                nWR <= 1;
                PCSrc <= 2'b00;
            end
            6'b110100: begin // beq rs, rt, imm
                // RegDst <= 0;
                // RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b111;
                DBDataSrc <= 1;// useless
                ExtSel <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= {0,zero};
            end    
            6'b110101: begin // bne rs, rt, imm
                // RegDst <= 0;
                // RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b111;
                DBDataSrc <= 1;// useless
                ExtSel <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= {0,~zero};
            end
            bgtz: begin // bgtz rs, imm
                RegDst <= 0;
                RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b001;
                // DBDataSrc <= 1;// useless
                ExtSel <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <={0,~(sign|zero)};
            end
            jal:begin
                RegDst <= 2'b00;
                WrRegDSrc <= 0;
                PCSrc <= 2'b11;
            end

            jr: begin
                PCSrc <= 2'b10;
            end

            j:begin
                PCSrc <= 2'b11;
            end

            6'b111111: begin
                PCWre <= 0;
                PCSrc <= 0;
            end
            default: PCWre <= 0;
        endcase
    end

endmodule