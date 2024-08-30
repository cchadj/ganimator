#!/bin/bash
#SBATCH --nodes=1
#SBATCH --gres=gpu:1
#SBATCH --time=24:00:00
#SBATCH --mem=16GB
#SBATCH --ntasks-per-node=8
#SBATCH --output="scripts/job.train.%j.out"
#SBATCH --error="scripts/job.train.%j.err"
#SBATCH --job-name=ganimdemo

# # # # # # # # # # # # # # # # # # # # # #
# GPU jupyter notebook setup on CYENS HPC #
# # # # # # # # # # # # # # # # # # # # # #

PROJECT_CONDA_ENV="ganimator"
PROJECT_DIRECTORY="/lustreFS/data/veupnea/cchadjiminas/projects/ganimator"

## Setup environment
source ~/.bashrc

echo "WHICH PYTHON: $(which python)"
cd "$PROJECT_DIRECTORY"

echo python demo.py --save_path="${SAVE_PATH}" --target_length="${TARGET_LENGTH}" --bvh_dir="${BVH_DIR}" --device="cuda"
python demo.py --save_path="${SAVE_PATH}" --target_length="${TARGET_LENGTH}" --bvh_dir="${BVH_DIR}" --device="cuda"

