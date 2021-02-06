module FUMMips (input clk);

	reg [15:0] pc;
	reg [15:0] instruction_register;
	reg [15:0] memory_data_register;

	reg [15:0] A_register;

	reg [15:0] B_register;

	reg [15:0] ALUOut_register;
	wire [15:0] next_pc;

	wire RegDst, MemRead, MemToReg, MemWrite, ALUSrcA, RegWrite, SignExt, PCWriteCond, PCWrite, IorD, IRWrite;
	wire [1:0] ALUSrcB;
	wire [1:0] PCSource;
	wire [3:0] ALUOp;

	wire [15:0] memory_read_data;
	wire [15:0] IorD_mux_out;
	wire [2:0] RegDst_mux_out;
	wire [15:0] MemToReg_mux_out;
	wire [15:0] rf_readdata1, rf_readdata2;
	wire [15:0] sign_extension_out;
	wire [3:0] ALUOperation;

	wire [15:0] ALUSrcA_mux_out;
	wire [15:0] ALUSrcB_mux_out;

	wire [15:0] PCSource_mux_out;

	wire zero, less_than, greater_than, bcond;
	wire [15:0] ALU_result;



	// PC logic
	initial pc <= 16'b0;
	
	always @(posedge clk) begin
		instruction_register <= IRWrite ? memory_read_data : instruction_register;

		memory_data_register <= memory_read_data;

		A_register <= rf_readdata1;
		B_register <= rf_readdata2;

		ALUOut_register = ALU_result;

		if(PCWrite || (PCWriteCond && bcond))
			pc <= PCSource_mux_out;
	end

	controlUnit control_unit(clk, instruction_register[15:12], RegDst, MemRead, MemToReg, MemWrite, ALUSrcA, RegWrite, SignExt, PCWriteCond, PCWrite, IorD, IRWrite, ALUSrcB, PCSource, ALUOp);

	mux #(16) IorD_mux(IorD, pc, ALUOut_register, IorD_mux_out);

	Memory memory(.clk(clk), .memread(MemRead), .memwrite(MemWrite), .address(IorD_mux_out), .writedata(B_register), .readdata(memory_read_data));	

	mux #(3) RegDst_mux(RegDst, instruction_register[8:6], instruction_register[5:3], RegDst_mux_out);

	mux #(16) MemToReg_mux(MemToReg, ALUOut_register, memory_data_register, MemToReg_mux_out);

	RegFile register_file(clk, instruction_register[11:9], instruction_register[8:6], RegDst_mux_out, MemToReg_mux_out, RegWrite, rf_readdata1, rf_readdata2);

	signExtend sign_extension(SignExt, instruction_register[5:0], sign_extension_out);

	ALUControlUnit ALU_control_unit(ALUOp, instruction_register[2:0], ALUOperation);

	mux #(16) ALUSrcA_mux(ALUSrcA, pc, A_register, ALUSrcA_mux_out);

	mux_4x1 #(16) ALUsrcB_mux(ALUSrcB, B_register, 16'd2, sign_extension_out, sign_extension_out << 1, ALUSrcB_mux_out);

	ALU alu(ALUSrcA_mux_out, ALUSrcB_mux_out, ALUOperation, ALU_result, zero, less_than, greater_than);

	mux_4x1 #(16) PCSource_mux(PCSource, ALU_result, ALUOut_register, {pc[15:13], instruction_register[11:0], {1'b0}}, 16'bx, PCSource_mux_out);

	branchControlUnit branch_control_unit(instruction_register[15:12], zero, less_than, greater_than, bcond);

endmodule
