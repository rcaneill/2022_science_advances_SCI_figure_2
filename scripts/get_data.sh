#!/bin/bash


ECCO_SITE='https://ecco.jpl.nasa.gov/drive/files'

SCRIPT=$(realpath $0)
SCRIPTPATH=$(dirname $SCRIPT)

DATAPATH=$SCRIPTPATH/../data/raw
mkdir -p $DATAPATH

#cd $ECCO_DRIVE/Version4/Release4
VERSION=Version4
RELEASE=Release4
KIND=interp_monthly

read -p "username for ecco.jpl.nasa.gov: " USER
read -s -p "password (see https://ecco.jpl.nasa.gov/drive/): " PASSWORD

echo "Getting data from $VERSION/$RELEASE/$KIND/varname/$YEAR/*"

# 'oceFWflx' 'oceQnet' 'SFLUX' 'SIarea' 'TFLUX'  'SSH'
for YEAR in {1997..2017};
do
    for VAR in 'MXLDEPTH' 'THETA' 'SALT';
    do
        echo "Copying $i"
        VARPATH=$KIND/$YEAR/$VAR
        mkdir -p $DATAPATH/$VARPATH
        for m in '01' '02' '03' '04' '05' '06' '07' '08' '09' '10' '11' '12';
        do
	        wget -c -P $DATAPATH/$VARPATH --user=$USER --password=$PASSWORD ${ECCO_SITE}/${VERSION}/${RELEASE}/${KIND}/${VAR}/${YEAR}/${VAR}_${YEAR}_${m}.nc
        done
    done
done

