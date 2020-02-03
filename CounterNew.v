`timescale 1ns / 1ps

module CounterTop_nc(clk,rst,en,LSBFE,cpol,cpha,out_cnt);

input clk,rst,en,LSBFE,cpol,cpha;
output [2:0]out_cnt;

wire sel,ena,enb;
wire [2:0]out_n,out_p;
genvar i;

assign sel=(cpol==cpha)?1:0;

DeMux1x2 dn (en,sel,enb,ena);
count_neg_nc cn (clk,ena,LSBFE,rst,out_n);
count_pos_nc cp (clk,enb,LSBFE,rst,out_p);

generate for(i=0;i<3;i=i+1)
	begin: count_m
		Mux2x1 mi (out_p[i],out_n[i],sel,out_cnt[i]);
	end
endgenerate

endmodule


//posedge counter
module count_pos_nc(clk,en,LSBFE,rst,out);

input rst,clk,en,LSBFE;
output reg [2:0] out;

always@(posedge clk)
begin
	if(rst)
	begin
		if(LSBFE)
			out<=3'b0;
		else
			out<=3'b111;		
	end
else
	begin 
	if(en)
		begin
			if(LSBFE)
			begin
				out<=out+1;	
				if(out==3'b111)
					out<=3'b0;
			end	
			else
			begin
			out<=out-1;
				if(out==3'b000)
					out<=3'b111;							
			end
		end
		else
			out<=out;	
	end
end		
endmodule
//counter negedge module
module count_neg_nc(clk,en,LSBFE,rst,out);

input rst,clk,en,LSBFE;
output reg [2:0] out;

always@(negedge clk)
begin
if(rst)
	begin
		if(LSBFE)
			out<=3'b0;
		else
			out<=3'b111;
	end
else 
	begin
	if(en)
		begin
			if(LSBFE)
			begin
				out<=out+1;								
			end	
			else
			begin
				out<=out-1;				
			end
		end
	else
		out<=out;
	end
end		
endmodule
