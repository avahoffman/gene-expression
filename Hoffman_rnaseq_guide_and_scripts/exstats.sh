#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=exstats
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG

#  exstats.sh
#  
#
#  Created by Ava Hoffman on 5/6/16.
#

export PATH=$PATH:~/rnaseq/trinityrnaseq-2.1.1/

~/rnaseq/trinityrnaseq-2.1.1/util/misc/contig_ExN50_statistic.pl ~/rnaseq/sorgh/RSEM/TMM.EXPR.matrix ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta | tee ExN50.stats