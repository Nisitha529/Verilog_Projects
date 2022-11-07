module andmore (
    input a,b,c,d,e,
    output g
);
    
    and #(50) and1(f1,a,b,c,d) , and2(g,f1,e);

endmodule