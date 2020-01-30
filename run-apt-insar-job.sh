#!/bin/bash

# Written by: monaghaa@colorado.edu
# Date: 20200130
# Purpose: This script submits an apt-instar container job on Summit

#SBATCH --account=ucb-general      # Summit Account
#SBATCH --partition=shas           # Summit partition
#SBATCH --qos=normal               # Summit qos
#SBATCH --time=06:00:00            # Max wall time
#SBATCH --nodes=1                  # Number of Nodes
#SBATCH --ntasks=1                 # Number of tasks per job
#SBATCH --job-name=aptinsar        # Job submission name
#SBATCH --output=aptinsar.%j.out   # Output file name with Job ID

# purge all existing modules
module purge

# The directory where you want the job to run
JOBDIR=/scratch/summit/$USER/$SLURM_JOBID
mkdir $JOBDIR
cd $JOBDIR

# Run your program
/projects/$USER/containers/apt-insar \
--reference-granule S1A_IW_SLC__1SDV_20190716T135159_20190716T135226_028143_032DC3_512B \
--secondary-granule S1A_IW_SLC__1SDV_20190704T135158_20190704T135225_027968_032877_1C4D \
--username $EARTHDATA_USER \
--password $EARTHDATA_PASS
