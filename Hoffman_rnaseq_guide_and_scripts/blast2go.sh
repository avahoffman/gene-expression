#!/bin/bash

#SBATCH --time=10000:00:00
#SBATCH --job-name=blast2go
#SBATCH --mail-type=ALL
#SBATCH --mail-user=avamariehoffman@gmail.com
#SBATCH --error=ERRORLOG
#SBATCH --output=OUTLOG

#  blast2go.sh
#  
#
#  Created by Ava Hoffman on 4/28/16.
#
#

export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+
export PATH=$PATH:~/rnaseq/ncbi-blast-2.3.0+/bin
export PATH=$PATH:~/rnaseq/blast2go_cli_v1.2.0

#configure db
#Dbacces.dbname=b2g_apr28

~/rnaseq/blast2go_cli_v1.2.0/blast2go_cli.run -createproperties cli.prop
#make sure to update cli.prop
~/rnaseq/blast2go_cli_v1.2.0/blast2go_cli.run -properties cli.prop -creategodb

~/rnaseq/blast2go_cli_v1.2.0/blast2go_cli.run -properties cli.prop -useobo go_latest.obo -loadfasta
example_data/1000_plant.fasta -loadblast example_data/1000_plant_blastResult.xml
-mapping -annotation -savedat example -savereport
example