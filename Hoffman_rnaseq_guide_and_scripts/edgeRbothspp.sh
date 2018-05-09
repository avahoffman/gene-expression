#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=edgeRall
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOGmay13
#SBATCH --output=OUTLOGmay13

#  edgeR.sh
#
#
#  Created by Ava Hoffman on 5/13/16.
#

export PATH=$PATH:~/rnaseq/trinityrnaseq-2.1.1

#R
#source("http://bioconductor.org/biocLite.R")
#biocLite('edgeR')
#biocLite('ctc')
#biocLite('Biobase')
#biocLite('gplots')
#biocLite('ape')


#~/scratch_dir/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix ~/scratch_dir/bothspp/counts.matrix --method edgeR --samples_file samples_described.txt --contrasts contrasts.txt

#navigate into other dir for part 2
#had some issues. Had to rename matrix.counts.matrix as counts.matrix. Something to do with Trinity's automatically generated metadata

#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ~/rnaseq/bothspp/TMM.EXPR.matrix -P 1e-2 -C 1 --samples ~/rnaseq/bothspp/samples_described.txt

~/scratch_dir/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ~/scratch_dir/bothspp/TMM.EXPR.txt -P 5e-2 -C 1 --samples ~/scratch_dir/bothspp/samples_described.txt --examine_GO_enrichment --GO_annots ~/scratch_dir/bothspp/go_annots_all.txt --gene_lengths ~/scratch_dir/bothspp/lengths_all.txt