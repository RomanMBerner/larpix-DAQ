#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_Nov2020'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
RUNTIME=180 #0 # Time duration of the run (in seconds) (default=1800)
#THRESHOLDFILES=$WORKDIR'/DAQ/'$EXPERIMENT'/thresholds/' # single file or directory
THRESHOLDFILES='/home/lhep/PACMAN/DAQ/'$EXPERIMENT'/testing_thresholds_11_30/' # single file or directory
OUTDIR=$WORKDIR'/DAQ/'$EXPERIMENT'/dataRuns/rawData/'
#DISABLED_CHANNELS=$(cat /home/lhep/PACMAN/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_11_27.json)
#DISABLED_CHANNELS=$(cat /home/lhep/PACMAN/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_11_27_NODISABLED.json)
#DISABLED_CHANNELS=$(cat /home/lhep/PACMAN/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_11_25.json)
DISABLED_CHANNELS=$(cat /home/lhep/PACMAN/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_12_01.json)
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'
echo 'Using configurations from' $THRESHOLDFILES

cd $WORKDIR/larpix-10x10-scripts
python3.6 start_run_rate_push.py --config_name $THRESHOLDFILES \
                          --controller_config controller/$CONTROLLER_CONFIG \
                          --runtime $RUNTIME \
                          --outdir $OUTDIR \
                          --disabled_channels "${DISABLED_CHANNELS}"
                          #&>/dev/null &!

##LOGGERFILE=$(ls -tr datalog* | tail -n 1)
##mv $LOGGERFILE $WORKDIR/DAQ/$EXPERIMENT/loggerFiles/$LOGGERFILE
##echo 'Logger file saved in' $WORKDIR'/DAQ/'$EXPERIMENT'/loggerFiles/'$LOGGERFILE

cd $WORKDIR/larpix-DAQ
