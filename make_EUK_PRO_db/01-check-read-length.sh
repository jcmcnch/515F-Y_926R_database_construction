#!/bin/bash

conda activate bbmap

##3. check the reads lengths to exclude too small or too long
readlength.sh in=PR2_EUKS_only.fasta out=histograms/PR2_EUKS_only.out
readlength.sh in=Silva138_EUKS_only.fasta out=histograms/Silva138_EUKS_hist.out
readlength.sh in=Silva138_PROK_only.fasta out=histograms/Silva138_PROK_hist.out

##based on the histogram output decide cut-oofs

#example cut-offs
# curl -O -J -L https://osf.io/eux4r/download
#mv SILVA_132_and_PR2_EUK.cdhit95pc.fasta histograms/
#readlength.sh in=histograms/SILVA_132_and_PR2_EUK.cdhit95pc.fasta out=histograms/SILVA_132_and_PR2_EUK.cdhit95pc.out

##looked for the max-min length where we had over 100 reads
reformat.sh in=PR2_EUKS_only.fasta out=PR2_EUKS_only_filtered.fasta minlen=200 maxlen=1100
reformat.sh in=Silva138_EUKS_only.fasta out=Silva138_EUKS_only_filtered.fasta minlen=400 maxlen=900
reformat.sh in=Silva138_PROK_only.fasta out=Silva138_PROK_only_filtered.fasta minlen=330 maxlen=560
