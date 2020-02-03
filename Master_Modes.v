module MasterMode(clk,rst,Data_in,SPI_RDY,LSBFE,cpol,cpha,MISO,Data_out,MOSI,SS_b);

input clk,rst,SPI_RDY,LSBFE,cpol,cpha,MISO;
input [7:0]Data_in;
output [7:0]Data_out; 
output MOSI,SS_b;
wire sel,spi_rdy_b,spi_rdy_a,MOSI03,MOSI12,SS_b03,SS_b12;

	assign sel=(cpol==cpha)?1:0;
	
	DeMux1x2 d1 (SPI_RDY,sel,spi_rdy_b,spi_rdy_a);
	
	Transmitter_0_3 mt1 (.Data_in(Data_in),.clk(clk),.rst(rst),.ready(spi_rdy_a),.LSBFE(LSBFE),.cpol(cpol),.cpha(cpha),.sel(SS_b03),.d_out(MOSI03));
	Transmitter_1_2 mt2 (.Data_in(Data_in),.clk(clk),.rst(rst),.ready(spi_rdy_b),.LSBFE(LSBFE),.cpol(cpol),.cpha(cpha),.sel(SS_b12),.d_out(MOSI12));	
	
	Mux2x1 m3 (SS_b12,SS_b03,sel,SS_b);
	Mux2x1 m4 (MOSI12,MOSI03,sel,MOSI);
	
	Receiver_0_3 mr1(.data_in(MISO),.clk(clk),.rst(rst),.LSBFE(LSBFE),.store_data(Data_out),.ready(SS_b));
	
endmodule
