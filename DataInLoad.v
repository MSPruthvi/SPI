`timescale 1ns / 1ps

module DataInLoad(din,clk,rst,en,LSBFE,cpol,cpha,out,out_cnt);

input [7:0]din;
input clk,rst,en,LSBFE,cpol,cpha;
output out;
output [2:0]out_cnt; 

CounterTop_nc ct (clk,rst,en,LSBFE,cpol,cpha,out_cnt);
Mux8x1 mx (din,out_cnt,out);

endmodule
