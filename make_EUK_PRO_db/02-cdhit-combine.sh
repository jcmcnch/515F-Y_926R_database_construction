#!/bin/bash

#combine reads on 95% identity to make dabatase smaller

#load env with cdhit -- I used mamba install -c bioconda cd-hit cd-hit-auxtools
conda activate cdhit_env

#4. Combine by 95% identity - ran for 6hrs, 2 nodes, 14 tasks, in bigmem2 - high memory
cd-hit -i PR2_EUKS_only_filtered.fasta -o PR2_EUKS.cdhit95pc.fasta -c 0.95
cd-hit -i Silva138_EUKS_only_filtered.fasta -o Silva138_EUKS.cdhit95pc.fasta -c 0.95
cd-hit -i Silva138_PROK_only_filtered.fasta -o Silva138_PROK.cdhit95pc.fasta -c 0.95
