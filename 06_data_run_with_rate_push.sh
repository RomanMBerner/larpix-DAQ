#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_March2021'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
WORKDIR='/home/lhep/PACMAN'
DATADIR='/data/LArPix'
RUNTIME=180 #0 # Time duration of the run (in seconds) (default=1800)
THRESHOLDFILES=$DATADIR'/'$EXPERIMENT'/thresholdFiles/' # single file or directory
OUTDIR=$DATADIR'/'$EXPERIMENT'/dataRuns/rawData/'
DISABLED_CHANNELS=$(cat $WORKDIR/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_12_01.json)
#############################################################################

echo 'Using configurations from' $THRESHOLDFILES

cd $WORKDIR/larpix-10x10-scripts
python3 start_run_rate_push.py --config_name $THRESHOLDFILES \
                               --controller_config controller/$CONTROLLER_CONFIG \
                               --runtime $RUNTIME \
                               --outdir $OUTDIR \
                               --disabled_channels "${DISABLED_CHANNELS}"
                               #&>/dev/null &!

##LOGGERFILE=$(ls -tr datalog* | tail -n 1)
##mv $LOGGERFILE $DATADIR/$EXPERIMENT/loggerFiles/$LOGGERFILE
##echo 'Logger file saved in' $DATADIR'/'$EXPERIMENT'/loggerFiles/'$LOGGERFILE

cd $WORKDIR/larpix-DAQ
