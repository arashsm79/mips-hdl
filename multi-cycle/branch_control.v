module branchControlUnit
	(
		input [3:0] op,
		input z, lt, gt,
		output reg bcond
	);

	always@(*) begin
		case(op)
			4'b1001: bcond = z; //beq
			4'b1010: bcond = ~z; //bne
			4'b1011: bcond = lt; //blt
			4'b1100: bcond = gt; //bgt
			default: bcond = 1'b0;
		endcase
	end
endmodule
