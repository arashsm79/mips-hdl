addi $1, $0, 10
andi $2, $1, 13 # 1010 & 1101 = 1000 = 8
ori $2, $2, 12 # 1000 | 1100 = 1100 = 12
subi $2, $2, 10 # 12 - 10 = 2

# $1 has 10 = 01010 and $2 has 2 = 00010
add $3, $1, $2 # $3 = 12
sub $3, $2, $1 # $3 = -8
and $3, $1, $2 # $3 = 2
or $3, $1, $2  # $3 = 10
xor $3, $1, $2 # $3 = 8
nor $3, $1, $2 # $3 = -11 = 10101
slt $3, $1, $2 # $3 = 0
slt $3, $2, $1 # $3 = 1

shw $1, 2($0) # Mem [2] = 10
lhw $2, 2($0) # $2 = Mem [2] = 10

# branch not taken
# $1 = 10
# $2 = 10
# $3 = 1
beq $3, $2, label # $3 != $2
bne $1, $2, label # $1 == $2
blt $2, $3, label # $2 > $3
bgt $3, $2, label # $3 < $2

addi $7, $7, 7 # this should happen, if all of the above are not taken

jmp label

addi $6, $6, 6 # this shouldn't happen, if the jump works


# branch taken
# $1 = 10
# $2 = 10
# $3 = 1
label:	beq $1, $2, bneL # $1 == $2
	addi $5, $5, 5 # this shouldn't happen, if the branch works

bneL:	bne $3, $2, bltL # $3 != $2
	addi $5, $5, 5 # this shouldn't happen, if the branch works

bltL:	blt $3, $2, bgtL # $3 < $2
	addi $5, $5, 5 # this shouldn't happen, if the branch works

bgtL:	bgt $2, $3, exit # $2 > $3
	addi $5, $5, 5 # this shouldn't happen, if the branch works

exit: 


# Machine code:

0001 000 001 001010
0010 001 010 001101
0011 010 010 001100
0100 010 010 001010

0000 001 010 011 000
0000 010 001 011 001
0000 001 010 011 010
0000 001 010 011 011
0000 001 010 011 100
0000 001 010 011 101
0000 001 010 011 110
0000 010 001 011 110

1000 000 001 000010
0111 000 010 000010

1001 011 010 000110
1010 001 010 000101
1011 010 110 000100
1100 011 010 000011

0001 111 111 000111

1111 000000010101

0001 110 110 000110

1001 001 010 000001
0001 101 101 000101

1010 011 010 000001
0001 101 101 000101

1011 011 010 000001
0001 101 101 000101

1100 010 011 000001
0001 101 101 000101




