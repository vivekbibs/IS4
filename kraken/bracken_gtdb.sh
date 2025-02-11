#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=bracken_classify_gtdb
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/bracken


DB_DIR="/shared/projects/mudis4ls_is4_benchmark/BDs/kraken/gtdb"
kraken_report="/shared/projects/mudis4ls_is4_benchmark/test_results/kraken/test.kreport"
output_dir="/shared/projects/mudis4ls_is4_benchmark/test_results/kraken/gtdb"

# k=35 pour kraken2, default kmer length
bracken -d $DB_DIR -i $kraken_report -o "$output_dir/test.bracken"
# Ici on va spécifier la version directement en brut, mais plus tard on assignera au flag y la sortie de terminal de "chemin_vers_kraken2 --version
# pour que ce soit plus propre
sacct -j $SLURM_JOB_ID --format=JobID,JobName,Elapsed,TotalCPU,MaxRSS,CPUTime,CPUTimeRAW > "$output_dir/logs/slurm_stats_${SLURM_JOB_NAME}.log"
