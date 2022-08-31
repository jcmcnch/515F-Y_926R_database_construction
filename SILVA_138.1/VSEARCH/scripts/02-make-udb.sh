#!/bin/bash -i
conda activate vsearch-env
vsearch --makeudb_usearch 220830_SILVA138.1_VSEARCH-formatted.fasta --output 220830_SILVA138.1_VSEARCH-formatted.udb
