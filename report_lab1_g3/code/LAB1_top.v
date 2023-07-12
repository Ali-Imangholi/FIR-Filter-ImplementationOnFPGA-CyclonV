module LAB1_top(CLOCK_50, KEY, SW, UART_RXD, UART_TXD, LEDR);

input CLOCK_50;
input [0:0] KEY;		//reset key
input [3:0] SW;
output [15:0] LEDR;

input UART_RXD;
output UART_TXD;

parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 4;
parameter WIDTH=16;
parameter OUT_WIDTH=38;


wire [OUT_WIDTH-1:0]FIR_OUTPUT;
wire [WIDTH-1:0]FIR_INPUT;
wire INPUT_VALID;
wire OUTPUT_VALID;

wire DATA_READY; 
wire BUSY;
wire [7:0] OUTPUT_RECIVER;
wire [7:0] INPUT_TRANSMITTER;
wire TXD_START;

LAB1_top_Controller LAB1_TOP_CONTROLLER(
.clk(CLOCK_50),
.LAB1_top_Controller_rst(KEY),
.data_ready(DATA_READY),
.Output_Valid_FIR(OUTPUT_VALID),
.busy(BUSY),
.RXD(OUTPUT_RECIVER), //output Reciver
.FIR_Output(FIR_OUTPUT),
.TXD_start(TXD_START),
.FIR_Input(FIR_INPUT),
.Input_Valid_FIR(INPUT_VALID),
.TXD(INPUT_TRANSMITTER) //input transmitter
);



serialFIRfilter SERIAL_FIR_FILTER(
.clk(CLOCK_50),
.rst(KEY),
.FIR_input(FIR_INPUT),
.input_valid(INPUT_VALID),
.output_valid(OUTPUT_VALID),
.FIR_output(FIR_OUTPUT)
);

async_transmitter ASYNC_TRANSMITTER(
.clk(CLOCK_50),
.TxD_start(TXD_START),
.TxD_data(INPUT_TRANSMITTER),
.TxD(UART_TXD),
.TxD_busy(BUSY)
);

async_receiver ASYNC_RECEIVER(
.clk(CLOCK_50),
.RxD(UART_RXD),
.RxD_data_ready(DATA_READY),
.RxD_data(OUTPUT_RECIVER)
);


endmodule
