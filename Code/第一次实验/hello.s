	.data
str: .asciiz "Hello World!"
CR: .word32 0x10000
DA: .word32 0x10008

	.code
main:
	lwu r3, CR(r0)
	lwu r4, DA(r0)
	daddi r5, $zero, str #将字符串首地址导入寄存器
	daddi r6, r0, 4

	sd r5, 0(r4) # write str to DATA
	sd r6, 0(r3) # write 4 to CTRL

	halt

