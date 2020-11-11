#          .data # false code
#str1:     .asciiz "plz enter two numbers:\n"
#str2:     .asciiz "warning: result overflow\n"
#str3:     .asciiz "the result:\n"
#CONTROL:  .word32 0x10000
#DATA:     .word32 0x10008
#          .data # right code
#str1:     .asciiz "plz enter two numbers:\n" # when I change 'please' to 'plz', something wrong happends! why?
#str2:     .asciiz "the Result:\n"
#str3:     .asciiz "Waring:result overflow!\n"
#CONTROL:  .word32 0x10000
#DATA:     .word32 0x10008


# output: "lt:"
          .data # right code
	  # .align 8 # after adding this line, the output was still "lt:"
CONTROL:  .word32 0x10000
DATA:     .word32 0x10008
str1:     .asciiz "plz enter two numbers:\n" # when I change 'please' to 'plz', something wrong happends! why?
str2:     .asciiz "the Result:\n"
str3:     .asciiz "Waring:result overflow!\n"

	.text
main:
	lwu r21,CONTROL(r0)
      lwu r22,DATA(r0)
    daddi r24,r0,4        ;set string output
    daddi r1,r0,str2      ;get address of str1
       sd r1,(r22)        ;wirte DATA
       sd r24,(r21)       ;print

	halt
