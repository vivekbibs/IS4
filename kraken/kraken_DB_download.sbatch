#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=kraken_install_db
#SBATCH --mem=120GB
#SBATCH --cpus-per-task=24
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/kraken
DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs"
# module load conda
# conda activate kraken2

kraken2-build --standard --threads $SLURM_CPUS_PER_TASK --db $DB_DIR

