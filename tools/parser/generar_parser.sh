#!/bin/bash
flex latuilex.l
bison -y latuiparse.y
cp *.c ../../src
# cp *.h ../../src
cp *.h ../../include