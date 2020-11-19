#!/usr/bin/bash
# To be used as       goA3.sh in the relevant directory.

    cp ~/Mark-A3/Bundle.zip .
    unzip -o Bundle.zip

    # Case 0
    echo "----- Case 0: Invalid BLM, X-> Y -------" &> Case0.txt
    ./TS X Y InB.txt Out0.txt &>> Case0.txt

    # Case 1
    echo "----- Case 1: Invalid Morse.txt entry, missing t" &> Case1.txt
    cp M1.txt Morse.txt;cp B.txt Braille.txt
    ./TS M L InM.txt Out1.txt &>> Case1.txt
    rm Morse.txt Braille.txt

    # Case 2
    echo "----- Case 2: Invalid Braille.txt entry, symbol 2 in c" &> Case2.txt
    cp M.txt Morse.txt;cp B1.txt Braille.txt
    ./TS B L InB.txt Out2.txt &>> Case2.txt
    rm Morse.txt Braille.txt

    # Case 3
    echo "----- Case 3: Duplicate Morse.txt map, k and m" &> Case3.txt
    cp M2.txt Morse.txt;cp B.txt Braille.txt
    ./TS M L InM.txt Out3.txt &>> Case3.txt
    rm Morse.txt Braille.txt


    # Case 4
    echo "----- Case 4: Invalid Morse string in M->L" &> Case4.txt
    echo "Should get : seven :" &>> Case4.txt
    cp M.txt Morse.txt; cp B.txt Braille.txt
    ./TS M L InM1.txt Out4.txt &>> Case4.txt
    rm Morse.txt Braille.txt

    # Case 5
    echo "----- Case 5: Invalid Braille string in B to L" &> Case5.txt
    echo "Should get : sevey" &>> Case5.txt
    cp M.txt Morse.txt; cp B.txt Braille.txt
    ./TS B L InB1.txt Out5.txt &>> Case5.txt
    rm Morse.txt Braille.txt

    # Case 6
    echo "----- Case 6: Reordered Morse works. Small L to M" &> Case6.txt
    cp M3.txt Morse.txt; cp B.txt Braille.txt
    ./TS L M InL.txt Out6.txt &>> Case6.txt
    rm Morse.txt Braille.txt

    # Case 7
    echo "----- Case 7: Morse to Braille case" &> Case7.txt
    cp M.txt Morse.txt; cp B.txt Braille.txt
    ./TS M B InM2.txt Out7.txt &>> Case7.txt

    # Case 8
    echo "----- Case 8: Consistency: Braille back to Morse" &> Case8.txt
    ./TS B M Out7.txt Out8.txt &>> Case8.txt

    echo "Report on differences: " &>> Case8.txt
    diff Out8.txt InM2.txt &>> Case8.txt

    # Case 9
    echo "----- Case 9: Common Latin to Morse" &> Case 9.txt
    ./TS L M InL.txt Out9.txt &>> Case9.txt

