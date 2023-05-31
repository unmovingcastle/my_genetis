#!/bin/bash

cd "/fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/\
current_antenna_evo_build/XF_Loop/Evolutionary_Loop/"

WorkingDir="/users/PAS2137/unmovingcastle/Documents/my_genetis/\
current_work/Evolutionary_loop/"

: << END
Mostly empty directories. Might fill them in the future.
END
# mkdir -p $WorkingDir/Antenna_Performance_Metric
# cp Antenna_Performance_Metric/*.py $WorkingDir/Antenna_Performance_Metric
# cp Antenna_Performance_Metric/*.cpp $WorkingDir/Antenna_Performance_Metric
# cp Antenna_Performance_Metric/*.sh $WorkingDir/Antenna_Performance_Metric
# mkdir -p $WorkingDir/ARA_Bicone_Data
# mkdir -p $WorkingDir/ARA_Bicone_Root_Files

: << END
Not sure if necessary, but included to be safe
So this next block is gonna take a while
END
# cp -r Batch_Jobs/ $WorkingDir
# cp -r Data_Generators/ $WorkingDir
# cp -r Database/ $WorkingDir
# cp -r developingGA/ $WorkingDir

: << END
This next block is probably the only relavent part. 
Most codes are in these directories, so I am copying
them.
END
# cp -r GA $WorkingDir
# cp -r Generation_Data $WorkingDir
# cp -r Loop_Scripts $WorkingDir
# cp -r Loop_Parts $WorkingDir

: << END
empty directories; might fill in the future
END
# mkdir -p $WorkingDir/Run_Outputs
# mkdir -p $WorkingDir/saveStates
mkdir -p $WorkingDir/scriptEOFiles
# mkdir -p $WorkingDir/XF_Errors
# mkdir -p $WorkingDir/XF_Outputs

: << END
Finally, the files
END
cp *.csv $WorkingDir
cp *.sh $WorkingDir
cp *.xmacro $WorkingDir


#####################################################
echo "I got here! Job completed :)"


