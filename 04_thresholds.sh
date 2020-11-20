#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_Nov2020'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
BASE_CONFIG='' # Chip configuration to load prior to threshold scan (default=configs/autothreshold_base.json)
CHIP_KEY='1-2-42'       # if used, uncomment below
CHANNELS='[0,1]'         # if used, uncomment below
DISABLED_CHANNELS=$(cat /home/lhep/PACMAN/larpix-10x10-scripts/disabled_channels_cold_10x10chips.json)
RUNTIME=1                # Period to measure rate for (seconds, default=1)
TARGET_RATE=2            # Target max rate for individual channel (Hz, default=2)
DISABLE_THRESHOLD=20     # Maximum rate allowed with trim at 31 (Hz, default=20)
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'

cd $WORKDIR/larpix-10x10-scripts
python3.6 -i autoconfig_thresholds.py --controller_config controller/$CONTROLLER_CONFIG \
                                      --runtime $RUNTIME \
                                      --disabled_channels "$DISABLED_CHANNELS"
                                      #--chip_key $CHIP_KEY
                                      #--target_rate $TARGET_RATE
                                      #--disable_threshold $DISABLE_THRESHOLD
                                      #--channels $CHANNELS

mv $(find . -name 'config-*.json') $WORKDIR/DAQ/$EXPERIMENT/thresholds/
echo 'Threshold files saved in' $WORKDIR'/DAQ/'$EXPERIMENT'/thresholds'

cd $WORKDIR/larpix-DAQ
