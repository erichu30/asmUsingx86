; asm homework two 
.model flat, stdcall

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

printf PROTO C,							;std c library function in libc.lib
	format: PTR BYTE, args: vararg
scanf PROTO C,							;std c library function in libc.lib
	format: PTR BYTE, args: vararg

.data
	inputCase DWORD 0		; input case number
	inputNum DWORD 0		; input the number ready to compare
	
	caseValue BYTE "%d", 0	
	numValue BYTE "%d", 0
	nextLine BYTE "%d", 0dh, 0ah, 0		; nextline
	printMax BYTE "Max = ", 0
	printMin BYTE "Min = ", 0

	max DWORD -2147483648
	min DWORD 2147483647
.code
	main proc
	invoke scanf, addr caseValue, addr inputCase	; scanf case number into inputCase
	mov ebx, 1										; use ebx as a counter to count the for loop
	L1:
		cmp ebx, inputCase		 					; compare the ebx counter and inputCase
		ja L3										; jump to the end of loop (if ebx > inputCase)
													; jump above
		
		invoke scanf, addr numValue, addr inputNum	; scanf the number ready to compare into inputNum
		mov eax, inputNum							; put the inputNum into eax
		jmp L2										; jump to L2 
		
	L2:	
		cmp eax, max							
		jg L4									; if inputNum(eax) > max, jump to L4
		
		cmp min, eax							
		jg L5									; if min > inputNum(eax), jump to L5
		
		inc ebx										; ebx counter ++
		jmp L1
	L4:
		mov max, eax							; max = inputNum
		jmp L2
	L5:
		mov min, eax							; min = inputNum
		jmp L2

	L3:
		invoke printf, addr printMin
		invoke printf, addr nextLine, min
		invoke printf, addr printMax
		invoke printf, addr nextLine, max
		ret 0
		
main ENDP
END main
