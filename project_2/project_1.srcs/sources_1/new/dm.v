module dm_4k(addr , din , we ,re, clk , dout);     
    input   [11: 0]addr;  // address bus     
    input   [31: 0]din;   // 32-bit input data     
    input we;    // memory write enable
    inout re;    
    input clk;   // clock 
    output reg[31: 0]dout;  // 32-bit memory output 
    reg [31: 0] dm[1023: 0];
    
    initial
        $readmemh("D:\\VsCode\\Codes\\firstPractice\\data.txt" , dm);

    always @(posedge clk)
        begin
            if(we)
                dm[addr[11:2]] <= din;
        end
    always @(negedge clk)
        begin
            if(re)
            dout = dm[addr[11: 2]];
        end

endmodule
