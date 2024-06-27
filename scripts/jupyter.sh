#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --time=24:00:00
#SBATCH --mem=32GB
#SBATCH --ntasks-per-node=8
#SBATCH --output="scripts/job.%j.out"
#SBATCH --error="scripts/job.%j.err"
#SBATCH --job-name=smdmjp

# # # # # # # # # # # # # # # # # # # # # #
# GPU jupyter notebook setup on CYENS HPC #
# # # # # # # # # # # # # # # # # # # # # #

PROJECT_CONDA_ENV="ganimator"
PROJECT_DIRECTORY="/lustreFS/data/veupnea/cchadjiminas/projects/ganimator"

## Setup environment
source ~/.bashrc
conda deactivate 
conda deactivate 
conda activate "$PROJECT_CONDA_ENV"

# get tunneling info
export XDG_RUNTIME_DIR="" node=$(hostname -s)
user="$(whoami)"
submit_host="${SLURM_SUBMIT_HOST}"
port=10501
echo $node pinned to port $port
# print tunneling instructions

echo -e "
To connect to the compute node ${node} on CYENS HPC running your jupyter notebook server, you need to run following two commands in a terminal 1.
Command to create ssh tunnel from you workstation/laptop to controller1:

ssh -L ${port}:${node}:${port} ${user}@82.116.197.12

Copy the link provided below by jupyter-server and replace the NODENAME with localhost before pasting it in your browser on your workstation/laptop "

# Run Jupyter
cd "$PROJECT_DIRECTORY"
jupyter lab --no-browser --port=${port} --port-retries=50 --ip=${node}

