; =============================================================================
; Lovebyte sizecoding starter pack - Minimal setup example using CCCD constant
;
; assumed register values:
; AX=0000 / BX=0000 / CX=00FF / DS=CS=SI=100h/ DI=FFFE / BP=09xx
; =============================================================================
org 100h   

push 0a000h-70	; Set ES segment to A000 - 70*16 (center x)
pop es
mov al,0x13	; Init 320x200x256 colors	
int 0x10

updateloop:
 mov ax,0cccdh	; Convert DI to dl=x,dh=y
 mul di	
 sub dh,104	; center y

 ; floor effect:  z=abs(y) , u = st0/z , v = 127.0/z;
 xor bx,bx
 pusha				; push all regs to stack ax(-4),cx(-6),dx(-8),bx(-10),sp(-12),bp(-14),si,di
 fninit				; init fpu
 fild word [bx-8]		; y 
 fidiv word [scalevalue]	; y/scale
 fabs				; z=abs(y/scale)
 fild word [bx-9]		; x z
 fdiv st1			; x/z z
 fistp word [bx-4]		; store x/z -> ax
 fidivr word [floorval] 	; 127*256/z
 fist word [bx-10]		; store 32767/z -> bx		
 popa	
 add ax,bp
 xor al,bl
 and al,15
 add al,16
 stosb
loop updateloop ; while (cx>0) cx--; 
hlt		; 1 byte method to wait for 'vblank'
inc bp		; increment framecounter
in al,0x60	; check keyboard
dec al
jnz updateloop
ret

; constants
floorval dw 32767
scalevalue dw 16

