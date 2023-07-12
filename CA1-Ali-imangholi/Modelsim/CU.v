module CU
(
input clk,
input cu_rst,
input rollBack,
input Input_Valid,
output reg dp_rst,
output reg shift_enb,
output reg count_enb,
output reg register_enb,
output reg resetReg,
output reg Output_Valid
);

reg [2:0] nextState, presentState;

parameter [2:0] resetSTATE = 3'b000,
				start = 3'b001,
				acceptInput = 3'b010,
				calculation = 3'b011,
				endProcess = 3'b100;
				
always@(posedge clk, posedge cu_rst)
begin: presentState_nextState
	if(cu_rst == 1'b1)
		presentState <= resetSTATE;
	else
		presentState <= nextState;
end
		
always@(presentState, posedge rollBack, Input_Valid)
begin: choose_nextState
	//nextState <= start;// we must initialize out in order to synthesize tool don't make a latch.
	case(presentState)
	resetSTATE: nextState = start;
	start: if(Input_Valid == 1'b1) nextState = acceptInput; else nextState = start;
	acceptInput: if(Input_Valid == 1'b0) nextState = calculation; else nextState = acceptInput;
	calculation: if(rollBack == 1'b1) nextState = endProcess; else nextState = calculation;
	endProcess: nextState = start;
	endcase
end

always@(presentState)
begin
	{dp_rst, shift_enb, count_enb, Output_Valid, register_enb, resetReg} = 6'b0;// we must initialize out in order to synthesize tool don't make a latch.
	case(presentState)
	resetSTATE: {dp_rst, resetReg} = 2'b11;
	start: resetReg = 1'b1;
	acceptInput: shift_enb = 1'b1;
	calculation: {count_enb, register_enb} = 2'b11;
	endProcess: Output_Valid = 1'b1;
	endcase
end

endmodule