#!/bin/bash
#SBATCH --job-name=metaphlan_test
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=5

# Activer l'environnement Conda 
source source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/metaphlan

# Définir les variables
fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
fastq_file="ERS12377136.fastq.gz"
fastq_file_path="${fastq_dir}${fastq_file}"

# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/metaphlan"

# Exécuter MetaPhlAn 
metaphlan "$fastq_file_path" --bowtie2out "$output_dir/metagenome.bowtie2.bz2" \
          --nproc "$SLURM_CPUS_PER_TASK" --input_type fastq \
          -o "$output_dir/profiled_metagenome.txt"