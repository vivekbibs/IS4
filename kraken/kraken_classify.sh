#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=kraken_classify
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=15
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/kraken

# module load conda
# conda activate kraken2
DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs/kraken"
seq="/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/only_one/fastq/ERS12377136.fastq.gz"
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/kraken"
output_file="$output_dir/kraken_test.tsv"

kraken2 --db $DB_DIR --threads ${SLURM_CPUS_PER_TASK} --report "$output_dir/test.kreport" $seq > $output_file

# Loading database information... done.
# 100000 sequences (14.61 Mbp) processed in 0.821s (7306.8 Kseq/m, 1067.27 Mbp/m).
#   72233 sequences classified (72.23%)
#   27767 sequences unclassified (27.77%)
# (END)

