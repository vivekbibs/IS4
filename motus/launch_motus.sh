#!/bin/bash
#SBATCH --job-name=motus_full_taxons
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=10
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/motus

# Définir les variables

fastq_dir="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/only_one/fastq/"
fastq_file="ERS12377136.fastq.gz"
name="${fastq_file%.fastq.gz}"

fastq_file_path="${fastq_dir}${fastq_file}"

# Définir le répertoire de sortie
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/motus"
mkdir -p $output_dir

# Exécuter motus 
motus profile -s $fastq_file_path -n $name -t ${SLURM_CPUS_PER_TASK} -A > "$output_dir/results.txt" 2> "$output_dir/log.txt"

# With -k is possible to change the taxonomy level. For example, the result of motus profile -s test1_single.fastq -n test3 -k class is:

# With -p you add the NCBI taxonomy id to the profile. Hence you will have 3 columns now, where the second one is the NCBI id.

# With -q you can print the full rank taxonomy (up to the one selected with -k)

# With -A is possible to print all levels together.
# Total time: 37.58 s