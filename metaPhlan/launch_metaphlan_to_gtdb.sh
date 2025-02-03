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