#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=rsem
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG

#  RSEM.sh
#  
#
#  Created by Ava Hoffman on 4/10/16.
#

export PATH=$PATH:~/rnaseq/bowtie2-2.2.7
export PATH=$PATH:~/rnaseq/RSEM-1.2.28
export PATH=$PATH:~/rnaseq/trinityrnaseq-2.1.1

#wget https://github.com/deweylab/RSEM/archive/v1.2.28.tar.gz
#tar -xvf v1.2.28.tar.gz
#cd RSEM-1.2.28
#make

#also need some other R packages
#R
#source("http://bioconductor.org/biocLite.R")
#biocLite("qvalue")N
#biocLite('Biobase')
#q()

#build ref
#~/rnaseq/RSEM-1.2.28/rsem-prepare-reference --bowtie2 ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta andro_ref

#realign
#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/andro/TrmPr1_A_DR7_s_5_1_sequence.txt ~/rnaseq/andro/TrmPr2_A_DR7_s_5_2_sequence.txt andro_ref adr7

#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/andro/TrmPr1_A_DR8_s_5_1_sequence.txt ~/rnaseq/andro/TrmPr2_A_DR8_s_5_2_sequence.txt andro_ref adr8

#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/andro/TrmPr1_A_WW7_s_5_1_sequence.txt ~/rnaseq/andro/TrmPr2_A_WW7_s_5_2_sequence.txt andro_ref aww7

#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/andro/TrmPr1_A_WW8_s_5_1_sequence.txt ~/rnaseq/andro/TrmPr2_A_WW8_s_5_2_sequence.txt andro_ref aww8

#export matrix
#~/rnaseq/trinityrnaseq-2.1.1/util/abundance_estimates_to_matrix.pl --est_method RSEM adr7.isoforms.results adr8.isoforms.results aww7.isoforms.results aww8.isoforms.results

#comparisons
#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/PtR --matrix matrix.counts.matrix --samples samples_described.txt --CPM --log2 --compare_replicates
#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/PtR --matrix matrix.counts.matrix -s samples_described.txt --log2 --sample_cor_matrix
#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/PtR --matrix matrix.TMM.EXPR.matrix -s samples_described.txt --log2 --sample_cor_matrix

#build ref
#~/rnaseq/RSEM-1.2.28/rsem-prepare-reference --bowtie2 ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta sorgh_ref

#realign
#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/sorgh/TrmPr1_S_DR7_s_4_1_sequence.txt ~/rnaseq/sorgh/TrmPr2_S_DR7_s_4_2_sequence.txt sorgh_ref sdr7

#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/sorgh/TrmPr1_S_DR8_s_4_1_sequence.txt ~/rnaseq/sorgh/TrmPr2_S_DR8_s_4_2_sequence.txt sorgh_ref sdr8

#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/sorgh/TrmPr1_S_WW8_s_4_1_sequence.txt ~/rnaseq/sorgh/TrmPr2_S_WW8_s_4_2_sequence.txt sorgh_ref sww8

#~/rnaseq/RSEM-1.2.28/rsem-calculate-expression -p 16 --paired-end --bowtie2 --bowtie2-sensitivity-level very_sensitive --bowtie2-mismatch-rate 0.2 --bowtie2-k 10000 --estimate-rspd --append-names --calc-ci ~/rnaseq/sorgh/TrmPr1_S_WW9_s_4_1_sequence.txt ~/rnaseq/sorgh/TrmPr2_S_WW9_s_4_2_sequence.txt sorgh_ref sww9

#export matrix
#~/rnaseq/trinityrnaseq-2.1.1/util/abundance_estimates_to_matrix.pl --est_method RSEM sdr7.isoforms.results sdr8.isoforms.results sww8.isoforms.results sww9.isoforms.results

#comparisons
#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/PtR --matrix matrix.counts.matrix --samples samples_described.txt --CPM --log2 --compare_replicates
#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/PtR --matrix matrix.counts.matrix -s samples_described.txt --log2 --sample_cor_matrix

#Counting Numbers of Expressed Transcripts or Genes
#~/rnaseq/trinityrnaseq-2.1.1/util/misc/count_matrix_features_given_MIN_TPM_threshold.pl ~/rnaseq/sorgh/RSEM/matrix.TPM.not_cross_norm | tee matrix.TPM.not_cross_norm.counts_by_min_TPM




