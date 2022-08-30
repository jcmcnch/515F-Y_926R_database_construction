#!/usr/bin/env python3

import re
import csv
import sys
from Bio import SeqIO
import argparse

parser = argparse.ArgumentParser(description='This script formats the SILVA db so it can be used with VSEARCH for taxonomy classification.')

parser.add_argument('--fasta', help='Your database in fasta format.')
parser.add_argument('--taxonomy', help='Corresponding taxonomy (7-levels).')
parser.add_argument('--output', help='VSEARCH-formatted output.')

args = parser.parse_args()

hashTax = {}

for astrLine in csv.reader(open(args.taxonomy), csv.excel_tab):

    strVSEARCHformattedtax = ( "tax=" + re.sub("D_\d+__(.+);D_\d+__(.+);D_\d+__(.+);D_\d+__(.+);D_\d+__(.+);D_\d+__(.+);D_\d+__(.+)", "d:\g<1>,p:\g<2>,c:\g<3>,o:\g<4>,f:\g<5>,g:\g<6>,s:\g<7>", astrLine[1].strip() ) ).replace(";",",")

    strVSEARCHheader = ';'.join([astrLine[0].strip(), strVSEARCHformattedtax])

    hashTax[astrLine[0].strip()] = strVSEARCHheader

output_file = open(args.output, "w+")

for record in SeqIO.parse(args.fasta, "fasta"):

    if str(record.id) in hashTax: #Gonna lose some things because NR99 for qiime2 db and NR99 from phyloFLASH are not the same

        newheader = hashTax[record.id]

        output_file.write(">" + newheader + "\n")

        output_file.write(str(record.seq) + "\n")
