module MCU_tb ();
    reg clk,rst;
    MicroController uut(
        .clk(clk),
        .rst(rst)
    );

    initial begin
        rst = 1;
        #100;
        rst = 0;
    end 
    
    initial begin
        clk = 0 ;
        forever begin
            #10 clk = ~clk ;
        end    
    end

endmodule