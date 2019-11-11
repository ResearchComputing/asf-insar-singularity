This repository contains a bash script that will install
The "apt-insar" Docker container maintained by the
Alaska SAR Facility on Summit, such that it can be used
with the Singularity containerization software.

To install the apt-insar docker container on Summit:

Step 1: Login to a Summit 'scompile' node and download this github
        repository to any directory you want, as follows:

$ git clone https://github.com/ResearchComputing/asf-insar-singularity.git

Step 2: Run the installation script:

$ cd asf-insar-singularity 
$ bash ./apt-insar-install.sh

Note: The container will be installed in /projects/$USER/containers by default.
      You can change the INSTALL_DIR variable in the script if you want it
      somewhere else.

----------------------------------

To use the ASF apt-insar Docker container on Summit:

$ /projects/$USER/containers//apt-insar --reference-granule REFERENCE_GRANULE --secondary-granule SECONDARY_GRANULE [--username USERNAME] [--password PASSWORD] [--dem {ASF,SRTM}]

| Option | Description |

| --reference-granule | Reference granule name. |

| --secondary-granule | Secondary granule name. |

| --username | Earthdata Login username. |

| --password | Earthdata Login password. |

| --dem | Digital Elevation Model.
        ASF automatically selects the best geoid-corrected NED/SRTM DEM.
        SRTM uses the ISCE default settings. |

For example:

$ /projects/$USER/containers//apt-insar --reference-granule S1A_IW_SLC__1SDV_20190716T135159_20190716T135226_028143_032DC3_512B --secondary-granule S1A_IW_SLC__1SDV_20190704T135158_20190704T135225_027968_032877_1C4D --username janedoe --password 1loveNASA!
