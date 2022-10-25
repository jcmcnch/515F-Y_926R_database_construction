#!/bin/bash -i
conda activate qiime2-2022.8

qiime rescript dereplicate \
    --i-sequences silva-138.1-ssu-nr99-seqs-Wulf.qza \
    --i-taxa silva-138.1-ssu-nr99-tax-derep-uniq.qza \
    --p-rank-handles 'silva' \
    --p-mode 'uniq' \
    --o-dereplicated-sequences silva-138.1-ssu-nr99-seqs-Wulf-uniq.qza \
    --o-dereplicated-taxa  silva-138.1-ssu-nr99-tax-Wulf-derep-uniq.qza

qiime feature-classifier fit-classifier-naive-bayes \
    --i-reference-reads silva-138.1-ssu-nr99-seqs-Wulf-uniq.qza \
    --i-reference-taxonomy silva-138.1-ssu-nr99-tax-Wulf-derep-uniq.qza \
    --o-classifier silva-138.1-ssu-nr99-Wulf-classifier.qza
