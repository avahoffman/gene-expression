factor_labeling = read.table("factor_labeling.txt", row.names=2, header=F)
colnames(factor_labeling) = c('type')
factor_list = unique(factor_labeling[,1])
gene_lengths = read.table("lengths_all.txt", header=T, row.names=1)
gene_lengths = as.matrix(gene_lengths[,1,drop=F])
GO_info = read.table("go_annots_all.txt", header=F, row.names=1,stringsAsFactors=F)
GO_info_listed = apply(GO_info, 1, function(x) unlist(strsplit(x,',')))
names(GO_info_listed) = rownames(GO_info)
features_with_GO = rownames(GO_info)
lengths_features_with_GO = gene_lengths[features_with_GO,]
get_GO_term_descr =  function(x) {
    d = 'none';
    go_info = GOTERM[[x]];
    if (length(go_info) >0) { d = paste(Ontology(go_info), Term(go_info), sep=' ');}
    return(d);
}
# build pwf based on ALL DE features
cat_genes_vec = as.integer(features_with_GO %in% rownames(factor_labeling))
library(goseq)
library(GO.db)
library(qvalue)
pwf=nullp(cat_genes_vec,bias.data=lengths_features_with_GO)
rownames(pwf) = names(GO_info_listed)
for (feature_cat in factor_list) {
   message('Processing category: ', feature_cat)
    cat_genes_vec = as.integer(features_with_GO %in% rownames(factor_labeling)[factor_labeling$type == feature_cat])
    pwf$DEgenes = cat_genes_vec
    res = goseq(pwf,gene2cat=GO_info_listed)
    ## over-represented categories:
     pvals = res$over_represented_pvalue
     pvals[pvals > 1 -1e-10] = 1-1e-10
     q = qvalue(pvals)
     res$over_represented_FDR = q$qvalues
    go_enrich_filename = paste(feature_cat,'.GOseq.enriched', sep='')
    result_table = res[res$over_represented_pvalue<=0.05,]
    descr = unlist(lapply(result_table$category, get_GO_term_descr))
    result_table$go_term = descr;
    write.table(result_table[order(result_table$over_represented_pvalue),], file=go_enrich_filename, sep='	', quote=F, row.names=F)
    ## under-represented categories:
     pvals = res$under_represented_pvalue
     pvals[pvals>1-1e-10] = 1 - 1e-10
     q = qvalue(pvals)
     res$under_represented_FDR = q$qvalues
    go_depleted_filename = paste(feature_cat,'.GOseq.depleted', sep='')
    result_table = res[res$under_represented_pvalue<=0.05,]
    descr = unlist(lapply(result_table$category, get_GO_term_descr))
    result_table$go_term = descr;
    write.table(result_table[order(result_table$under_represented_pvalue),], file=go_depleted_filename, sep='	', quote=F, row.names=F)
}
