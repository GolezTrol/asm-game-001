; =============================================================================
; Lovebyte sizecoding starter pack - Minimal setup example using CCCD constant
;
; assumed register values:
; AX=0000 / BX=0000 / CX=00FF / DS=CS=SI=100h/ DI=FFFE / BP=09xx
; =============================================================================
    org 100h

    xor di, di

    push 0a000h	; Set ES segment to A000
    pop es

    ; Init 320x200x256 colors	
    mov al,0x13
    int 0x10

    mov al, 27h ; Draw red
    call stripe
    mov al, 0Fh ; Draw white
    call stripe
    mov al, 20h ; Draw blue
    ; No call here. Let it run. The ret is the program exit
stripe:
    mov cx, 21440
    rep stosb
    ret
