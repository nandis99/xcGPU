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

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INST/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$INST/lib/lib64
export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

export BASE=$WD/src/dftfeDebug/build/release/complex

srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_1.prm > outputMg2x_1
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_2.prm > outputMg2x_2
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_3.prm > outputMg2x_3
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_4.prm > outputMg2x_4
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_5.prm > outputMg2x_5
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_6.prm > outputMg2x_6
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_7.prm > outputMg2x_7
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_8.prm > outputMg2x_8
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_9.prm > outputMg2x_9
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileMg2x_10.prm > outputMg2x_10
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBe.prm > outputBe
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileTiAl_mixedPrec.prm > outputTiAl_hubbard_mixedPrec_mpi6
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileTiAl.prm > outputTiAl_hubbard
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileFeCuPt2_scf.prm > outputFeCuPt2_scf
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileFeCuPt2_pdos.prm > outputFeCuPt2_pdos
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_scf.prm > outputBccFe_scf
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_scfConstraintMag.prm > outputBccFe_scfConstraintMag
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_pdos.prm > outputBccFe_pdos
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_relax.prm > outputBccFe_relax
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileGaAs.prm > outputGaAs
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileGaAs_BANDS.prm > outputGaAs_bands
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_relaxFullMassMatrix.prm > outputBccFe_relaxFullMassMatrix
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_scan.prm > outputBccFe_scan
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_scan_kerker.prm > outputBccFe_scan_kerker
srun -n 6 -c 7 --gpu-bind closest $BASE/dftfe parameterFileBccFe_scan_useLibxcFalse.prm > outputBccFe_scan_useLibxcFalse