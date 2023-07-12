module BaudTickGen(
    input clk, enable,
    output reg tick  // generate a tick at the specified baud rate * oversampling
);
parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 1;
reg [24:0] count;
reg [24:0] top;

 


always @ (posedge clk) begin
top =( (ClkFrequency / Baud) /Oversampling);
	if (enable) begin
		count = 20'b0;
		tick= 1'b0;
	end
	else begin
		if (count == top) begin
			tick = 1'b1;
			count = 20'b0;
		end
		else begin
			tick=1'b0;
			count = count + 1'b1;
		end
	end
end

endmodule

