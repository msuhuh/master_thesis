############## LOAD PACKAGES & LIBRARIES #################
library(GenomicRanges)


############## GET COMMAND-LINE ARGUMENTS #################
args <- commandArgs(trailingOnly = TRUE) 
LTR_vs_phyloP_file <- args[1] 
out_file <- args[2]


############## LOAD, MANAGE & CONVERT FILE ################
load(file = LTR_vs_phyloP_file)
seqlevels(hg38_LTR_GR) <- sub("^chr", "", seqlevels(hg38_LTR_GR))

bed_data <- data.frame(seqnames = as.character(seqnames(hg38_LTR_GR)), start = start(hg38_LTR_GR), end = end(hg38_LTR_GR))

write.table(bed_data, out_file, quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)
