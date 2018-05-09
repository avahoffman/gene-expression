#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=GOannot
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG

#  GOassign.sh
#  
#
#  Created by Ava Hoffman on 5/5/16.
#

export PATH=$PATH:~/rnaseq/Trinotate-3.0.1
export PATH=$PATH:~/rnaseq/trinityrnaseq-2.1.1/

#install GOseq
#R
#source("http://bioconductor.org/biocLite.R")
#biocLite('goseq')

#extract GO assignments per gene
#~/rnaseq/Trinotate-3.0.1/util/extract_GO_assignments_from_Trinotate_xls.pl --Trinotate_xls ~/rnaseq/andro/Trinotate/trinotate_annotation_report_andro.xls -T --include_ancestral_terms > go_annotations_andro.txt

#~/rnaseq/Trinotate-3.0.1/util/extract_GO_assignments_from_Trinotate_xls.pl --Trinotate_xls ~/rnaseq/sorgh/Trinotate/trinotate_annotation_report_sorgh.xls -T --include_ancestral_terms > go_annotations_sorgh.txt

#make description files
#cat ~/rnaseq/andro/RSEM/adr7.isoforms.results  | cut -f 1,3 > andro.genes.lengths.txt
#cat ~/rnaseq/andro/RSEM/adr7.isoforms.results  | cut -f 1 > andro.genes.txt
#cat ~/rnaseq/sorgh/RSEM/sdr7.isoforms.results  | cut -f 1,3 > sorgh.genes.lengths.txt
#cat ~/rnaseq/sorgh/RSEM/sdr7.isoforms.results  | cut -f 1 > sorgh.genes.txt

#run assignment using GOseq. First, highly expressed on average across all samples

#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_GOseq.pl --factor_labeling factor_andro_highlo.txt --GO_assignments go_annotations_andro.txt --lengths andro.genes.lengths.txt

#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_GOseq.pl --factor_labeling factor_sorgh_highlo.txt --GO_assignments go_annotations_sorgh.txt --lengths sorgh.genes.lengths.txt

#highly expressed in drt (top 400 ranked by avg drt TMM)

~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_GOseq.pl --factor_labeling factor_andro_drt_highly_expressed.txt --GO_assignments go_annotations_andro.txt --lengths andro.genes.lengths.txt

~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_GOseq.pl --factor_labeling factor_sorgh_dr_highly_expressed.txt --GO_assignments go_annotations_sorgh.txt --lengths sorgh.genes.lengths.txt

#highly expressed in ww (top 400 ranked by avg ww TMM)

~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_GOseq.pl --factor_labeling factor_andro_ww_highly_expressed.txt --GO_assignments go_annotations_andro.txt --lengths andro.genes.lengths.txt

~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/run_GOseq.pl --factor_labeling factor_sorgh_ww_highly_expressed.txt --GO_assignments go_annotations_sorgh.txt --lengths sorgh.genes.lengths.txt