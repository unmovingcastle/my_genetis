#!/bin/bash                                                                                                                                                                                          
#### These are my variables   
startingLine=4         ## This tells us what line in our CSV file to start saving as a list in our python program. Remember it saves each line from here until the end as a separate list.         
XScale=10              ## This will be used to scale our X entries of our CSV file after they are converted to an array! 
YScale=2               ## This will be used to scale our Y entries of our CSV file after they are converted to an array! 
csvFile='/users/PAS0654/osu9348/Python_Practice/CSV/real_cool_document.csv'     ## Name of our .csv file BEFORE we convert it (and location).
txtFile='/users/PAS0654/osu9348/Python_Practice/Solutions/real_cool_document.txt'         ## Name of our .txt file after we convert it (and location).
DataSave='/users/PAS0654/osu9348/Python_Practice/Solutions'                       ## Name and location of plot and .txt to be saved.
RunName='TestingCode'                                                             ## This is to let us make a new directory by this name, and move our plot there!  

#### This runs my python program that DOES depend on all of the variable to be pass through from THIS bash script!
python $DataSave/FileEx2.py $startingLine $XScale $YScale $csvFile $txtFile


#### We are now going to make a new directory (with the name of this run), and then move our plot and .txt there so it's not erased. 
mkdir $DataSave/$RunName                                ## Making a new directory under our run name, which ideally should be changed every time we run.
mv MYPLOT.png $DataSave/$RunName                        ## Moving the plot to this new run name specific directory.
mv real_cool_document.txt $DataSave/$RunName            ## Moving the TXT file to this new run name specific directory. 


#### Note, you could have also just saved the TXT file directly into your $RunName directory; it's your call.
