#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_Nov2020'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
RUNTIME=1800 # Time duration of the run (in seconds) (default=1800)
THRESHOLDFILES=$WORKDIR'/DAQ/'$EXPERIMENT'/thresholds/' # single file or directory
OUTDIR=$WORKDIR'/DAQ/'$EXPERIMENT'/dataRuns/rawData/'
DISABLED_CHANNELS=$(cat /home/lhep/PACMAN/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_11_27.json)
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'
echo 'Using configurations from' $THRESHOLDFILES

cd $WORKDIR/larpix-10x10-scripts
python3.6 -i start_run.py --config_name $THRESHOLDFILES \
                          --controller_config controller/$CONTROLLER_CONFIG \
                          --runtime $RUNTIME \
                          --outdir $OUTDIR \
                          --disabled_channels "${DISABLED_CHANNELS}"
                          #&>/dev/null &!

##LOGGERFILE=$(ls -tr datalog* | tail -n 1)
##mv $LOGGERFILE $WORKDIR/DAQ/$EXPERIMENT/loggerFiles/$LOGGERFILE
##echo 'Logger file saved in' $WORKDIR'/DAQ/'$EXPERIMENT'/loggerFiles/'$LOGGERFILE

cd $WORKDIR/larpix-DAQ
