module mux_4x1
	#(
		parameter LENGTH = 16
	)
	(
		input[1:0] select,
		input [LENGTH-1:0] in0, in1, in2, in3,
		output [LENGTH-1:0] out
	);

	assign out = select[1] ? (select[0] ? in3 : in2) : (select[0] ? in1 : in0);
endmodule
