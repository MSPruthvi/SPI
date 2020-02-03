module ModeSelectionTx(in,clk,rst,cpol,cpha,out);
	input in,clk,rst,cpol,cpha;
	output out;
	
	wire [3:0]w;

//Mode 0
dff_pos u0 (.d(in),.clk(clk),.rst(rst),.q(w[0]));

//Mode 1;
dff_neg u1 (.d(in),.clk(clk),.rst(rst),.q(w[1]));

//mode 2
assign w[2]=w[1];

//Mode 3
assign w[3]=w[0];

//Mux
Mux4x1 m(.a(w),.sel({cpol,cpha}),.out(out));

endmodule
