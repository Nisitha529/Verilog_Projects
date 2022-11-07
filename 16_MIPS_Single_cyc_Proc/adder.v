module adder (
    input a,
    input b,
    input cin,
    output cout,
    output sum,
);

xor #(50) xor1(sum ,a,b,cin);
and #(50) and1(c1,a,b);
or  #(50) or1(c2,a,b);
and #(50) and2(c3,c2,cin);
or  #(50) or2(cout,c1,c3);
    
endmodule