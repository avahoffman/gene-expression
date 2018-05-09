#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=blast
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG

#  blast.sh
#  
#
#  Created by Ava Hoffman on 4/9/16.
#

export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+
export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+/bin

#wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.3.0+-x64-linux.tar.gz
#tar zxvpf ncbi-blast-2.3.0+-x64-linux.tar.gz

#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_sprot.fasta.gz
#gunzip uniprot_sprot.fasta.gz


#wget ftp://ftp.uniprot.org/pub/databases/uniprot/current_release/knowledgebase/complete/uniprot_trembl.fasta.gz
#gunzip uniprot_sprot.fasta.gz
#could do the above, but it's a shitload of proteins. So I limited to Euphyllophytes only, which is higher land plants including ferns, gymnosperms, and angiosperms.

#https://en.wikipedia.org/wiki/Embryophyte

#35,215 sequences in my Swiss-prot db (reviewed)
#3,406,188 in my TrEMBL (not reviewed)

makeblastdb -in uniprot_swissprot.fasta -dbtype prot
makeblastdb -in uniprot_trembl.fasta -dbtype prot

# FYI: e-value of -20 means looking for semi-closely related species. More distant homology should use ~ -10. Note, the next step takes a long time!!

blastx -query ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta -db ~/rnaseq/blastdbs/uniprot_swissprot.fasta -out blastx.sprot.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

blastx -query ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta -db ~/rnaseq/blastdbs/uniprot_trembl.fasta -out blastx.trembl.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

blastx -query ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta -db ~/rnaseq/blastdbs/uniprot_swissprot.fasta -out blastx.sprot.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

blastx -query ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta -db ~/rnaseq/blastdbs/uniprot_trembl.fasta -out blastx.trembl.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6


~/rnaseq/trinityrnaseq-2.1.1/util/analyze_blastPlus_topHit_coverage.pl blastx.sprot.andro.outfmt6 ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta uniprot_swissprot.fasta

~/rnaseq/trinityrnaseq-2.1.1/util/analyze_blastPlus_topHit_coverage.pl blastx.trembl.andro.outfmt6 ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta uniprot_trembl.fasta

~/rnaseq/trinityrnaseq-2.1.1/util/analyze_blastPlus_topHit_coverage.pl blastx.sprot.sorgh.outfmt6 ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta uniprot_swissprot.fasta

~/rnaseq/trinityrnaseq-2.1.1/util/analyze_blastPlus_topHit_coverage.pl blastx.trembl.sorgh.outfmt6 ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta uniprot_trembl.fasta
