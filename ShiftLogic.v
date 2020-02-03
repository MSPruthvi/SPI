`timescale 1ns / 1ps

module Store1Bit_pos(d_in,clk,rst,sel,d_out);

input d_in,clk,rst,sel;
output d_out;
wire mx_out;

dff_pos d(mx_out,clk,rst,d_out);
Mux2x1 m (d_out,d_in,sel,mx_out);

endmodule

module Store1Bit_neg(d_in,clk,rst,sel,d_out);

input d_in,clk,rst,sel;
output d_out;
wire mx_out;

dff_neg d(mx_out,clk,rst,d_out);
Mux2x1 m (d_out,d_in,sel,mx_out);

endmodule

module store8bit_pos(d_in,lsbfe,clk,rst,sel,d_out);

input d_in,clk,rst,sel,lsbfe;
output [7:0]d_out;
wire [8:0]w;

assign w[0]=d_in;
genvar i;


generate
	for(i=0;i<8;i=i+1)
	begin:store
		Store1Bit_pos s1(w[i],clk,rst,sel,w[i+1]);
		Mux2x1 m1 (w[i+1],w[(7-i)+1],lsbfe,d_out[i]);
	end
endgenerate
 
endmodule

module store8bit_neg(d_in,lsbfe,clk,rst,sel,d_out);

input d_in,clk,rst,sel,lsbfe;
output [7:0]d_out;
wire [8:0]w;

assign w[0]=d_in;
genvar i;
//assign d_out=w[8:1];

generate
	for(i=0;i<8;i=i+1)
	begin:store
		Store1Bit_neg s1(w[i],clk,rst,sel,w[i+1]);
		Mux2x1 m1 (w[i+1],w[(7-i)+1],lsbfe,d_out[i]);
	end
endgenerate
 
endmodule
