#!/bin/bash -i
conda activate qiime2-2022.8

qiime feature-classifier extract-reads \
    --i-sequences pr2_version_4.14.0_SSU-seqs-derep-uniq.qza \
    --p-f-primer GCGGTAATTCCAGCTCCAA \
    --p-r-primer ACTTTCGTTCTTGATYRR \
    --p-n-jobs 2 \
    --p-read-orientation 'forward' \
    --o-reads pr2_version_4.14.0_SSU-seqs-515FY-926R.qza
