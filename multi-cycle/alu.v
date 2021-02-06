module ALU(input [15:0] data1,data2,input [3:0] aluoperation,output reg [15:0] result,output reg zero,lt,gt);

	always@(aluoperation,data1,data2)
	begin
		case (aluoperation)
			4'b0000 : result = data1 + data2; // ADD
			4'b0001 : result = data1 - data2; // SUB
			4'b0010 : result = data1 & data2; // AND
			4'b0011 : result = data1 | data2; // OR
			4'b0100 : result = data1 ^ data2; // XOR
			4'b0101 : result = data1 ~| data2; // NOR
			4'b0110 : result = (data1 < data2) ? 16'd1 : 16'd0; // SLT
			default : result = data1 + data2; // ADD
		endcase

		if(data1>data2)
		begin
			gt = 1'b1;
			lt = 1'b0;
		end else if(data1<data2)
		begin
			gt = 1'b0;
			lt = 1'b1;
		end else 
		begin
			gt = 1'b0;
			lt = 1'b0;
		end

		if (result==16'd0) zero=1'b1;
		else zero=1'b0;

	end


endmodule

/*
module testbench;

	reg [15:0] d1,d2;  // d1=data1, d2=data2 
	reg [3:0] aluop;   // aluop=aluoperation 

	wire [15:0] r; // r=result 
	wire gt,lt,z; // z=zero 

	ALU u0(d1, d2, aluop, r, z, lt, gt);

	initial begin
		$monitor("%d, %b, %b, %b", r, z, lt, gt);

		#5
		d1=16'd1;
		d2=16'd2;
		aluop=4'b0000;

		#20
		d1=16'd8;
		d2=16'd8;
		aluop=4'b0001;
		#20
		d1=16'd9;
		d2=16'd7;
		aluop=4'b1000;
	end


endmodule
*/

