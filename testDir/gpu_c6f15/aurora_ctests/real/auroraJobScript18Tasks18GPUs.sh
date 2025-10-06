#!/bin/bash
#PBS -l select=3
#PBS -l place=scatter
#PBS -l walltime=00:10:00
#PBS -l filesystems=home
#PBS -j oe
#PBS -q debug-scaling
#PBS -A DFTCalc2
#PBS -N DFTFE_SYCL


echo "Number of Nodes Allocated      = $PBS_NUM_NODES"
echo "Number of Tasks Allocated      = $PBS_NUM_PPN"
echo "CPU on node                    = $PBS_NUM_CPUS"
module load boost

export MPIR_CVAR_ENABLE_GPU=0
cd $PBS_O_WORKDIR

NNODES=$(wc -l < "$PBS_NODEFILE")
NRANKS_PER_NODE=6
NDEPTH=1
NTHREADS=1
NTOTRANKS=$(( NNODES * NRANKS_PER_NODE ))

export OMP_NUM_THREADS=1
export OMP_PLACES=threads
export DFTFE_NUM_THREADS=1
export DEAL_II_NUM_THREADS=1

export CPU_BIND_SCHEME="--cpu-bind=list:1-8:9-16:17-24:25-32:33-40:41-48:53-60:61-68:69-76:77-84:85-92:93-100"
export GPU_BIND_SCHEME="--gpu-bind=list:0.0:0.1:1.0:1.1:2.0:2.1:3.0:3.1:4.0:4.1:5.0:5.1"


export BASE=/lus/flare/projects/DFTCalc2/srinibasn/dftfe_xcGPUoptimizations/install/real

mpiexec -n ${NTOTRANKS} --ppn ${NRANKS_PER_NODE} ${CPU_BIND_SCHEME} ${GPU_BIND_SCHEME} $BASE/dftfe parameterFileMg2x_4.prm > outputMg2x_4
