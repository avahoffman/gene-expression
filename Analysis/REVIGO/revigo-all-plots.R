##revigo compiliation of plots

A.gerardii=expression(paste(italic("Andropogon gerardii")))
S.nutans=expression(paste(italic("Sorghastrum nutans")))

#pdf(file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/MEC_reanalysis/REVIGO/revigo-all-plots.pdf",height=10,width=15)
#use plot_grid to give A and B for publication
grid=plot_grid( plot1,plot2,plot3,plot4,plot5,plot6,
                #align = 'h',
                #labels = c("A", "B", "C", "D", "E", "F"),
                #label_size=35,
                #hjust = -0.5,
                nrow = 2,
                rel_widths=c(1,1,1), #adjust to make sure heatmaps are approximately same width
                rel_heights=c(1,1) )

grobs=ggplotGrob(plot1 + theme(legend.position="bottom",legend.box.just = "left"))$grobs
legend=grobs[[which(sapply(grobs, function(x) x$name) == "guide-box")]]
#add legend
dev.off()
pdf(file="/Users/avahoffman/Documents/CSU/Research/Shenghua_Data_Manuscripts/RNA-seq/MER-resubmit/FIGURE_3.pdf",height=10,width=14.1732)
plot_grid(grid, legend, ncol = 1, rel_heights = c(1, .17)) 
dev.off()


