module signed_multiply
#(parameter WIDTH=16)
(
 input signed [WIDTH-1:0] in_1,
 input signed [WIDTH-1:0] in_2,
 output [2*WIDTH-1:0] out
);

 assign out = in_1 * in_2;

endmodule