`define MODE0,MODE1

module Receiver(data_in,clk,rst,LSBFE,cpol,cpha,store_data,ready);
	input data_in,clk,rst,cpol,cpha,LSBFE,ready;
	output [0:7]store_data;
	wire [2:0]cnt;
	//wire w;
	reg cntr_en,x,c;
	
	parameter IDLE=2'b00, WAIT=2'b01, TRANSFER=2'b10, STOP=2'b11;
	reg [1:0]ps,ns;

	//ModeSelectionRx u1(.in(data_in),.clk(clk),.rst(rst),.cpol(cpol),.cpha(cpha),.out(w));
	//store8bit_pos u2(.d_in(data_in),.lsbfe(LSBFE),.clk(clk),.rst(rst),.sel(cntr_en),.d_out(store_data));
	store8bit_neg u2(.d_in(data_in),.lsbfe(LSBFE),.clk(clk),.rst(rst),.sel(cntr_en),.d_out(store_data));
	//count_pos_nc ct (.clk(clk),.en(cntr_en),.LSBFE(LSBFE),.rst(rst),.out(cnt));
	count_neg_nc ct (.clk(clk),.en(cntr_en),.LSBFE(LSBFE),.rst(rst),.out(cnt));

`ifdef MODE0

//FSM logic for Mode 0
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

`elsif MODE1
//FSM logic for Mode 0
always@(negedge clk) 
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
`endif

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
					ns<=WAIT;
				else
					ns<=STOP;
				end
	endcase
end
endmodule



module test_receiver;
	reg data_in,clk,rst,cpol,cpha,ready,LSBFE;
	wire [7:0]store_data;

Receiver dut (data_in,clk,rst,LSBFE,cpol,cpha,store_data,ready);

initial begin
	data_in=0; clk=0; rst=1; 
	cpol=0; cpha=1; 
	ready=1;
	LSBFE=1;
	#20
	rst=0;
	//#2
   //ready = 1;
end

always #7 data_in=$random;
always #13 clk=~clk;
endmodule
