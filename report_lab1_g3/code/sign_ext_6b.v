module sign_ext_6b
#(parameter WIDTH=16)
(
input signed [2*WIDTH-1:0] in,
output signed [2*WIDTH+5:0] out
);

assign out = {{6{in[2*WIDTH-1]}}, in};

endmodule
