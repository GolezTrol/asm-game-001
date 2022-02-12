; =============================================================================
; Lovebyte sizecoding starter pack - Minimal setup example using CCCD constant
;
; assumed register values:
; AX=0000 / BX=0000 / CX=00FF / DS=CS=SI=100h/ DI=FFFE / BP=09xx
; =============================================================================
org 100h   
push 0a000h	; Set ES segment to A000
pop es
mov bx, 257 ; Random seed

int 10h ; Set 40x25
%macro gotoxy 2
    mov ah,02h
    mov bh, 00h
    mov dl,%1
    mov dh,%2
    int 10h
%endmacro

;mov al,13h	; Init 320x200x256 colors	
;int 10h

mov cx, 20 ;; iterations
updateloop:
    push cx
    
    ; Get time
    mov ah, 0
    int 1Ah


    ; Print char
    gotoxy 12,12;
    mov     ah, 2
    mov DL, 'A' ; 0AH
    add dl, 2
    int 21H
    
    ; Move screen
    gotoxy 0, 24
    mov DL, 0AH
    ;int 21h

    ; Plot player and move
    gotoxy 0, 25
    mov DL, 'X'
    int 21h

; Now,,, wait a sec!
    MOV     CX, 0FH
    MOV     DX, 4240H
    MOV     AH, 86H
    INT     15H

    pop cx 

in al,0x60	; check keyboard
dec al
jz updateloop

dec cx

;cmp al,
cmp al, 27; esc
jne updateloop

ret

random:
    pusha
    mul ax      ; square random number
    add cx, bx  ; calculate next iteration of Weyl sequence
    add ax, cx  ; add Weyl sequence
    mov al, ah  ; get lower byte of random number from higher byte of ax
    mov ah, dl  ; get higher byte of random number from lower byte of dx
    ;...         ; use new random number stored in ax
    popa
    ret
