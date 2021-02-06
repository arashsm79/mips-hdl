//control unit
module controlUnit
	(
		input clk,
		input [3:0] op,
		output reg RegDst, MemRead, MemToReg,
		MemWrite, ALUSrcA, RegWrite, SignExt, PCWriteCond,
		PCWrite, IorD, IRWrite,
		output reg [1:0] ALUSrcB,
		output reg [1:0] PCSource,
		output reg [3:0] ALUOp 
	);


	localparam 
		STATE_INIT = 4'b1111,
		STATE_IF = 4'b0000,
		STATE_ID = 4'b0001,
		STATE_LOAD_STORE_MEM_ADDRESS_COMPUTATION = 4'b0010,
		STATE_R_TYPE_EXEC = 4'b0011,
		STATE_I_TYPE_EXEC = 4'b0100,
		STATE_BRANCH_COMPLETION = 4'b0101,
		STATE_JUMP_COMPLETION = 4'b0110,
		STATE_LOAD_MEM_ACCESS = 4'b0111,
		STATE_STORE_MEM_ACCESS = 4'b1000,
		STATE_R_TYPE_COMPLETION = 4'b1001,
		STATE_I_TYPE_COMPLETION = 4'b1010,
		STATE_LOAD_MEM_READ_COMPLETION = 4'b1011,
		STATE_TEMP2 = 4'b1100,
		STATE_TEMP3 = 4'b1101,
		STATE_TEMP4 = 4'b1110;


	reg[3:0] currState;
	reg[3:0] nextState;

	initial currState = STATE_INIT;

	always @(posedge clk) begin
		currState = nextState;
	end

	always @(*) begin
		nextState = currState;
		case (currState)

			STATE_INIT: begin
				nextState = STATE_IF;
			end

			STATE_IF: begin
				nextState = STATE_ID;
			end

			STATE_ID: begin
				case (op)
					// R-Type
					4'b0000: begin
						nextState = STATE_R_TYPE_EXEC;
					end

					// I-Type 
					4'b0001, 4'b0010, 4'b0011, 4'b0100: begin
						nextState = STATE_I_TYPE_EXEC;
					end

					// Load Store
					4'b0111, 4'b1000: begin
						nextState = STATE_LOAD_STORE_MEM_ADDRESS_COMPUTATION;
					end

					// Branch
					4'b1001, 4'b1010, 4'b1011, 4'b1100: begin
						nextState = STATE_BRANCH_COMPLETION;
					end

					// Jump
					4'b1111: begin
						nextState = STATE_JUMP_COMPLETION;
					end
				endcase
			end

			STATE_LOAD_STORE_MEM_ADDRESS_COMPUTATION: begin
				case(op)
					4'b0111: begin
						nextState = STATE_LOAD_MEM_ACCESS;
					end
					4'b1000: begin
						nextState = STATE_STORE_MEM_ACCESS;
					end
				endcase
			end

			STATE_R_TYPE_EXEC: begin
				nextState = STATE_R_TYPE_COMPLETION;
			end

			STATE_I_TYPE_EXEC: begin
				nextState = STATE_I_TYPE_COMPLETION;
			end

			STATE_BRANCH_COMPLETION: begin
				nextState = STATE_IF;
			end

			STATE_JUMP_COMPLETION: begin
				nextState = STATE_IF;
			end

			STATE_LOAD_MEM_ACCESS: begin
				nextState = STATE_LOAD_MEM_READ_COMPLETION;
			end

			STATE_STORE_MEM_ACCESS: begin
				nextState = STATE_IF;
			end

			STATE_R_TYPE_COMPLETION: begin
				nextState = STATE_IF;
			end

			STATE_I_TYPE_COMPLETION: begin
				nextState = STATE_IF;
			end

			STATE_LOAD_MEM_READ_COMPLETION: begin
				nextState = STATE_IF;
			end
		endcase
	end

	initial begin
			RegDst = 1'b0;
			MemRead = 1'b0;
			MemToReg = 1'b0;
			MemWrite = 1'b0;
			ALUSrcA = 1'b0;
			RegWrite = 1'b0;
			SignExt = 1'b0;
			PCWriteCond = 1'b0;
			PCWrite= 1'b0;
			IorD = 1'b0;
			IRWrite = 1'b0;
			PCSource = 2'b00;
			ALUSrcB = 2'b00;
			ALUOp = 4'b0000;
	end


	always @(*) begin
		case (currState)

			STATE_INIT: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end

			STATE_IF: begin
				RegDst = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b1;
				IorD = 1'b0;
				IRWrite = 1'b1;
				PCSource = 2'b00;
				ALUSrcB = 2'b01;
				ALUOp = 4'b0001;
			end

			STATE_ID: begin
				RegDst = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b1;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b11;
				ALUOp = 4'b0001;
			end

			STATE_LOAD_STORE_MEM_ADDRESS_COMPUTATION: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b10;
				ALUOp = op;
			end

			STATE_R_TYPE_EXEC: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = op;
			end
			STATE_I_TYPE_EXEC: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b10;
				ALUOp = op;
			end
			STATE_BRANCH_COMPLETION: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b1;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b1;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b01;
				ALUSrcB = 2'b00;
				ALUOp = op;
			end
			STATE_JUMP_COMPLETION: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b1;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b10;
				ALUSrcB = 2'b00;
				ALUOp = op;
			end
			STATE_LOAD_MEM_ACCESS: begin
				RegDst = 1'b0;
				MemRead = 1'b1;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b1;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end
			STATE_STORE_MEM_ACCESS: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b1;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b1;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end
			STATE_R_TYPE_COMPLETION: begin
				RegDst = 1'b1;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b1;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end
			STATE_I_TYPE_COMPLETION: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b1;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end
			STATE_LOAD_MEM_READ_COMPLETION: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b1;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b1;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end
			STATE_TEMP2: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end
			STATE_TEMP3: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end
			STATE_TEMP4: begin
				RegDst = 1'b0;
				MemRead = 1'b0;
				MemToReg = 1'b0;
				MemWrite = 1'b0;
				ALUSrcA = 1'b0;
				RegWrite = 1'b0;
				SignExt = 1'b0;
				PCWriteCond = 1'b0;
				PCWrite= 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCSource = 2'b00;
				ALUSrcB = 2'b00;
				ALUOp = 4'b0000;
			end

		endcase

	end


endmodule
