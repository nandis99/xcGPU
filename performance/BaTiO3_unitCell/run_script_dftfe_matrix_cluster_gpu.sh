#!/bin/bash
#. /shared/spack/share/spack/setup-env.sh
#SBATCH --job-name=Al # Job name
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --time=20:00:00 # Time limit hrs:min:sec
#SBATCH --gres=gpu:8
#SBATCH --exclusive
#SBATCH -o slurm.out


echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
#echo "CPU bind Info  = $SLURM_CPU_BIND"    
echo "CPU on node  = $SLURM_CPUS_ON_NODE"         

module load spack
module load openmpi/5.0.6-gcc-13.3.0-ytficip nccl/2.23.4-1-gcc-13.3.0-xyspmp2 gdrcopy/2.4.1-gcc-13.3.0-dvwa323
export LIBRARY_PATH="/storage/dftfeDependenciesNoMKL/linAlgLibs/install/lib:$LIBRARY_PATH"

param_file="BaTiO3_scf.prm"
param_file1="BaTiO3_scf_libxc_false_4d8.prm"
param_file2="BaTiO3_scf_libxc_false_7d6.prm"
exe="/home/srinibasn/dftfe_xcGPUoptimizations/build/release/real/dftfe"
# mpirun -n $SLURM_NTASKS $exe ${param_file} > BaTiO3_scf_libxc_true_test_dofs_full.out
# mpirun -n $SLURM_NTASKS $exe ${param_file1} > BaTiO3_scf_libxc_false_test_dofs_full_test.out
mpirun -n $SLURM_NTASKS $exe ${param_file2} > BaTiO3_scf_libxc_false_7.6M_dofs_50Cells_temp_final.out