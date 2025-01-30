#!/bin/bash
#SBATCH --job-name=metaphlan_test
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=5

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/motus

# Définir les variables

fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
fastq_file="ERS12377136.fastq.gz"
name="${fastq_file%.fastq.gz}"

fastq_file_path="${fastq_dir}${fastq_file}"

# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/motus"
mkdir -p $output_dir

# Exécuter motus 
motus profile -s $fastq_file_path -n $name -t $SLURM_CPUS_PER_TASK > "$output_dir/results.txt" 2> "$output_dir/log.txt"