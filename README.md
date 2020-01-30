This repository contains a bash script that will install
The "apt-insar" Docker container maintained by the
Alaska SAR Facility on Summit, such that it can be used
with the Singularity containerization software.

To install the apt-insar docker container on Summit:

Step 1: Login to a Summit 'scompile' node and download this github
        repository to any directory you want, as follows:
```
$ git clone https://github.com/ResearchComputing/asf-insar-singularity.git
```
Step 2: Run the installation script:
```
$ cd asf-insar-singularity 
$ bash ./apt-insar-install.sh
$ cd ../ 
$ rmdir asf-insar-singularity
```
Note: The container will be installed in `/projects/$USER/containers` by default.
      You can change the `INSTALL_DIR` variable in the script if you want it
      somewhere else.

----------------------------------

To use the ASF apt-insar Docker container on Summit, use this command in your job script:

`$ /projects/$USER/containers/apt-insar --reference-granule REFERENCE_GRANULE --secondary-granule SECONDARY_GRANULE [--username USERNAME] [--password PASSWORD] [--dem {ASF,SRTM}]`

| Option | Description |

| --reference-granule | Reference granule name. |

| --secondary-granule | Secondary granule name. |

| --username | Earthdata Login username. |

| --password | Earthdata Login password. |

| --dem | Digital Elevation Model.
        ASF automatically selects the best geoid-corrected NED/SRTM DEM.
        SRTM uses the ISCE default settings. |

For example _[note that the "`\`" merges lines]_:

```
$ /projects/$USER/containers/apt-insar \
--reference-granule S1A_IW_SLC__1SDV_20190716T135159_20190716T135226_028143_032DC3_512B \
--secondary-granule S1A_IW_SLC__1SDV_20190704T135158_20190704T135225_027968_032877_1C4D \
--username $EARTHDATA_USER \
--password $EARTHDATA_PASS
```

Note in the example above it is assumed that you have saved your username and password to environment variables called `$EARTHDATA_USER` and `$EARTHDATA_PASS`. One way to ensure that these variables persist across all of your sessions is to export them at the start of any session by placing the following two lines in ~/.bash_profile (e.g, for user=`janedoe` and password=`1Lov3NASA!`):
```
export EARTHDATA_USER=janedoe
export EARTHDATA_PASS=1Lov3NASA!
```

A sample job script called `run-apt-insar-job.sh` can be found in your `/projects/$USER/containers` directory. You can edit this script to suit your workflow and submit jobs to Summit as follows:
`sbatch run-apt-insar-job.sh`

Note that the job script is presently configured to use one core (`--ntasks=1`). Each core on the Summit `shas` partition is associated with 4.48 GB RAM.  If your job crashes because it has insufficient memory, you can increase the number of cores (e.g., `--ntasks=2` will give you 9.96 GB of RAM).
