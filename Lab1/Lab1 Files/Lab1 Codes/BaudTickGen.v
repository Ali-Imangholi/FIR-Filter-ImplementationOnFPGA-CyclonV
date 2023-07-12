module BaudTickGen(
    input clk, enable,
    output reg tick  // generate a tick at the specified baud rate * oversampling
);
parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 1;

////////////////////////////////
//Calculate clk tick number between each two baud tick
//Generate baud tick
//place your code here
////////////////////////////////

endmodule