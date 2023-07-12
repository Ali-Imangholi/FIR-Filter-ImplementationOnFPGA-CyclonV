module signed_adder
#(parameter WIDTH=16)
(
 input signed [2*WIDTH+5:0] in_1,
 input signed [2*WIDTH+5:0] in_2,
 input cin,
 output signed[2*WIDTH+5:0] out
);

 assign out = in_1 + in_2 + cin;

endmodule