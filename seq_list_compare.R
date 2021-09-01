rm(list = ls())

get_rc <- function(seq)
{
    seq <- as.character(seq)
    seq_rc <- paste(rev(unlist(strsplit(chartr("ACGT", "TGCA", seq), NULL))), collapse = "")
    return(seq_rc)
}

get_cano <- function(seq)
{
    seq <- as.character(seq)
    seq_rc <- get_rc(seq)
    if (seq < seq_rc)
    {
        return(seq)
    }
    else
    {
        return(seq_rc)
    }
}

args <- commandArgs(trailingOnly = T)
list_path1 <- args[1]
list_path2 <- args[2]
stranded_mode <- args[3]

seq_list1 <- read.table(list_path1, header = F)$V1
seq_list2 <- read.table(list_path2, header = F)$V1

if (stranded_mode == "unstranded")
{
    seq_cano_vect1 <- as.character(lapply(seq_list1, function(x) get_cano(as.character(x))))
    seq_cano_vect2 <- as.character(lapply(seq_list2, function(x) get_cano(as.character(x))))
} else if (stranded_mode == "stranded")
{
    seq_cano_vect1 <- as.character(seq_list1)
    seq_cano_vect2 <- as.character(seq_list2)
} else
{
    stop(paste("unknown stranded mode:", stranded_mode))
}
write.table(setdiff(seq_cano_vect1, seq_cano_vect2), "only_in_list1.list", row.names = F, col.names = F, quote = F)
write.table(setdiff(seq_cano_vect2, seq_cano_vect1), "only_in_list2.list", row.names = F, col.names = F, quote = F)
