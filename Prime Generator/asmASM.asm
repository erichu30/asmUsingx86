;include irvine32.inc

.model flat,C

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

isPrime proto C, n:DWORD					 ; include isPrime function in c, announce n a DWORD format
printf PROTO C,                              ; Std C library function
         format: PTR BYTE, args: VARARG      ; (in libc.lib)
scanf PROTO C,                               ; STd C library function
         format: PTR BYTE, args: VARARG		 ; (in libc.lib)

.data
	input BYTE "%d",0		
	nextLine BYTE "%d", 0dh, 0ah, 0		;do the same as "\n"
	value DWORD 0			
.code
	asmMain PROC C
	INVOKE scanf,ADDR input, ADDR value
	
	mov ebx, 0	;counter 
				;eax is the return value of function isPrime

L1:
	INVOKE isPrime, ebx
	cmp ebx, value	; compare ebx and value
    je L4			; if ebx = value, jump to the end of while, out of for loop

	cmp eax, 1		; compare the return value of isPrime and 1
					; if eax == 1, ZF = 0			(it is a prime number)
					; else if eax != 1, ZF = 1		(it is NOT a prime number)
	je L3			; if equal, jump to L3. 
					; jnz : branches if zf is unset ( = 0 )                                                                                                  (pp. 235, text book)   
			
	jz L2			; if not equal

L2:   
	inc ebx			; counter++
    loop L1	
L3: 
	invoke printf, ADDR nextLine, ebx
	inc ebx
	loop L1
L4:					; end of while
	
	ret 0
asmMain ENDP

END
