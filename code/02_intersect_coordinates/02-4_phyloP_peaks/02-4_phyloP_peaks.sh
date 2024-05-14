#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 3-00:00:00
#SBATCH -J misa1224_phyloP_histo
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load python3


# SET VARIABLES
in_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/Zoonomia_alignment/hg38.phyloP447way.bedGraph"
out_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38.phyloP447way.histogram.png"


# RUN SCRIPT
python3 make_phyloP_histogram.py "$in_file" "$out_file"

