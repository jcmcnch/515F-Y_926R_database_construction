#!/bin/bash -i
conda activate qiime2-2022.8
mamba install -c conda-forge -c bioconda -c qiime2 -c defaults xmltodict
pip install git+https://github.com/bokulich-lab/RESCRIPt.git
qiime dev refresh-cache
qiime --help
