# <!-- It is highly recommended to save the intermediate BowTie2 output for re-running MetaPhlAn extremely quickly (--bowtie2out), and use multiple CPUs (--nproc) if available: -->
fastq_dir = "/shared/projects/mudis4ls_is4_benchmark/test_data_meteor/fastq/"
fastq_file = "ERS12377136.fastq.gz"
fastq_file_path = fastq_dir+fastq_file
metaphlan fastq_file_path --bowtie2out metagenome.bowtie2.bz2 --nproc 5 --input_type fastq -o profiled_metagenome.txt