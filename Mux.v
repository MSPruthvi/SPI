`timescale 1ns / 1ps
module Mux2x1(a,b,sel,out);

input a,b,sel;
output out;

assign out=sel?b:a;

endmodule

module Mux4x1(a,sel,out);

input [3:0]a;
input [1:0]sel;
output out;
wire [1:0]w;

Mux2x1 m1 (a[0],a[1],sel[0],w[0]);
Mux2x1 m2 (a[2],a[3],sel[0],w[1]);
Mux2x1 m3 (w[0],w[1],sel[1],out);

endmodule

module Mux8x1(a,sel,out);

input [7:0]a;
input [2:0]sel;
output out;
wire [5:0]w;

Mux2x1 m1 (a[0],a[1],sel[0],w[0]);
Mux2x1 m2 (a[2],a[3],sel[0],w[1]);
Mux2x1 m3 (a[4],a[5],sel[0],w[2]);
Mux2x1 m4 (a[6],a[7],sel[0],w[3]);
Mux2x1 m5 (w[0],w[1],sel[1],w[4]);
Mux2x1 m6 (w[2],w[3],sel[1],w[5]);
Mux2x1 m7 (w[4],w[5],sel[2],out);

endmodule
