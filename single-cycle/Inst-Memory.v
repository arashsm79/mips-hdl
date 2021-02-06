//memory unit
module IMemBank(input memread, input [15:0] address, output reg [15:0] readdata);

	reg [15:0] mem_array [0:255];

	initial begin
		$readmemb("instruction.mem", mem_array);
	end

	always@(memread, address, mem_array[address[15:1]])begin
		if(memread)begin
			readdata=mem_array[address[15:1]];
		end
	end

endmodule

/*
module testbench;
	reg memread;              // rw=RegWrite 
	reg [15:0] adr;  // adr=address 
	wire [15:0] rd; // rd=readdata 

	IMemBank u0(memread, adr, rd);

	initial begin
		$monitor("%b", rd);
		memread=1'b0;
		adr=16'd0;

		#5
		memread=1'b1;
		adr=16'd0;
	end

	initial repeat(127)#4 adr=adr+1;

endmodule
*/
