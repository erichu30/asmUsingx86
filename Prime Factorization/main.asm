; asm homework 04 another
.model flat, stdcall

includelib ucrt.lib
includelib legacy_stdio_definitions.lib

printf proto C, format: PTR BYTE, args: vararg
scanf proto C, format: PTR BYTE, args: vararg

.data
	inputValue BYTE "%d", 0					; use %d as a byte type

	outputValue BYTE "%d * ", 0
	outputPow BYTE "%d^%d", 0dh, 0ah, 0
	outputPowWithMul BYTE "%d^%d * ", 0
	outputNextLine BYTE "%d", 0dh, 0ah, 0
	nextLine BYTE 0dh, 0ah, 0

	input DWORD 0
	count DWORD 0
	i DWORD 2
	; eax as input

.code
main proc
	L1:
		invoke scanf, addr inputValue, addr input
		mov i, 2							; use i as a for loop counter
		mov eax, input
		cmp eax, 0
		jl L0								; if input < 0, jump to the end
											; else keep going
	L2:
		cmp input, 1
		je L3								; if input == 1, print \n
		jmp L4
	L3:
		invoke printf, addr nextLine
		jmp L1
	L4:										; for loop conditional judgement
		mov ecx, i
		cmp ecx, input					
		jle L5								; counter(i) <= input
		jmp L1								; if counter(i) > input, jump to scanf
	L5:
		mov edx, 0							; clear dividend high to 0
		mov eax, input						; put input into dividend low
		div ecx								; input % i (counter)
											; 商放在eax, 餘數在edx
		cmp edx, 0							; if input % i == 0 (while loop condition)
		je L6								; jump to L6 (while loop statement)
		jmp L7								; if the condition not reach(input % i != 0), jump out the while loop 
	L6:
		mov input, eax						; input = input / i
		inc count							; cnt++
		jmp L5
	L7:
		mov ebx, count
		cmp ebx, 0							; if cnt > 0
		jg L8
		jmp L16
	L8:
		cmp input, 1
		je L9								; if input == 1, jump to L9
		jmp L10							; else jump to L10 (input != 1)
	L9:
		cmp count, 1						; if input==1 && cnt==1, jump to L11
		je L11								
		jmp L12							; if input==1 && cnt!=1, jump to L12
	L10:
		cmp count, 1						; if input!=1 && cnt==1, jump to L13
		je L13								
		jmp L14							; if input!=1 && cnt!=1, jump to L14 
	L11:
		invoke printf, addr outputNextLine, i			; input==1 && cnt==1
		jmp L15
	L12:
		invoke printf, addr outputPow, i, count			; input==1 && cnt!=1					
		jmp L15
	L13:
		invoke printf, addr outputValue, i				; input!=1 && cnt==1		
		jmp L15
	L14:
		invoke printf, addr outputPowWithMul, i, count	; input!=1 && cnt!=1
		jmp L15
	L15:
		mov count, 0						; cnt = 0
	L16:
		inc i								; i++
		jmp L4
	L0:
		ret

main ENDP
END main
		
