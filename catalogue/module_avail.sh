#!/bin/bash
#SBATCH --job-name=module_avail
#SBATCH --mem=10GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID

module avail -l > /shared/projects/mudis4ls_is4_benchmark/IS4_repo/catalogue/module_avail.txt