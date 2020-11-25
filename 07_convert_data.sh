#!/bin/bash
#############################################################################
#EXPERIMENT='SingleCube_Oct2020'
EXPERIMENT='SingleModule_Nov2020'
GEOMETRYFILE='/home/lhep/PACMAN/larpix-geometry/larpixgeometry/layouts/layout-2.4.0.yaml'
CONFIGURATIONFILE='/home/lhep/PACMAN/larpix-v2-testing-scripts/event-display/evd_configs/evd_config_20-10-26_10-48-37.json'
PEDESTALFILE='/home/lhep/PACMAN/DAQ/'$EXPERIMENT'/pedestalRuns/datalog_2020_10_31_10_47_25_CET_evd_ped.json'
DATAFILEPATH='/home/lhep/PACMAN/DAQ/'$EXPERIMENT'/dataRuns/rawData'
DATAFILE='datalog_2020_11_25__CET_.h5'
OUTPUTPATH='/home/lhep/PACMAN/DAQ/'$EXPERIMENT'/dataRuns/convertedData'
BUFFER_SIZE='38400'
EVENT_DT='1384'        # drift window [0.1us] (see table below)
NHIT_CUT='50'          # min. number of hits requested for an event
MAX_PACKETS='-1'
VD='2.168'             # drift velocity [mm/us] (see table below)
CLOCK_PERIOD='0.1'
DBSCAN_EPS='14.0'
DBSCAN_MIN_SAMPLES='5'
ELECTRONLIFETIME_FILE='/home/lhep/PACMAN/ElecLifetime_SingleCube_Bern.root'
#############################################################################
# Drift velocities and windows:
# ---------------------------------
# 0.10 kV/cm --> vd = 0.532 mm/us --> event_dt = 563.9 us
# 0.20 kV/cm --> vd = 0.932 mm/us --> event_dt = 321.9 us
# 0.25 kV/cm --> vd = 1.091 mm/us --> event_dt = 275.0 us
# 0.30 kV/cm --> vd = 1.232 mm/us --> event_dt = 243.5 us
# 0.40 kV/cm --> vd = 1.459 mm/us --> event_dt = 205.6 us
# 0.50 kV/cm --> vd = 1.647 mm/us --> event_dt = 180.1 us
# 0.60 kV/cm --> vd = 1.807 mm/us --> event_dt = 166.0 us
# 0.70 kV/cm --> vd = 1.944 mm/us --> event_dt = 154.3 us
# 0.80 kV/cm --> vd = 2.062 mm/us --> event_dt = 145.5 us
# 0.90 kV/cm --> vd = 2.168 mm/us --> event_dt = 138.4 us
# 1.00 kV/cm --> vd = 2.262 mm/us --> event_dt = 132.6 us
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'

#cd $WORKDIR/DAQ/$EXPERIMENT/dataRuns/rawData/
#unset -v DATAFILE
#DATAFILE=$(ls -tr datalog* | tail -n 1)
echo 'Using datafile' $DATAFILE

#cd $WORKDIR/DAQ/$EXPERIMENT/pedestalRuns/
#unset -v PEDESTALFILE
#PEDESTALFILE=$(ls -tr datalog* | tail -n 1)
echo 'Using pedestal file' $PEDESTALFILE

echo 'Using geometry file' $GEOMETRYFILE

unset -v OUTPUTFILENAME
OUTPUTFILENAME=${DATAFILE:0:-3}'evd.h5'
echo 'Output filename:' $OUTPUTFILENAME

rm $WORKDIR/DAQ/$EXPERIMENT/dataRuns/convertedData/$OUTPUTFILENAME

python3.6 $WORKDIR/larpix-v2-testing-scripts/event-display/to_evd_file.py \
                -i $DATAFILEPATH/$DATAFILE \
                -o $OUTPUTPATH/$OUTPUTFILENAME \
                -g $GEOMETRYFILE \
                -p $PEDESTALFILE \
                -c $CONFIGURATIONFILE \
                -b $BUFFER_SIZE \
                --event_dt $EVENT_DT \
                --nhit_cut $NHIT_CUT \
                -n $MAX_PACKETS \
                --vd $VD \
                --clock_period $CLOCK_PERIOD \
                --dbscan_eps $DBSCAN_EPS \
                --dbscan_min_samples $DBSCAN_MIN_SAMPLES
                #--electron_lifetime_file $ELECTRONLIFETIME_FILE

cd $WORKDIR/DAQ/$EXPERIMENT/dataRuns/rawData
mv $OUTPUTFILENAME ../convertedData/$OUTPUTFILENAME
echo 'Saved converted file' $OUTPUTFILENAME 'to' $WORKDIR '/DAQ/$EXPERIMENT/convertedData/' $OUTPUTFILENAME

cd $WORKDIR/larpix-DAQ
