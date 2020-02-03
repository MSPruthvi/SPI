`timescale 1ns / 1ps

module SPI(clk,rst,SPI_RDY,LSBFE,sppr,spr,cpol,cpha,Data_in_m,Data_in_s,Data_out_m,Data_out_s,c);
	
	input clk,rst,cpol,cpha,SPI_RDY,LSBFE;
	input [2:0] sppr,spr;
	input [7:0]Data_in_m,Data_in_s;
	output [7:0]Data_out_m,Data_out_s;
	output c;
	wire MISO,MOSI,s_clk,SS_b;
	

	baud_top b (.sppr(sppr),.spr(spr),.clk(clk),.cpol(cpol),.outs(s_clk));
	MasterMode m (.clk(s_clk),.rst(rst),.Data_in(Data_in_m),.SPI_RDY(SPI_RDY),.LSBFE(LSBFE),.cpol(cpol),.cpha(cpha),.MISO(MISO),.Data_out(Data_out_m),.MOSI(MOSI),.SS_b(SS_b));
	SlaveMode s (.clk(s_clk),.rst(rst),.Data_in(Data_in_s),.SS_b(SS_b),.LSBFE(LSBFE),.cpol(cpol),.cpha(cpha),.MOSI(MOSI),.Data_out(Data_out_s),.MISO(MISO),.c(c));

endmodule

module SPI_tb;

	reg clk,rst,cpol,cpha,SPI_RDY,LSBFE;
	reg [2:0] sppr,spr;
	reg [7:0]Data_in_m,Data_in_s;
	wire [7:0]Data_out_m,Data_out_s;
	wire c;
	SPI dut(clk,rst,SPI_RDY,LSBFE,sppr,spr,cpol,cpha,Data_in_m,Data_in_s,Data_out_m,Data_out_s,c);

initial 
begin
rst=1;
clk=0;
cpol=0;
cpha = 0;
SPI_RDY = 0;
LSBFE = 0;

sppr = 0;
spr = 0;

Data_in_m = 8'b1011_0100;
Data_in_s = 8'b1001_0111;


#100
rst = 0;
SPI_RDY= 1;
end

always #5 clk = ~clk;

endmodule