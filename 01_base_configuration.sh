#!/bin/bash
#############################################################################
CONTROLLER_CONFIG='network-10x10-tile-singlecube.json'
LOGGER=false   # Flag to create an HDF5Logger object to track data
NO_RESET=false # Flag that if present, chips will NOT be reset, otherwise chips will be reset during initialization
#############################################################################

#WORKDIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
WORKDIR='/home/daq/PACMAN'

cd $WORKDIR/larpix-10x10-scripts

if ! $LOGGER && ! $NO_RESET
then
    python3 base.py --controller_config controller/$CONTROLLER_CONFIG
fi
if $LOGGER && ! $NO_RESET
then
    python3 base.py --controller_config controller/$CONTROLLER_CONFIG --logger
fi
if ! $LOGGER && $NO_RESET
then
    python3 base.py --controller_config controller/$CONTROLLER_CONFIG --no_reset
fi
if $LOGGER && $NO_RESET
then
    python3 base.py --controller_config controller/$CONTROLLER_CONFIG --logger --no_reset
fi

cd $WORKDIR/larpix-DAQ
