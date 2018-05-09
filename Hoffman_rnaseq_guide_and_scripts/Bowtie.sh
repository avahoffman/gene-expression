#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=bt2
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG


#  Bowtie.sh
#  
#
#  Created by Ava Hoffman on 4/9/16.
#

export PATH=$PATH:~/rnaseq/bowtie2-2.2.7
export PATH=$PATH:~/rnaseq/samtools

#build ref
#wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.7/bowtie2-2.2.7-linux-x86_64.zip
#unzip bowtie2-2.2.7-linux-x86_64.zip
bowtie2-build ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta sorgh-bowtie2ref

#realign
#takes 1hr.
bowtie2 --very-sensitive-local --dovetail -p 800 -x sorgh-bowtie2ref -1 ~/rnaseq/sorgh/TrmPr1_S_DR7_s_4_1_sequence.txt -2 ~/rnaseq/sorgh/TrmPr2_S_DR7_s_4_2_sequence.txt -S sorgh_dr7.sam
bowtie2 --very-sensitive-local --dovetail -p 800 -x sorgh-bowtie2ref -1 ~/rnaseq/sorgh/TrmPr1_S_DR8_s_4_1_sequence.txt -2 ~/rnaseq/sorgh/TrmPr2_S_DR8_s_4_2_sequence.txt -S sorgh_dr8.sam
bowtie2 --very-sensitive-local --dovetail -p 800 -x sorgh-bowtie2ref -1 ~/rnaseq/sorgh/TrmPr1_S_WW8_s_4_1_sequence.txt -2 ~/rnaseq/sorgh/TrmPr2_S_WW8_s_4_2_sequence.txt -S sorgh_ww8.sam
bowtie2 --very-sensitive-local --dovetail -p 800 -x sorgh-bowtie2ref -1 ~/rnaseq/sorgh/TrmPr1_S_WW9_s_4_1_sequence.txt -2 ~/rnaseq/sorgh/TrmPr2_S_WW9_s_4_2_sequence.txt -S sorgh_ww9.sam

# git clone git://github.com/samtools/samtools.git
#convert to bam (you lose some detail here..)
samtools view -bS sorgh_dr7.sam > sorgh_dr7.bam
samtools view -bS sorgh_dr8.sam > sorgh_dr8.bam
samtools view -bS sorgh_ww8.sam > sorgh_ww8.bam
samtools view -bS sorgh_ww9.sam > sorgh_ww9.bam
#flagstats
samtools flagstat sorgh_dr7.bam
samtools flagstat sorgh_dr8.bam
samtools flagstat sorgh_ww8.bam
samtools flagstat sorgh_ww9.bam
#stats
samtools stats sorgh_dr7.bam
samtools stats sorgh_dr8.bam
samtools stats sorgh_ww8.bam
samtools stats sorgh_ww9.bam