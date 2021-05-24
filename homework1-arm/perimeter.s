/*//----------------------------------------------------------------------------------------------------------------------------
//Program name: "Perimeter of Rectangle".  
//  This program demonstrates the using assembly to gather the sides of a rectangle as
//  inputs and outputing the perimeter and its average side length.  
//  Copyright (C) 2021 Eric Britten.                                                    
//                                                                                                                           
//  This file is part of the software program "Perimeter of Rectangle".
//                                                      
//  Perimeter of Rectangle is free software: you can redistribute it and/or modify it under the terms of the GNU General     
//  Public License version 3 as published by the Free Software Foundation.                                                   
//  
//  Perimeter of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY// without even the     
//  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more    
//  details. A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                
//----------------------------------------------------------------------------------------------------------------------------




//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Eric Britten
//  Author email: ebritten@cs.fullerton.edu
//
//Program information
//  Program name: Floating IO
//  Programming languages: One modules in C and one module in ARMv4
//  Date program began: 2021-05-22
//  Date of last update: 2021-05-22
//  Date of reorganization of comments: 2021-05-22
//  Files in this program: rectangle.cpp, perimeter.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04 (WSL).
//
//This file
//   File name: perimeter.asm
//   Language: X86 with Intel syntax.
//   Max page width: 132 columns
//   Assemble: as -o perimeter.o perimeter.s


//===== Begin code area ================================================================================================
*/

//----- Data Section
.data

.balign 4
welcome:          .ascii "This program will compute the perimeter and the average side length of a rectangle.\n\0" 
.balign 4
input_height:     .ascii "Enter the height: \0"
.balign 4
input_width:       .ascii "Enter the width: \0"
.balign 4
float_format:      .ascii "%ld\0"
.balign 4
perimeter_text:    .ascii "The perimeter is %ld\n\0"
.balign 4
average_side_text: .ascii "The length of the average side is %ld\n\0"
.balign 4
hope_text:         .ascii "I hope you enjoyed your rectangle!\n\0"
.balign 4
good_bye:          .ascii "The assembly program will send the perimeter to the main function\n\0"
.balign 4


.text //Reserved for executing instructions.
.global perimeter
    //----- Declare external functions
    .extern printf
    .extern scanf

perimeter:

//Prolog ----- Insurance for any caller of this assembly module -------------------------------------------------------
//Any future program calling this module that the data in the caller's GPRs will not be modified.
push {r4, lr}

//------------- Display a welcome message to the user.
ldr r0, address_of_welcome               //"This program will compute the perimeter and the average side length of a rectangle"
bl printf

//============= Begin block to input exactly the height ========================================================
// Display a prompt message asking for the height
ldr r0, address_of_input_height          //"Enter the height: "
bl printf

//Begin the scanf block
sub sp, sp, #8
ldr r0, address_of_float_format          //"%ld" (64-bit long)
mov r1, sp
bl scanf
ldr r6, [sp]                            //store the height in r6
add sp, sp, #8

//============= End of block to input height =================================================================


//============= Begin block to input the width ===============================================================
//Display a prompt message asking for the width
//mov rax, 0
ldr r0, address_of_input_width          //"Enter the width: "
bl printf

//Begin the scanf block -------------------------------------------------------------------------------------
sub sp, sp, #8
ldr r0, address_of_float_format          //"%ld" (64-bit )
mov r1, sp
bl scanf
ldr r4, [sp]
add sp, sp, #8
//============= End of block to input width =================================================================

//============= Begin block to calculate the perimeter ======================================================
add r7, r6, r4
add r7, r7, r7
//============= End block to calculate the perimeter ========================================================

//============= Begin block to calculate the average side length=============================================
lsr r8, r7, #2   // divide by 4 with a right shift of 2 bits
//============= End block to calculate the average side length=============================================

//============= Begin block to output the perimeter to the console =============================================
mov r1, r7
ldr r0, address_of_perimeter_text
bl printf
//============= End block to output the perimeter to the console =============================================

//============= Begin block to output the average side length to the console =============================================
mov r1, r8
ldr r0, address_of_average_side_text
bl printf
//============= End block to output the average side length to the console =============================================

//Display good-bye message (the next block of instructions)
ldr r0, address_of_hope_text              //"I hope you enjoyed your rectangle!"
bl printf

//============= Prepare to exit from this program ======================================================================

ldr r0, address_of_good_bye              //"The assembly program will send the perimeter to the main function."
bl printf

//===== Restore original values to integer registers ===================================================================
mov r0, r7
pop {r4, lr}
bx lr

address_of_welcome: .word welcome
address_of_input_height: .word input_height
address_of_input_width: .word input_width
address_of_float_format: .word float_format
address_of_perimeter_text: .word perimeter_text
address_of_average_side_text: .word average_side_text
address_of_hope_text: .word hope_text
address_of_good_bye: .word good_bye
//========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
