#!/bin/bash -i
conda activate qiime2-2022.8

qiime rescript dereplicate \
    --i-sequences pr2_version_4.14.0_SSU-seqs-515FY-926R.qza \
    --i-taxa pr2_version_4.14.0_SSU-tax-derep-uniq.qza \
    --p-rank-handles 'silva' \
    --p-mode 'uniq' \
    --o-dereplicated-sequences pr2_version_4.14.0_SSU-seqs-515FY-926R-uniq.qza \
    --o-dereplicated-taxa  pr2_version_4.14.0_SSU-tax-515FY-926R-derep-uniq.qza

qiime feature-classifier fit-classifier-naive-bayes \
    --i-reference-reads pr2_version_4.14.0_SSU-seqs-515FY-926R-uniq.qza \
    --i-reference-taxonomy pr2_version_4.14.0_SSU-tax-515FY-926R-derep-uniq.qza \
    --o-classifier pr2_version_4.14.0_SSU-515FY-926R-classifier.qza
