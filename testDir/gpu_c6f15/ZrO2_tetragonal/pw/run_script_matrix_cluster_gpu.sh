#!/bin/bash
#. /shared/spack/share/spack/setup-env.sh
#SBATCH --job-name=Al # Job name
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --time=00:30:00 # Time limit hrs:min:sec
#SBATCH --gres=gpu:8
#SBATCH --exclusive
#SBATCH --output=slurm.out


echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
#echo "CPU bind Info  = $SLURM_CPU_BIND"    
echo "CPU on node  = $SLURM_CPUS_ON_NODE"         

module load spack
module load openmpi/5.0.6-gcc-13.3.0-ytficip nccl/2.23.4-1-gcc-13.3.0-xyspmp2 gdrcopy/2.4.1-gcc-13.3.0-dvwa323
export LIBRARY_PATH="/storage/dftfeDependenciesNoMKL/linAlgLibs/install/lib:$LIBRARY_PATH"

param_file="ZrO2_scf.prm"
exe="/home/srinibasn/dftfe_xcGPUoptimizations/build/release/complex/dftfe"
exe_pgd="/home/srinibasn/dftfe_pgd/build/release/complex/dftfe"


for exc in  LDA-PW;do
    for useLibxc in true false;do
        sed -i "s/SPIN[[:space:]]*POLARIZATION[[:space:]]*=.*/SPIN POLARIZATION = ${spinVal}/" "$param_file"
        sed -i "s/USE LIBXC FOR XC FUNCTIONAL EVALUATION[[:space:]]*=.*/USE LIBXC FOR XC FUNCTIONAL EVALUATION = ${useLibxc}/" "$param_file"
        sed -i "s/EXCHANGE CORRELATION TYPE[[:space:]]*=.*/EXCHANGE CORRELATION TYPE = ${exc}/" "$param_file"

        outFile="ZrO2_scf_useLibxc_${useLibxc}_xc_${exc}_c6f15.out"
        outFile_pgd="ZrO2_scf_useLibxc_${useLibxc}_xc_${exc}_pgd.out"
        # /apps/softwares/linaro/forge/24.1.1/bin/ddt --offline --output=Debug.html --mem-debug=off --leak-report-top-ranks=8 --check-bounds=off --debug mpirun -n "$SLURM_NTASKS" $exe "$param_file" > "$outFile"
        mpirun -n "$SLURM_NTASKS" $exe "$param_file" > "$outFile"
        # mpirun -n "$SLURM_NTASKS" $exe_pgd "$param_file" > "$outFile_pgd"
    done
done