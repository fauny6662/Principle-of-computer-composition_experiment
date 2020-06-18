`timescale 1ns / 1ps

module test_mips;
    reg clk, rst;
    Mips mips1(clk, rst);
    initial 
        begin:Clocking
            clk = 0;
            forever #10 clk = ~clk;
        end
    initial
        begin
            rst = 1;
            #20 rst = 0;
        end

endmodule // test_mips