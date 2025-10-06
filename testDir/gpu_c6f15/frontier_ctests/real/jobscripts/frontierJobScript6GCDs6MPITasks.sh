#!/bin/sh
#SBATCH -A nti115
#SBATCH -J gputests
#SBATCH -t 1:00:00
#SBATCH -p batch
#SBATCH -N 1
#SBATCH --gpus-per-node 6
#SBATCH --ntasks-per-gpu 1
#SBATCH --gpu-bind closest

export OMP_NUM_THREADS=1
export MPICH_VERSION_DISPLAY=1
export MPICH_ENV_DISPLAY=1
export MPICH_OFI_NIC_POLICY=NUMA
export MPICH_GPU_SUPPORT_ENABLED=1
export MPICH_SMP_SINGLE_COPY_MODE=NONE
export FI_MR_CACHE_MONITOR=disabled

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INST/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INST/lib/lib64
export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

export BASE=$WD/src/dftfeDebug/build/release/real

srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileN2_1.prm > outputN2_1
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileN2_2.prm > outputN2_2
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileN2_3.prm > outputN2_3
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileN2_4.prm > outputN2_4
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileN2_5.prm > outputN2_5
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_8.prm > outputMg2x_8
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_9.prm > outputMg2x_9
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_10.prm > outputMg2x_10
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_11.prm > outputMg2x_11
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_14.prm > outputMg2x_14
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_15.prm > outputMg2x_15
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe Pt3Ni_hubbard_spin.prm > outputPt3Ni_hubbard_spin
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe Pt3Ni_hubbard_spin_mixedPrec.prm > outputPt3Ni_hubbard_spin_mixedPrec
