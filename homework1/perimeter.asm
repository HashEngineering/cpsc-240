;----------------------------------------------------------------------------------------------------------------------------
;Program name: "Perimeter of Rectangle".  
;  This program demonstrates the using assembly to gather the sides of a rectangle as
;  inputs and outputing the perimeter and its average side length.  
;  Copyright (C) 2021 Eric Britten.                                                    
;                                                                                                                           
;  This file is part of the software program "Perimeter of Rectangle".
;                                                      
;  Perimeter of Rectangle is free software: you can redistribute it and/or modify it under the terms of the GNU General     
;  Public License version 3 as published by the Free Software Foundation.                                                   
;  
;  Perimeter of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the     
;  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more    
;  details. A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                
;----------------------------------------------------------------------------------------------------------------------------




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Eric Britten
;  Author email: ebritten@cs.fullerton.edu
;
;Program information
;  Program name: Floating IO
;  Programming languages: One modules in C and one module in X86
;  Date program began: 2021-02-02
;  Date of last update: 2021-02-07
;  Date of reorganization of comments: 2021-02-11
;  Files in this program: rectangle.cpp, perimeter.asm
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04 (WSL).
;
;This file
;   File name: perimeter.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm


;===== Begin code area ================================================================================================

;----- Declare external functions
extern printf
extern scanf

; declare the function in this file as global
global perimeter

;----- Data Section
segment .data
welcome           db "This program will compute the perimeter and the average side length of a rectangle.",10,0
input_height      db "Enter the height: ",0
input_width       db "Enter the width: ",0
float_format      db "%lf",0
perimeter_text    db "The perimeter is %lf",10,0
average_side_text db "The length of the average side is %lf",10,0
hope_text         db "I hope you enjoyed your rectangle!",10,0
good_bye          db "The assembly program will send the perimeter to the main function",10,0


segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

perimeter:

;Prolog ----- Insurance for any caller of this assembly module -------------------------------------------------------
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags

;Registers rax, rip, and rsp are usually not backed up.
push qword 0                   ; align stack with 16 bytes


;------------- Display a welcome message to the user.
mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, welcome               ;"This program will compute the perimeter and the average side length of a rectangle"
call printf

;============= Begin block to input exactly the height ========================================================
; Display a prompt message asking for the height
mov rax, 0
mov rdi, input_height          ;"Enter the height: "
call printf

;Begin the scanf block
push qword 0
mov rax, 0
mov rdi, float_format          ;"%lf" (64-bit float)
mov rsi, rsp
call scanf
movsd xmm10, [rsp]             ;store the height in xmm10

pop rax                        ;Reverse the push in the scanf block
;============= End of block to input height =================================================================


;============= Begin block to input the width ===============================================================
;Display a prompt message asking for the width
mov rax, 0
mov rdi, input_width          ;"Enter the width: "
call printf

;Begin the scanf block -------------------------------------------------------------------------------------
push qword 0                   ;reserve space on stack for result
mov rax, 0
mov rdi, float_format          ;"%lf" (64-bit float)
mov rsi, rsp
call scanf
movsd xmm11, [rsp]             ;store the width in xmm11

pop rax                        ;Reverse the push in the scanf block
;============= End of block to input width =================================================================

;============= Begin block to calculate the perimeter ======================================================
movsd xmm12, xmm10              ; xmm12 = height
addsd xmm12, xmm11              ; xmm12 = height + width
mov r8, 2                       ; r8 = 2
cvtsi2sd xmm15, r8              ; xmm15 = 2.0 (convert long 2 to 2.0 double)
mulsd xmm12, xmm15              ; xmm12 = (height + width) * 2.0 (xmm15) (perimeter)
;============= End block to calculate the perimeter ========================================================

;============= Begin block to calculate the average side length=============================================
movsd xmm13, xmm10              ; xmm13 = (height)
addsd xmm13, xmm11              ; xmm13 = (height + width)
divsd xmm13, xmm15              ; xmm13 = (height + width)/2.0(xmm15) (average side length)
;============= End block to calculate the average side length=============================================

;============= Begin block to output the perimeter to the console =============================================
push qword 0
mov rax, 1
movsd xmm0, xmm12           ; move perimeter value in xmm12 to xmm0
mov rdi, perimeter_text
call printf
;============= End block to output the perimeter to the console =============================================

;============= Begin block to output the average side length to the console =============================================
mov rax, 1
movsd xmm0, xmm13           ; move average side length value in xmm13 to xmm0
mov rdi, average_side_text
call printf
pop rax
;============= End block to output the average side length to the console =============================================

;Display good-bye message (the next block of instructions)
mov rax, 0
mov rdi, hope_text              ;"I hope you enjoyed your rectangle!"
call printf

;============= Prepare to exit from this program ======================================================================

;Display good-bye message (the next block of instructions)
mov rax, 0
mov rdi, good_bye              ;"The assembly program will send the perimeter to the main function."
call printf


movsd xmm0, xmm12              ;select the perimeter for the caller

pop rax                        ;Reverse the push near the beginning of this asm function.

;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
