`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/06 19:58:07
// Design Name: 
// Module Name: ctrl
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


module ctrl(
    input [5:0]op,
    output reg RegDst,
    Branch,
    MemtoReg,
    Alusrc,
    MemWrite,
    RegWrite,
    Jump,
    Extop,
    output reg[1:0]Aluop,
    output reg r_type
    );
    
    always @(*)
        begin
            case(op)
                6'b000000: //R-type
                    begin
                        RegDst=1;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=0;
                        MemWrite=0;
                        RegWrite=1;
                        Jump=0;
                        Extop=0;
                        Aluop=0;
                        Aluop[0]=1;
                        r_type=1;
                    end 
                6'b001101: //ori
                    begin
                        RegDst=0;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=1;
                        MemWrite=0;
                        RegWrite=1;
                        Jump=0;
                        Aluop=0;
                        Aluop[1]=1;
                        Extop=0;
                        r_type=0;
                    end
                6'b100011://lw
                    begin
                        RegDst=0;
                        Branch=0;
                        MemtoReg=1;
                        Alusrc=1;
                        MemWrite=0;
                        RegWrite=1;
                        Jump=0;
                        Aluop=0;
                        Extop=1;
                        r_type=0;
                    end
                6'b101011://sw
                    begin
                        RegDst=0;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=1;
                        MemWrite=1;
                        RegWrite=0;
                        Jump=0;
                        Aluop=0;
                        Extop=1;
                        r_type=0;
                    end
                6'b000100://beq
                    begin
                        RegDst=0;
                        Branch=1;
                        MemtoReg=0;
                        Alusrc=0;
                        MemWrite=0;
                        RegWrite=0;
                        Jump=0;
                        Aluop=0;
                        Aluop[0]=1;
                        Extop=0;
                        r_type=0;
                    end
                6'b000010: //jp
                    begin
                        RegDst=0;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=0;
                        MemWrite=0;
                        RegWrite=0;
                        Jump=1;
                        Aluop=0;
                        Aluop[0]=1;
                        Extop=0;
                        r_type=0;
                    end
                6'b001000:  //addi
                    begin
                        RegDst=0;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=1;
                        MemWrite=0;
                        RegWrite=1;
                        Jump=0;
                        Aluop=0;
                        Extop=1;
                        r_type=0;
                    end
                6'b001001:  //addiu
                    begin
                        RegDst=0;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=1;
                        MemWrite=0;
                        RegWrite=1;
                        Jump=0;
                        Aluop=0;
                        Extop=1;
                        r_type=0;
                    end
                6'b001010:  //slt
                    begin
                        RegDst=1;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=0;
                        MemWrite=0;
                        RegWrite=1;
                        Jump=0;
                        Aluop=0;
                        Extop=0;
                        r_type=1;
                    end
                default:
                    begin
                        RegDst=0;
                        Branch=0;
                        MemtoReg=0;
                        Alusrc=0;
                        MemWrite=0;
                        RegWrite=0;
                        Jump=0;
                        Aluop=0;
                        Extop=0;
                        r_type=0;
                    end
            endcase
        end
endmodule
