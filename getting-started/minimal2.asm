; =============================================================================
; Lovebyte sizecoding starter pack - Minimal setup example regular division
;
; assumed register values:
; AX=0000 / BX=0000 / CX=00FF / DS=CS=SI=100h/ DI=FFFE / BP=09xx
; =============================================================================
org 100h   

push 0a000h	; Set ES segment to A000
pop es
mov al,0x13	; Init 320x200x256 colors	
int 0x10

updateloop:
 mov ax,di
 xor dx,dx 
 mov bx,320 
 div bx 	; ax = y (di/320), dx = x (di%320)
 add ax,bp	; al=x+framecounter
 xor al,dl	; al=(x+bp)^y
 shr al,4	; set color to 16..31 range al=(al>>4)+16 
 add al,16	
 stosb		; write pixel to screen, increase DI
loop updateloop ; while (cx>0) cx--; 
hlt		; 1 byte method to wait for 'vblank'
inc bp		; increment framecounter
in al,0x60	; check keyboard
dec al
jnz updateloop
ret

