#This is a version of Part_D1 that uses multiple Seeds for a version of AraSim
########  AraSim Execution (D)  ################################################################################################################## 
#
#
#       1. Moves each .dat file individually into a folder that AraSim can access while changing to a .txt file that AraSim can use. (can we just have the .py program make this output a .txt?)
#
#       2. For each individual ::
#           I. Run Arasim for that text file
#           III. Moves the AraSim output into the Antenna_Performance_Metric folder
#
#
################################################################################################################################################## 

#variables
gen=$1
NPOP=$2
WorkingDir=$3
AraSimExec=$4
exp=$5
NNT=$6
RunName=$7
Seeds=$8
DEBUG_MODE=$9
SpecificSeed=32000

#chmod -R 777 /fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/

cd $WorkingDir

# I'm going to make a directory to hold the AraSim output and error files for each gen
mkdir -m775 Run_Outputs/$RunName/${gen}_AraSim_Outputs
mkdir -m775 Run_Outputs/$RunName/${gen}_AraSim_Errors

cd Antenna_Performance_Metric
for i in `seq 1 $NPOP`
do
	mv evol_antenna_model_${i}.dat $AraSimExec/a_${i}.txt
done

#read -p "Press any key to continue... " -n1 -s
echo "Resuming..."
echo

rm -f $WorkingDir/job_list.txt
cd "$AraSimExec"

# If we're doing a real run, we only need to change the setup .txt file once
# Although we need to be carefuly, since maybe eventually we'll want to run multiple times at once?
if [ $DEBUG_MODE -eq 0 ]
then

############################                             
	###This next line replaces the number of neutrinos thrown in our setup.txt AraSim file with what ever number you assigned NNT at the top of this program. setup_dummy.txt  ###                             
	###is a copy of setup.txt that has NNU=num_nnu (NNU is the number of neutrinos thrown. This line finds every instance of num_nnu in setup_dummy.txt and replaces it with   ###                             
	###$NNT (the number you assigned NNT above). It then pipes this information into setup.txt (and overwrites the last setup.txt file allowing the number of neutrinos thrown ###                             
	###to be as variable changed at the top of this script instead of manually changing it in setup.txt each time. Command works the following way:                            ###                             
	###sed "s/oldword/newwordReplacingOldword/" path/to/filewiththisword.txt > path/to/fileWeAreOverwriting.txt                                                                ###                             
############################

	sed -e "s/num_nnu/$NNT/" -e "s/n_exp/$exp/" -e "s/current_seed/$SpecificSeed/" ${AraSimExec}/setup_dummy_araseed.txt > ${AraSimExec}/setup.txt

	# Now we just need to run AraSim from the setup file

	for i in `seq 1 $NPOP`
	do
		for j in `seq 1 $Seeds`
		do
			cd $WorkingDir
			output_name=/fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/current_antenna_evo_build/XF_Loop/Evolutionary_Loop/Run_Outputs/$RunName/${gen}_AraSim_Outputs/${gen}_${i}_${j}.output
			error_name=/fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/current_antenna_evo_build/XF_Loop/Evolutionary_Loop/Run_Outputs/$RunName/${gen}_AraSim_Errors/${gen}_${i}_${j}.error
			jobscript=$(sbatch --export=ALL,gen=$gen,num=$i,WorkingDir=$WorkingDir,RunName=$RunName,Seeds=$j,AraSimDir=$AraSimExec --job-name=AraSimCall_AraSeed_${gen}_${i}_${j}.run --output=$output_name --error=$error_name Batch_Jobs/AraSimCall_AraSeed.sh)
			echo ${jobscript}		
	
			jobID=$(echo "${jobscript}" | tr -d -c 0-9) 
			touch $WorkingDir/job_list.txt 
			chmod 775 $WorkingDir/job_list.txt
			echo $jobID >> $WorkingDir/job_list.txt 
	
			cd $AraSimExec
			rm -f outputs/*.root
		done

	done

# If we're testing with the seed, use DEBUG_MODE=1
# Then, we'll change the setup file for each job
else
	for i in `seq 1 $NPOP`
	do
		for j in `seq 1 $Seeds`
		do
		# I think we want to use the below commented out version
		# but I'm commenting it out for testing purposes
		SpecificSeed=$(expr $j + 32000)
		#SpecificSeed=32000

		sed -e "s/num_nnu/$NNT/" -e "s/n_exp/$exp/" -e "s/current_seed/$SpecificSeed/" ${AraSimExec}/setup_dummy_araseed.txt > ${AraSimExec}/setup.txt
		
		#We will want to call a job here to do what this AraSim call is doing so it can run in parallel
		cd $WorkingDir
		output_name=/fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/current_antenna_evo_build/XF_Loop/Evolutionary_Loop/Run_Outputs/$RunName/${gen}_AraSim_Outputs/${gen}_${i}_${j}.output
		error_name=/fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/current_antenna_evo_build/XF_Loop/Evolutionary_Loop/Run_Outputs/$RunName/${gen}_AraSim_Errors/${gen}_${i}_${j}.error
		jobscript=$(sbatch --export=ALL,gen=$gen,num=$i,WorkingDir=$WorkingDir,RunName=$RunName,Seeds=$j,AraSimDir=$AraSimExec --job-name=AraSimCall_AraSeed_${gen}_${i}_${j}.run --output=$output_name --error=$error_name Batch_Jobs/AraSimCall_AraSeed.sh)

		jobID=$(echo "${jobscript}" | tr -d -c 0-9)
		touch $WorkingDir/job_list.txt 
		chmod 775 $WorkingDir/job_list.txt
		echo $jobID >> $WorkingDir/job_list.txt

		# We are going to implement a notificaiton system
		# This will require being able to know the job IDs
		# We'll print this to a file and then read read it in D2
		
		cd $AraSimExec
		rm -f outputs/*.root
		done
	done
fi

#This submits the job for the actual ARA bicone. Veff depends on Energy and we need this to run once per run to compare it to. 
if [ $gen -eq 10000 ]
then
	#sed -e "s/num_nnu/100000" /fs/ess/PAS1960/BiconeEvolutionOSC/AraSim/setup_dummy_araseed.txt > /fs/ess/PAS1960/BiconeEvolutionOSC/AraSim/setup.txt
	sbatch --export=ALL,WorkingDir=$WorkingDir,RunName=$RunName,AraSimDir=$AraSimExec Batch_Jobs/AraSimBiconeActual_Prototype.sh 

fi
#Any place we see the directory AraSimFlags we need to change that so that AraSimFlags is a directory under the runname directory
#cd $WorkingDir/AraSimFlags/

#chmod -R 777 /fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/

