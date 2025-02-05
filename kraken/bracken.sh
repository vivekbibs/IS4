#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=bracken_classify
#SBATCH --mem=250GB
#SBATCH --cpus-per-task=10
#SBATCH -o bracken_less_threads2.out  
#SBATCH -e bracken_less_threads2.err
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/bracken


DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs"

# k=35 pour kraken2, default kmer length
bracken-build -d $DB_DIR -t ${SLURM_CPUS_PER_TASK}
# Ici on va spécifier la version directement en brut, mais plus tard on assignera au flag y la sortie de terminal de "chemin_vers_kraken2 --version"
# pour que ce soit plus propre
