    .data
    .text
    # 计算1-14偶数的乘积

    daddi r1, r0, 1 # 计数器
    daddi r2, r0, 1 # 乘积
    daddi r3, r0, 1 # 奇偶判断器

loop:
    bne r3, r0, else# 如果等于0，就更新判断器为1，否则更新为0
    daddi r3, r0, 1
    dmul r2, r2, r1
    j next
else:
    daddi r3, r0, 0
next:
    daddi r1, r1, 1
    slti r4, r1, 15 # r4用于判断是否是循环结束
    bne r4, r0, loop
    halt
