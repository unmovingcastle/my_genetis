#!/bin/bash  

#### Things you should always do when coding:
#### (1)Comment everything as thoroughly as possible
#### (2)Every time you add a directory add the entire path - not just the path from where this file is currently located. That way if the file moves locations, it will still run without issue,
#### since the whole path name is there. Ie "/fs/project/PAS0654/Coding_Practice/Moved_Files" versus writing "/Moved_Files"   
#### (3)ALWAYS make sure your directories are made as variables. Ie. workingDir = /fs/project/PAS0654/Coding_Practice. This way later you can use $workingDir/Moved_Files for example. 
#### This makes it MUCH easier for other users to pull a version off of gitHub since they will only have to edit the directory in one place instead of many!
 

#### These are my variables. The user should always check these before starting a run.
num=3                # This is the variable used in calculate.py
FileNum=10           # This is for the number of files I have to move. Since I only have 10 files, I can only move from 1-10 files.
ScaleFactor=500      # This is the factor I am scaling my x axis in plot.py by. 
Looping=2            # This is how many times I am going to loop this code.
RunName='Wooo'       # This is to name the file after what "run" we have done. 
workingDir=/fs/project/PAS0654/Coding_Practice      #This is the variable mentioned above in (3)

#### Must make the RunName directory. If you put this in the loop, it would try to make it every time, and will give you an error.                                                                                                                                                  
mkdir $workingDir/Runs/$RunName/


for gen in `seq 1 $Looping`
do  

#### Here I am creating a for loop that will copy $FileNum number of files to a different directory while changeing the name of them in the new directory
#### they are being moved to. It looks like: cp path/where/files/currently/extis/filesname.txt path/where/files/are/moved/to/NEWNAME.txt.
for i in `seq 1 $FileNum`
do

    cp $workingDir/Files/${i}.txt $workingDir/Moved_Files/moved_${i}.txt

done

#### This prints this line to consul.
echo 'All files have been moved!'
echo '...'
echo '...'
echo '...'
echo '...'

#### This line removed all of the files from the directory they were orginially in. Note there are scenarios where we could use rm -r path/to/files/*txt. 
#### This would remove all files that end in txt. Note that this would throw an error if we didn't have '-r' since it is recursively removing (ie removes multiple files)
for i in `seq 1 $FileNum`
do

    rm -r $workingDir/Files/${i}.txt

done 

#### I am using these to space out my outputs.
echo '...'
echo '...'
echo '...'
echo '...'

#### Now we are actually just putting these files back so that when we loop it, it will not give us an error because it cannot find the files we are trying to copy 
#### since we removed them in the step above. We don't need to remove these from the "Moved_Files" directory after because when this loops it will just overwrite them every time. 
for i in `seq 1 $FileNum`                                                                                                                                                                 
do                                                                                                                                                                                     

    cp $workingDir/Moved_Files/moved_${i}.txt $workingDir/Files/${i}.txt                                                              
done 

#### This print the line to consul.
echo 'All files have been moved back!'
echo '...'
echo '...'
echo '...'
echo '...'

#### This line runs calculate.py with the flag -- ie variable -- num from above. Note that we call the variable we declared above with a $ (but don't need the $
#### when we declare the variable in the beginning, only when we call it later in the bash script). 
python $workingDir/Array/calculate.py $num

#### I am using these to space out my outputs.
echo '...'
echo '...'
echo '...'
echo '...'

#### This is the sed command. It works as 'sed -e "s/WORD_YOURE_REPLACING/NEW_WORD_OR_NUM/". This will replace the first instance of this word. There are ways to replace
#### all instances of a word; however we aren't doing that here. 
#### 
#### Note that if we just replaced this word in Plot.py and didn't pipe it to a new file this would not allow us to loop the bash script. (pipe line
#### is /fs/project/PAS0654/Coding_Practice/Plot/Plot.py > /fs/project/PAS0654/Coding_Practice/Plot/New_Plot.py which writes all of the code in Plot.py WITH this new replacement 
#### for "SCALED" into a new .py called "NEW_PLOT.py"). 
#### 
#### Once it was replaced "SCALED" in the original file, this line wouldn't know what to find because the string "SCALED" wouldn't exist anymore. It would output an error to
#### consul every loop after the first. 

#### Similarly, if you went to run it again later & changed "ScaleFactor" at the top, it wouldn't replace it, since there is no "SCALE" string of text in Plot.py anymore.  

sed -e "s/SCALE/$ScaleFactor/" $workingDir/Plot/Plot.py > $workingDir/Plot/New_Plot.py

echo '...'
echo '...'
echo '...'
echo '...'

#### This line runs New_Plot.py
python $workingDir/Plot/New_Plot.py

echo '...'
echo '...'
echo '...'
echo '...'

#### This line created a text file with the loop number in it each time. It will overwrite it self each loop -- as well as each time I run this script.
echo ${Looping} > $RunName.txt

#### This moves the file created above before the next loop starts and renames it so it will not be deleted. However, if I run this again, it will overwrite these files
#### if we do not change the $RunName.
mv $workingDir/$RunName.txt $workingDir/Runs/$RunName/

#### We are moving our plot so it is not overwritten. 
mv $workingDir/test_plot1.png $workingDir/Runs/$RunName/

done
