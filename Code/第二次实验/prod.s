	.data
Prompt: 	.asciiz "Please enter two numbers:\n"
ResultIs:   	.asciiz "the Result:\n"
Warning: .asciiz "Warning: result overflow!\n"
CR:     .word32 0x10000
DR:       .word32 0x10008

# space note!
 
	.text
main:
	daddi $a0, $R0, Prompt # output Prompt
	jal printf_str

	lwu r21,CR(r0)
	lwu r22,DR(r0)
	daddi r24,r0,8        ;read input
	sd r24,(r21)
	lwu r16,(r22) 	  ;multiplicand in R16
	sd r24,(r21)
	lwu r17,(r22) 	  ;multiplier in R17

	dadd $a0, r16, r0
	dadd $a1, r17, r0
	jal prod
	daddi $a0, $R0, ResultIs
	jal printf_str
	
	
	dadd $a0, $R0, $v0
	jal printf_integer
	
	dsrl $v0, $v0, 16 # right shift 32 bits
	dsrl $v0, $v0, 16
	beqz $v0, end # if high == 0 --> end, else warning
	daddi $a0, r0, Warning
	jal printf_str

end:
	halt

prod: # return c = a * b
	dadd $v0, $zero, $zero # v0-->c a0-->a a1-->b
	daddi $t0, $zero, 32
	
loopprod:
	andi $t1, $a1, 1
	beqz $t1, next # == 1 --> c = c + a
	dadd $v0, $v0, $a0

next:
	dsll $a0, $a0, 1
	dsrl $a1, $a1, 1
	
	daddi $t0, $t0, -1
	bnez $t0, loopprod
	
	jr $ra
	
printf_str: # $a0 <--> str to be output
	ld $t0, CR($R0) # t0 <--> CR
	ld $t1, DR($R0) # t1 <--> DR

	daddi $t2, $R0, 4
	sd $a0, 0($t1) # str output
	sd $t2, 0($t0) # to screen

	jr $ra

printf_integer: # $a0 <--> integer to be output
	ld $t0, CR($R0) # t0 <--> CR
	ld $t1, DR($R0) # t1 <--> DR

	daddi $t2, $R0, 2
	sd $a0, 0($t1) # signed number output
	sd $t2, 0($t0) # to screen

	jr $ra

