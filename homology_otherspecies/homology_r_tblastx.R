
library(ggplot2)
library(plyr)
library(reshape2)

df1=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/homology_by_gene/homology_r_tblastx.csv")
head(df1)
# df1$ange <- as.numeric(df1$ange)
# df1$song <- as.numeric(df1$sonu)
dfmelt=melt(df1)
final=transform(dfmelt,species = reorder(species, value))

colors=c("orangered","royalblue")

androlabel=expression(paste(italic("Andropogon gerardii")))
sorghlabel=expression(paste(italic("Sorghastrum nutans")))

pdf(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/homology_by_gene/homology_plot_tblastx.pdf",height=5,width=6)
ggplot(final, aes(x=species, y=value, fill=variable)) + 
    geom_bar(stat='identity',position="dodge") + 
  theme_bw() + 
  ylab("\nProtein match with existing transcriptomes (%)") +
  xlab(NULL) +
  theme(legend.title=element_blank()) +
  scale_fill_manual(values=colors, labels=c(androlabel,sorghlabel)) +
  theme(legend.text=element_text(size=12, face="italic"), axis.text.x = element_text(angle=45, hjust=1,face="italic")) +
  theme(legend.position = c(.3, .8)) +
  coord_cartesian(ylim = c(40, 100)) 
dev.off()