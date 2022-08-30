#!/bin/bash -i
conda activate biopython-env
./scripts/190509-make-VSEARCH-formatted-db.py --fasta exported-fasta/dna-sequences.fasta --taxonomy exported-taxonomy/taxonomy.tsv --output 220830_SILVA138.1_VSEARCH-formatted.fasta 
