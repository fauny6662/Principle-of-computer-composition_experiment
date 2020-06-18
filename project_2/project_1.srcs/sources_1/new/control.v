`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/07 13:58:31
// Design Name: 
// Module Name: control
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module control(
    input [5:0] op,
    input [5:0] func,
    output 
    RegDst,
    Branch,
    MemtoReg,
    Alusrc1,//busA端的输入来自立即数
    Alusrc2,//busB端的输入来自立即数
    MemWrite,
    MemRead,
    RegWrite,
    Jump,
    Extop,
    output reg [4:0] ALUctr);

    wire R, addi, addiu, slti, sltiu, andi, ori, lui, xori, beq, bne, bgez, blez, lb, lh, lw, sb, sh, sw;
    assign R = (op == 6'b000000) ? 1 : 0;
    assign addi = (op == 6'b001000) ? 1 : 0;
    assign addiu = (op == 6'b001001) ? 1 : 0;
    assign slti = (op == 6'b001010) ? 1 : 0;
    assign sltiu = (op == 6'b001011) ? 1 : 0;
    assign andi = (op == 6'b001100) ? 1 : 0;
    assign ori = (op == 6'b001101) ? 1 : 0;
    assign lui = (op == 6'b001111) ? 1 : 0;
    assign xori = (op == 6'b001110) ? 1 : 0;
    assign beq = (op == 6'b000100) ? 1 : 0;
    assign bne = (op == 6'b000101) ? 1 : 0;
    assign bgez = (op == 6'b000001) ? 1 : 0;
    assign blez = (op == 6'b000110) ? 1 : 0;
    assign lb = (op == 6'b100000) ? 1 : 0;
    assign lh = (op == 6'b100001) ? 1 : 0;
    assign lw = (op == 6'b100011) ? 1 : 0;
    assign sb = (op == 6'b101000) ? 1 : 0;
    assign sh = (op == 6'b101001) ? 1 : 0;
    assign sw = (op == 6'b101011) ? 1 : 0;

    assign RegDst = R;
    assign Branch = beq | bne | bgez | blez;
    assign MemtoReg = lb | lh | lw;
    assign Alusrc1 = (R == 1) && (func==6'b000000 || func[5:1]==5'b00001);
    assign Alusrc2 = MemRead | MemWrite | addi | addiu | slti | sltiu | andi | ori | lui | xori;
    assign MemWrite = sb | sh | sw;
    assign MemRead = lb | lh | lw;
    assign RegWrite = R | addi | addiu | slti | sltiu | andi | ori | lui | xori | MemRead;
    assign Jump = (op == 6'b000010 || (op == 6'b000000 && func == 6'b001000)) ? 1 : 0;
    assign Extop = addi | addiu | slti | sltiu | MemRead | MemWrite;
    //生成5位的ALUctr
    always @(*)
    begin
        if(R)
            ALUctr = {func[5], func[3:0]};//按照R型func字段的第5,3~0位来写ALUctr
        else
            begin
                case (op)
                    6'b001000 : ALUctr = 5'b10000;
                    6'b001001 : ALUctr = 5'b10001;
                    6'b001010 : ALUctr = 5'b11010;
                    6'b001011 : ALUctr = 5'b11011;
                    6'b001100 : ALUctr = 5'b10100;
                    6'b001101 : ALUctr = 5'b10101;
                    6'b001111 : ALUctr = 5'b11000;
                    6'b001110 : ALUctr = 5'b10110;
                    6'b000100 : ALUctr = 5'b10011;
                    6'b100000 : ALUctr = 5'b10001;
                    6'b100001 : ALUctr = 5'b10001;
                    6'b100011 : ALUctr = 5'b10001;
                    6'b101000 : ALUctr = 5'b10001;
                    6'b101001 : ALUctr = 5'b10001;
                    6'b101011 : ALUctr = 5'b10001;
                    default: ALUctr = 0;
                endcase
            end
    end
    
endmodule
