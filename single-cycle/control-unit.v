//control unit
module controlUnit
	(
		input [3:0] op,
		output reg RegDst, Jump, Branch, MemRead, MemToReg,
		MemWrite, ALUSrc, RegWrite, SignExt,
		output reg [3:0] ALUOp 
	);

	initial begin
		RegDst = 1'b0;
		Jump = 1'b0;
		Branch = 1'b0;
		MemRead = 1'b0;
		MemToReg = 1'b0;
		ALUOp = 4'b0000;
		MemWrite = 1'b0;
		ALUSrc = 1'b0;
		RegWrite = 1'b0;
		SignExt = 1'b0;
	end


	always @(op) begin
		case (op)
			4'b0000: begin // R-Type
				RegDst = 1'b1;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
				SignExt = 1'b0;
			end

			4'b0001: begin // addi
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0001;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				SignExt = 1'b1;
			end


			4'b0010: begin // andi
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0010;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				SignExt = 1'b0;
			end


			4'b0011: begin // ori
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0011;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				SignExt = 1'b0;
			end


			4'b0100: begin // subi
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0100;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				SignExt = 1'b1;
			end


			4'b0111: begin // lhw
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b1;
				ALUOp = 4'b0111;
				MemWrite = 1'b0;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
				SignExt = 1'b1;
			end


			4'b1000: begin // shw
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b1000;
				MemWrite = 1'b1;
				ALUSrc = 1'b1;
				RegWrite = 1'b0;
				SignExt = 1'b1;
			end


			4'b1001: begin // beq
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b1001;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b1;
			end


			4'b1010: begin // bne
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b1010;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b1;
			end


			4'b1011: begin // blt
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b1011;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b1;
			end


			4'b1100: begin // bgt
				RegDst = 1'b0;
				Jump = 1'b0;
				Branch = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b1100;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b1;
			end


			4'b1111: begin // jmp
				RegDst = 1'b0;
				Jump = 1'b1;
				Branch = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				ALUOp = 4'b0000;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
			end
		endcase

	end


endmodule
