
########  Plotting (F)  ############################################################################################################################ 
#
#
#      1. Plots in 3D and 2D of current and all previous generation's scores. Saves the 2D plots. Extracts data from $RunName folder in all of the i_generationDNA.csv files. Plots to same directory.
#
#
#################################################################################################################################################### 
# variables
NPOP=$1
WorkingDir=$2
RunName=$3
gen=$4
Seeds=$5
NSECTIONS=$6
#chmod -R 777 /fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/

# Current Plotting Software

cd $WorkingDir

module load python/3.7-2019.10

#cp AraOut_ActualBicone_10_18.txt Run_Outputs/$RunName/AraOut_ActualBicone.txt
#cp ARA_Bicone_Data/AraOut_Actual_Bicone_Fixed_Polarity_2.9M_NNU.txt Run_Outputs/$RunName/AraOut_ActualBicone.txt

cd Antenna_Performance_Metric
# Format is source directory (where is generationDNA.csv), destination directory (where to put plots), npop
python FScorePlot.py $WorkingDir/Run_Outputs/$RunName $WorkingDir/Run_Outputs/$RunName $NPOP $gen

python3 color_plots.py $WorkingDir/Run_Outputs/$RunName/ $WorkingDir/Run_Outputs/$RunName $NPOP $gen $Seeds

mkdir -m 775 $WorkingDir/Run_Outputs/$RunName/Gain_Plots/${gen}_Gain_Plots
./image_maker.sh $WorkingDir/Run_Outputs/$RunName/Generation_Data/Generation_${gen} $WorkingDir/../Xmacros $WorkingDir/Run_Outputs/$RunName/Antenna_Images $gen $WorkingDir $RunName $NPOP

: <<'END'
cd $WorkingDir/Run_Outputs/$RunName
mail -s "FScore_${RunName}_Gen_${gen}" dropbox.2dwp1o@zapiermail.com < FScorePlot2D.png
mail -s "FScore_Color_${RunName}_Gen_${gen}" dropbox.2dwp1o@zapiermail.com < Fitness_Scores_RG.png
mail -s "Veff_${RunName}_Gen_${gen}" dropbox.2dwp1o@zapiermail.com < Veff_plot.png
mail -s "Veff_Color_${RunName}_Gen_${gen}" dropbox.2dwp1o@zapiermail.com < Veffectives_RG.png
mail -s "3D_Length_${RunName}_Gen_${gen}" dropbox.2dwplo@zapiermail.com < 3DLength.png
mail -s "3D_Radius_${RunName}_Gen_${gen}" dropbox.2dwplo@zapiermail.com < 3DRadius.png
mail -s "3D_Theta_${RunName}_Gen_${gen}" dropbox.2dwplo@zapiermail.com < 3DTheta.png

if [ $NSECTIONS -eq 1 ]
then
	mail -s "LRT_${RunName}_Gen_${gen}" dropbox.2dwp1o@zapiermail.com < LRTPlot2D.png
else
	mail -s "LRTS_${RunName}_Gen_${gen}" dropbox.2dwp1o@zapiermail.com < LRTSPlot2D.png
fi
END
cd "$WorkingDir"

echo 'Congrats on getting some nice plots!'

## I'm going to get rid of all of the slurm files being created

rm -f slurm-*

#chmod -R 777 /fs/ess/PAS1960/BiconeEvolutionOSC/BiconeEvolution/
