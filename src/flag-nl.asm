; =============================================================================
; Lovebyte sizecoding starter pack - Minimal setup example using CCCD constant
;
; assumed register values:
; AX=0000 / BX=0000 / CX=00FF / DS=CS=SI=100h/ DI=FFFE / BP=09xx
; =============================================================================
    org 100h

    les bp,[bx]

    ; Init 320x200x256 colors	
    mov al, 0x13
    int 0x10
    mov al, 0x28 ; Draw red
    call  stripe
    mov al, 0x1F ; Draw white (white enough to be close to blue)
    call  stripe
    inc ax
    ; No call here. Let it run. The ret is the program exit
stripe:
    mov ch, 0x54
    rep stosb
    ret
    