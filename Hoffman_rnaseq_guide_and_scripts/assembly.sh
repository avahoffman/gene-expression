#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG

#  assembly.sh
#  
#
#  Created by Ava Hoffman on 4/9/16.
#


export PATH=$PATH:~/rnaseq/trinityrnaseq-2.1.1
export PATH=$PATH:~/rnaseq/trinityrnaseq-2.1.1/Trinity
export PATH=$PATH:~/rnaseq/bowtie-1.1.2

#assembly w Trinity.

~/trinityrnaseq-2.1.1/Trinity --seqType fq --max_memory 60G --left TrmPr1_A_DR7_s_5_1_sequence.txt,TrmPr1_A_DR8_s_5_1_sequence.txt,TrmPr1_A_WW7_s_5_1_sequence.txt,TrmPr1_A_WW8_s_5_1_sequence.txt --right TrmPr2_A_DR7_s_5_2_sequence.txt,TrmPr2_A_DR8_s_5_2_sequence.txt,TrmPr2_A_WW7_s_5_2_sequence.txt,TrmPr2_A_WW8_s_5_2_sequence.txt --CPU 8 --min_contig_length 300 --output Trinity_andro_out --full_cleanup

#For sorgh, below took almost exactly 7 hr

~/rnaseq/trinityrnaseq-2.1.1/Trinity --seqType fq --max_memory 60G --left TrmPr1_S_DR7_s_4_1_sequence.txt,TrmPr1_S_DR8_s_4_1_sequence.txt,TrmPr1_S_WW8_s_4_1_sequence.txt,TrmPr1_S_WW9_s_4_1_sequence.txt --right TrmPr2_S_DR7_s_4_2_sequence.txt,TrmPr2_S_DR8_s_4_2_sequence.txt,TrmPr2_S_WW8_s_4_2_sequence.txt,TrmPr2_S_WW9_s_4_2_sequence.txt --CPU 16 --min_contig_length 300 --output Trinity_sorgh_out --full_cleanup

#stats

~/rnaseq/trinityrnaseq-2.1.1/util/TrinityStats.pl Trinity_andro_out.Trinity.02122016.fasta
~/rnaseq/trinityrnaseq-2.1.1/util/TrinityStats.pl Trinity_sorgh_out.Trinity.fasta

