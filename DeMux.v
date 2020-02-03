`timescale 1ns / 1ps

module DeMux1x2(in,sel,a,b);

input in,sel;
output reg a,b;

always@(*) begin
	if(sel)
		begin
			b<=in;
			a<=0;
		end
	else
		begin
			a<=in;
			b<=0;
		end
end

endmodule
