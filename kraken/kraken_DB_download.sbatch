#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=kraken_install_db
#SBATCH --mem=120GB
#SBATCH --cpus-per-task=32
# Définir le chemin vers l'environnement Conda
CONDA_ENV_PATH="/shared/projects/mudis4ls_is4_benchmark/conda/envs/kraken2"

# Ajouter les binaires de l'environnement Conda au PATH
export PATH="$CONDA_ENV_PATH/bin:$PATH"
export LD_LIBRARY_PATH="$CONDA_ENV_PATH/lib:$LD_LIBRARY_PATH"
DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs"
# module load conda
# conda activate kraken2

kraken2-build --standard --threads $SLURM_CPUS_PER_TASK --db $DB_DIR

