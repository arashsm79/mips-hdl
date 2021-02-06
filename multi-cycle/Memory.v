//memory unit
module Memory(input clk, input memread, input memwrite, input [15:0] address, input [15:0] writedata, output [15:0] readdata);

	reg [15:0] mem_array [0:255];

	initial begin
		$readmemb("instruction.mem", mem_array);
	end

	always@(posedge clk)
	begin
		if(memwrite)begin
			mem_array[address[15:1]]= writedata;
		end
	end

	assign readdata = (memread) ? (mem_array[address[15:1]]) : 16'd0;

endmodule

