module FUMMips (input clk);

	reg [15:0] pc;
	wire [15:0] next_pc;

	wire inst_memread;
	wire [15:0] instruction;
	wire RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, SignExt;
	wire [3:0] ALUOp;
	wire [2:0] reg_dest_mux_to_wirte_register;
	wire [15:0] mem_to_reg_mux_to_write_data, rf_readdata1, rf_readdata2;
	wire [15:0] sign_extension_out;
	wire [3:0] ALUOperation;
	wire [15:0] ALU_source_mux_to_ALU;
	wire zero, less_than, greater_than, bcond;
	wire [15:0] ALU_result;
	wire [15:0] memory_read_data;
	wire [15:0] pc_plus_2, pc_branch, pc_jump, branch_mux_to_jump_mux;

	// PC logic
	initial pc <= 16'b0;
	
	always @(posedge clk) pc <= next_pc;
	
	assign pc_plus_2 = pc + 2;
	assign pc_branch = pc_plus_2 + (sign_extension_out << 1);
	assign pc_jump = {pc[15:13], instruction[11:0], {1'b0}};

	assign inst_memread = 1'b1;


	IMemBank instruction_memory(.memread(inst_memread), .address(pc), .readdata(instruction));	

	controlUnit control_unit(instruction[15:12], RegDst, Jump, Branch, MemRead, MemToReg, MemWrite, ALUSrc, RegWrite, SignExt, ALUOp);

	mux #(3) reg_dest_mux(RegDst, instruction[8:6], instruction[5:3], reg_dest_mux_to_wirte_register);

	RegFile register_file(clk, instruction[11:9], instruction[8:6], reg_dest_mux_to_wirte_register, mem_to_reg_mux_to_write_data, RegWrite, rf_readdata1, rf_readdata2);

	signExtend sign_extension(SignExt, instruction[5:0], sign_extension_out);

	ALUControlUnit ALU_control_unit(ALUOp, instruction[2:0], ALUOperation);

	mux #(16) ALU_source_mux(ALUSrc, rf_readdata2, sign_extension_out, ALU_source_mux_to_ALU);

	ALU alu(rf_readdata1, ALU_source_mux_to_ALU, ALUOperation, ALU_result, zero, less_than, greater_than);

	branchControlUnit branch_control_unit(instruction[15:12], zero, less_than, greater_than, bcond);

	DMemBank data_memory(clk, MemRead, MemWrite, ALU_result, rf_readdata2, memory_read_data);

	mux #(16) data_memory_read_data_mux(MemToReg, ALU_result, memory_read_data, mem_to_reg_mux_to_write_data);
	
	mux #(16) branch_mux((Branch & bcond), pc_plus_2, pc_branch, branch_mux_to_jump_mux);

	mux #(16) jump_mux(Jump, branch_mux_to_jump_mux, pc_jump, next_pc);

endmodule
