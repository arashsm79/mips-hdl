// sign extension module
module signExtend
	(
		input SignExt,
		input [5:0] data,
		output [15:0] out
	);

	assign out = (SignExt) ? {{10{data[5]}}, data[5:0]} : {{10{1'b0}}, data[5:0]};
endmodule

	
