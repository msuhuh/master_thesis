#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 5:00:00
#SBATCH -J misa1224_LTR_vs_TRIM28
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load R_packages


# SET VARIABLES
LTR_cons_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38_LTR_vs_phyloP.RData"
TRIM28_cons_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38_TRIM28_vs_phyloP.RData"
out_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38_LTR_vs_TRIM28.RData"
script="/proj/snic2020-16-24/private/users/minna/master_thesis/code/06_intersect_LTR_vs_TRIM28/06-1_intersect_LTR_vs_TRIM28.R"

# RUN SCRIPT
Rscript "$script" "$LTR_cons_file" "$TRIM28_cons_file" "$out_file"
