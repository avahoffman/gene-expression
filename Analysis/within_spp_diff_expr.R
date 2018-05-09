library(ggplot2)
library(cowplot)
library(reshape2)
library(grid)
library(gridExtra)

rm(list=ls())
dev.off()

adata=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/within_species_diffs/diffexpwithinsppANGE.csv")
head(adata)
adata=adata[!(adata$label=="unknown"),];
colnames(adata)=c("id","d1","d2","w1","w2","label","col")

# amatrix=as.matrix(adata[,1:4])
# amatrix2=log2(amatrix+.001)
# amatrix2 = t(scale(t(amatrix2), scale=F))
# adata2=as.data.frame(amatrix2)
#paste centered data in excel. can't get it to behave otherwise >:(

adata2=melt(adata)
labs = factor(adata2$id, levels = unique(adata2$id))

p_1=ggplot(adata2, aes( variable, labs)) + 
  geom_tile(aes(fill = value), colour = "black") + 
  scale_fill_gradient2(low = "red", mid="black",high = "green",name="Log2 \nfold \nchange ", limits=c(-11.4,13.2)) +
  ggtitle(expression(paste(italic("Andropogon gerardii")))) +
  scale_y_discrete(labels=as.character(adata2$label)) +
  theme_classic() +
  ylab("Transcript") + 
  xlab("") +
  theme(legend.position="none") +
  theme(axis.ticks.length=unit(0,"cm")) +
  theme(axis.text.y = element_text(face = adata2$col)) +
  theme(plot.title = element_text(hjust = 2.5, vjust=0))





sdata=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/within_species_diffs/diffexpwithinsppSONU.csv")
head(sdata)
sdata=sdata[!(sdata$label=="unknown"),];
colnames(sdata)=c("id","d1","d2","w1","w2","label","col")
sdata2=melt(sdata)
labs2 = factor(sdata2$id, levels = unique(sdata2$id))

p_2=ggplot(sdata2, aes( variable, labs2)) + 
  geom_tile(aes(fill = value), colour = "black") + 
  scale_fill_gradient2(low = "red", mid="black",high = "green",name="Log2 TMM \n(centered) ", limits=c(-11.4,13.2)) +
  ggtitle(expression(paste(italic("Sorghastrum nutans")))) +
  scale_y_discrete(labels=as.character(sdata2$label)) +
  theme_classic() +
  ylab("") + 
  xlab("") +
  theme(legend.position="none")+
  theme(axis.ticks.length=unit(0,"cm"))+
  theme(axis.text.y = element_text(face = sdata2$col)) +
  theme(plot.title = element_text(hjust = 2.5, vjust=0))


#pdf(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/within_species_diffs//heatmap_w_gene_names.pdf",height=10,width=8)
#use plot_grid to give A and B for publication
grid=plot_grid( p_1,p_2,
                #align = 'vh',
                labels = c("A", "B"),
                label_size=35,
                hjust = -0.5,
                nrow = 1,
                rel_widths=c(1,1) #adjust to make sure heatmaps are approximately same width
)
grobs=ggplotGrob(p_2 + theme(legend.position="bottom"))$grobs
legend=grobs[[which(sapply(grobs, function(x) x$name) == "guide-box")]]
#add legend
dev.off()
pdf(file="/Users/avahoffman/Documents/CSU/Research/Shenghua_Data_Manuscripts/RNA-seq/MER-resubmit/FIGURE_1.pdf",height=9,width=7.08661)
plot_grid(grid, legend, ncol = 1, rel_heights = c(1, .05)) 
dev.off()

  