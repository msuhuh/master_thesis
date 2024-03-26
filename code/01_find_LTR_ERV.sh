#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J misa1224_find_LTR_human
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load python3


# SET VARIABLES
in_path="/proj/snic2020-16-24/private/users/minna/master_thesis/data/RepeatMasker_data/hg38.fa.out"
in_file="${in_path##*/}"
out_path="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/01_LTR_coordinates/${in_file:: -7}_LTR_coordinates.csv"


# RUN SCRIPT
python3 01_find_LTR_ERV.py "$in_path" "$out_path" 
