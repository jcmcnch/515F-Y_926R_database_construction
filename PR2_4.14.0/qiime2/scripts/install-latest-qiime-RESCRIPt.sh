#!/bin/bash -i
conda update conda
wget https://data.qiime2.org/distro/core/qiime2-2022.8-py38-linux-conda.yml
mamba env create -n qiime2-2022.8 --file qiime2-2022.8-py38-linux-conda.yml
# OPTIONAL CLEANUP
rm qiime2-2022.8-py38-linux-conda.yml
conda activate qiime2-2022.8
mamba install -c conda-forge -c bioconda -c qiime2 -c defaults xmltodict
pip install git+https://github.com/bokulich-lab/RESCRIPt.git
qiime dev refresh-cache
qiime --help
