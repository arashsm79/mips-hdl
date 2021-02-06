//ALU control unit
module ALUControlUnit
	(
		input[3:0] ALUOp,
		input [2:0] funct,
		output reg [3:0] ALUOperation
	);


	always @(*) begin
		case (ALUOp)
			4'b0000: begin //R-Type
				case (funct)
					3'b000: ALUOperation = 4'b0000;
					3'b001: ALUOperation = 4'b0001;
					3'b010: ALUOperation = 4'b0010;
					3'b011: ALUOperation = 4'b0011;
					3'b100: ALUOperation = 4'b0100;
					3'b101: ALUOperation = 4'b0101;
					3'b110: ALUOperation = 4'b0110;
				endcase
			end
			4'b0001: begin
				ALUOperation = 4'b0000; //addi
			end
			4'b0010: begin
				ALUOperation = 4'b0010; //andi
			end
			4'b0011: begin
				ALUOperation = 4'b0011; //ori
			end
			4'b0100: begin
				ALUOperation = 4'b0001; //subi
			end
			4'b0111: begin
				ALUOperation = 4'b0000; //lw
			end
			4'b1000: begin
				ALUOperation = 4'b0000; //sw
			end
			4'b1001: begin
				ALUOperation = 4'b0001; //beq
			end
			4'b1010: begin
				ALUOperation = 4'b0001; //bne
			end
			4'b1011: begin
				ALUOperation = 4'b0001; //blt
			end
			4'b1100: begin
				ALUOperation = 4'b0001; //bgt
			end
			default: ALUOperation = 4'b0000; 

		endcase
	end
endmodule
