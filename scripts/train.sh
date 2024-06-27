#!/bin/bash -l
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --time=24:00:00
#SBATCH --mem=32GB
#SBATCH --ntasks-per-node=8
#SBATCH --output="scripts/job.train.%j.out"
#SBATCH --error="scripts/job.train.%j.err"
#SBATCH --job-name=ganim

# # # # # # # # # # # # # # # # # # # # # #
# GPU jupyter notebook setup on CYENS HPC #
# # # # # # # # # # # # # # # # # # # # # #

PROJECT_CONDA_ENV="ganimator"
PROJECT_DIRECTORY="/lustreFS/data/veupnea/cchadjiminas/projects/ganimator"

## Setup environment
source ~/.bashrc
source /lustreFS/data/veupnea/cchadjiminas/miniconda3/etc/profile.d/conda.sh
conda deactivate 
conda deactivate 
conda activate "$PROJECT_CONDA_ENV"

cd "$PROJECT_DIRECTORY"

BVH_PREFIX="${BVH_PREFIX:-"./data/DanceDB/"}"
SAVE_PATH="${SAVE_PATH:-"./results"}"

echo --bvh_prefix="${BVH_PREFIX}" --bvh_name="${BVH_NAME}" --save_path="${SAVE_PATH}"
python train.py --bvh_prefix="${BVH_PREFIX}" --bvh_name="${BVH_NAME}" --save_path="${SAVE_PATH}"

