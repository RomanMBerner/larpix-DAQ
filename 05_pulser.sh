#!/bin/bash
#############################################################################
EXPERIMENT='SingleModule_Nov2020'
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json' # Hydra network configuration file
THRESHOLDFILES=$WORKDIR'/DAQ/'$EXPERIMENT'/thresholds/' # /TestPulse_10Nov2020/' #10x10chips_without_pump_updated/" # Config file or directory to load chip configs from (take last produced config file, see below)
CHIP_KEY='1-1-11' # if used, uncomment below
PULSE_DAC=27       # Amplitude for test pulses in DAC counts (default=10)
N_PULSES=50       # Number of test pulses to issue on each channel (default=10)
CHANNELS='[0,1]'  # List of channels to issue test pulses to issue on each channel
RUNTIME=0.010       # Time window to collect data after issuing each test pulse (in seconds) (default=0.1)
START_DAC=95      # Starting DAC value to issue test pulses from (default=95)
#TRACK_STATS='--track_stats' # keep track of channel-by-channel triggering stats and print a summary (comment out to disable)
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/PACMAN'
#cd $WORKDIR/DAQ/config_files/
echo Using configurations from $THRESHOLDFILE

cd $WORKDIR/larpix-10x10-scripts
python3.6 -i internal_pulse.py --config_name $THRESHOLDFILES \
                               --controller_config controller/$CONTROLLER_CONFIG \
                               --pulse_dac $PULSE_DAC \
                               --n_pulses $N_PULSES \
                               --runtime $RUNTIME \
                               $TRACK_STATS
                               #--start_dac $START_DAC
                               #--chip_key $CHIP_KEY
                               #--channels $CHANNELS

unset -v DATAFILE
DATAFILE=$(ls -tr datalog* | tail -n 1)
mv $DATAFILE $WORKDIR/DAQ/$EXPERIMENT/pulser/$DATAFILE
echo 'Pulser file saved in' $WORKDIR'/DAQ/'$EXPERIMENT'/pulser/'$DATAFILE

# To plot output of a single chip:
# Note: Change datafiles in /larpix-v2-testing-scripts/plotting-scripts/pulser_config_file.json
# cd $WORKDIR/larpix-v2-testing-scripts/plotting-scripts/
# python3.6 -i plot_testpulse.py 1000000 $WORKDIR/larpix-v2-testing-scripts/plotting-scripts/pulser_config_file.json

cd $WORKDIR/larpix-DAQ
