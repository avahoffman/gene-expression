#TROM.R

library(TROM)
library(lattice)
library(gplots)
library(RColorBrewer)
library(gtools)
library(openxlsx)
library(topGO)
library(GO.db)


#andro_data=read.table("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/TROM/matrix.TMM.EXPR.andro.txt",header=T)
setwd("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/TROM/")
#save(andro_data, file="andro_data.rda")
#sorgh_data=read.table("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/TROM/matrix.TMM.EXPR.sorgh.txt",header=T)
#save(sorgh_data, file="sorgh_data.rda")

load("andro_data.rda")

#z_thre1 <- choose.z(andro_data)


andro_associated_genes <- select.associated.genes(
  sp_gene_expr = andro_data,
  z_thre = 0, save = TRUE,
  plot_distribution = TRUE)

dm_trom <- ws.trom(sp_gene_expr = andro_data,
                   z_thre = 1, provide = FALSE,
                   save_overlap_genes = FALSE)

heatmap.3(   dm_trom,
             Rowv = NULL,
             Colv = NULL,
             dendrogram = c("none"),
             distfun = dist,
             hclustfun = hclust,
             xlab = "",
             ylab = "",
             main = "D. melanogaster Stage Mapping",
             key = TRUE,
             keysize = 1,
             trace = "none",
             density.info = c("none"),
             col = terrain.colors(120),
             max_score = 6
)
