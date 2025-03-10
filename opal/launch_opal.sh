#!/bin/bash
#SBATCH --job-name=opal_test
#SBATCH --cpus-per-task=1
#SBATCH --mem=100GB
#SBATCH -o slurm.%x.%j.out  # STDOUT file with the Job Name and the Job ID
#SBATCH -e slurm.%x.%j.err  # STDERR file with the Job Name and the Job ID
# Activer l'environnement Conda 
source /shared/projects/mudis4ls_is4_benchmark/miniforge3/bin/activate /shared/projects/mudis4ls_is4_benchmark/conda/envs/opal

opal.py -g /shared/projects/mudis4ls_is4_benchmark/test_results/opal/goldstandard_low_1.bin \
/shared/projects/mudis4ls_is4_benchmark/test_results/opal/bracken.tsv \
/shared/projects/mudis4ls_is4_benchmark/test_results/opal/metaphlan_species.tsv \
/shared/projects/mudis4ls_is4_benchmark/test_results/opal/meteor.tsv \
/shared/projects/mudis4ls_is4_benchmark/test_results/opal/sylph_species.tsv \
-l "Bracken, Metaphlan, meteor, Sylph" \
-o /shared/projects/mudis4ls_is4_benchmark/test_results/opal \
-r "species, species"