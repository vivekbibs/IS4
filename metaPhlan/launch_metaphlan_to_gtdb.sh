#!/bin/bash
#SBATCH --job-name=metaphlan_to_gtdb
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=5

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/metaphlan



metaphlan_output="/shared/projects/mudis4ls_is4_benchmark/test_results/metaphlan/profiled_metagenome.txt"
# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/metaphlan"


sgb_to_gtdb_profile.py -i $metaphlan_output -o "$output_dir/metaphlan_output_gtdb.txt"

#/shared/projects/mudis4ls_is4_benchmark/conda/envs/metaphlan/lib/python3.9/site-packages/metaphlan/utils/ path des scripts de passage vers gtdb


# (metaphlan) (base) vashokan@clust-slurm-client2:/shared/projects/mudis4ls_is4_benchmark$ find . -name "*_SGB2GTDB.tsv"
# ./conda/pkgs/metaphlan-4.1.1-pyhdfd78af_0/site-packages/metaphlan/utils/mpa_vJun23_CHOCOPhlAnSGB_202307_SGB2GTDB.tsv
# ./conda/pkgs/metaphlan-4.1.1-pyhdfd78af_0/site-packages/metaphlan/utils/mpa_vOct22_CHOCOPhlAnSGB_202212_SGB2GTDB.tsv
# ./conda/pkgs/metaphlan-4.1.1-pyhdfd78af_0/site-packages/metaphlan/utils/mpa_vJan21_CHOCOPhlAnSGB_202103_SGB2GTDB.tsv
# ./conda/pkgs/metaphlan-4.1.1-pyhdfd78af_0/site-packages/metaphlan/utils/mpa_vJun23_CHOCOPhlAnSGB_202403_SGB2GTDB.tsv
# ./conda/envs/metaphlan/lib/python3.9/site-packages/metaphlan/utils/mpa_vJun23_CHOCOPhlAnSGB_202307_SGB2GTDB.tsv
# ./conda/envs/metaphlan/lib/python3.9/site-packages/metaphlan/utils/mpa_vOct22_CHOCOPhlAnSGB_202212_SGB2GTDB.tsv
# ./conda/envs/metaphlan/lib/python3.9/site-packages/metaphlan/utils/mpa_vJan21_CHOCOPhlAnSGB_202103_SGB2GTDB.tsv
# ./conda/envs/metaphlan/lib/python3.9/site-packages/metaphlan/utils/mpa_vJun23_CHOCOPhlAnSGB_202403_SGB2GTDB.tsv