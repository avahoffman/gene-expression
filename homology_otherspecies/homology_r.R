  
  library(ggplot2)
  library(plyr)
  library(reshape2)
  
  df1=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/homology_by_gene/homology_r.csv")
  head(df1)
  # df1$ange <- as.numeric(df1$ange)
  # df1$song <- as.numeric(df1$sonu)
  dfmelt=melt(df1)
  final=transform(dfmelt,species = reorder(species, value))
  
  colors=c("orangered","royalblue")
  
  androlabel=expression(paste(italic("Andropogon gerardii")))
  sorghlabel=expression(paste(italic("Sorghastrum nutans")))
  
  #pdf(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/homology_by_gene/homology_plot.pdf",height=5,width=6)
  pdf(file="/Users/avahoffman/Documents/CSU/Research/Shenghua_Data_Manuscripts/RNA-seq/MER-resubmit/FIGURE_2.pdf",height=4,width=4)
  ggplot(final, aes(x=species, y=value, fill=variable)) + 
      geom_bar(stat='identity',position="dodge") + 
    theme_bw() + 
    theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
    ylab("Gene match with \nexisting transcriptomes (%)") +
    xlab(NULL) +
    theme(legend.title=element_blank()) +
    scale_fill_manual(values=colors, labels=c(androlabel,sorghlabel)) +
    theme(legend.text=element_text(size=10, face="italic"), axis.text.x = element_text(angle=45, hjust=1,face="italic")) +
    theme(legend.position = c(.3, .85)) +
    coord_cartesian(ylim = c(75, 100)) 
  dev.off()