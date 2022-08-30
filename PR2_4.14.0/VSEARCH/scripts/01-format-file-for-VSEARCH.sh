#!/bin/bash -i
conda activate seqtk-env
#conda activate bbmap-env

#download UTAX version, which has correct headers
wget https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_SSU_UTAX.fasta.gz
gunzip pr2_version_4.14.0_SSU_UTAX.fasta.gz

#get IDs after qiime curation, removing the caret character
grep ">" exported-fasta/dna-sequences.fasta | sed 's/>//' > RESCRIPt-curated.ids.txt 

#get full strings from fasta file using grep (slow!)
while read line ; do grep $line pr2_version_4.14.0_SSU_UTAX.fasta ; done < RESCRIPt-curated.ids.txt > matches.txt

#clean up, remove duplicates
sed 's/>//' matches.txt | sort | uniq > matches.uniq.txt

#pull out all fasta sequences using seqtk from UTAX file
seqtk subseq pr2_version_4.14.0_SSU_UTAX.fasta matches.uniq.txt > 220830_PR2-4.14.0_VSEARCH-formatted.fasta

#thank goodness for Brian Bushnell's BBTools which can take a substring match
#filterbyname.sh in=pr2_version_4.14.0_SSU_UTAX.fasta substring=t out=220830_PR2-4.14.0_VSEARCH-formatted.fasta names=RESCRIPt-curated.ids.txt
