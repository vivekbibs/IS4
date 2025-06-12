#!/bin/bash
#SBATCH --job-name=kraken_install_db
#SBATCH --mem=500GB
#SBATCH --cpus-per-task=1
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID
#SBATCH --time=24:00:00    


# --- Variables de configuration ---
DB_DIR="/shared/bank/kraken/gtdb" # Chemin vers le répertoire de la base de données
DB_FILENAME="k2_gtdb_genome_reps_20241109.tar.gz"
DB_URL="https://genome-idx.s3.amazonaws.com/kraken/${DB_FILENAME}"

# --- Initialisation et vérifications ---
echo "Début du job SLURM : ${SLURM_JOB_NAME} (ID: ${SLURM_JOB_ID})"
echo "Date de début : $(date)"
echo "Répertoire de destination : ${DB_DIR}"



# --- Téléchargement de la base de données ---
echo "Téléchargement de l'archive Kraken DB (${DB_FILENAME})..."

wget -c -nc -P "${DB_DIR}" "${DB_URL}"
if [ $? -ne 0 ]; then
    echo "Erreur lors du téléchargement de ${DB_FILENAME}. Aborting."
    exit 1
fi
echo "Téléchargement terminé."

# --- Décompression de la base de données ---
ARCHIVE_PATH="${DB_DIR}/${DB_FILENAME}"
echo "Décompression de l'archive : ${ARCHIVE_PATH} vers ${DB_DIR}..."

tar -xzf "${ARCHIVE_PATH}" -C "${DB_DIR}"
if [ $? -ne 0 ]; then
    echo "Erreur lors de la décompression de ${ARCHIVE_PATH}. Aborting."
    exit 1
fi
echo "Décompression terminée."

# --- Nettoyage (optionnel) ---
echo "Suppression de l'archive téléchargée pour libérer de l'espace..."
rm "${ARCHIVE_PATH}"
if [ $? -ne 0 ]; then
    echo "Attention: Impossible de supprimer l'archive ${ARCHIVE_PATH}."
fi

# --- Rapport de fin de job SLURM ---
echo "--- SLURM Job Accounting Report ---"

sacct -j $SLURM_JOB_ID --format=JobID,JobName,Partition,AllocCPUs,State,ExitCode,Elapsed,NNodes,NTasks,MaxRSS > job_report_${SLURM_JOB_ID}.txt
cat job_report_${SLURM_JOB_ID}.txt # Affiche le rapport dans la sortie standard du job aussi
echo "-----------------------------------"

echo "Job finished at $(date)."