#!/bin/bash
#############################################################################
#EXPERIMENT='SingleCube_Oct2020'
EXPERIMENT='SingleModule_Nov2020'
GEOMETRYFILE='/home/lhep/PACMAN/larpix-geometry/larpixgeometry/layouts/layout-2.4.0.yaml'
CONFIGURATIONFILE='/data/'$EXPERIMENT'/LArPix/config_files/evd_config_20-11-11_16-19-15.json'
PEDESTALFILE='/data/'$EXPERIMENT'/LArPix/pedestalRuns/datalog_2020_11_29_13_00_07_CET_evd_ped.json'
DATAFILE='datalog_2020_11_29_12_22_02_CET_.h5'
EFIELD='0.5'           # E-field intensity [kV/cm]
DATAFILEPATH='/data/'$EXPERIMENT'/LArPix/dataRuns/rawData'
OUTPUTPATH='/data/'$EXPERIMENT'/LArPix/dataRuns/convertedData'
BUFFER_SIZE='38400'
NHIT_CUT='50'          # min. number of hits requested for an event
MAX_PACKETS='-1'
CLOCK_PERIOD='0.1'
DBSCAN_EPS='20.0'      # 14
DBSCAN_MIN_SAMPLES='5'
ELECTRONLIFETIME_FILE='/home/lhep/PACMAN/eLifetime_files/ElecLifetime_Module0HV.root'
#############################################################################
# Drift velocities and windows for SingleCube_Oct2020 experiment:
# 0.10 kV/cm --> vd = 0.532 mm/us --> event_dt = 5639 [0.1 us]
# 0.20 kV/cm --> vd = 0.932 mm/us --> event_dt = 3219 [0.1 us]
# 0.25 kV/cm --> vd = 1.091 mm/us --> event_dt = 2750 [0.1 us]
# 0.30 kV/cm --> vd = 1.232 mm/us --> event_dt = 2435 [0.1 us]
# 0.40 kV/cm --> vd = 1.459 mm/us --> event_dt = 2056 [0.1 us]
# 0.50 kV/cm --> vd = 1.647 mm/us --> event_dt = 1801 [0.1 us]
# 0.60 kV/cm --> vd = 1.807 mm/us --> event_dt = 1660 [0.1 us]
# 0.70 kV/cm --> vd = 1.944 mm/us --> event_dt = 1543 [0.1 us]
# 0.80 kV/cm --> vd = 2.062 mm/us --> event_dt = 1455 [0.1 us]
# 0.90 kV/cm --> vd = 2.168 mm/us --> event_dt = 1384 [0.1 us]
# 1.00 kV/cm --> vd = 2.262 mm/us --> event_dt = 1326 [0.1 us]
#############################################################################
# Drift velocities and windows for SingleModule_Nov2020 experiment:
# 0.1 kV/cm --> vd = 0.0535 mm/us --> event_dt = 5981 [0.1 us]
# 0.2 kV/cm --> vd = 0.0933 mm/us --> event_dt = 3430 [0.1 us]
# 0.3 kV/cm --> vd = 0.1230 mm/us --> event_dt = 2602 [0.1 us]
# 0.4 kV/cm --> vd = 0.1461 mm/us --> event_dt = 2190 [0.1 us]
# 0.5 kV/cm --> vd = 0.1648 mm/us --> event_dt = 1942 [0.1 us]
# 0.6 kV/cm --> vd = 0.1806 mm/us --> event_dt = 1772 [0.1 us]
# 0.7 kV/cm --> vd = 0.1941 mm/us --> event_dt = 1649 [0.1 us]
# 0.8 kV/cm --> vd = 0.2060 mm/us --> event_dt = 1553 [0.1 us]
# 0.9 kV/cm --> vd = 0.2166 mm/us --> event_dt = 1477 [0.1 us]
# 1.0 kV/cm --> vd = 0.2261 mm/us --> event_dt = 1415 [0.1 us]
#############################################################################

# Set parameters related to the electric field intensity
if [ $EFIELD == 0.1 ]; then
    EVENT_DT='5981'
    VD='0.0535'
elif [ $EFIELD == 0.2 ]; then
    EVENT_DT='3430'
    VD='0.0933'
elif [ $EFIELD == 0.3 ]; then
    EVENT_DT='2602'
    VD='0.1230'
elif [ $EFIELD == 0.4 ]; then
    EVENT_DT='2190'
    VD='0.1461'
elif [ $EFIELD == 0.5 ]; then
    EVENT_DT='1942'
    VD='0.1648'
elif [ $EFIELD == 0.6 ]; then
    EVENT_DT='1772'
    VD='0.1806'
elif [ $EFIELD == 0.7 ]; then
    EVENT_DT='1649'
    VD='0.1941'
elif [ $EFIELD == 0.8 ]; then
    EVENT_DT='1553'
    VD='0.2060'
elif [ $EFIELD == 0.9 ]; then
    EVENT_DT='1477'
    VD='0.2166'
elif [ $EFIELD == 1.0 ]; then
    EVENT_DT='1415'
    VD='0.2261'
else
    echo 'WARNING: E-field intensity not properly set!'
fi

echo 'Using the following E-field related parameters:'
echo 'EFIELD   =' $EFIELD
echo 'EVENT_DT =' $EVENT_DT
echo 'VD       =' $VD


#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'

#cd $WORKDIR/DAQ/$EXPERIMENT/dataRuns/rawData/
#unset -v DATAFILE
#DATAFILE=$(ls -tr datalog* | tail -n 1)
echo 'Data file:     ' $DATAFILE

#cd $WORKDIR/DAQ/$EXPERIMENT/pedestalRuns/
#unset -v PEDESTALFILE
#PEDESTALFILE=$(ls -tr datalog* | tail -n 1)
echo 'Pedestal file: ' $PEDESTALFILE

echo 'Geometry file: ' $GEOMETRYFILE

unset -v OUTPUTFILENAME
OUTPUTFILENAME=${DATAFILE:0:-3}'evd.h5'
echo 'Output file:   ' $OUTPUTFILENAME

rm /data/$EXPERIMENT/LArPix/dataRuns/convertedData/$OUTPUTFILENAME

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

echo 'Saved converted file to' $OUTPUTPATH'/'$OUTPUTFILENAME

cd $WORKDIR/larpix-DAQ
