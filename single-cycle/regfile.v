module RegFile (clk, readreg1, readreg2, writereg, writedata, RegWrite, readdata1, readdata2);
	input [2:0] readreg1, readreg2, writereg;
	input [15:0] writedata;
	input clk, RegWrite;
	output [15:0] readdata1, readdata2;

	reg [15:0] regfile [7:0];

	initial begin: regfile_initializer

		integer i;
		for(i = 0; i < 8; i = i+1) begin
			regfile[i] = 16'd0;
		end
	end
	generate
		genvar idx;
		for(idx = 0; idx < 8; idx = idx+1) begin: register
			wire [15:0] GPRegister;
			assign GPRegister = regfile[idx];
		end
	endgenerate

	always @(posedge clk)
	begin
		regfile[0]=0;
		if (RegWrite)
			regfile[writereg] <= writedata;
	end
	assign readdata1 = regfile[readreg1];
	assign readdata2 = regfile[readreg2];
endmodule

/*
module testbench;
reg clk,rw;              // rw=RegWrite 
reg [2:0] rr1, rr2, wr;   // rr1=readreg1, rr2=readreg2, wr=writereg 
reg [15:0] wd;  // wd=writedata 
wire [15:0] rd1, rd2; // rd1=readdata1, rd2=readdata2 

RegFile u0(clk, rr1, rr2, wr, wd, rw, rd1, rd2);

initial begin
$monitor("read %b and %b  resulted in: %b and %b", rr1, rr2, rd1, rd2); 
clk=1'b0;

#5
wr=3'd1;
rr1=3'd0;
rr2=3'd0;
wd=16'd10;
rw = 1'b1;
clk = 1'b1; #2 clk=1'b0;

#5
rw = 1'b0;
rr1=3'd1;
rr2=3'd0;
clk = 1'b1; #2 clk=1'b0;
	end

endmodule

*/
