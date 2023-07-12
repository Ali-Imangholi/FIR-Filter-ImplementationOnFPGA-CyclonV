module coefficients_Rom
#(parameter WIDTH=16, parameter LENGTH=64)
(
input [LENGTH-1:0]pointer,
output  [WIDTH - 1:0] RomOut // cofficient that pointer indicate to it.
);

reg signed [WIDTH - 1:0] coeffs [0:LENGTH-1];
initial
 begin
	$readmemb("coeffs.txt", coeffs);
 end

assign RomOut = coeffs[pointer];

endmodule