main.vvp: ALU-control-unit.v alu.v branch_control.v control-unit.v Data-Memory.v fum-mips.v Inst-Memory.v mux.v regfile.v sign-extend.v testbench.v instruction.mem
	iverilog -o main.vvp ALU-control-unit.v alu.v branch_control.v control-unit.v Data-Memory.v fum-mips.v Inst-Memory.v mux.v regfile.v sign-extend.v testbench.v -Wall

.PHONY clean:
	rm -f main.vvp wave.vcd

