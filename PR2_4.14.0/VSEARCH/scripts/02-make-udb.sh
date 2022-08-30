#!/bin/bash -i
conda activate vsearch-env
vsearch --makeudb_usearch 220830_PR2-4.14.0_SEARCH-formatted.fasta --output 220830_PR2-4.14.0_VSEARCH-formatted.udb 
