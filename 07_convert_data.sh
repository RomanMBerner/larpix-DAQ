#!/bin/bash
#############################################################################
#EXPERIMENT='SingleCube_Oct2020'
EXPERIMENT='SingleModule_Nov2020'
GEOMETRYFILE='/home/lhep/PACMAN/larpix-geometry/larpixgeometry/layouts/layout-2.4.0.yaml'
CONFIGURATIONFILE='/data/'$EXPERIMENT'/LArPix/config_files/evd_config_20-11-11_16-19-15.json'
PEDESTALFILE='/home/lhep/PACMAN/DAQ/'$EXPERIMENT'/pedestalRuns/datalog_2020_11_29_11_12_31_CET_evd_ped.json'
DATAFILEPATH='/home/lhep/PACMAN/DAQ/'$EXPERIMENT'/dataRuns/rawData'
DATAFILE='datalog_2020_11_29_10_29_51_CET_.h5'
OUTPUTPATH='/home/lhep/PACMAN/DAQ/'$EXPERIMENT'/dataRuns/convertedData'
BUFFER_SIZE='38400'
EVENT_DT='1942'        # drift window [0.1us] (see table below)
NHIT_CUT='50'          # min. number of hits requested for an event
MAX_PACKETS='-1'
VD='1.648'             # drift velocity [mm/us] (see table below)
CLOCK_PERIOD='0.1'
DBSCAN_EPS='20.0'      # 14
DBSCAN_MIN_SAMPLES='5'
#ELECTRONLIFETIME_FILE='/home/lhep/PACMAN/ElecLifetime_SingleCube_Bern.root'
#############################################################################
# Drift velocities and windows for SingleCube_Oct2020 experiment:
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
# Drift velocities and windows for SingleModule_Nov2020 experiment:
# 0.2500 kV/cm --> vd = 1.092 mm/us --> event_dt = 293.04 us
# 0.2508 kV/cm --> vd = 1.094 mm/us --> event_dt = 292.50 us
# 0.5000 kV/cm --> vd = 1.648 mm/us --> event_dt = 194.17 us
# 0.7011 kV/cm --> vd = 1.942 mm/us --> event_dt = 164.78 us
# 0.7500 kV/cm --> vd = 2.002 mm/us --> event_dt = 159.84 us
# 1.0000 kV/cm --> vd = 2.261 mm/us --> event_dt = 141.53 us
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

#cd $WORKDIR/DAQ/$EXPERIMENT/dataRuns/rawData
#mv $OUTPUTFILENAME ../convertedData/$OUTPUTFILENAME
#echo 'Saved converted file' $OUTPUTFILENAME 'to' $WORKDIR '/DAQ/$EXPERIMENT/convertedData/' $OUTPUTFILENAME

cd $WORKDIR/larpix-DAQ
