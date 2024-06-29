#!/bin/bash

clear

# Set up the pipeline failure expectations.
set -euo pipefail

echo "--- Initialized --- "

echo "Creating 'logs' directory"
mkdir -p logs

echo "Executing HPC Snakemake command"

# Execute the Snakemake command
snakemake \
      -s Snakefile_RunSelectionAnalyses \
      --cluster-config cluster.json \
      --cluster "qsub -V -l nodes={cluster.nodes}:ppn={cluster.ppn} -q {cluster.name} -l walltime={cluster.walltime} -e logs -o logs" \
      --jobs 64 all \
      --rerun-incomplete \
      --keep-going \
      --reason \
      --latency-wait 120

# End Snakemake command

exit 0

# End of file.