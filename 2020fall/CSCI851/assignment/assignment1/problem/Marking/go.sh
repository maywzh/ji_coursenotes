#!/usr/bin/bash

fix *.cpp *.h
convert.sh *.cpp *.h
pdflatex out.tex
rm out.aux out.log out.tex

cp ~/Marking/Bundle.zip .
unzip -o Bundle.zip
rm Bundle.zip

echo "Checking for argv"
grep "argv" *

echo "Checking for class"
grep "class" *

echo "Checking for cerr"
grep "cerr" *



bcheck ./Vet 3 Animals.txt Vets.txt Problems.txt Treatments.txt Output-0.txt > Process0.txt

./RepCent 3 Vehicles.txt Mechanics.txt Problems.txt Fixes.txt Output-1.txt > Process1.txt
./RepCent 10 Vehicles2.txt Mechanics2.txt Problems2.txt Fixes2.txt Output-2.txt > Process2.txt
./RepCent 7 Vehicles3.txt Mechanics3.txt Problems3.txt Fixes3.txt Output-3.txt > Process3.txt


