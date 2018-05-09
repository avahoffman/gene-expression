



#cluster ange and sorg by gene and min p value
ange=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/all_genes_cross_species_andro_tmm.csv")
ange$count=1
head(ange,100)
str(ange)
min.pval.pergene=aggregate( cbind(p.value) ~ gene, FUN=min, data=ange)
count.pergene=aggregate( cbind(count) ~ gene, FUN=sum, data=ange)
head(min.pval.pergene,50)
head(count.pergene,50)
ange_data=cbind(min.pval.pergene,count.pergene)
ange_data$spp='ange'
ange_data=ange_data[,c(1,2,4,5)]
#write.csv(ange_data,file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/ange_paralogs.csv")

sorg=read.csv("/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/all_genes_cross_species_sorgh_tmm.csv")
head(sorg,100)
sorg$count=1
str(sorg)
min.pval.pergene=aggregate( cbind(p.value) ~ gene, FUN=min, data=sorg)
count.pergene=aggregate( cbind(count) ~ gene, FUN=sum, data=sorg)
head(min.pval.pergene,50)
head(count.pergene,50)
nrow(min.pval.pergene);nrow(count.pergene)
sorg_data=cbind(min.pval.pergene,count.pergene)
sorg_data$spp='sorg'
sorg_data=sorg_data[,c(1,2,4,5)]
#write.csv(sorg_data,file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/sorg_paralogs.csv")



#each gene on a line
all_data=rbind(ange_data,sorg_data)
nrow(all_data)
test_data=all_data[c(1:200,19590:19790),]
reshaped_data <- reshape(all_data, 
             timevar = "spp",
             idvar = c("gene"),
             direction = "wide")
write.table(reshaped_data,file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/all_paralogs.txt")





#want to take an average after all for heatmap..
avg.pergene=aggregate( cbind(adr7,adr8,aww7,aww8) ~ gene, FUN=mean, data=ange)
write.csv(avg.pergene,file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/andro_mean_exp.csv")
avg.pergene=aggregate( cbind(dr7,dr8,ww8,ww9) ~ gene, FUN=mean, data=sorg)
write.csv(avg.pergene,file="/Users/avahoffman/Documents/CSU/Research/RNASEQDATA/Kristiansson_analysis/sorgh_mean_exp.csv")
