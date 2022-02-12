; =============================================================================
; Lovebyte sizecoding starter pack - Minimal setup example using CCCD constant
;
; assumed register values:
; AX=0000 / BX=0000 / CX=00FF / DS=CS=SI=100h/ DI=FFFE / BP=09xx
; =============================================================================
org 100h   

push 0a000h	; Set ES segment to A000
pop es
mov al,0x13	; Init 320x200x256 colors	
int 0x10
xor di, di
mov cx, 64000

updateloop:
    xor dx, dx
    mov ax, di ; Pixel index
    mov bx, 200 
    div bx ; ax = y, dx = x
    call diff ; Get the absolute diff between ax and dx into bx
    imul bx, bx
    mov al, 32 ; blue
    cmp bx, 144
    jg draw
    mov al, 15 ;white
    cmp bx, 25
    jg draw
    mov al, 39; red
draw:
    stosb		; write pixel to screen, increase DI
loop updateloop ; while (cx>0) cx--; 

waitkbd:
    mov cx, 64000
    xor di, di
    in al,0x60	; check keyboard
    dec al
    jnz updateloop
ret 

diff:
    cmp ax, dx
    jl diffless
    mov bx, ax
    sub bx, dx
    ret
diffless:
    mov bx, dx
    sub bx, ax
    ret
