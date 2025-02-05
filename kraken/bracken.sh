#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=bracken_classify
#SBATCH --mem=120GB
#SBATCH --cpus-per-task=15
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/bracken


DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs"
KRAKEN_INSTALLATION="/shared/projects/mudis4ls_is4_benchmark/conda/pkgs/kraken2-2.1.3-pl5321h077b44d_4/share/kraken2-2.1.3-4"
# k=35 pour kraken2, default kmer length
bracken-build -y "2.1.3" -d ${KRAKEN_DB} -t $SLURM_CPUS_PER_TASK -k ${KMER_LEN} -l ${READ_LEN} 
# Ici on va spécifier la version directement en brut, mais plus tard on assignera au flag y la sortie de terminal de "chemin_vers_kraken2 --version"
# pour que ce soit plus propre
