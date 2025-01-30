#!/bin/bash
#SBATCH --job-name=sylph_test
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=5

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/sylph

# Définir les variables
sylph_bd_path="/shared/projects/mudis4ls_is4_benchmark/BDs/gtdb-r220-c200-dbv1.syldb"
fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
fastq_file="ERS12377136.fastq.gz"
name="${fastq_file%.fastq.gz}"

fastq_file_path="${fastq_dir}${fastq_file}"

# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/sylph"
mkdir -p $output_dir

# Exécuter sylph 
sylph profile $sylph_bd_path $fastq_file_path -t $SLURM_CPUS_PER_TASK > "$output_dir/profiling.tsv"