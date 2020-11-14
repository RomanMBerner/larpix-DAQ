#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_Nov2020'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
PERIODIC_TRIGGER_CYCLES=1000000 # Periodic trigger rate in LArPix clock cycles (default=1000000)
RUNTIME=120                     # Duration for run (in seconds) (default=60)
CHANNELS='[0,1]'                # if used, uncomment below
CHIP_KEY='1-1-11'               # if used, uncomment below
DISABLED_CHANNELS='[6,7,8,9,22,23,24,25,38,39,40,54,55,56,57]' # if used, uncomment below #'[]' # $(cat larpix-10x10-scripts/disabled_channels.json) #'[6,7,8,9,22,23,24,25,38,39,40,54,55,56,57]' # if used, uncomment below
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'

cd $WORKDIR/larpix-10x10-scripts
python3.6 pedestal.py --controller_config controller/$CONTROLLER_CONFIG --periodic_trigger_cycles $PERIODIC_TRIGGER_CYCLES --runtime $RUNTIME --disabled_channels $DISABLED_CHANNELS #--chip_key $CHIP_KEY #--channels $CHANNELS #--chip_key=$CHIP_KEY 

unset -v DATAFILE
DATAFILE=$(ls -tr datalog* | tail -n 1)
mv $DATAFILE $WORKDIR/DAQ/$EXPERIMENT/pedestalRuns/$DATAFILE
echo 'Pedestal run file saved in' $WORKDIR'/DAQ/'$EXPERIMENT'/pedestalRuns/$DATAFILE'

#LOGGERFILE=$(ls -tr datalog* | tail -n 1)
#mv $LOGGERFILE $WORKDIR/DAQ/$EXPERIMENT/loggerFiles/$LOGGERFILE
echo 'Logger file saved in' $WORKDIR'/DAQ/'$EXPERIMENT'/loggerFiles/'$LOGGERFILE

cd $WORKDIR/DAQ/$EXPERIMENT/pedestalRuns/
python2.7 -i $WORKDIR/larpix-v2-testing-scripts/plotting-scripts/plot_pedestal.py $WORKDIR/DAQ/$EXPERIMENT/pedestalRuns/$DATAFILE

cd $WORKDIR/larpix-DAQ
