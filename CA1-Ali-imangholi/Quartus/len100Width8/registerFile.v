module registerFile //This register file has ability to shift it's cells
#(parameter WIDTH=8, parameter LENGTH=100)
(
input rst,
input shift_enb,
input signed [WIDTH-1:0]in,
input [LENGTH-1:0] pointer,
input clk,
output wire signed [WIDTH-1:0]out 
);

integer i=0;
integer j=0;
reg signed [WIDTH - 1:0] regFile [0:LENGTH-1];


always@(posedge clk, posedge rst)
begin: registerFile
	//out <= regFile[pointer]; // we must initialize out in order to synthesize tool don't make a latch.
	i = 0;
	j = 0;
	if(rst == 1'b1)
	begin:registerFile_reset
		for (i=0; i < LENGTH ; i=i+1 )
			regFile[i] <= 0;
	end
	
	else if(shift_enb == 1'b1)
	begin:registerFile_shift
		regFile[0]<=in;
		for (j=1; j < LENGTH ; j=j+1 )
			regFile[j] <= regFile[j - 1];
	end
	
	//else
	//begin:pointer_in_registerFile
	//	out <= regFile[pointer];
	//end	
end

assign out = regFile[pointer];
endmodule
