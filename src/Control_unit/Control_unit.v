`timescale 1ns / 1ps

module Control_unit(
    input [5:0] Opcode,
    input zero,
    input sign,
    output reg Reset,// �͵�ƽ��Ч���͵�ƽ����
    output reg ALUSrcA,
    output reg ALUSrcB,
    output reg DBDataSrc,
    output reg PCWre,
    output reg RegWre,
    output reg InsMemRW,
    output reg nRD, // �͵�ƽ��Ч�����ݴ洢�����ź�
    output reg nWR, // �͵�ƽ��Ч�����ݴ洢��д�ź�
    output reg RegDst,// ѡ��д�Ĵ����ĵ�ַ
    output reg ExtSel,// 
    output reg [1:0] PCSrc, // ѡ��ʹ����һ��������PC��ַ
    output reg [2:0] ALUOp // ALU�����룬ѡ��ALU�Ĺ���
);
    always@(*)
    begin
        case(Opcode)
            6'b000000: begin // add
                PCWre <= 1;
                RegDst <= 1;
                RegWre <= 1;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b000;
                DBDataSrc <= 0;
                PCSrc <= 0;
                nRD <= 1;
                nWR <= 1;
            end
            6'b000001: begin // addi
                PCWre <= 1;
                // InsMemRW <= 1;
                RegDst <= 0;
                RegWre <= 1;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b000;
                DBDataSrc <= 0;
                ExtSel <= 1; // 符号拓展
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b000010: begin // sub
                PCWre <= 1;
                // InsMemRW <= 1;
                RegDst <= 1;
                RegWre <= 1;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b001;
                DBDataSrc <= 0;
                // ExtSel <= ;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end

            6'b010000: begin // ori
                PCWre <= 1;
                // InsMemRW <= 1;
                RegDst <= 0;
                RegWre <= 1;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b011;
                DBDataSrc <= 0;
                ExtSel <= 0; // 0拓展
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b010001: begin // and
                PCWre <= 1;
                // InsMemRW <= 1;
                RegDst <= 1;
                RegWre <= 1;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b100;
                DBDataSrc <= 0;
                // ExtSel <= ;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b010010: begin  // or
                PCWre <= 1;
                RegDst <= 1;
                RegWre <= 1;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b011;
                DBDataSrc <= 0;
                // ExtSel <= ;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b011000: begin // sll
                PCWre <= 1;
                RegDst <= 1;
                RegWre <= 1;
                ALUSrcA <= 1;// Sa_number
                ALUSrcB <= 0;
                ALUOp <= 3'b010;
                DBDataSrc <= 0;
                // ExtSel <= ;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b011100: begin // slt
                PCWre <= 1;
                RegDst <= 1;
                RegWre <= 1;
                ALUSrcA <= 0;// Sa_number
                ALUSrcB <= 0;
                ALUOp <= 3'b110;
                DBDataSrc <= 0;
                // ExtSel <= ;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b100110: begin // sw rt, imm(rs)
                PCWre <= 1;
                RegDst <= 0;
                RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b000;
//                DBDataSrc <= 1;
                ExtSel <= 1;
                nRD <= 1;
                nWR <= 0;
                PCSrc <= 0;
            end
            6'b100111: begin // lw rt, imm(rs)
                PCWre <= 1;
                RegDst <= 0;
                RegWre <= 1;
                ALUSrcA <= 0;
                ALUSrcB <= 1;
                ALUOp <= 3'b000;
                DBDataSrc <= 1;
                ExtSel <= 1;
                nRD <= 0;
                nWR <= 1;
                PCSrc <= 0;
            end
            6'b110000: begin // beq rs, rt, imm
                PCWre <= 1;
                RegDst <= 0;
                RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b111;
                DBDataSrc <= 1;// useless
                ExtSel <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= zero;
            end    
            6'b110001: begin // bne rs, rt, imm
                PCWre <= 1;
                RegDst <= 0;
                RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b111;
                DBDataSrc <= 1;// useless
                ExtSel <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <= {0,~zero};
            end
            6'b110010: begin // bgtz rs, imm
                PCWre <= 1;
                RegDst <= 0;
                RegWre <= 0;
                ALUSrcA <= 0;
                ALUSrcB <= 0;
                ALUOp <= 3'b001;
                DBDataSrc <= 1;// useless
                ExtSel <= 1;
                nRD <= 1;
                nWR <= 1;
                PCSrc <={0,~(sign|zero)};
            end
            6'b111000: begin // j addr
                PCWre <= 1;
//                RegDst <= 0;
//                RegWre <= 0;
//                ALUSrcA <= 0;
//                ALUSrcB <= 0;
//                ALUOp <= 3'b001;
//                DBDataSrc <= 1;// useless
//                ExtSel <= 1;
//                nRD <= 1;
//                nWD <= 1;
                PCSrc <= 10;
            end   
            6'b111111: begin
                PCWre <= 0;
                PCSrc <= 0;
            end
            default: PCWre <= 0;
        endcase
    end

endmodule