#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_March2021'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
WORKDIR='/home/daq/PACMAN'
DATADIR='/data/LArPix'
PERIODIC_TRIGGER_CYCLES=1000000 # Periodic trigger rate in LArPix clock cycles (default=1000000)
RUNTIME=5 #120                 # Duration for run (in seconds) (default=60)
CHANNELS='[0,1]'                # if used, uncomment below
CHIP_KEY='1-1-11'               # if used, uncomment below
DISABLED_CHANNELS=$(cat $WORKDIR/larpix-10x10-scripts/disabled_channels_cold_10x10_chips_2020_11_27.json) # if used, uncomment below
#############################################################################

echo "Disabled channels: $DISABLED_CHANNELS"

cd $WORKDIR/larpix-10x10-scripts
python3 pedestal.py --controller_config controller/$CONTROLLER_CONFIG \
                    --periodic_trigger_cycles $PERIODIC_TRIGGER_CYCLES \
                    --runtime $RUNTIME \
                    #--disabled_channels "$DISABLED_CHANNELS"
                    #--chip_key $CHIP_KEY
                    #--channels $CHANNELS

unset -v DATAFILE
DATAFILE=$(ls -tr datalog* | tail -n 1)
mv $DATAFILE $DATADIR/$EXPERIMENT/pedestalRuns/$DATAFILE
echo 'Pedestal run file saved in' $DATADIR'/'$EXPERIMENT'/pedestalRuns/'$DATAFILE
DATAFILE='datalog_2021_03_01_12_11_16_CET_.h5'

cd $WORKDIR/larpix-DAQ
python3 $WORKDIR/larpix-v2-testing-scripts/plotting-scripts/plot_pedestal.py $DATADIR/$EXPERIMENT/pedestalRuns/$DATAFILE
