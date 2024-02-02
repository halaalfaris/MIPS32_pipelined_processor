`timescale 1 ns/1 ns
`include "mip32_b.v"

module mips32_tb ();

reg clk, reset;

mip32_b mip (clk, reset);



initial begin 
	$dumpfile("BenchmarkII.vcd");      // create a VCD waveform dump called "wave.vcd"
    $dumpvars(0, mip);
   
	reset = 1'b1;
	clk = 1'b0;
	#5; 
	clk = 1'b1;
	#2;
	reset = 1'b0;
	#3;
	
	forever begin 
	clk = #5 ~clk;
	end

	#1000;
    $finish;

	end


endmodule
