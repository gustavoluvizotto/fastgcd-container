#!/bin/sh

fastgcd $1

mkdir -p output
mv gcds output/
mv vulnerable_moduli output/
