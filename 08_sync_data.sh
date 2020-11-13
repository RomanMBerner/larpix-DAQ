#!/bin/bash
################################################################
# Bash script to copy the files produced by the charge r/o
# to a sync directory. Enter SOURCE_DIR and SYNC_DIR below.
# Last modified: 2020-11-01 by rberner.
#
SOURCE_DIR='/home/lhep/PACMAN/DAQ'
USR='lhep'
HOST='lhepacube11.lhep.unibe.ch'
SYNC_DIR='/data/SingleCube_Oct2020/LArPix'
################################################################
while true
do
    rsync -auvE --delete $SOURCE_DIR/ $USR@$HOST:$SYNC_DIR/
    sleep 1m
done
