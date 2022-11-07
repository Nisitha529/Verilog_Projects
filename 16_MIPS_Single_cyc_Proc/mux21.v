module mux21 (
    input A,B,sel,
    output O
);
    not #(50) not1(nsel,sel);
    and #(50) and1(O1,A,nsel);
    and #(50) and2(O2,B,sel);
    or  #(50) or1(O,O1,O2);
endmodule