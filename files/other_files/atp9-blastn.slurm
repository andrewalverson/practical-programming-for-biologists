#!/bin/bash

#SBATCH --job-name=atp9.blast
#SBATCH --partition comp01
#SBATCH --nodes=1
#SBATCH --qos comp
#SBATCH --cpus-per-task=32
#SBATCH --time=00:20:00
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
# #SBATCH --mail-type=ALL
# #SBATCH --mail-user=aja@uark.edu

export OMP_NUM_THREADS=32

module purge
module load intel/18.0.1 impi/18.0.1 mkl/18.0.1
module load blast

cd $SLURM_SUBMIT_DIR

# copy files to scratch
cp -r nt/ /scratch/$SLURM_JOB_ID
cp watermelon.fsa /scratch/$SLURM_JOB_ID

# cd into where the files are (on scratch)
cd /scratch/$SLURM_JOB_ID

# run the commands
makeblastdb -in watermelon.fsa -dbtype nucl
blastn -query nt/atp9.fasta -db watermelon.fsa > atp9.vs.watermelon.blastn

# copy output back to $SLURM_SUBMIT_DIR

rsync -arlv * $SLURM_SUBMIT_DIR/
