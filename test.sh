#!/bin/bash

clear

WORD=testing

make
rm aseq.txt at2sing.txt at4sing.txt at2fast.txt at4fast.txt

echo "Running spell_seq..."
for ((i=20; i>0; i--))
do
./spell_seq $WORD >> aseq.txt
done

echo "Running spell_t2_singleloop..."
for ((i=20; i>0; i--))
do
./spell_t2_singleloop $WORD >> at2sing.txt
done


echo "Running spell_t2_fastest..."
for ((i=20; i>0; i--))
do
./spell_t2_fastest $WORD >> at2fast.txt
done

echo "Running spell_t4_singleloop..."
for ((i=20; i>0; i--))
do
./spell_t4_singleloop $WORD >> at4sing.txt
done

echo "Running spell_t4_fastest..."
for ((i=20; i>0; i--))
do
./spell_t4_fastest $WORD >> at4fast.txt
done

echo "Cleaning up the output files..."
sed -i "s/Spell check time://g" aseq.txt
sed -i "s/Word $WORD is spelled correctly//g" aseq.txt

sed -i "s/Spell check time://g" at2sing.txt
sed -i "s/Word $WORD is spelled correctly//g" at2sing.txt

sed -i "s/Spell check time://g" at2fast.txt
sed -i "s/Word $WORD is spelled correctly//g" at2fast.txt

sed -i "s/Spell check time://g" at4sing.txt
sed -i "s/Word $WORD is spelled correctly//g" at4sing.txt

sed -i "s/Spell check time://g" at4fast.txt
sed -i "s/Word $WORD is spelled correctly//g" at4fast.txt

sed -i 's/^ *//; s/ *$//; /^$/d' aseq.txt
sed -i 's/^ *//; s/ *$//; /^$/d' at2sing.txt
sed -i 's/^ *//; s/ *$//; /^$/d' at2fast.txt
sed -i 's/^ *//; s/ *$//; /^$/d' at4sing.txt
sed -i 's/^ *//; s/ *$//; /^$/d' at4fast.txt

if grep -q misspelled "aseq.txt" "at2sing.txt" "at2fast.txt" "at4sing.txt" "at4fast.txt"; then
   echo "WARNING: Input word is misspelled."
else
	exit 0
fi