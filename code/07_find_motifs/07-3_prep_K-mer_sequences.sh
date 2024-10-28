# IMPORT MODULES
module load R_packages


# SET VARIABLES
LTR_vs_TRIM28_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/02_intersected_regions/hg38_LTR_vs_TRIM28.RData"
assembly_file="/proj/snic2020-16-24/private/users/minna/master_thesis/data/zoonomia_data/assembly/GCF_000001405.38_GRCh38.p12_genomic.fna"
out_file="/proj/snic2020-16-24/private/users/minna/master_thesis/analyses/03_K-mer_analysis/prep_seqs_K-mer_analysis_+50.fa"
script="/proj/snic2020-16-24/private/users/minna/master_thesis/code/07_find_motifs/07-2_prep_K-mer_sequences.R"

# RUN SCRIPT
Rscript "$script" "$LTR_vs_TRIM28_file" "$assembly_file" "$out_file"
