########  Execute our initial genetic algorithm (A)  ##########################################
#
# 1. Runs genetic algorithm
# 2. Moves GA outputs and renames the .csv file so it isn't overwritten.
#
###############################################################################################

# variables
gen=$1
NPOP=$2
NSECTIONS=$3
WorkingDir=$4
RunName=$5
GeoFactor=$6
RADIUS=$7
LENGTH=$8
ANGLE=$9
SEPARATION=${10}

# NOTE: the asymmetric bicone_GA.exe should be compiled from fourGeneGA_cutoff_testing.cpp
# (It tells you at the top of the cpp file how to compile)
cd $WorkingDir
# If the bcione is symmetric, we have a different algorithm to run.

if [ $NSECTIONS -eq 0 ] # if $NSECTIONS is 1, then it is symmetric (see Asym_XF_Loop.sh)
then
	# g++ -std=c++11 roulette_algorithm_cut_test.cpp -o bicone_GA.exe 
	g++ -std=c++11 GA/Algorithms/improved_GA.cpp -o GA/Executables/bicone_GA.exe
	if [ $gen -eq 0 ]
	then
		./GA/Executables/bicone_GA.exe start $NPOP $GeoFactor
	else
		./GA/Executables/bicone_GA.exe cont $NPOP $GeoFactor 
	fi	

else
	g++ -std=c++11 GA/Algorithms/Latest_Asym_GA.cpp -o GA/Executables/bicone_GA.exe
	# g++ -std=c++11 fourGeneGA_cutoff_testing.cpp -o bicone_GA.exe
	# g++ -std=c++11 GA/Algorithms/Asym_identical_starts.cpp -o bicone_GA.exe
	# g++ -std=c++11 GA/Algorithms/Asym_GA_latest_version_identical_starts.cpp\
	#  -o GA/Executables/bicone_GA.exe

	if [ $gen -eq 0 ]
	then
		# ./GA/Executables/bicone_GA.exe start $NPOP $GeoFactor 
		./GA/Executables/bicone_GA.exe start $NPOP $GeoFactor 3 36 2 #$NSECTIONS $GeoFactor #$RADIUS $LENGTH $ANGLE $SEPARATION
	else
		# ./GA/Executables/bicone_GA.exe start $NPOP $GeoFactor
		./GA/Executables/bicone_GA.exe cont $NPOP $GeoFactor 3 36 2 #3 36 8 #$NSECTIONS $GeoFactor #$RADIUS $LENGTH $ANGLE $SEPARATION 
	fi
fi
echo "Flag: Successfully Ran GA!"

# cp Generation_Data/generationDNA.csv Run_Outputs/$RunName/${gen}_generationDNA.csv
# mv Generation_Data/generators.csv Run_Outputs/$RunName/${gen}_generators.csv
mkdir -m775 $WorkingDir/Run_Outputs/$RunName/Generation_Data/Generation_${gen}
cp Generation_Data/generationDNA.csv\
 $WorkingDir/Run_Outputs/$RunName/Generation_Data/Generation_${gen}/${gen}_generationDNA.csv
mv Generation_Data/generators.csv\
 $WorkingDir/Run_Outputs/${RunName}/Generation_Data/Generation_${gen}/${gen}_generators.csv

if [ $gen -gt 0 ]
then
	mv Generation_Data/parents.csv Run_Outputs/$RunName/${gen}_parents.csv
	# mv Generation_Data/genes.csv Run_Outputs/$RunName/${gen}_mutations.csv
	# mv Generation_Data/mutations.csv Run_Outputs/$RunName/${gen}_mutations.csv
fi