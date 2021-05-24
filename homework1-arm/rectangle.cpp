//----------------------------------------------------------------------------------------------------------------------------
//  Program name: "Perimeter of Rectangle".  
//  This program demonstrates the using assembly to gather the sides of a rectangle as 
//  inputs and outputing the perimeter and average side length.
//  Copyright (C) 2021 Eric Britten.                                                    
//                                                                                                                           
//  This file is part of the software program "Perimeter of Rectangle".
//                                                      
//  Perimeter of Rectangle is free software: you can redistribute it and/or modify it under the terms of the GNU General     
//  Public License version 3 as published by the Free Software Foundation.                                                   
//
//  Perimeter of Rectangle is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the     
//  implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more    
//  details. A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                
//----------------------------------------------------------------------------------------------------------------------------

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Eric Britten
//  Author email: ebritten@cs.fullerton.edu
//
//Program information
//  Program name: Perimeter of Rectangle
//  Programming languages: One modules in C and one module in X86
//  Date program began: 2021-02-02
//  Date of last update: 2021-02-07
//  Date of reorganization of comments: 2021-02-11
//  Files in this program: rectangle.cpp, perimeter.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu 20.04 (WSL).
//
//Purpose
//  Show how to:
//  * input and output floating point (64-bit) numbers
//  * calculating the perimeter of a rectangle and its average side length.  
//  * return the perimeter as a 64-bit floating point to the calling function (main)
//
//This file
//   File name: rectangle.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: g++ -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp -std=c++11
//   Link: g++ -m64 -no-pie -o rectangle.out rectangle.o perimeter.o -std=c++11
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <iostream>
#include <iomanip>

// standard prototypes for assembly functions:
extern "C" long perimeter();

int main(int argc, char* argv[])
{
    std::cout << "Welcome to a friendly assembly program written by Eric Britten" << std::endl;
    long answer = perimeter();
    std::cout << "The main function received this number " 
              << std::fixed 
              << std::setprecision(5) 
              << answer 
              << " and has decided to keep it." << std::endl;
    std::cout << "A 0 will be returned to the operating system\nHave a nice day." << std::endl << std::endl;
    return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

