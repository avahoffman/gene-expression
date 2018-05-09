#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=blast
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG

#  blast_redo.sh
#
#
#  Created by Ava Hoffman on 5/9/16.
#

export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+
export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+/bin

# FYI: e-value of -20 means looking for semi-closely related species. More distant homology should use ~ -10. Note, the next step takes a long time!!

#blastx -query ~/rnaseq/andro/blast_redo/andro_reblasted.txt -db ~/rnaseq/blastdbs/uniprot_swissprot.fasta -out blastx.sprot.andro.outfmt6 -evalue 1e-5 -num_threads 40 -max_target_seqs 5 -outfmt 6

#blastx -query ~/rnaseq/andro/blast_redo/andro_reblasted.txt -db ~/rnaseq/blastdbs/uniprot_trembl.fasta -out blastx.trembl.andro.outfmt6 -evalue 1e-5 -num_threads 40 -max_target_seqs 5 -outfmt 6

#~/rnaseq/trinityrnaseq-2.1.1/util/analyze_blastPlus_topHit_coverage.pl blastx.sprot.andro.outfmt6 ~/rnaseq/andro/blast_redo/andro_reblasted.txt ~/rnaseq/blastdbs/uniprot_swissprot.fasta

#~/rnaseq/trinityrnaseq-2.1.1/util/analyze_blastPlus_topHit_coverage.pl blastx.trembl.andro.outfmt6 ~/rnaseq/andro/blast_redo/andro_reblasted.txt ~/rnaseq/blastdbs/uniprot_trembl.fasta

blastx -query ~/rnaseq/sorgh/blast_redo/reblast_sorgh.txt -db ~/rnaseq/blastdbs/uniprot_swissprot.fasta -out blastx.sprot.sorgh.outfmt6 -evalue 1e-5 -num_threads 100 -max_target_seqs 3 -outfmt 6

~/rnaseq/trinityrnaseq-2.1.1/util/analyze_blastPlus_topHit_coverage.pl blastx.sprot.sorgh.outfmt6 ~/rnaseq/sorgh/blast_redo/reblast_sorgh.txt ~/rnaseq/blastdbs/uniprot_swissprot.fasta
