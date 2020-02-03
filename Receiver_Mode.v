
module Receiver_0_3(data_in,clk,rst,LSBFE,store_data,ready);
	input data_in,clk,rst,LSBFE,ready;
	output [0:7]store_data;
	wire [2:0]cnt;
	//wire w;
	reg cntr_en,x,c;
	
	parameter IDLE=2'b00, WAIT=2'b01, TRANSFER=2'b10, STOP=2'b11;
	reg [1:0]ps,ns;


	store8bit_pos u2(.d_in(data_in),.lsbfe(LSBFE),.clk(clk),.rst(rst),.sel(cntr_en),.d_out(store_data));
	count_pos_nc ct (.clk(clk),.en(cntr_en),.LSBFE(LSBFE),.rst(rst),.out(cnt));

//FSM logic for Mode 0 & 3
always@(posedge clk) 
begin
	if(rst) begin
		ps<=IDLE;
		//dout_m<=8'b0;
		cntr_en<=0;
		x<=0;
		end	
	else
		begin
			ps<=ns;
			x<=x+1;
		end		
	
	case(ps)
		IDLE: begin
				c<=0;
		end
		
		WAIT: begin
				//cntr_en<=0;
				//c<=0;
		end
				
		TRANSFER: begin
				if((cnt==3'b111 && LSBFE) || (cnt==3'b000 && !LSBFE))							//count is output of counter module
					begin
						c<=1;											//completion flag
						cntr_en<=0;						
					end	
				else
					begin
						cntr_en<=1;
						c<=0;
					end
				end 
		STOP:begin
				if(c)begin
					//cntr_en<=0;
					c<=0;
					end
				end
	endcase	
	
end
always@(ps,x,ready,cnt,c,LSBFE) 
begin
	case(ps)
		IDLE: begin
					if(ready)
						ns<=WAIT;
					else
						ns<=IDLE;
				end
				
		WAIT: begin		
					if(ready)
						ns<=TRANSFER;
					else
						ns<=WAIT;					
				end
				
		TRANSFER: begin
				if((cnt==3'b111 && LSBFE) || (cnt==3'b000 && !LSBFE))
					ns<=STOP;
				else
					ns<=TRANSFER;				
				end
				
		STOP:begin
				if(c)
					ns<=TRANSFER;
				else
					ns<=STOP;
				end
	endcase
end

endmodule
