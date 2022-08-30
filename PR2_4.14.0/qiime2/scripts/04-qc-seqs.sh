#!/bin/bash -i
conda activate qiime2-2022.8

qiime rescript cull-seqs \
    --i-sequences pr2_version_4.14.0_SSU_mothur.seqs.qza \
    --o-clean-sequences pr2_version_4.14.0_SSU-seqs-cleaned.qza

qiime rescript filter-seqs-length-by-taxon \
    --i-sequences pr2_version_4.14.0_SSU-seqs-cleaned.qza \
    --i-taxonomy pr2_version_4.14.0_SSU-tax.qza \
    --p-labels Archaea Bacteria Eukaryota \
    --p-min-lens 900 1200 1400 \
    --o-filtered-seqs pr2_version_4.14.0_SSU-seqs-filt.qza \
    --o-discarded-seqs pr2_version_4.14.0_SSU-seqs-discard.qza

qiime rescript dereplicate \
    --i-sequences pr2_version_4.14.0_SSU-seqs-filt.qza  \
    --i-taxa pr2_version_4.14.0_SSU-tax.qza \
    --p-rank-handles 'silva' \
    --p-mode 'uniq' \
    --o-dereplicated-sequences pr2_version_4.14.0_SSU-seqs-derep-uniq.qza \
    --o-dereplicated-taxa pr2_version_4.14.0_SSU-tax-derep-uniq.qza
