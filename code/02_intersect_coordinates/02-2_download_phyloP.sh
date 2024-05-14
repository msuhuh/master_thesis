#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 5:00:00
#SBATCH -J misa1224_download_phyloP
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# SET VARIABLES
out_dir="/proj/snic2020-16-24/private/users/minna/master_thesis/data/Zoonomia_alignment/"


# RUN SCRIPT
wget -P "$out_dir" https://hgdownload.soe.ucsc.edu/goldenPath/hg38/phyloP447way/hg38.phyloP447way.bw
