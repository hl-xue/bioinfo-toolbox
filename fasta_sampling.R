rm(list = ls())

library(Biostrings)

args <- commandArgs(trailingOnly = T)
fa_to_sample <- args[1]
output_path <- args[2]
min_seq_length <- args[3]
n_sample <- args[4]

print(paste("Fasta to sample:", fa_to_sample))
print(paste("Output path:", output_path))
print(paste("Minimum sequence length:", min_seq_length))
print(paste("Sampling number:", n_sample))

biostr <- readDNAStringSet(fa_to_sample)
biostr <- biostr[width(biostr) > min_seq_length]
ind <- sample(1:length(biostr), size = n_sample, replace = F)
biostr.sel <- biostr[ind]

writeXStringSet(biostr.sel, output_path, width = 20001)
