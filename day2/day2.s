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
    mov x20,x0
    adrp x21,b@PAGE
    add x21,x21,b@PAGEOFF
    mov x22,#0
p:
    adrp x0,b@PAGE
    add x0,x0,b@PAGEOFF
    add x0,x0,x20
    cmp x21,x0
    b.ge d
    ldrb w0,[x21]
    cmp w0,#'-'
    b.eq k
    cmp w0,#'0'
    b.lt k
    cmp w0,#'9'
    b.gt k
    mov x23,#0
a:
    ldrb w0,[x21]
    cmp w0,#'0'
    b.lt e
    cmp w0,#'9'
    b.gt e
    mov x1,#10
    mul x23,x23,x1
    sub w0,w0,#'0'
    add x23,x23,x0
    add x21,x21,#1
    b a
e:
    add x21,x21,#1
    mov x24,#0
g:
    ldrb w0,[x21]
    cmp w0,#'0'
    b.lt h
    cmp w0,#'9'
    b.gt h
    mov x1,#10
    mul x24,x24,x1
    sub w0,w0,#'0'
    add x24,x24,x0
    add x21,x21,#1
    b g
h:
    mov x25,x23
r:
    cmp x25,x24
    b.gt p
    mov x1,x25
    mov x2,#0
    mov x3,#10
t:
    cmp x1,#0
    b.eq u
    udiv x1,x1,x3
    add x2,x2,#1
    b t
u:
    tst x2,#1
    b.ne v
    cmp x2,#2
    b.lt v
    lsr x3,x2,#1
    mov x4,#1
    mov x6,#10
w:
    cmp x3,#0
    b.eq x
    mul x4,x4,x6
    sub x3,x3,#1
    b w
x:
    udiv x6,x25,x4
    add x7,x4,#1
    mul x8,x6,x7
    cmp x8,x25
    b.ne v
    add x22,x22,x25
v:
    add x25,x25,#1
    b r
k:
    add x21,x21,#1
    b p
d:
    mov x0,x22
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