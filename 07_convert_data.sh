#!/bin/bash
#############################################################################
GEOMETRYFILE="/home/lhep/PACMAN/larpix-geometry/larpixgeometry/layouts/layout-2.4.0.yaml"
#CONFIGURATIONFILE="/home/lhep/PACMAN/DAQ/SingleCube_Oct2020/config_files/config-1-1-11-2020_10_16_19_37_11_CEST.json"
CONFIGURATIONFILE="/home/lhep/PACMAN/larpix-v2-testing-scripts/event-display/evd_configs/evd_config_20-10-26_10-48-37.json"
PEDESTALFILE="/home/lhep/PACMAN/DAQ/SingleCube_Oct2020/pedestalRuns/datalog_2020_11_01_08_42_30_CET_evd_ped.json"
DATAFILEPATH="/home/lhep/PACMAN/DAQ/SingleCube_Oct2020/dataRuns/rawData"
DATAFILE="datalog_2020_11_01_07_56_59_CET_.h5"
#OUTPUTPATH="/home/lhep/PACMAN/DAQ/SingleCube_Oct2020/dataRuns/convertedData"
OUTPUTPATH="/home/lhep/PACMAN"
BUFFER_SIZE="38400"
EVENT_DT="1818"        # drift window [0.1us]
NHIT_CUT="50"          # min. number of hits requested for an event
MAX_PACKETS="-1"
VD="1.648"             # drift velocity [mm/us]
CLOCK_PERIOD="0.1"
DBSCAN_EPS="14.0"
DBSCAN_MIN_SAMPLES="5"
#############################################################################
source /home/roman/software/root/build/bin/thisroot.sh

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'

#cd $WORKDIR/DAQ/dataRuns/rawData/
#unset -v DATAFILE
#DATAFILE=$(ls -tr datalog* | tail -n 1)
echo "Using datafile" $DATAFILE

#cd $WORKDIR/DAQ/pedestalRuns/
#unset -v PEDESTALFILE
#PEDESTALFILE=$(ls -tr datalog* | tail -n 1)
echo "Using pedestal file" $PEDESTALFILE

echo "Using geometry file" $GEOMETRYFILE

unset -v OUTPUTFILENAME
OUTPUTFILENAME=${DATAFILE:0:-3}"evd.h5"
echo "Output filename:" $OUTPUTFILENAME

python3.6 $WORKDIR/larpix-v2-testing-scripts/event-display/to_evd_file.py -i $DATAFILEPATH/$DATAFILE -o $OUTPUTPATH/$OUTPUTFILENAME -g $GEOMETRYFILE -p $PEDESTALFILE -c $CONFIGURATIONFILE -b $BUFFER_SIZE --event_dt $EVENT_DT --nhit_cut $NHIT_CUT -n $MAX_PACKETS --vd $VD --clock_period $CLOCK_PERIOD --dbscan_eps $DBSCAN_EPS --dbscan_min_samples $DBSCAN_MIN_SAMPLES #--electron_lifetime_file /home/lhep/PACMAN/ElecLifetime_SingleCube_Bern.root

#cd $WORKDIR/DAQ/dataRuns/rawData/
#mv $DATAFILE alreadyConverted/$DATAFILE
#mv $OUTPUTFILENAME ../convertedData/$OUTPUTFILENAME
#
#echo "Saved converted file" $OUTPUTFILENAME "to" $WORKDIR "/DAQ/convertedData/" $OUTPUTFILENAME

cd $WORKDIR
