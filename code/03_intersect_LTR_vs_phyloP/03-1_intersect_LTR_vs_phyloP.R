############## LOAD PACKAGES & LIBRARIES #################
library(GenomicRanges)


############## GET COMMAND-LINE ARGUMENTS #################
args <- commandArgs(trailingOnly = TRUE) 
LTR_file <- args[1] 
phyloP_file <- args[2] 
out_file <- args[3]

print(LTR_file)
print(phyloP_file)
print(out_file)


############## MANAGE FILES #################
hg38_LTR <- read.table(LTR_file, sep = "\t", stringsAsFactors = FALSE)  
hg38_phyloP <- read.table(phyloP_file, sep = "\t", stringsAsFactors = FALSE)


############## CONVERT FILES TO GR MANAGEABLE OBJECTS ###################
hg38_LTR_GR <- GRanges(seqnames = hg38_LTR$V1, ranges = IRanges(start = hg38_LTR$V2, end = hg38_LTR$V3), type = hg38_LTR$V4) 
hg38_phyloP_GR <- GRanges(seqnames = hg38_phyloP$V1, ranges = IRanges(start = hg38_phyloP$V2, end = hg38_phyloP$V3), cons = hg38_phyloP$V4) 


############## FIND INTERSECTION ###################
hg38_LTR_vs_phyloP <- findOverlaps(hg38_LTR_GR, hg38_phyloP_GR) 
 
hg38_LTR_GR[hg38_LTR_vs_phyloP@from[1]] 
hg38_phyloP_GR[hg38_LTR_vs_phyloP@to[1]] 

tmp_cons_df = data.frame( ERV_idx = hg38_LTR_vs_phyloP@from, cons = hg38_phyloP_GR$cons[hg38_LTR_vs_phyloP@to]) 
cons_agg <- aggregate(cons~ERV_idx, data = tmp_cons_df, FUN = "max") 
hg38_LTR_GR$max_cons <- NA 
hg38_LTR_GR$max_cons[cons_agg$ERV_idx] <- cons_agg$cons


################ SAVE FILE ###################
save(hg38_LTR_GR, file = out_file)
