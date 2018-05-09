#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=hmlgy.4
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG4
#SBATCH --output=OUTLOG4

#  homology.sh
#  
#
#  Created by Ava Hoffman on 4/21/16.
#

export PATH=$PATH:~/scratch_dir/ncbi-blast-2.3.0+
export PATH=$PATH:~/scratch_dir/ncbi-blast-2.3.0+/bin

#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/brachypodium_distachyon/cdna/Brachypodium_distachyon.v1.0.31.cdna.all.fa.gz
#gunzip Brachypodium_distachyon.v1.0.31.cdna.all.fa.gz
#makeblastdb -in Brachypodium_distachyon.v1.0.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Brachypodium_distachyon.v1.0.31.cdna.all.fa -out tblastx.Brachydista.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Brachypodium_distachyon.v1.0.31.cdna.all.fa -out tblastx.Brachydista.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/arabidopsis_thaliana/cdna/Arabidopsis_thaliana.TAIR10.31.cdna.all.fa.gz
#gunzip Arabidopsis_thaliana.TAIR10.31.cdna.all.fa.gz
#makeblastdb -in Arabidopsis_thaliana.TAIR10.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Arabidopsis_thaliana.TAIR10.31.cdna.all.fa -out tblastx.arabidopsisthal.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Arabidopsis_thaliana.TAIR10.31.cdna.all.fa -out tblastx.arabidopsisthal.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-37/fasta/hordeum_vulgare/cdna/Hordeum_vulgare.Hv_IBSC_PGSB_v2.cdna.all.fa.gz
#gunzip Hordeum_vulgare.Hv_IBSC_PGSB_v2.cdna.all.fa.gz
#makeblastdb -in Hordeum_vulgare.Hv_IBSC_PGSB_v2.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Hordeum_vulgare.Hv_IBSC_PGSB_v2.cdna.all.fa -out tblastx.hordeum.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Hordeum_vulgare.Hv_IBSC_PGSB_v2.cdna.all.fa -out tblastx.hordeum.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/leersia_perrieri/cdna/Leersia_perrieri.Lperr_V1.4.31.cdna.all.fa.gz
#gunzip Leersia_perrieri.Lperr_V1.4.31.cdna.all.fa.gz
#makeblastdb -in Leersia_perrieri.Lperr_V1.4.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Leersia_perrieri.Lperr_V1.4.31.cdna.all.fa -out tblastx.leersia.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Leersia_perrieri.Lperr_V1.4.31.cdna.all.fa -out tblastx.leersia.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#
#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/oryza_sativa/cdna/Oryza_sativa.IRGSP-1.0.31.cdna.all.fa.gz
#gunzip Oryza_sativa.IRGSP-1.0.31.cdna.all.fa.gz
#makeblastdb -in Oryza_sativa.IRGSP-1.0.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Oryza_sativa.IRGSP-1.0.31.cdna.all.fa -out tblastx.oryza.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Oryza_sativa.IRGSP-1.0.31.cdna.all.fa -out tblastx.oryza.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#
#
##----
#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/populus_trichocarpa/cdna/Populus_trichocarpa.JGI2.0.31.cdna.all.fa.gz
#gunzip Populus_trichocarpa.JGI2.0.31.cdna.all.fa.gz
#makeblastdb -in Populus_trichocarpa.JGI2.0.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Populus_trichocarpa.JGI2.0.31.cdna.all.fa -out tblastx.populus.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Populus_trichocarpa.JGI2.0.31.cdna.all.fa -out tblastx.populus.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/setaria_italica/cdna/Setaria_italica.JGIv2.0.31.cdna.all.fa.gz
#gunzip Setaria_italica.JGIv2.0.31.cdna.all.fa.gz
#makeblastdb -in Setaria_italica.JGIv2.0.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Setaria_italica.JGIv2.0.31.cdna.all.fa -out tblastx.setaria.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Setaria_italica.JGIv2.0.31.cdna.all.fa -out tblastx.setaria.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/sorghum_bicolor/cdna/Sorghum_bicolor.Sorbi1.31.cdna.all.fa.gz
#gunzip Sorghum_bicolor.Sorbi1.31.cdna.all.fa.gz
#makeblastdb -in Sorghum_bicolor.Sorbi1.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Sorghum_bicolor.Sorbi1.31.cdna.all.fa -out tblastx.sorghum.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Sorghum_bicolor.Sorbi1.31.cdna.all.fa -out tblastx.sorghum.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

wget ftp://ftp.ensemblgenomes.org/pub/plants/release-37/fasta/triticum_aestivum/cdna/Triticum_aestivum.TGACv1.cdna.all.fa.gz
gunzip Triticum_aestivum.TGACv1.cdna.all.fa.gz
makeblastdb -in Triticum_aestivum.TGACv1.cdna.all.fa -dbtype nucl
tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Triticum_aestivum.TGACv1.cdna.all.fa -out tblastx.triticum.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Triticum_aestivum.TGACv1.cdna.all.fa -out tblastx.triticum.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#wget ftp://ftp.ensemblgenomes.org/pub/plants/release-31/fasta/zea_mays/cdna/Zea_mays.AGPv3.31.cdna.all.fa.gz
#gunzip Zea_mays.AGPv3.31.cdna.all.fa.gz
#makeblastdb -in Zea_mays.AGPv3.31.cdna.all.fa -dbtype nucl
#tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Zea_mays.AGPv3.31.cdna.all.fa -out tblastx.maize.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
#tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Zea_mays.AGPv3.31.cdna.all.fa -out tblastx.maize.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#gunzip Pvirgatum_273_v1.1.transcript.fa.gz
makeblastdb -in Pvirgatum_273_v1.1.transcript.fa -dbtype nucl
tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Pvirgatum_273_v1.1.transcript.fa -out tblastx.panicum.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Pvirgatum_273_v1.1.transcript.fa -out tblastx.panicum.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#gunzip Esalsugineum_173_v1.0.transcript.fa.gz
makeblastdb -in Esalsugineum_173_v1.0.transcript.fa -dbtype nucl
tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Esalsugineum_173_v1.0.transcript.fa -out tblastx.Esalsugineum.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Esalsugineum_173_v1.0.transcript.fa -out tblastx.Esalsugineum.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#gunzip Kmarnieriana_309_v1.1.transcript.fa.gz
makeblastdb -in Kmarnieriana_309_v1.1.transcript.fa -dbtype nucl
tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Kmarnieriana_309_v1.1.transcript.fa -out tblastx.Kmarnieriana.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Kmarnieriana_309_v1.1.transcript.fa -out tblastx.Kmarnieriana.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#gunzip Phallii_308_v2.0.transcript.fa.gz
makeblastdb -in Phallii_308_v2.0.transcript.fa -dbtype nucl
tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Phallii_308_v2.0.transcript.fa -out tblastx.phallii.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Phallii_308_v2.0.transcript.fa -out tblastx.phallii.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#gunzip Sviridis_311_v1.1.transcript.fa.gz
makeblastdb -in Sviridis_311_v1.1.transcript.fa -dbtype nucl
tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Sviridis_311_v1.1.transcript.fa -out tblastx.setariaviridis.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Sviridis_311_v1.1.transcript.fa -out tblastx.setariaviridis.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6

#gunzip Zmarina_324_v2.2.transcript.fa.gz
makeblastdb -in Zmarina_324_v2.2.transcript.fa -dbtype nucl
tblastx -query ~/scratch_dir/Trinity_andro_out.Trinity.02122016.fasta -db Zmarina_324_v2.2.transcript.fa -out tblastx.zmarina.andro.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
tblastx -query ~/scratch_dir/Trinity_sorgh_out.Trinity.fasta -db Zmarina_324_v2.2.transcript.fa -out tblastx.zmarina.sorgh.outfmt6 -evalue 1e-10 -num_threads 40 -max_target_seqs 1 -outfmt 6
















