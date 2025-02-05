#!/bin/bash
# https://ifb-elixirfr.gitlab.io/cluster/doc/quick-start/#1-write-a-bash-script
#SBATCH --job-name=kraken_install_db
#SBATCH --mem=150GB
#SBATCH --cpus-per-task=10
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID


module load conda
conda activate kraken2
kraken2-build --standard --threads $SLURM_CPUS_PER_TASK --db /shared/projects/mudis4ls_is4_benchmark/BDs

