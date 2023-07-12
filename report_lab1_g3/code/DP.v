module DP
#(parameter WIDTH=16, parameter LENGTH=64)
(
input clk,
input dp_rst,
input dp_shift_enb,
input dp_count_enb,
input [WIDTH-1:0]dp_in,
input register_enb,
input resetReg,
output  dp_rollBack,
output  [2*WIDTH+5:0]dp_out
);

wire [LENGTH-1:0]out_counter_to_pointer;
wire [WIDTH-1:0]out_RegisterFile_to_in_1_Smult;
wire [WIDTH-1:0]out_CoeffRom_to_in_2_Smult;
wire [2*WIDTH-1:0]out_Smult_to_in_sngExt;
wire [2*WIDTH+5:0]out_Sadder_in_register;
wire [2*WIDTH+5:0]out_register_in_2_Sadder;
wire [2*WIDTH+5:0] out_sngExt_in_1_Sadder;
wire rollBack;

registerFile RF(
.rst(dp_rst),
.shift_enb(dp_shift_enb),
.in(dp_in),
.pointer(out_counter_to_pointer),
.clk(clk),
.out(out_RegisterFile_to_in_1_Smult)
);

coefficients_Rom CoeffRom(
.pointer(out_counter_to_pointer),
.RomOut(out_CoeffRom_to_in_2_Smult)
);

counter cnt(
.clk(clk),
.rst(dp_rst),
.count_enb(dp_count_enb),
.out(out_counter_to_pointer),
.rollBack(rollBack)
);

signed_multiply Smult(
.in_1(out_RegisterFile_to_in_1_Smult),
.in_2(out_CoeffRom_to_in_2_Smult),
.out(out_Smult_to_in_sngExt)
);


signed_adder Sadder(
.in_1(out_sngExt_in_1_Sadder),
.in_2(out_register_in_2_Sadder),
.cin(1'b0),
.out(out_Sadder_in_register)
);


register Reg(
.in(out_Sadder_in_register),
.clk(clk),
.reset(resetReg),
.enb(register_enb),
.out(out_register_in_2_Sadder)
);

sign_ext_6b sngExt(
.in(out_Smult_to_in_sngExt),
.out(out_sngExt_in_1_Sadder)
);

//assign dp_out = out_register_in_2_Sadder;
assign dp_out = out_Sadder_in_register;
assign dp_rollBack = rollBack;

endmodule
