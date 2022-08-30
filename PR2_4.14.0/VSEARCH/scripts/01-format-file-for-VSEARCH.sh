#!/bin/bash -i
conda activate bbmap-env

#download UTAX version, which has correct headers
wget https://github.com/pr2database/pr2database/releases/download/v4.14.0/pr2_version_4.14.0_SSU_UTAX.fasta.gz
gunzip pr2_version_4.14.0_SSU_UTAX.fasta.gz

#get IDs after qiime curation, removing the caret character
grep ">" exported-fasta/dna-sequences.fasta | sed 's/>//' > RESCRIPt-curated.ids.txt 

#thank goodness for Brian Bushnell's BBTools which can take a substring match
filterbyname.sh in=pr2_version_4.14.0_SSU_UTAX.fasta substring=t out=220830_PR2-4.14.0_VSEARCH-formatted.fasta names=RESCRIPt-curated.ids.txt
