#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=kraken_install_db
#SBATCH --mem=200GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/kraken
DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs/kraken"

# module load conda
# conda activate kraken2
# https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20241228.tar.gz 
# wget -q -nc -P "$DB_DIR" https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20241228.tar.gz
# wget -nc -P /shared/projects/mudis4ls_is4_benchmark/BDs/kraken https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20241228.tar.gz
# kraken2-build --standard --threads ${SLURM_CPUS_PER_TASK} --db $DB_DIR
wget -nc -P /shared/projects/mudis4ls_is4_benchmark/BDs/kraken/gtdb https://genome-idx.s3.amazonaws.com/kraken/k2_gtdb_genome_reps_20241109.tar.gz 

