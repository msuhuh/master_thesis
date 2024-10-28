############## LOAD PACKAGES & LIBRARIES #################
library(GenomicRanges)
library(Biostrings)


############## GET COMMAND-LINE ARGUMENTS #################
args <- commandArgs(trailingOnly = TRUE) 
LTR_vs_TRIM28_file <- args[1] 
assembly_file <- args[2] 
out_file <- args[3]


############## LOAD & MANAGE FILES ################
load(file = LTR_vs_TRIM28_file) 

hg38_assembly <- readDNAStringSet(assembly_file, format = "fasta")


############### FILTER SEQNAMES ##################
seqlevels(hg38_LTR_vs_TRIM28) <- sub("^chr", "", seqlevels(hg38_LTR_vs_TRIM28)) 

filt_hg38_LTR_vs_TRIM28 <- hg38_LTR_vs_TRIM28[seqnames(hg38_LTR_vs_TRIM28) %in% c(1:23,"X")] 

chr_names <- seqnames(filt_hg38_LTR_vs_TRIM28)

valid_assembly_header <- grepl("^NC_", names(hg38_assembly)) & grepl("chromosome [0-9XY]+", names(hg38_assembly))
hg38_assembly <- hg38_assembly[valid_assembly_header]
names(hg38_assembly) <- sub(".*chromosome ([0-9XY]+).*", "\\1", names(hg38_assembly))


############### EXTEND EACH MIDPEAK  UPSTREAM & DOWNSTREAM ###################
extended_hg38_LTR_vs_TRIM28 <- GRanges(seqnames = filt_hg38_LTR_vs_TRIM28@seqnames, ranges = IRanges(start = mid(filt_hg38_LTR_vs_TRIM28)-50, end = mid(filt_hg38_LTR_vs_TRIM28)+50))
mcols(extended_hg38_LTR_vs_TRIM28) <- mcols(filt_hg38_LTR_vs_TRIM28)

filt_hg38_LTR_vs_TRIM28
mid(filt_hg38_LTR_vs_TRIM28)
extended_hg38_LTR_vs_TRIM28


############### GET SEQUENCES FOR EXTENDED RANGES ####################
sequences <- hg38_assembly[extended_hg38_LTR_vs_TRIM28]


############### MANAGE DATA & SAVE FILE #####################
names(sequences) <- paste0("chr-", seqnames(extended_hg38_LTR_vs_TRIM28), "_ps:", start(extended_hg38_LTR_vs_TRIM28), "-", end(extended_hg38_LTR_vs_TRIM28), "_mx_c:", mcols(extended_hg38_LTR_vs_TRIM28)$max_cons)


writeXStringSet(sequences, filepath = out_file)
