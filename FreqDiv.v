/*module freq_divider(clk,rst,clkout);
	 input clk,rst;
	 output  clkout;
	wire [26:0] q;
	genvar i;
	
	//assign q[0]=clk;

  generate for (i=0; i<27; i=i+1)
   begin : loop
		dff_pos di (~q[i],clk,rst,q[i]);
   end
endgenerate

assign clkout=q[26];

endmodule*/

module Clock_divider(clock_in,clock_out);
input clock_in; 
output clock_out; 
reg[27:0] counter=28'd0;
parameter DIVISOR = 28'd50000000;

always @(posedge clock_in)
begin
 counter <= counter + 28'd1;
 if(counter>=(DIVISOR-1))
  counter <= 28'd0;
end
assign clock_out = (counter<DIVISOR/2)?1'b0:1'b1;

endmodule


module tb_freq;

reg clock_in; 
wire clock_out; 

	Clock_divider dut(clock_in,clock_out);

initial 
begin
clock_in=1;


end

always #5 clock_in=~clock_in;

endmodule
