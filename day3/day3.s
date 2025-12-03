.global _main
.align 4
.bss
b: .skip 65536
.text
_main:
    mov x0,#0
    adrp x1,b@PAGE
    add x1,x1,b@PAGEOFF
    mov x2,#65536
    mov x16,#3
    svc #0x80
    mov x10,x0
    adrp x11,b@PAGE
    add x11,x11,b@PAGEOFF
    mov x20,#0
p:
    adrp x0,b@PAGE
    add x0,x0,b@PAGEOFF
    add x0,x0,x10
    cmp x11,x0
    b.ge d
    mov x21,x11
q:
    adrp x0,b@PAGE
    add x0,x0,b@PAGEOFF
    add x0,x0,x10
    cmp x21,x0
    b.ge e
    ldrb w0,[x21]
    cmp w0,#10
    b.eq e
    add x21,x21,#1
    b q
e:
    mov x12,#0
    mov x13,x11
i:
    cmp x13,x21
    b.ge u
    add x14,x13,#1
j:
    cmp x14,x21
    b.ge n
    ldrb w0,[x13]
    sub x0,x0,#'0'
    mov x1,#10
    mul x0,x0,x1
    ldrb w1,[x14]
    sub x1,x1,#'0'
    add x0,x0,x1
    cmp x0,x12
    b.le k
    mov x12,x0
k:
    add x14,x14,#1
    b j
n:
    add x13,x13,#1
    b i
u:
    add x20,x20,x12
    add x11,x21,#1
    b p
d:
    mov x0,x20
    sub sp,sp,#48
    mov x1,sp
    add x1,x1,#40
    mov x2,#0
    mov x3,#10
    cmp x0,#0
    b.ne c
    mov w4,#'0'
    strb w4,[x1]
    mov x2,#1
    b f
c:
    cmp x0,#0
    b.eq f
    udiv x4,x0,x3
    msub x5,x4,x3,x0
    add w5,w5,#'0'
    strb w5,[x1]
    sub x1,x1,#1
    add x2,x2,#1
    mov x0,x4
    b c
f:
    add x1,x1,#1
    mov x0,#1
    mov x16,#4
    svc #0x80
    mov x0,#1
    adr x1,nl
    mov x2,#1
    mov x16,#4
    svc #0x80
    mov x0,#0
    mov x16,#1
    svc #0x80
nl: .ascii "\n"