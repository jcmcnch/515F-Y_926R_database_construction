#!/bin/bash

## This script will create PR2_Euks_only.fasta, Silva138_EUKS_only.fasta, Silva138_PROK_only.fasta
## make sure to change the path of your Silva-138.1-ssu-nr99-tax-515FY-926R-derep-uniq.qza

##1. Prepare PR2 - Remove Prokaryotes
##data
PR2_reads=../PR2_v5/01-QCandextract-Parada-primers/exported-fasta/PR2v5_parada.fasta
PR2_taxonomy=../PR2_v5/01-QCandextract-Parada-primers/exported-taxonomy/PR2v5_parada_taxonomy.tsv

##Extract features from PR2 db that match prokaryotes: Bacteria and Archaea -- keep only Euks
## the feature ID is in the first column of the taxonomy table

## Extract lines that do not contain "Archaea" or "Bacteria" and keep only the first column

grep -Ev "Archaea|Bacteria" $PR2_taxonomy | cut -f1 | tr '\t' ' ' > PR2_Euks.txt

## use seqtk to keep only the sequences not in our exclude list
## install https://github.com/lh3/seqtk
seqtk subseq $PR2_reads PR2_Euks.txt > PR2_EUKS_only.fasta
#or 
#directory_with_seqtk/seqtk subseq $PR2_reads PR2_Euks.txt > PR2_EUKS_only.fasta


##2. Prepare Silva 138 - Split the Eukaryotes and Prokaryotes
conda activate qiime2-amplicon-2024.5 

echo "export"
qiime tools export --input-path silva-138.1-ssu-nr99-tax-515FY-926R-derep-uniq.qza --output-path exported-taxonomy
qiime tools export --input-path silva-138.1-ssu-nr99-seqs-515FY-926R-uniq.qza --output-path exported-fasta

echo "rename the files to something useful"
mv exported-taxonomy/taxonomy.tsv exported-taxonomy/Silva138_parada_taxonomy.tsv
mv exported-fasta/dna-sequences.fasta exported-fasta/Silva138_parada.fasta

SILVA_reads=../Silva138.1/exported-fasta/Silva138_parada.fasta
SILVA_taxonomy=../Silva138.1/exported-taxonomy/Silva138_parada_taxonomy.fasta

##Extract features from Silva138 db that match Eukaryotes - taxonomy is in the fasta header
## Use awk to extract sequences belonging to Eukaryotes

awk '/^>/ {
        if ($0 ~ / Eukaryota;/) {
            print $0
            seq_started = 1
        } else {
            seq_started = 0
        }
    }
    seq_started { print }' $SILVA_reads > Silva138_EUKS_only.fasta

## Use awk to extract sequences belonging to Bacteria or Archaea  
awk '/^>/ {
        if ($0 ~ / Bacteria;/ || $0 ~ / Archaea;/) {
            print $0
            seq_started = 1
        } else {
            seq_started = 0
        }
    }
    seq_started { print }' $SILVA_reads > Silva138_PROK_only.fasta
    
