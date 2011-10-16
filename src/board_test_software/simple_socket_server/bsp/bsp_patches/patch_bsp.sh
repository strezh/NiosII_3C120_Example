#!/bin/sh

echo "Patching file ./drivers/src/altera_avalon_tse.c"
rm -f ./drivers/src/altera_avalon_tse.c
cp ./bsp_patches/rod_altera_avalon_tse.c ./drivers/src/altera_avalon_tse.c

