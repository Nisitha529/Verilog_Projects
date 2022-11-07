module mux2x5to5(
    input [4:0] Addr0 , Addr1 ,
    input Select,
    output [4:0] AddrOut
);
    
    mux21 mux0(AddrOut[0], Addr0[0],Addr1[0],Select);
    mux21 mux1(AddrOut[1], Addr0[1],Addr1[1],Select);
    mux21 mux2(AddrOut[2], Addr0[2],Addr1[2],Select);
    mux21 mux3(AddrOut[3], Addr0[3],Addr1[3],Select);
    mux21 mux1(AddrOut[4], Addr0[4],Addr1[4],Select);

endmodule