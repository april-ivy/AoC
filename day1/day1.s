.global _main
.align 4
.bss
b: .skip 32768
.text
_main:
    mov x0,#0
    adrp x1,b@PAGE
    add x1,x1,b@PAGEOFF
    mov x2,#32768
    mov x16,#3
    svc #0x80
    mov x10,x0
    adrp x11,b@PAGE
    add x11,x11,b@PAGEOFF
    mov x12,#50
    mov x13,#0
p:
    adrp x14,b@PAGE
    add x14,x14,b@PAGEOFF
    add x14,x14,x10
    cmp x11,x14
    b.ge d
    ldrb w0,[x11]
    cmp w0,#10
    b.eq s
    cmp w0,#'L'
    b.eq l
    cmp w0,#'R'
    b.eq r
    add x11,x11,#1
    b p
s:
    add x11,x11,#1
    b p
l:
    mov x15,#0
    b n
r:
    mov x15,#1
n:
    add x11,x11,#1
    mov x19,#0
m:
    ldrb w0,[x11]
    cmp w0,#'0'
    b.lt o
    cmp w0,#'9'
    b.gt o
    mov x1,#10
    mul x19,x19,x1
    sub w0,w0,#'0'
    add x19,x19,x0
    add x11,x11,#1
    b m
o:
    cmp x15,#0
    b.eq q
    add x12,x12,x19
    b w
q:
    sub x12,x12,x19
w:
    mov x1,#100
    sdiv x2,x12,x1
    msub x12,x2,x1,x12
    cmp x12,#0
    b.ge z
    add x12,x12,#100
z:
    cmp x12,#0
    b.ne p
    add x13,x13,#1
    b p
d:
    mov x0,x13
    sub sp,sp,#32
    mov x1,sp
    add x1,x1,#30
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