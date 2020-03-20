include Irvine32.inc
includelib legacy_stdio_definitions.lib
includelib ucrt.lib

scanf PROTO C,
	format: PTR BYTE,
	args: VARARG

printf PROTO C,
	format: PTR BYTE,
	args: VARARG

Point2D STRUCT					; the structure to store (x, y)
	x SDWORD 0
	y SDWORD 0
Point2D ENDS

Triangle STRUCT					; the structure of 3 side lengths and the area
	DistA REAL8 ?
	DistB REAL8 ?
	DistC REAL8 ?
	Area REAL8 ?
Triangle ENDS

calDist PROTO, temp:Point2D, temp2:Point2D
calArea PROTO, temp: Triangle

.data
	value BYTE "%d", 0
	value2 BYTE "%.3f", 0dh, 0ah, 0
	n SDWORD 0						; temporary variable to store the input value
	inputCnt SDWORD 6				; input counter to input 6 point
	arr SDWORD 7 DUP(?)				; array to store the input point
	
	example Triangle <>
	point1 Point2D <>
	point2 Point2D <>
	point3 Point2D <>

; main procedure to scanf 3 coordinate and put it in structure Point2D point1, point2, point3 
; calling calDist by using each Point2D to construct the distance (a, b, c) store in structure Triangle
; calling calArea by using a Triangle structure named example to produce its area
; printf the area
.code
main PROC
	L1:
		mov ebx, 0									; use as 0-5 input counter
		mov esi, 0
	L2:
		cmp ebx, inputCnt							; to compare if ebx counter exceed 6
		jae L3										; if counter >= 6, jmp to L3, else continue
		inc ebx										; counter++
		invoke scanf, addr value, addr n

		mov ecx, n
		mov arr[esi], ecx							; put the input data into array[]
		add esi, TYPE SDWORD						; to move to next place in the array
		jmp L2										; keep typing the coordinate
	L3:
		cmp eax, 0									; if there is any input, eax is set 1
		jle L0										; if there is no input, jump to end
		mov ebx, arr[0]								; move each coordinate from array to the 3 Point2D structure
		mov point1.x, ebx
		mov ebx, arr[4]
		mov point1.y, ebx
		mov ebx, arr[8]
		mov point2.x, ebx
		mov ebx, arr[12]
		mov point2.y, ebx
		mov ebx, arr[16]
		mov point3.x, ebx
		mov ebx, arr[20]
		mov point3.y, ebx
		
		invoke calDist, point1, point2				; calculate the distance from a point to another
		fstp example.DistA
		invoke calDist, point2, point3
		fstp example.DistB
		invoke calDist, point3, point1
		fstp example.DistC

		invoke calArea, example						; calculate the area of a triangle
		fstp example.Area

		invoke printf, addr value2, example.Area
		jmp L1
	L0:
		ret
		
main ENDP

calDist PROC, temp:Point2D, temp2:Point2D
.data
	a SDWORD ?
.code
	L1:
		mov a, 0					; initializaion
		mov eax, temp.x				; pow((temp2.x-temp.x), 2)
		sub temp2.x, eax
		mov eax, temp2.x
		imul temp2.x
		mov a, eax

		mov eax, temp.y				; pow((temp2.y-temp.y), 2)
		sub temp2.y, eax
		mov eax, temp2.y
		imul temp2.y
		add a, eax					; +, store in a

		fild a						; push into stack in floating-point format
		fsqrt						; replace ST(0) with its square root					
		ret							; return the floating-point value into st(0)
calDist ENDP


calArea PROC, temp: Triangle
.data
	s REAL8 0.0						; s = (a+b+c)/2
	floatTwo REAL8 2.0
	fA REAL8 ?
	fB REAL8 ?
	fC REAL8 ?
.code
	L1:
		fldz						; load +0.0 onto register stack
		fld temp.DistA
		fadd
		fld temp.DistB
		fadd
		fld temp.DistC
		fadd
		fdiv floatTwo				; s is still on ST(0)
		fstp s						; pop st(0) and store it on s

		fld s						; push on the stack
		fld temp.DistA
		fsub						; st(0) - st(1) and pop		s-temp.DistA
		fstp fA						; pop the result and store it to fA

		fld s
		fld temp.DistB
		fsub						; s- temp.DistB
		fstp fB

		fld s
		fld temp.DistC
		fsub						; s - temp.DistC
		fstp fC

		fld s
		fld fA
		fmul						; ST(1) = ST(1) * ST(0), and pop ST(0)
		fld fB
		fmul
		fld fC
		fmul
		fsqrt						; area = sqrt(s * fA * fB * fC)
		ret

calArea ENDP

END main