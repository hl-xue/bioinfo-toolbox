library(tidyr)
library(ggplot2)

plot_feature_scatter <- function(count_path_1, count_path_2, out_dir, count1_name, count2_name) {
    count.tab1 <- read.table(count_path_1, header = T)
    count.tab1.long <- gather(data = count.tab1, key = "sample", value = count.1, -feature)
    count.tab2 <- read.table(count_path_2, header = T)
    count.tab2.long <- gather(data = count.tab2, key = "sample", value = count.2, -feature)
    count.comp.tab <- merge(count.tab1.long, count.tab2.long, by = c("feature", "sample"))
    count.comp.fit <- count.comp.tab[count.comp.tab$count.1 > 0 & count.comp.tab$count.2 > 0, ]
    pcor <- round(cor(count.comp.fit$count.1, count.comp.fit$count.2, method = "pearson"), 2)
    ggplot() +
        geom_point(data = count.comp.tab, aes(x = count.1 + 1E-6, y = count.2 + 1E-6), alpha = 0.2, size = 0.2) +
        geom_abline(intercept = 0, slope = 1, color = "royalblue", size = 0.75) +
        geom_smooth(data = count.comp.fit, aes(x = count.1 + 1E-6, y = count.2 + 1E-6), 
                    method = "lm", color = "gold3", size = 0.75) +
        geom_text(aes(x = 1e-6, y = 1e9, label = paste0('corr: ', pcor)), size = 6, color = "gold3") +
        scale_x_log10(limits = c(1E-6, 1E9)) +
        scale_y_log10(limits = c(1E-6, 1E9)) +
        xlab(count1_name) +
        ylab(count2_name) +
        theme(text = element_text(size = 15)) +
        ggsave(paste0(out_dir, "/compare.counts.png"), width = 12, height = 6)
}
