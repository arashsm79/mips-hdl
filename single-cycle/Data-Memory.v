//memory unit
module DMemBank(input clk, input memread, input memwrite, input [15:0] address, input [15:0] writedata, output [15:0] readdata);

	reg [15:0] mem_array [255:0];

	initial begin: datamem_initializer

		integer i;
		for(i = 0; i < 256; i = i+1) begin
			mem_array[i] = 16'd0;
		end
	end

	always@(posedge clk)
	begin
		if(memwrite)begin
			mem_array[address[15:1]]= writedata;
		end
	end
	assign readdata = (memread) ? (mem_array[address[15:1]]) : 16'd0;

endmodule

/*
module testbench;
	reg memread, memwrite;              // rw=RegWrite 
	reg [15:0] adr;  // adr=address 
	wire [15:0] rd; // rd=readdata 
	reg [15:0] wd;
	reg clk = 1'b0;

	DMemBank u0(clk, memread, memwrite, adr, wd, rd);

	initial begin
		$monitor("read %b got %b", adr, rd);
		clk = 1'b0;

		#5
		memwrite = 1'b1;
		memread=1'b0;
		adr=16'd2;
		wd = 16'd32;
		clk = 1'b1; #2 clk=1'b0;

		#5
		memread=1'b1;
		adr=16'd2;

		clk = 1'b1; #2 clk=1'b0;
	end

endmodule
*/
