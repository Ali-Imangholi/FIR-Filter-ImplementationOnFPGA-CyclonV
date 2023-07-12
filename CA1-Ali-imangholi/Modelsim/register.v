module register
#(parameter WIDTH=16)
(
 input signed [2*WIDTH+5:0] in,
 input clk,
 input reset,
 input enb,
 output reg signed [2*WIDTH+5:0] out
);

always@(posedge clk) 
begin : REGISTER
	if(reset == 1'b1)
		out <= 0;
	else if(enb == 1'b1)
		out <= in;
	else
		out <= out;

end

endmodule