#!/bin/bash

#specify where apt-insar is installed (or where you want it installed)
INSTALL_DIR=/projects/$USER/containers

#keep track of where you are
INITDIR=$PWD

#load singularity
module load singularity/3.3.0
mkdir -p /scratch/summit/$USER/tmp
export SINGULARITY_TMPDIR=/scratch/summit/$USER/tmp
export SINGULARITY_CACHEDIR=/scratch/summit/$USER/tmp

#install container if not already installed
if [ ! -f "$INSTALL_DIR/apt-insar.sif" ]; then

 # step 1: create installation directory and pull container
 # from dockerhub
 echo ""
 echo "container does not exist; creating one in $INSTALL_DIR"
 mkdir -p $INSTALL_DIR
 cd $INSTALL_DIR
 singularity pull --name apt-insar.sif docker://asfdaac/apt-insar
 echo "Done creating container in $INSTALL_DIR"

 # step 2: create the script that executes the container
 echo ""
 echo "creating apt-insar wrapper..."
 echo '#!/bin/bash' > apt-insar
 echo 'module load singularity/3.3.0' >> apt-insar
 echo singularity exec --bind '${PWD}':/output $INSTALL_DIR/apt-insar.sif sh $INSTALL_DIR/commands.sh '$@' >>apt-insar
 chmod +x apt-insar
 echo "Done creating apt-insar wrapper"

 # step 3: create the script containing the commands
 # to be run from within the container
 echo ""
 echo "Creating commands.sh..."
 echo '#!/bin/bash' > commands.sh
 echo 'cp /work/* .' >> commands.sh
 echo python3 -u insar.py '$@' >> commands.sh
 echo "Done creating commands.sh"

else

 echo ""
 echo "container already exists in $INSTALL_DIR"
 echo ""

fi

if [ ! -f "$INSTALL_DIR/apt-insar.sif" ]; then
 echo ""
 echo Installation of ASF apt-insar Docker container failed.
 echo Contact rc-help@colorado.edu for assistance.
else
 echo ""
 echo Installation of ASF apt-insar Docker container is complete.
 echo ""
 echo To use the ASF apt-insar Docker container on Summit:
 echo ""
 echo '$' $INSTALL_DIR/apt-insar --reference-granule REFERENCE_GRANULE --secondary-granule SECONDARY_GRANULE '[--username USERNAME] [--password PASSWORD] [--dem {ASF,SRTM}]'
 echo ""
 echo '| Option | Description |'
 echo ""
 echo '| --reference-granule | Reference granule name. |'
 echo '| --secondary-granule | Secondary granule name. |'
 echo '| --username | Earthdata Login username. |'
 echo '| --password | Earthdata Login password. |'
 echo '| --dem | Digital Elevation Model.'
 echo '        ASF automatically selects the best geoid-corrected NED/SRTM DEM.'
 echo '        SRTM uses the ISCE default settings. |'
 echo ""
 echo "For example"
 echo '$' $INSTALL_DIR/apt-insar --reference-granule S1A_IW_SLC__1SDV_20190716T135159_20190716T135226_028143_032DC3_512B --secondary-granule S1A_IW_SLC__1SDV_20190704T135158_20190704T135225_027968_032877_1C4D --username $USER --password 1loveNASA!
fi
