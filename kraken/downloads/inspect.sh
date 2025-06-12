#!/bin/bash
#SBATCH --job-name=kraken_inspect_gtdb
#SBATCH --mem=500GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID
#SBATCH --time=24:00:00    


# --- Variables de configuration ---
DB_DIR="/shared/bank/kraken/gtdb_r220" # Chemin vers le répertoire de la base de données


# --- Initialisation et vérifications ---
echo "Début du job SLURM : ${SLURM_JOB_NAME} (ID: ${SLURM_JOB_ID})"
echo "Date de début : $(date)"
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/kraken

kraken2-inspect --db /shared/bank/kraken/gtdb_r220/

echo "Job finished at $(date)."
