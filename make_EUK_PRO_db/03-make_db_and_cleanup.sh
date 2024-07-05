#!/bin/bash -i

conda activate bbmap

#5. Combine the EUKS
cat Silva138_EUKS.cdhit95pc.fasta PR2_EUKS.cdhit95pc.fasta> Silva138_and_PR2v5_EUKS.cdhit95pc.fasta

#6.make database
bbsplit.sh build=1 ref=Silva138_and_PR2v5_EUKS.cdhit95pc.fasta,Silva138_PROK.cdhit95pc.fasta path=EUK_PROK_bbsplit_db

#7. Clean up directory - if wanted 
mkdir intermidiate_files/
mv *filtered* intermidiate_files/
mv *only* intermidiate_files/
mv *clstr* intermidiate_files/
mv PR2_Euks.txt intermidiate_files/
