#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 3-00:00:00
#SBATCH -J misa1224_LTR_vs_phyloP
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load R_packages


# SET VARIABLES
LTR_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/01_LTR_coordinates/hg38_LTR_coordinates.bed"
phyloP_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/zoonomia_data/phyloP/hg38.phyloP447way.above_2.bed"
out_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38_LTR_vs_phyloP.RData"
script="/proj/snic2020-16-24/private/users/minna/master_thesis/code/02_intersect_regions/02-3_intersect_LTR_vs_phyloP/02-3-1_intersect_LTR_vs_phyloP.R"

# RUN SCRIPT
Rscript "$script" "$LTR_file" "$phyloP_file" "$out_file"
