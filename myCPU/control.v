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
    input clk,ctrl,//ctrl是保证跳转指令的id段之后的控制信号都是0
    input [5:0] op,
    input [5:0] func,
    input [31:0]instruction,
    output reg 
    RegDst,
    Branch,
    MemtoReg,
    Alusrc1,//busA端的输入来自立即数
    Alusrc2,//busB端的输入来自立即数
    RegWrite,
    output reg[1:0] Jump,//j/jr/jal
    output reg Extop,
    keep,
    output reg [1:0] MemWrite, MemRead,//内存的读和写分别有三种方式
    output reg [4:0] ALUctr);

    wire R, addi, addiu, slti, sltiu, andi, ori, lui, xori, beq, bne, bgez, bgtz, blez, bltz, lb, lh, lw, sb, sh, sw,jal,nop;
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
    assign bgez = (op == 6'b000001 && instruction[20:16] == 5'b00001) ? 1 : 0;
    assign bgtz = (op == 6'b000111) ? 1 : 0;
    assign blez = (op == 6'b000110) ? 1 : 0;
    assign bltz = (op == 6'b000001 && instruction[20:16] == 5'b00000) ? 1 : 0;
    assign lb = (op == 6'b100000) ? 1 : 0;
    assign lh = (op == 6'b100001) ? 1 : 0;
    assign lw = (op == 6'b100011) ? 1 : 0;
    assign sb = (op == 6'b101000) ? 1 : 0;
    assign sh = (op == 6'b101001) ? 1 : 0;
    assign sw = (op == 6'b101011) ? 1 : 0;
    assign jal = (op == 6'b000011) ? 1 : 0;
    assign nop =(instruction==0)? 1:0;
    always @(posedge clk)
        begin
            if(R|addi|addiu|slti|sltiu|andi|ori|lui|xori|beq|bne|bgez|bgtz|blez|bltz|lb|lh|lw|sb|sh|sw|nop|jal==1)
                begin
                    keep=0;
                end  
            else if(ctrl == 0)
                keep=1;
        end
    always @(*)
        begin
            if(ctrl==1|nop==1)
                begin
                    RegDst=0;
                    Branch=0;
                    MemtoReg=0;
                    Alusrc1=0;
                    Alusrc2=0;
                    MemWrite=2'b00;
                    MemRead=2'b00;
                    RegWrite=0;
                    Jump=2'b00;
                    Extop=0;
                end
            else
                begin
                    RegDst = R;
                    Branch = beq | bne | bgez | bgtz | blez | bltz;
                    MemtoReg = lb | lh | lw;
                    Alusrc1 = (R == 1) && (func==6'b000000 || func[5:1]==5'b00001);
                    Alusrc2 = MemtoReg | sb | sh | sw | addi | addiu | slti | sltiu | andi | ori | lui | xori;
                    if(lb == 1)
                        MemRead = 2'b01;
                    else if(lh == 1)
                        MemRead = 2'b10;
                    else if(lw == 1)
                        MemRead = 2'b11;
                    else MemRead = 2'b00;
                    if(sb == 1)
                        MemWrite = 2'b01;
                    else if(sh == 1)
                        MemWrite = 2'b10;
                    else if(sw == 1)
                        MemWrite = 2'b11;
                    else MemWrite = 2'b00;
                    RegWrite = R | addi | addiu | slti | sltiu | andi | ori | lui | xori | MemtoReg | jal;
                    if(op == 6'b000010)//j
                        Jump = 2'b01;
                    else if(op == 6'b000000 && func == 6'b001000)//jr
                        Jump = 2'b10;
                    else if(op == 6'b000011)//jal
                        Jump = 2'b11;
                    else Jump = 2'b00;
                    Extop = addi | addiu | slti | sltiu | MemtoReg | sb | sh | sw | Branch;
                end
        end

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
                    6'b000011 : ALUctr = 5'b01000;
                    default: ALUctr = 0;
                endcase
            end
    end
    
endmodule
