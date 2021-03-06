#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_March2021'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network config file #"network-10x10-tile-4chips.json"
WORKDIR='/home/daq/PACMAN'
DATADIR='/data/LArPix'
CHIP_KEY='1-4-101'          # if used, uncomment below
THRESHOLD=128               # Global threshold value to set (default=128)
RUNTIME=10                  # Duration for run (in seconds) (default=60)
CHANNELS='[18,19,20,21,22]' #'[6,7,8,9,22,23,24,25,38,39,40,54,55,56,57]'  # List of channels to collect data from (json formatted)
#############################################################################

cd $WORKDIR/larpix-10x10-scripts
python3 leakage_current_rough.py --controller_config controller/$CONTROLLER_CONFIG \
                                 --threshold $THRESHOLD \
                                 --runtime $RUNTIME
                                 #--channels $CHANNELS
                                 #--chip_key $CHIP_KEY

unset -v DATAFILE
DATAFILE=$(ls -tr datalog* | tail -n 1)
mv $DATAFILE $DATADIR/$EXPERIMENT/leakageCurrentRuns/$DATAFILE
echo 'LeakageCurrent run file saved in' $WORKDIR'/'$EXPERIMENT'/leakageCurrentRuns/'$DATAFILE

cd $DATADIR/$EXPERIMENT/leakageCurrentRuns/
python3 $WORKDIR/larpix-v2-testing-scripts/plotting-scripts/plot_leakage.py $DATADIR/$EXPERIMENT/leakageCurrentRuns/$DATAFILE

cd $WORKDIR/larpix-DAQ
