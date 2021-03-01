#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_March2021'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
BASE_CONFIG=''                                         # Chip configuration to load prior to threshold scan (default=configs/autothreshold_base.json)
WORKDIR='/home/daq/PACMAN'
DATADIR='/data/LArPix'
CHIP_KEY='1-2-42'                                      # if used, uncomment below
CHANNELS='[0,1]'                                       # if used, uncomment below
DISABLED_CHANNELS=$(cat /home/daq/PACMAN/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_11_27.json)
RUNTIME=1                                              # Period to measure rate for (seconds, default=1)
TARGET_RATE=5                                          # Target max rate for individual channel (Hz, default=2)
DISABLE_THRESHOLD=100                                  # Maximum rate allowed with trim at 31 (Hz, default=20)
#############################################################################

cd $WORKDIR/larpix-10x10-scripts
python3 -i autoconfig_thresholds.py --controller_config controller/$CONTROLLER_CONFIG \
                                    --runtime $RUNTIME \
                                    --disabled_channels "$DISABLED_CHANNELS"
                                    #--chip_key $CHIP_KEY
                                    #--target_rate $TARGET_RATE
                                    #--disable_threshold $DISABLE_THRESHOLD
                                    #--channels $CHANNELS

mv $(find . -name 'config-*.json') $DATADIR/$EXPERIMENT/thresholdFiles/
echo 'Threshold files saved in' $DATADIR'/'$EXPERIMENT'/thresholdFiles'

cd $WORKDIR/larpix-DAQ
