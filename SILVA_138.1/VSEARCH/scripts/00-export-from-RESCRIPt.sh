#!/bin/bash -i
conda activate qiime2-2022.8
qiime tools export --input-path ../qiime2/silva-138.1-ssu-nr99-tax-derep-uniq.qza --output-path exported-taxonomy
qiime tools export --input-path ../qiime2/silva-138.1-ssu-nr99-seqs-derep-uniq.qza --output-path exported-fasta
