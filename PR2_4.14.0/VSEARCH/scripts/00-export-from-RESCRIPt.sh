#!/bin/bash -i
conda activate qiime2-2022.8
qiime tools export --input-path ../qiime2/pr2_version_4.14.0_SSU-seqs-derep-uniq.qza  --output-path exported-fasta
