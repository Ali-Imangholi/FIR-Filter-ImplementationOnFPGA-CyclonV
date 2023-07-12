`timescale 1ns / 1ps

module testbench;
parameter WIDTH = 16;
parameter LENGTH = 64;
parameter OUT_WIDTH = 38;
parameter DATA_LEN = 221184;
//
reg [WIDTH-1:0] input_from_text_file [0:DATA_LEN-1];
reg [OUT_WIDTH -1:0] expected_data_from_text_file [0:LENGTH-1];
reg [OUT_WIDTH -1:0] myOutput [0:LENGTH-1];
//
reg CLK, RST;
reg [LENGTH-1:0]FIR_INPUT;
reg INPUT_VALID;
wire [OUT_WIDTH -1:0]FIR_OUTPUT;
wire OUTPUT_VALID;
//
integer i,j =0;
reg [OUT_WIDTH -1:0] myOutputFile;


// start compare `myOutput` and `expected_data_from_text_file` after all outputs were wirrten in the `myOutputFile` .
reg startComapre_2_files;

//make instant from top module (serial FIR filter)
serialFIRfilter topModule(
.clk(CLK),
.rst(RST),
.FIR_input(FIR_INPUT),
.input_valid(INPUT_VALID),
.output_valid(OUTPUT_VALID),
.FIR_output(FIR_OUTPUT)
);

// read inputs form file

initial
    begin  
    $readmemb("inputs.txt", input_from_text_file);   
end

// read excepted outputs from file

initial
    begin
    $readmemb("outputs.txt", expected_data_from_text_file);
end    

// make clk

initial
begin
	CLK = 1'b0;
end

always #10 CLK = ~CLK;

// make reset signal

initial
begin 
	RST = 1'b0;   
	#15
	RST = 1'b1;
	#15
	RST = 1'b0;
	#15;
end

// push each input from file into `FIR_INPUT`

initial begin
	startComapre_2_files = 1'b0;
	INPUT_VALID = 1'b0;
	for (i=0 ; i < DATA_LEN ; i=i+1)
	begin
	FIR_INPUT = input_from_text_file[i];
	#100
	INPUT_VALID = 1'b1;
	#20
	INPUT_VALID = 1'b0;
	#5000;
	end
	startComapre_2_files = 1'b1;
end


// write outputs in the `myOutputFile.txt`

initial
begin
	myOutputFile = $fopen("myOutputFile.txt");
end


always@(posedge OUTPUT_VALID) // each time that OUTPUT_VALID becomes 1 we store the resault in the myOutputFile.txt
begin
	$fwrite(myOutputFile,"%b\n", FIR_OUTPUT);
end

// compare the resault of my module with excepted outputs after that all outputs were written in the `myOutputFile.txt`.
always@(posedge startComapre_2_files)
begin
	$fclose(myOutputFile);
	#20
	$readmemb("myOutputFile.txt", myOutput);
	#20
	for(j=0; j < DATA_LEN; j=j+1)
	begin
		if(myOutput[j] != expected_data_from_text_file[j])
			$display("[-] Test failed for input:", j);
		else
			$display("[+] Test Passed for input:", j);
	end
	$display("***  test has finished.  ***");

$stop;

end

endmodule