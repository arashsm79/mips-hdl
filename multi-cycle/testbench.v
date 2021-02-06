module testbench;
	reg clk;

	initial begin
		clk = 0;
		repeat (200) 
			#20 clk = ~clk;
		$finish;
	end

	FUMMips fum_mips(.clk(clk));

	initial begin

		$dumpfile("wave.vcd");
		$dumpvars(0, fum_mips);
	end

endmodule
