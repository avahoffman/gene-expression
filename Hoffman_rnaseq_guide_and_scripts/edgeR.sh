#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=edgeR
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=edgerERRORLOGnov28
#SBATCH --output=edgerOUTLOGnov28

#  edgeR.sh
#  
#
#  Created by Ava Hoffman on 11/28/16.
#

export PATH=$PATH:~/scratch_dir/trinityrnaseq-2.1.1

#R
#source("http://bioconductor.org/biocLite.R")
#biocLite('edgeR')
#biocLite('ctc')
#biocLite('Biobase')
#biocLite('gplots')
#biocLite('qvalue')
#biocLite('goseq')


#~/scratch_dir/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix ~/scratch_dir/andro/counts.matrix --method edgeR --samples_file ~/scratch_dir/andro/samples_described.txt --contrasts ~/scratch_dir/andro/contrasts.txt

#navigate into other dir for part 2
#had some issues. Had to rename matrix.counts.matrix as counts.matrix. Something to do with Trinity's automatically generated metadata

#~/scratch_dir/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ~/scratch_dir/andro/TMM.EXPR.matrix -P 5e-2 -C 1 --samples ~/scratch_dir/andro/samples_described.txt --examine_GO_enrichment --GO_annots ~/scratch_dir/andro/go_annotations_andro.txt --gene_lengths ~/scratch_dir/andro/andro.genes.lengths.txt

#~/scratch_dir/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix ~/scratch_dir/sorgh/counts.matrix --method edgeR --samples_file ~/scratch_dir/sorgh/samples_described.txt --contrasts ~/scratch_dir/sorgh/contrasts.txt

~/scratch_dir/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ~/scratch_dir/sorgh/TMM.EXPR.matrix -P 5e-2 -C 0.5 --samples ~/scratch_dir/sorgh/samples_described.txt --examine_GO_enrichment --GO_annots ~/scratch_dir/sorgh/go_annotations_sorgh.txt --gene_lengths ~/scratch_dir/sorgh/sorgh.genes.lengths.txt