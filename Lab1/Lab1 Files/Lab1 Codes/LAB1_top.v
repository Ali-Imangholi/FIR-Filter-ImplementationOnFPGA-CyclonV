module LAB1_top(CLOCK_50, KEY, SW, UART_RXD, UART_TXD, LEDR);

input CLOCK_50;
input [0:0] KEY;		//reset key
input [3:0] SW;
output [15:0] LEDR;

input UART_RXD;
output UART_TXD;

parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 4;


////////////////////////////////
//Place your controller here
////////////////////////////////

endmodule
