
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
gen=$1
NPOP=$2
WorkingDir=$3
#WorkingDir=/users/PAS1960/eliotaferstl/GENETISBicone/BiconeEvolution/current_antenna_evo_build/XF_Loop/Evolutionary_Loop
RunName=$4
GeoFactor=$5
SYMMETRY=$6
LENGTH=$7
ANGLE=$8
NSECTIONS=$9

echo "Flag: Beginning Part A"
#chmod -R 777 /fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/

cd $WorkingDir
if [ $gen -eq 0 ]
then

	echo "Flag: Running GA Initial Generation"
	./GA/Executables/rouletteWithSwitches.exe start $NPOP $GeoFactor $SYMMETRY $LENGTH $ANGLE $NSECTIONS
	echo "Flag: Finished GA Initial Generation"

else

	echo "Flag: Running GA First Generation"
	./GA/Executables/rouletteWithSwitches.exe cont $NPOP $GeoFactor $SYMMETRY $LENGTH $ANGLE $NSECTIONS
	echo "Flag: Finished GA First Generation"

fi

echo "Flag: Successfully Ran GA!"

cp Generation_Data/generationDNA.csv Run_Outputs/$RunName/${gen}_generationDNA.csv
mv Generation_Data/parents.csv Run_Outputs/$RunName/${gen}_parents.csv
mv Generation_Data/genes.csv Run_Outputs/$RunName/genes.csv
mv Generation_Data/mutations.csv Run_Outputs/$RunName/${gen}_mutations.csv
mv Generation_Data/generators.csv Run_Outputs/$RunName/${gen}_generators.csv 

#chmod -R 777 /fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/

