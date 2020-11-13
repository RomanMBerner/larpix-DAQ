#!/bin/bash
#############################################################################
#CONTROLLER_CONFIG="network-10x10-tile-4chips.json" # Hydra network configuration file
CONTROLLER_CONFIG="network-10x10-tile-singlecube.json" # Hydra network configuration file
CONFIGFILE="$WORKDIR/DAQ/TestPulse_10Nov2020/" #10x10chips_without_pump_updated/" # Config file or directory to load chip configs from (take last produced config file, see below)
CHIP_KEY='1-1-11' # if used, uncomment below
PULSE_DAC=3      # Amplitude for test pulses in DAC counts (default=10)
N_PULSES=10       # Number of test pulses to issue on each channel (default=10)
CHANNELS='[0,1]'  # List of channels to issue test pulses to issue on each channel
RUNTIME=0.1       # Time window to collect data after issuing each test pulse (in seconds) (default=0.1)
START_DAC=95      # Starting DAC value to issue test pulses from (default=95)
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/lhep/pacman'
#cd $WORKDIR/DAQ/config_files/
echo Using config file $CONFIGFILE

cd $WORKDIR/larpix-10x10-scripts
python3.6 -i internal_pulse.py --config_name $CONFIGFILE --controller_config controller/$CONTROLLER_CONFIG --pulse_dac $PULSE_DAC --n_pulses $N_PULSES --runtime $RUNTIME #--start_dac $START_DAC #--chip_key $CHIP_KEY #--channels $CHANNELS
cd $WORKDIR/larpix-10x10-scripts/

##unset -v DATAFILE
##DATAFILE=$(ls -tr datalog* | tail -n 1)
##mv $DATAFILE $WORKDIR/DAQ/pulser/$DATAFILE
##echo "Pulser file saved in $WORKDIR/DAQ/pulser/$DATAFILE"

# To plot output of a single chip:
# Note: Change datafiles in /larpix-v2-testing-scripts/plotting-scripts/pulser_config_file.json"
# cd $WORKDIR/larpix-v2-testing-scripts/plotting-scripts/
# python2.7 -i plot_testpulse.py 1000000 $WORKDIR/larpix-v2-testing-scripts/plotting-scripts/pulser_config_file.json

cd $WORKDIR