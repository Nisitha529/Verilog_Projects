module D_FF (
    input d,
    input rst_n,
    input clk,
    input init_value,
    output q
);

    reg q ;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) q <= init_value ;
        else q <= d ;
    end
    
endmodule