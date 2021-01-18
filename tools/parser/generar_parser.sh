#!/bin/bash
flex latlexui.l
bison -y latparseui.y
cp *.c ../../src
cp *.h ../../include