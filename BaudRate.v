`timescale 1ns / 1ps
//Module multi 
module multi(sppr,spr,out);

input[2:0] sppr,spr;
output reg [10:0]out;
wire [7:0]res;
wire [3:0]res1,res2;
integer i;

assign res1=sppr+1;
assign res2=spr+1;
assign res=2**res2;					//formula:  baud rate gen divisor=(SPPR+1)*2^(SPR+1)

always@(*)
begin	
	out=11'b0;
	for(i=0;i<4;i=i+1)
	begin
		if(res1[i]==1)
		begin
			out=out+(res<<i);		//
		end
		else
			out=out;
	end
out = out>>1;

end
endmodule

//Baud rate generation
module baudRate(in,clk,cpol,outs);

input [10:0] in;
input clk,cpol;
output outs;
reg out;
reg i;
reg [10:0] cnt;

always@(posedge clk)
begin
/*if(rst)
begin
	out<=0;
	cnt<=0;
end
else*/
		if(cnt<in-1 && i==0)
			begin	
				out<=1;
				cnt<=cnt+1;
			end
		else if(cnt==in-1 && i==0)
			begin
				i<=1; 
				out<=1;
			end  
		else if(((cnt>0) || (in==1))&& i==1)
			begin
				out<=0;
            if(in==1)
				i<=0;	
				else
				cnt<=cnt-1;
			end
		else
			begin
				i<=0;
				cnt<=0;
			end		
	end
assign outs=cpol?out:~out;

endmodule

//bad top module
module baud_top(sppr,spr,clk,cpol,outs);

input clk,cpol;
input[2:0] sppr,spr;
output outs;
wire [10:0] w;

multi m1(sppr,spr,w);
baudRate b1(w,clk,cpol,outs);

endmodule
 