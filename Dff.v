//D FF Pos edge module

module dff_pos(d,clk,rst,q);
	input d,clk,rst;
	output reg q;
	
always@(posedge clk) begin
	if(rst)
		q<=0;
	else
		q<=d;
end
endmodule

//D FF Negedge edge module

module dff_neg(d,clk,rst,q);
	input d,clk,rst;
	output reg q;
	
always@(negedge clk) begin
	if(rst)
		q<=0;
	else
		q<=d;
end
endmodule
