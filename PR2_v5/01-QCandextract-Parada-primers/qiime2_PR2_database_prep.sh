#!/bin/bash

#script to process the PR2v5.0 database including QC

conda activate qiime2-amplicon-2024.5 
echo "conda activated"

# First import the database
qiime tools import \
  --type 'FeatureData[Sequence]' \
  --input-path 00-prep-raw_PR2_files/pr2_clean.fasta\
  --output-path qiime_objects/pr2.qza

#Then the taxonomy file
qiime tools import \
  --type 'FeatureData[Taxonomy]' \
  --input-format HeaderlessTSVTaxonomyFormat \
  --input-path 00-prep-raw_PR2_files/pr2_headers.txt \
  --output-path qiime_objects/pr2_tax.qza

# modified from https://github.com/jcmcnch/515F-Y_926R_database_construction/blob/main/PR2_4.14.0/qiime2/scripts/01-import-seqs.sh
echo "running cleaning and QC"
qiime rescript cull-seqs \
    --i-sequences qiime_objects/pr2.qza \
    --o-clean-sequences qiime_objects/pr2_version_5_SSU-seqs-cleaned.qza

qiime rescript dereplicate \
    --i-sequences qiime_objects/pr2_version_5_SSU-seqs-cleaned.qza  \
    --i-taxa qiime_objects/pr2_tax.qza \
    --p-rank-handles 'disable'\
    --p-mode 'uniq' \
    --o-dereplicated-sequences qiime_objects/pr2_version_5_SSU-seqs-derep-uniq.qza \
    --o-dereplicated-taxa qiime_objects/pr2_version_5_SSU-tax-derep-uniq.qza

# Use the Parada universal primmers 
# note on cut-offs: https://forum.qiime2.org/t/picking-values-for-p-min-length-and-p-max-length-in-qiime-feature-classifier-extract-reads/20912

echo "extracting reads"
qiime feature-classifier extract-reads \
    --i-sequences qiime_objects/pr2_version_5_SSU-seqs-derep-uniq.qza \
    --p-f-primer GTGYCAGCMGCCGCGGTAA \
    --p-r-primer CCGYCAATTYMTTTRAGTTT \
    --p-min-length 200 \
    --p-read-orientation 'forward' \
    --o-reads qiime_objects/pr2_version_5_SSU-seqs-515FY-926R.qza

echo "dereplicate extracted reads and make classifier"
qiime rescript dereplicate \
    --i-sequences qiime_objects/pr2_version_5_SSU-seqs-515FY-926R.qza \
    --i-taxa qiime_objects/pr2_version_5_SSU-tax-derep-uniq.qza \
    --p-rank-handles 'disable' \
    --p-mode 'uniq' \
    --o-dereplicated-sequences qiime_objects/pr2_version_5_SSU-seqs-515FY-926R-uniq.qza \
    --o-dereplicated-taxa  qiime_objects/pr2_version_5_SSU-tax-515FY-926R-derep-uniq.qza

echo "make classifier needs - 10hrs on high memory cluster"
qiime feature-classifier fit-classifier-naive-bayes \
    --i-reference-reads qiime_objects/pr2_version_5_SSU-seqs-515FY-926R-uniq.qza \
    --i-reference-taxonomy qiime_objects/pr2_version_5_SSU-tax-515FY-926R-derep-uniq.qza \
    --o-classifier qiime_objects/pr2_version_5_SSU-515FY-926R-classifier.qza
  
   
echo "export fasta and taxonomy"
qiime tools export --input-path qiime_objects/pr2_version_5_SSU-tax-515FY-926R-derep-uniq.qza --output-path exported-taxonomy
qiime tools export --input-path qiime_objects/pr2_version_5_SSU-seqs-515FY-926R-uniq.qza --output-path exported-fasta  

echo "making helpful names"
mv exported-taxonomy/taxonomy.tsv exported-taxonomy/PR2v5_parada_taxonomy.tsv
mv exported-fasta/dna-sequences.fasta exported-fasta/PR2v5_parada.fasta  

