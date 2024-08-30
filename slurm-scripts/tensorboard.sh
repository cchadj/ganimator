#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH --mem=32GB
#SBATCH --ntasks-per-node=2
#SBATCH --output="scripts/job.%j.out"
#SBATCH --error="scripts/job.%j.err"
#SBATCH --job-name=ganimtb

# # # # # # # INPUTS  # # # # # # # # # #
LOG_DIR="${LOG_DIR:-"results-clio-rasopoulos-3/logs/"}"


PORT="${PORT:-$(availport)}"
PROJECT_CONDA_ENV="${PROJECT_CONDA_ENV:-"ganimator"}"
PROJECT_DIRECTORY="${PROJECT_DIRECTORY:-"/lustreFS/data/veupnea/cchadjiminas/projects/ganimator"}"
# # # # # # # # # #  # # # # # # # # # #

cat << EOF
LOG_DIR "${LOG_DIR}"

PROJECT_DIRECTORY "${PROJECT_DIRECTORY}"
PROJECT_CONDA_ENV "${PROJECT_CONDA_ENV}"
PORT "${PORT}"
EOF

## Setup environment
source ~/.bashrc
conda deactivate 
conda deactivate 
conda activate "$PROJECT_CONDA_ENV"

# get tunneling info
export XDG_RUNTIME_DIR="" node=$(hostname -s)
user="$(whoami)"
submit_host="${SLURM_SUBMIT_HOST}"
echo $node pinned to PORT $PORT
# print tunneling instructions

echo -e "
To connect to the compute node ${node} on CYENS HPC running your jupyter notebook server, you need to run following two commands in a terminal 1.
Command to create ssh tunnel from you workstation/laptop to controller1:

ssh -L ${PORT}:${node}:${PORT} ${user}@82.116.197.12

Copy the link provided below in your local browser"
 
echo "http://localhost:${PORT}/#scalars"


# Run Tensorboard
cd "$PROJECT_DIRECTORY"
tensorboard --port="${PORT}" --logdir "${LOG_DIR}" --host="${node}"

