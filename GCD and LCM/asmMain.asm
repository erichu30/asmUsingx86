.386
.model flat, stdcall

include Irvine32.inc			; for the procedure ReadInt and WriteInt

calGCD PROTO C, a:DWORD, b:DWORD

.data
	m DWORD ?
	m2 DWORD ?
	n DWORD ?
	n2 DWORD ?

.code
	main proc
	L1:
		call ReadInt			; read a 32-bit signed int into eax
		mov m, eax
		mov m2, eax				; for the LCM used
		cmp m, 0				; if key less than -1, jump to the end of loop
		jl L0
		call ReadInt
		mov n, eax
		mov n2, eax				; for the LCM used

		loop L2
	L2:
		cmp m, eax				; compare m and eax (n)
		jl L3					; jump to L3 if m < eax(n)
		loop L4
		
	L3:
		mov ebx, m				; exchange m and n
		mov m, eax
		mov n, ebx
		loop L4
	L4:
		invoke calGCD, m, n
		mov eax, ecx			; WriteInt use eax
		call WriteInt 
		call Crlf				; nextline
		mov eax, m2
		mov ebx, n2
		mul ebx					; eax(m) x ebx(n) = edx | eax

		div ecx					; m x n / gcd(m, n) = eax (LCM) 
		call WriteInt
		call Crlf				; nextline

		jmp L1
	L0:
		ret
main ENDP
; temp = m % n
; m = n
; n = temp
; if n == 0, gcd == previous m
calGCD PROC C, a:DWORD, b:DWORD		; use a(m) and b(n)
	L1:
		cmp b, 0					; if divisor == 0, the previous number m is the GCD
		je L2
		mov eax, a					; dividend low half
		mov edx, 0					; dividend high half = 0
		
		mov ebx, b					; divisor
		div ebx						; edx = m % n
									; eax = m / n
		mov b, edx					; n = m % n
		mov a, ebx					; take place m with n
		loop L1
	L2:
		mov ecx, a
		ret 
calGCD ENDP

END main