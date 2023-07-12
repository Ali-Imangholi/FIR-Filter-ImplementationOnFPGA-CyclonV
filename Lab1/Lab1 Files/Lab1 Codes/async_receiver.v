module async_receiver(
    input clk,
    input RxD,
    output reg RxD_data_ready = 0,
    output reg [7:0] RxD_data = 0  // data received, valid only (for one clock cycle) when RxD_data_ready is asserted
);

parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 4;	// needs to be a power of 2


////////////////////////////////
//place your code here
////////////////////////////////

endmodule
