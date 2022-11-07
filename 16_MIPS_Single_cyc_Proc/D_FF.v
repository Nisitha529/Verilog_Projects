module D_FF (
    output q,
    input d,
    input rst_n,
    input clk,
    input init_value
);

    reg q ;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) q <= init_value ;
        else q <= d ;
    end
    
endmodule