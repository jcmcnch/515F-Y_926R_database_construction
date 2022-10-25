#!/bin/bash -i
conda activate qiime2-2022.8

qiime feature-classifier extract-reads \
    --i-sequences silva-138.1-ssu-nr99-seqs-derep-uniq.qza \
    --p-f-primer GCGGTAATTCCAGCTCCAA \
    --p-r-primer ACTTTCGTTCTTGATYRR \
    --p-n-jobs 2 \
    --p-read-orientation 'forward' \
    --o-reads silva-138.1-ssu-nr99-seqs-Wulf.qza
