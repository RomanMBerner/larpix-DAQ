#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_Nov2020'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
RUNTIME=1800 # Time duration before flushing remaining data to disk and initiating a new run (in seconds) (default=1800)
CONFIGFILE='$WORKDIR/DAQ/'$EXPERIMENT'/thresholds/' # single file or directory
OUTDIR=$WORKDIR'/DAQ/'$EXPERIMENT'/dataRuns/rawData/'
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'
echo 'Using configuration from' $CONFIGFILE

cd $WORKDIR/larpix-10x10-scripts
python3.6 -i start_run.py --config_name $CONFIGFILE --controller_config controller/$CONTROLLER_CONFIG --runtime $RUNTIME --outdir $OUTDIR #&>/dev/null &!

##LOGGERFILE=$(ls -tr datalog* | tail -n 1)
##mv $LOGGERFILE $WORKDIR/DAQ/$EXPERIMENT/loggerFiles/$LOGGERFILE
##echo 'Logger file saved in' $WORKDIR'/DAQ/'$EXPERIMENT'/loggerFiles/'$LOGGERFILE

cd $WORKDIR/larpix-DAQ
