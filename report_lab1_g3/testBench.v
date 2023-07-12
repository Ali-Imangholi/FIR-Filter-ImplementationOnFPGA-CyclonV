`timescale 1ns / 1ns

module testbench;
//
parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 4;
parameter WIDTH=16;
parameter OUT_WIDTH=38;
//
reg clk_50;
reg [0:0] key;		//reset key
reg [3:0] sw;
reg uart_rxd;
wire [15:0] ledr;
wire uart_txd;

//

LAB1_top mut(
.CLOCK_50(clk_50),
.KEY(key),
.SW(sw),
.UART_RXD(uart_rxd),
.UART_TXD(uart_txd),
.LEDR(ledr)
);

// make clks

initial
begin
	clk_50 = 1'b0;
end

always #20 clk_50 = ~clk_50;

// make reset signal

initial
begin 
	key = 1'b0;   
	#25
	key = 1'b1;
	#25
	key = 1'b0;
	#25;
end

// push each input
//1111100101100000
//22000
//21000
initial
begin
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;	
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#Baud
	uart_rxd = 1'b1;
	#Baud
	uart_rxd = 1'b0;
	#250000;
end

endmodule
