#!/bin/bash
#SBATCH --job-name=meteor_fastq_mapping
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=5

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/meteor

# Définir les variables
meteor_bd_path="/shared/projects/mudis4ls_is4_benchmark/BDs/hs_10_4_gut"
# fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
# fastq_file="ERS12377136.fastq.gz"
# name="${fastq_file%.fastq.gz}"

fastq_file_path="${fastq_dir}${fastq_file}"

dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/only_one"
fastq_dir="$dir/fastq"
# Définir le répertoire de sortie
mapping_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/meteor/mapping"
profile_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/meteor/profile"
mkdir -p $output_dir



meteor profile -i "$mapping_dir/ERS12377136" -o $profile_dir -r $meteor_bd_path -n coverage