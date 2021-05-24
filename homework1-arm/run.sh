#!/bin/bash

#Program: Perimeter of Rectangle
#Author: Eric Britten

#Print Header
echo "//////////////////////////////////////////////////////////////////////////////"

#Delete some un-needed files
echo "Remove previously compiled files"
rm *.o
rm *.out

echo "Assemble perimeter.asm"
as -o perimeter.o perimeter.s

echo "Compile rectangle.cpp using the g++ compiler standard 2011"
g++ -c -Wall -no-pie -o rectangle.o rectangle.cpp -std=c++11

echo "Link the object files using the g++ linker standard 2011"
g++ -no-pie -o rectangle.out rectangle.o perimeter.o -std=c++11

echo "Build process complete"
echo "//////////////////////////////////////////////////////////////////////////////"
echo "Run the program Perimeter of Rectangle:"
echo ""

./rectangle.out

echo "The script file will terminate"
