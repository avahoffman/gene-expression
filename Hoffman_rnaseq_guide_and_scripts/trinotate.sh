#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=trinotate
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOGmay17
#SBATCH --output=OUTLOGmay17

#  trinotate.sh
#  
#
#  Created by Ava Hoffman on 4/29/16.
#

#http://trinotate.github.io/ for ALL downloads. There are many..

export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+
export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+/bin
export PATH=$PATH:~/rnaseq/Trinotate-3.0.1
export PATH=$PATH:~/rnaseq/TransDecoder-2.1.0
export PATH=$PATH:~/rnaseq/hmmer/binaries
export PATH=$PATH:~/rnaseq/blastdbs
export PATH=$PATH:~/rnaseq/signalp-4.1
export PATH=$PATH:~/rnaseq/chlorop-1.1
export PATH=$PATH:~/rnaseq/sqlite
export PATH=$PATH:~/rnaseq/tmhmm-2.0c/bin
export PATH=$PATH:~/rnaseq/trinityrnaseq-2.1.1/


#generate pep file, "likely proteins"
#~/rnaseq/TransDecoder-2.1.0/TransDecoder.LongOrfs -t ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta
#~/rnaseq/TransDecoder-2.1.0/TransDecoder.Predict -t ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta

# search Trinity transcripts
#blastx -query ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta -db ~/rnaseq/blastdbs/uniprot_sprot.pep -num_threads 40 -max_target_seqs 1 -outfmt 6 > blastx.andro.trinotate.outfmt6

# search Transdecoder-predicted proteins
#blastp -query ~/rnaseq/andro/Trinotate/Trinity_andro_out.Trinity.02122016.fasta.transdecoder.pep -db ~/rnaseq/blastdbs/uniprot_sprot.pep -num_threads 40 -max_target_seqs 1 -outfmt 6 > blastp.andro.trinotate.outfmt6

#HMMER identifies protein domains
#~/rnaseq/hmmer/binaries/hmmscan --cpu 16 --domtblout TrinotatePFAMandro.out ~/rnaseq/blastdbs/Pfam-A.hmm ~/rnaseq/andro/Trinotate/Trinity_andro_out.Trinity.02122016.fasta.transdecoder.pep > pfam.log

#SignalP predicts signal peptide cleavage sites
#~/rnaseq/signalp-4.1/signalp -f short -n signalp.andro.out ~/rnaseq/andro/Trinotate/Trinity_andro_out.Trinity.02122016.fasta.transdecoder.pep

#predict transmembrane helices in proteins
#~/rnaseq/tmhmm-2.0c/bin/tmhmm --short < ~/rnaseq/andro/Trinotate/Trinity_andro_out.Trinity.02122016.fasta.transdecoder.pep > tmhmm.andro.out

#predict chloroplast stuff
~/rnaseq/chlorop-1.1/chlorop -F ~/rnaseq/andro/Trinotate/Trinity_andro_out.Trinity.02122016.fasta.transdecoder.pep > chlorop.andro.out

#run Trinotate

#~/rnaseq/trinityrnaseq-2.1.1/util/support_scripts/get_Trinity_gene_to_trans_map.pl ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta > Trinity.fasta.andro.gene_trans_map
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite init --gene_trans_map ~/rnaseq/andro/Trinotate/Trinity.fasta.andro.gene_trans_map --transcript_fasta ~/rnaseq/andro/Trinity_andro_out.Trinity.02122016.fasta --transdecoder_pep ~/rnaseq/andro/Trinotate/Trinity_andro_out.Trinity.02122016.fasta.transdecoder.pep
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_swissprot_blastp ~/rnaseq/andro/Trinotate/blastp.andro.trinotate.outfmt6
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_swissprot_blastx ~/rnaseq/andro/Trinotate/blastx.andro.trinotate.outfmt6
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_pfam ~/rnaseq/andro/Trinotate/TrinotatePFAMandro.out
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_tmhmm ~/rnaseq/andro/Trinotate/tmhmm.andro.out
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_signalp ~/rnaseq/andro/Trinotate/signalp.andro.out
~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_signalp ~/rnaseq/andro/Trinotate/chlorop.andro.out
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite report > trinotate_annotation_report_andro.xls

#~/rnaseq/Trinotate-3.0.1/util/Trinotate_get_feature_name_encoding_attributes.pl ~/rnaseq/andro/Trinotate/trinotate_annotation_report_andro.xls  > annot_feature_map_andro.txt
#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/rename_matrix_feature_identifiers.pl ~/rnaseq/andro/RSEM/counts.matrix ~/rnaseq/andro/Trinotate/annot_feature_map_andro.txt > ANDRO.counts.wAnnot.matrix
#~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/rename_matrix_feature_identifiers.pl ~/rnaseq/andro/RSEM/TMM.EXPR.matrix ~/rnaseq/andro/Trinotate/annot_feature_map_andro.txt > ANDRO.TMM.EXPR.wAnnot.matrix

#generate pep file, "likely proteins"
#~/rnaseq/TransDecoder-2.1.0/TransDecoder.LongOrfs -t ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta
#~/rnaseq/TransDecoder-2.1.0/TransDecoder.Predict -t ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta

#search Trinity transcripts
#blastx -query ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta -db ~/rnaseq/blastdbs/uniprot_sprot.pep -num_threads 40 -max_target_seqs 1 -outfmt 6 > blastx.sorgh.trinotate.outfmt6

# search Transdecoder-predicted proteins
#blastp -query ~/rnaseq/sorgh/Trinotate/Trinity_sorgh_out.Trinity.fasta.transdecoder.pep -db ~/rnaseq/blastdbs/uniprot_sprot.pep -num_threads 40 -max_target_seqs 1 -outfmt 6 > blastp.sorgh.trinotate.outfmt6

#HMMER identifies protein domains
#~/rnaseq/hmmer/binaries/hmmscan --cpu 16 --domtblout TrinotatePFAMsorgh.out ~/rnaseq/blastdbs/Pfam-A.hmm ~/rnaseq/sorgh/Trinotate/Trinity_sorgh_out.Trinity.fasta.transdecoder.pep > pfam.log

#SignalP predicts signal peptide cleavage sites
#~/rnaseq/signalp-4.1/signalp -f short -n signalp.sorgh.out ~/rnaseq/sorgh/Trinotate/Trinity_sorgh_out.Trinity.fasta.transdecoder.pep

#predict transmembrane helices in proteins
#~/rnaseq/tmhmm-2.0c/bin/tmhmm --short < ~/rnaseq/sorgh/Trinotate/Trinity_sorgh_out.Trinity.fasta.transdecoder.pep > tmhmm.sorgh.out

#run Trinotate
#~/rnaseq/Trinotate-3.0.1/Trinotate init --gene_trans_map <file> --transcript_fasta <file> --transdecoder_pep ~/rnaseq/andro/Trinotate/Trinity_andro_out.Trinity.02122016.fasta.transdecoder.pep
#~/rnaseq/trinityrnaseq-2.1.1/util/support_scripts/get_Trinity_gene_to_trans_map.pl ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta > Trinity.fasta.sorgh.gene_trans_map
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite init --gene_trans_map ~/rnaseq/sorgh/Trinotate/Trinity.fasta.sorgh.gene_trans_map --transcript_fasta ~/rnaseq/sorgh/Trinity_sorgh_out.Trinity.fasta --transdecoder_pep ~/rnaseq/sorgh/Trinotate/Trinity_sorgh_out.Trinity.fasta.transdecoder.pep
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_swissprot_blastp ~/rnaseq/sorgh/Trinotate/blastp.sorgh.trinotate.outfmt6
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_swissprot_blastx ~/rnaseq/sorgh/Trinotate/blastx.sorgh.trinotate.outfmt6
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_pfam ~/rnaseq/sorgh/Trinotate/TrinotatePFAMsorgh.out
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_tmhmm ~/rnaseq/sorgh/Trinotate/tmhmm.sorgh.out
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite LOAD_signalp ~/rnaseq/sorgh/Trinotate/signalp.sorgh.out
#~/rnaseq/Trinotate-3.0.1/Trinotate ~/rnaseq/Trinotate.sqlite report > trinotate_annotation_report_sorgh.xls





~/rnaseq/Trinotate-3.0.1/util/Trinotate_get_feature_name_encoding_attributes.pl ~/rnaseq/sorgh/Trinotate/trinotate_annotation_report_sorgh.xls  > annot_feature_map_sorgh.txt
~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/rename_matrix_feature_identifiers.pl ~/rnaseq/sorgh/RSEM/counts.matrix ~/rnaseq/sorgh/Trinotate/annot_feature_map_sorgh.txt > SORGH.counts.wAnnot.matrix
~/rnaseq/trinityrnaseq-2.1.1/Analysis/DifferentialExpression/rename_matrix_feature_identifiers.pl ~/rnaseq/sorgh/RSEM/TMM.EXPR.matrix ~/rnaseq/sorgh/Trinotate/annot_feature_map_sorgh.txt > SORGH.TMM.EXPR.wAnnot.matrix
