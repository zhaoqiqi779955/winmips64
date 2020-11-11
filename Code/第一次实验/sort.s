	.data
CONTROL: .word32 0x10000
DATA:    .word32 0x10008
array: .word32 8,6,3,7,1,0,9,4,5,2
str1: .asciiz "before sort, the array is\n"
str2: .asciiz "after sort, the array is\n"

	.code

main:
	daddi $a0, $zero, str1
	jal showstr
	jal showdigit # output before sort

	daddi $a0, $zero, array
	daddi $a1, $zero, 10
	jal sort # sorting
asdfasdfsdfsdf:
	daddi $a0, $zero, str2
	jal showstr
	jal showdigit # output after sort
	
	halt


swap:
	dsll $t1, $a1, 2
	dadd $t1, $a0, $t1

	lw $t0, 0($t1)
	lw $t2, 4($t1)

	sw $t2, 0($t1)
	sw $t0, 4($t1)

	jr $ra


sort:
	daddi $sp, $sp, -40
	sd $ra, 32($sp)
	sd $s3, 24($sp)
	sd $s2, 16($sp)
	sd $s1, 8($sp)
	sd $s0, 0($sp)

	dadd $fp, $zero, $ra
	ld $gp, 32($sp) # 发现ra里面的数据总是被莫名其妙赋为0，没想到这里32($sp)的数据本来就是0，感到奇怪，为了暂时解决这个问题，在89行直接跳转回去
			# 经过反复尝试，是$sp初始值没有被设对，一开始为0000，失败；中间为7ffffffffffffffc，还是失败；最后改成03f8成功

	dadd $s2, $zero, $a0
	dadd $s3, $zero, $a1
	
	dadd $s0, $zero, $zero
for1tst:
	slt $t0, $s0, $s3
	beq $t0, $zero, exit1

	daddi $s1, $s0, -1
for2tst:
	slti $t0, $s1, 0
	bne $t0, $zero, exit2
	dsll $t1, $s1, 2
	dadd $t2, $s2, $t1 
	lw $t3, 0($t2)
	lw $t4, 4($t2)
	slt $t0, $t4, $t3
	beq $t0, $zero, exit2

	dadd $a0, $s2, $zero
	dadd $a1, $s1, $zero
	jal swap

	daddi $s1, $s1, -1
	j for2tst

exit2:
	daddi $s0, $s0, 1
	j for1tst

exit1:
	ld $s0, 0($sp)	
	ld $s1, 8($sp)
	ld $s2, 16($sp)
	ld $s3, 24($sp)
	ld $ra, 32($sp)
	daddi $sp, $sp, 40
	
	# j asdfasdfsdfsdf 
	jr $ra
	
showdigit: # no arguments
	daddi $a0, $zero, array # a0 = &array[0]
	daddi $t0, $zero, 0 # t0 = 0

loopshow:
	lw $t2, CONTROL($zero)
	lw $t3, DATA($zero) # t2-->CR, t3-->DA

	daddi $t4, $zero, 2
	lw $t5, 0($a0) # t4 = 2 <--> CR; t5 = *a0 <--> DA

	sd $t5, 0($t3)
	sd $t4, 0($t2)

	daddi $a0, $a0, 4 # update address of array
	daddi $t0, $t0, 1 # ++t0
	
	slti $t1, $t0, 10
	bne $t1, $zero, loopshow # while(t0 < 10)

	jr $ra

showstr: # a0 is str
	lw $t0, CONTROL($zero)
	lw $t1, DATA($zero) # t0 <--> CONTROL, t1 <--> DATA

	daddi $t3, $zero, 4 # t3 = 4

	sd $a0, 0($t1) # set DATA to str 
	sd $t3, 0($t0) # set CR = 4

	jr $ra
