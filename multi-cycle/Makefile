main.vvp: ALU-control-unit.v alu.v branch_control.v control-unit.v Memory.v fum-mips.v mux.v mux_4x1.v regfile.v sign-extend.v testbench.v instruction.mem
	iverilog -o main.vvp ALU-control-unit.v alu.v branch_control.v control-unit.v Memory.v fum-mips.v mux.v mux_4x1.v regfile.v sign-extend.v testbench.v -Wall
.PHONY clean:
	rm -f main.vvp
