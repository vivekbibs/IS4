#!/bin/bash
#SBATCH --job-name=meteor_mapping
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=8

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/meteor

# Définir les variables
meteor_bd_path="/shared/projects/mudis4ls_is4_benchmark/BDs/hs_10_4_gut"
fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
fastq_file="ERS12377136.fastq.gz"
name="${fastq_file%.fastq.gz}"

fastq_file_path="${fastq_dir}${fastq_file}"

# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/meteor/mapping"
mkdir -p $output_dir



meteor mapping -i $fastq_file_path \
-r $meteor_bd_path \
-o $output_dir \
-t $SLURM_CPUS_PER_TASK

