#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=kraken_install_db
#SBATCH --mem=350GB
#SBATCH --cpus-per-task=10
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID

# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/kraken
DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs/kraken"
# module load conda
# conda activate kraken2

kraken2-build --standard --threads ${SLURM_CPUS_PER_TASK} --db $DB_DIR --use-ftp


# https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20241228.tar.gz 
# wget -P /shared/projects/mudis4ls_is4_benchmark/BDs/kraken https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20241228.tar.gz
