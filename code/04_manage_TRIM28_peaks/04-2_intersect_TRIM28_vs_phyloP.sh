#!/bin/bash -l
#SBATCH -A naiss2023-22-1038
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 5:00:00
#SBATCH -J misa1224_TRIM28_vs_phyloP
#SBATCH --mail-type=ALL
#SBATCH --mail-user minna.sayehban.1224@student.uu.se


# IMPORT MODULES
module load R_packages


# SET VARIABLES
TRIM28_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/ChIP_seq_data/brattas/GSM2230418_NS_Trim28.peaks.bed"
phyloP_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/zoonomia_data/phyloP/hg38.phyloP447way.above_2.bed"
out_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38_TRIM28_vs_phyloP.RData"
hist_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38_hist_all_cons.pdf"
script="/proj/snic2020-16-24/private/users/minna/master_thesis/code/04_manage_TRIM28_peaks/04-1_intersect_TRIM28_vs_phyloP.R"

# RUN SCRIPT
Rscript "$script" "$TRIM28_file" "$phyloP_file" "$out_file" "$hist_file"
