#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=bttest
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG


#  bowtie_TEST_forRSEM.sh
#  
#
#  Created by Ava Hoffman on 4/11/16.
#
export PATH=$PATH:~/rnaseq/bowtie2-2.2.7
export PATH=$PATH:~/rnaseq/samtools

#build ref
#wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.7/bowtie2-2.2.7-linux-x86_64.zip
#unzip bowtie2-2.2.7-linux-x86_64.zip
bowtie2-build ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta andro-bowtie2ref

#realign
#takes 1hr.
echo "no local"
bowtie2 --very-sensitive --dovetail -p 800 -x andro-bowtie2ref -1 ~/rnaseq/andro/TrmPr1_A_DR8_s_5_1_sequence.txt -2 ~/rnaseq/andro/TrmPr2_A_DR8_s_5_2_sequence.txt -S nolocaladr8.sam
echo "no dovetail"
bowtie2 --very-sensitive-local -p 800 -x andro-bowtie2ref -1 ~/rnaseq/andro/TrmPr1_A_DR8_s_5_1_sequence.txt -2 ~/rnaseq/andro/TrmPr2_A_DR8_s_5_2_sequence.txt -S nodovetailadr8.sam
echo "no dovetail or local"
bowtie2 --very-sensitive -p 800 -x andro-bowtie2ref -1 ~/rnaseq/andro/TrmPr1_A_DR8_s_5_1_sequence.txt -2 ~/rnaseq/andro/TrmPr2_A_DR8_s_5_2_sequence.txt -S nodovetailorlocaladr8.sam