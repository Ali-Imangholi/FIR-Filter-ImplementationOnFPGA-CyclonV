module counter
#(parameter LENGTH = 100)
(
input clk,
input rst,
input count_enb,
output reg [LENGTH-1:0]out,
output wire rollBack
);

assign rollBack = (out == LENGTH - 2) ? 1'b1 : 1'b0; //for sync the start counting and states.

always@(posedge clk, posedge rst)
begin:counter
	if(rst == 1'b1)
		out <= 0;
	
	else if (count_enb == 1'b1)
	begin
		if(out == LENGTH - 1) //rollBack
		begin
			out <= 0;
		end
		else
			out <= out + 1;
	end
	
	else
		out <= 0; //default in order to synthesize tool don't make a latch.
end

endmodule