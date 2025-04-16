#!/bin/bash

#SBATCH --job-name=test_conda_home
#SBATCH --mem=2GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID

echo $CONDA_HOME
echo ${CONDA_HOME}