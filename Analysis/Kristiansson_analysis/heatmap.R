library(reshape)
library(ggplot2)




df=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/Kristiansson_analysis/SxE.csv")
head(df)
df=df[,c(2,17:24,27)]
colnames(df)=c("Group","Ad1","Ad2","Aw1","Aw2","Sd1","Sd2","Sw1","Sw2","tf")
labels=df[,1]
tfs=df[,10]
m1=as.matrix(df[,2:9])
m1=log2(m1+0.001)
m1 = t(scale(t(m1), scale=F))
order1 <- hclust( dist(m1, method = "euclidean"), method = "ward.D" )$order
df1=as.data.frame(m1)
df2=cbind(labels,df1,tfs) #reattach names
df2$labels=factor(df2$labels, levels = (df2$labels)[order1] )
df3=melt(df2)

#pdf(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/SxE-heatmap.pdf",height=10,width=4)
pdf(file="/Users/avahoffman/Documents/CSU/Research/Shenghua_Data_Manuscripts/RNA-seq/MER-resubmit/FIGURE_5.pdf",height=9,width=3.14961)
ggplot(df3, aes(variable, labels)) + 
  theme_classic() +
  geom_tile(aes(fill = value), colour = "black") + 
  scale_fill_gradient2(low = "red", mid="black",high = "green",name="Log2 TMM \n(centered) ") +
  theme(axis.text.y = element_text(size=7.7, face = df3$tfs[order1]))+
  theme(axis.text.x = element_text(angle=30,hjust=1))+
  ylab("Gene group") + 
  xlab("") +
  theme(legend.position = c(0.25, -0.07), legend.direction = "horizontal") +
  theme(axis.ticks.length=unit(0,"cm")) +
  theme(plot.margin=unit(c(0.2,0.2,1.7,0.2), "cm"))
dev.off()

