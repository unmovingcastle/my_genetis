#!/bin/bash
########    Execute our initial genetic algorithm (A)    #############################################################################
#
#
#   This part of the loop  ::
#
#      1. Runs genetic algorithm
#
#
#      2. Moves GA outputs and renames the .csv file so it isn't overwritten 
#
#
#
#
#######################################################################################################################################
#variables
gen=1
NPOP=8
NSECTIONS=2
WorkingDir=/users/PAS0654/eliotaferstl/GENETISBicone/BiconeEvolution/current_antenna_evo_build/XF_Loop/Evolutionary_Loop #/developingGA
RunName=Machtay_20200721_AraSim_Seed_Fix
GeoFactor=1
RADIUS=0
LENGTH=0
ANGLE=0
SEPARATION=0

cd $WorkingDir
if [ $gen -eq 0 ]
then

	./fourGeneGA_testing.exe start $NPOP $NSECTIONS $GeoFactor $RADIUS $LENGTH $ANGLE $SEPARATION

else

	./fourGeneGA_testing.exe cont $NPOP $NSECTIONS $GeoFactor $RADIUS $LENGTH $ANGLE $SEPARATION

fi

if [ $gen -eq 0 ]
then
	mkdir RunOutputs/$RunName
fi

cp generationDNA.csv RunOutputs/$RunName/${gen}_generationDNA.csv

#chmod -R 777 /fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/

