          .data
str1:     .asciiz "Please enter two numbers:\n"
str2:     .asciiz "Result:\n"
str3:     .asciiz "GG:result overflow!\n"
CONTROL:  .word32 0x10000
DATA:     .word32 0x10008

          .text
      lwu r21,CONTROL(r0)
      lwu r22,DATA(r0)
    daddi r24,r0,4        ;set string output
    daddi r1,r0,str1      ;get address of str1
       sd r1,(r22)        ;wirte DATA
       sd r24,(r21)       ;print

    daddi r24,r0,8        ;read input
       sd r24,(r21)
      lwu r16,(r22) 	  ;multiplicand in R16
       sd r24,(r21)
      lwu r17,(r22) 	  ;multiplier in R17

    daddi r3,r0,0 	  ;product in R3
    daddi r20,r0,32       ;counter in R20,initialize to 32
LOOP:
     andi r18,r17,1       ;get the rightmostbit of multiplier
     beqz r18,NEXT        ;if equals zero, jump to next
    daddu r3,r3,r16       ;else add multiplicand
NEXT:
     dsll r16,r16,1       ;left shift
     dsrl r17,r17,1       ;righ shift
    daddi r20,r20,-1      ;Discrement count
     bnez r20,LOOP        ;if match, jump to loop 

    daddi r24,r0,4        ;set string output
    daddi r1,r0,str2      ;get address of str2
       sd r1,(r22)        ;wirte DATA
       sd r24,(r21)       ;print
    daddi r24,r0,1 	  ;set Unsigned Integer output
       sw r3,(r22)
       sd r24,(r21)

     dsrl r13,r3,16
     dsrl r13,r13,16
     beqz r13,NORMAL      ;if not overflow, jump to normal
    daddi r24,r0,4        ;set string output
    daddi r1,r0,str3      ;get address of str3
       sd r1,(r22)        ;wirte DATA
       sd r24,(r21)       ;print
NORMAL:    
     halt
