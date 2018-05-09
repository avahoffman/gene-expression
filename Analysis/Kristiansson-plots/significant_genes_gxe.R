library(ggplot2)
library(reshape)
library(plyr)
library(cowplot)

A.gerardii=expression(paste(italic("A. gerardii")))
S.nutans=expression(paste(italic("S. nutans")))
#code for determining standard error for graphs.
######
summarySE <- function(data=NULL, measurevar, groupvars=NULL, na.rm=FALSE,
                      conf.interval=.95, .drop=TRUE) {
  require(plyr)
  
  # New version of length which can handle NA's: if na.rm==T, don't count them
  length2 <- function (x, na.rm=FALSE) {
    if (na.rm) sum(!is.na(x))
    else       length(x)
  }
  
  # This does the summary. For each group's data frame, return a vector with
  # N, mean, and sd
  datac <- ddply(data, groupvars, .drop=.drop,
                 .fun = function(xx, col) {
                   c(N    = length2(xx[[col]], na.rm=na.rm),
                     mean = median   (xx[[col]], na.rm=na.rm),
                     sd   = sd     (xx[[col]], na.rm=na.rm)
                   )
                 },
                 measurevar
  )
  
  # Rename the "mean" column    
  datac <- rename(datac, c("mean" = measurevar))
  
  datac$se <- datac$sd / sqrt(datac$N)  # Calculate standard error of the mean
  
  # Confidence interval multiplier for standard error
  # Calculate t-statistic for confidence interval: 
  # e.g., if conf.interval is .95, use .975 (above/below), and use df=N-1
  ciMult <- qt(conf.interval/2 + .5, datac$N-1)
  datac$ci <- datac$se * ciMult
  
  return(datac)
}

min.mean.sd.max <- function(x) {
  r <- c(min(x), mean(x) - sd(x), mean(x), mean(x) + sd(x), max(x))
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

df=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/functional_annotation_clusters_with_Kristiansson/significant\ genes.csv")
df=cbind(df[1:2],log2(df[3:6]+.001),df[7:10]) #transform TMM
df=melt(df,id.vars = c("use","spp","gene","gene.1","annotation","orig.p.val"))

df$trt=ifelse(df$variable == "dr1", "drt", ".")
df$trt=ifelse(df$variable == "dr2", "drt", df$trt)
df$trt=ifelse(df$variable == "w1", "w", df$trt)
df$trt=ifelse(df$variable == "w2", "w", df$trt)

head(df,30)
unique(df$gene.1)

###############
plotrxnorms<-function(gene_selected){
  data=df[(df$gene.1==gene_selected),]
  data=data[(data$use=="y"),]
  #data=data[(data$orig.p.val < 0.1),]
  #data=aggregate( value ~ spp + trt + gene.1 + gene + annotation ,data,FUN=sum)
  sebars=summarySE(data, measurevar="value", groupvars=c("spp","trt","gene.1","annotation"),na.rm=T)
  ggplot(sebars, aes(x=trt, y=value, group=spp, color=spp)) +
    xlab("") + 
    ylab("") +
    ggtitle(sebars$gene.1,sebars$annotation) +
    geom_line(size=1) +
    theme_classic() +
    scale_x_discrete(breaks=c("drt", "w"), labels=c("D", "W")) +
    scale_color_manual(values=c("orangered","royalblue"), guide = guide_legend(title = "Species"), labels=c(A.gerardii,S.nutans)) +
    theme(legend.position="none") +
    geom_errorbar(aes(ymin=value-se, ymax=value+se), width=.1, size=1, position=position_dodge(.01)) +
    theme(plot.margin=unit(c(0,0,0,0), "cm"))

  #print(sebars)
  }

p1=
  plotrxnorms("MSRB1_ORYSJ") + ylab("Log2 TMM") + theme(plot.margin=unit(c(0.2,0,0,0.2), "cm"))
p2=
  plotrxnorms("USPAL_ARATH") + theme(plot.margin=unit(c(0.2,0,0,0), "cm"))
p3=
  plotrxnorms("AFG1_YEAST") + theme(plot.margin=unit(c(0.2,0,0,0), "cm"))
p4=
  plotrxnorms("SALT_ORYSJ") + theme(plot.margin=unit(c(0.2,0,0,0), "cm"))
p5=
  plotrxnorms("NDUS4_ARATH") + theme(plot.margin=unit(c(0.2,0,0,0), "cm"))
p6=
  plotrxnorms("TIL_ARATH") + ylab("Log2 TMM") + theme(plot.margin=unit(c(0,0,0,0.2), "cm"))
p7=
  plotrxnorms("PDI14_ORYSJ")
p8=
  plotrxnorms("MYO17_ARATH")
p9=
  plotrxnorms("CUT1B_ARATH")
p10=
  plotrxnorms("GRPA_MAIZE")


grid=plot_grid( p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,
                align = 'vh',
                nrow = 2,
                rel_widths=c(1,1,1,1,1), #adjust to make sure heatmaps are approximately same width
                rel_heights=c(1,1)
)
grobs=ggplotGrob(p1 + theme(legend.position="bottom", legend.text = element_text(size = 15), legend.title = element_text(size=15)))$grobs
legend=grobs[[which(sapply(grobs, function(x) x$name) == "guide-box")]]
#add legend
#pdf(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/sxe.pdf",height=6.5,width=13)
pdf(file="/Users/avahoffman/Documents/CSU/Research/Shenghua_Data_Manuscripts/RNA-seq/MER-resubmit/FIGURE_7.pdf",height=6,width=14.1732)
plot_grid(grid, legend, ncol = 1, rel_heights = c(1, .1))
dev.off()

