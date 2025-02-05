#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=kraken_classify
#SBATCH --mem=120GB
#SBATCH --cpus-per-task=24
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/kraken2

# module load conda
# conda activate kraken2
DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs"
seq="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/only_one/fastq/ERS12377136.fastq.gz"
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/kraken"
output_file="$output_dir/kraken_test.tsv"

kraken2 --db $DB_DIR --threads $SLURM_CPUS_PER_TASK --output $output_file $seq

