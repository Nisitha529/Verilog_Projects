`timescale 1ns / 1ps

 module tb_mips16;  
      // Inputs  
      reg clk;  
      reg reset;  
      wire [15:0] pc_out;  
      wire [15:0] alu_result;//,reg3,reg4;  
      // Instantiate the Unit Under Test (UUT)  
      mips_16 uut (  
           .clk(clk),   
           .reset(reset),   
           .pc_out(pc_out),   
           .alu_result(alu_result)  
           //.reg3(reg3),  
          // .reg4(reg4)  
      );  
      initial begin  
           clk = 0;  
           forever #10 clk = ~clk;  
      end  
      initial begin  
           reset = 1;  
           #100;  
      reset = 0;  
      end  
 endmodule  