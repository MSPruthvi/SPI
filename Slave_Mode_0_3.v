
module SlaveMode(clk,rst,Data_in,SS_b,LSBFE,cpol,cpha,MOSI,Data_out,MISO,c);

input clk,rst,SS_b,LSBFE,cpol,cpha,MOSI;
input [7:0]Data_in;
output [7:0]Data_out; 
output MISO,c;

wire sel,SS_b_a,SS_b_b,MOSI03,MOSI12,c03,c12;

	assign sel=(cpol==cpha)?1:0;
	
	DeMux1x2 d1 (SS_b,sel,SS_b_b,SS_b_a);
	
	Transmitter_0_3 st1 (.Data_in(Data_in),.clk(clk),.rst(rst),.ready(SS_b_a),.LSBFE(LSBFE),.cpol(cpol),.cpha(cpha),.sel(c03),.d_out(MOSI03));
	Transmitter_1_2 st2 (.Data_in(Data_in),.clk(clk),.rst(rst),.ready(SS_b_b),.LSBFE(LSBFE),.cpol(cpol),.cpha(cpha),.sel(c12),.d_out(MOSI12));
	
	Mux2x1 s3 (c12,c03,sel,c);
	Mux2x1 s4 (MOSI12,MOSI03,sel,MISO);
	
	Receiver_0_3 sr1 (.data_in(MOSI),.clk(clk),.rst(rst),.LSBFE(LSBFE),.store_data(Data_out),.ready(SS_b));

	
endmodule


/*module Slave_Mode_1_2(clk,rst,Data_in,SS_b,LSBFE,cpol,cpha,MOSI,Data_out,MISO,c);

input clk,rst,SS_b,LSBFE,cpol,cpha,MOSI;
input [7:0]Data_in;
output [7:0]Data_out; 
output MISO,c;


	Transmitter_1_2 st1(.Data_in(Data_in),.clk(clk),.rst(rst),.ready(SS_b),.LSBFE(LSBFE),.cpol(cpol),.cpha(cpha),.sel(c),.d_out(MISO));
	Receiver_1_2 sr1(.data_in(MOSI),.clk(clk),.rst(rst),.LSBFE(LSBFE),.store_data(Data_out),.ready(SS_b));

	
endmodule
*/