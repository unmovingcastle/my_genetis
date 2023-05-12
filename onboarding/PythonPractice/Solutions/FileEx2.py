import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import argparse
import csv

#### This version of the code is that passes variables through from the bash script. Please see File.py for version where all directories, files, and variables are NOT passed from bash script 
#### Both are valid ways of coding; however, if you are writing software that depend on inputs and outputs from other software, you will want to go with FileEx2.py coding methods!
#### Good luck!

#### This sets a variable to be read in from the bash script that allows us to scale the values read in by the CSV file, and a variable to set the destination of the saved plots.         
parser = argparse.ArgumentParser()
parser.add_argument("startingLine", help="This tells us what line in our CSV file to start saving as a list in our python program", type=int)
parser.add_argument("XScale", help="Scaling variable to scale values in the CSV file before plotting", type=int)
parser.add_argument("YScale", help="Scaling variable to scale values in the CSV file before plotting", type=int)
parser.add_argument("csvFile", help="Name and location of CSV file to be converted", type=str)   
parser.add_argument("txtFile", help="Name and location of txt file to be saved", type=str)
g = parser.parse_args()

#### This part of the program will read in the contents from our csv file, and then output those contents to the terminal. 
with open(g.csvFile) as cool_doc:
  cool_contents = cool_doc.read()
print("This is what is in your CSV file:")
print("---------------------------------------------------------------------------------")
print("---------------------------------------------------------------------------------")
print(cool_contents)

#### First, grab each line of the real_cool_document.csv as one element in a 1D list. We can then later sort through them to decide which ones we want.
#### Note that this way of reading in the file is if you do not want the file loctation to be a variable.                                                                                
DataRaw =[]
with open(g.csvFile, "r") as DataFile:
        DataRaw=DataFile.readlines()

#### This is reading in the revelant lines. We tell it that our first revelant line (ie startingLine) is the 6th line (remember that we always start counting at 0).
#### We then read in from the 6th line to the last line (ie length of DataRaw). 
DataRawOnlyNumb =[]       # This is declaring that we are making an list (but not what's in it yet)

#### In this for loop we are doing a split -- ie telling this to save each element broken by a comma as two different entries in the array. 
for i in range(g.startingLine, len(DataRaw)): 
  DataRaw[i] = DataRaw[i].rstrip()                  # This list has each element terminating with '\n', so we use rstrip to remove '\n' from each string.
  DataRawOnlyNumb.append(DataRaw[i].split(','))     # Starting at line startingLine all the way to the end of the file, we want to break up each elements separated by a comma and 
                                                    # them as an element in our new array DataRawOnlyNumb.

print("This is what is in your 'number only' array after you have removed commas and irrelevant data/numbers/text")
print("---------------------------------------------------------------------------------")
print("---------------------------------------------------------------------------------")  
print(DataRawOnlyNumb)

#### Now convert it to a numpy array and roll it up. The previous data was stored as a list, now we need to save it as an array to be plotted. When you initialize without
#### np.array, it's a list. As soon as you add this, it makes it an array. For plotting purposes, we want an array. 
Data = []
Data = np.array(DataRawOnlyNumb).astype(np.float)
print("This is your data transposed to all X's and all Y'x")
print("---------------------------------------------------------------------------------")
print("---------------------------------------------------------------------------------")
print(Data.T)       # Data.T transposes it to a column for the x's and a column for the y's. 
print("---------------------------------------------------------------------------------")
print("---------------------------------------------------------------------------------")

#### This plots the 0th array in Data.T and 1st array in Data.T as x and y values respectively.  
plt.xlabel("X Values", size = 21)
plt.ylabel("Y Values", size = 21)
plt.title("PLOTTING CSV FILE FUN", size = 24)
LabelName = "YAY DOTS"
plt.plot(Data.T[0], Data.T[1], label = LabelName, marker = 'o', linestyle='')                       # Plotting the X and Y data as it appears in the CSV file.   
ScaledName= "YAY SCALED DOTS"
plt.plot(Data.T[0]*g.XScale, Data.T[1]*g.YScale, label = ScaledName, marker = 'o', linestyle='')        # Plotting the X and Y data scaled by the variables XScale and YScale.  
plt.legend(fontsize = 20)
plt.savefig('MYPLOT.png')                                                                           # Saves the plot as this name in the same directory as File.py exists.
plt.show()                                                                                          # You must always have this line of your plot will not display.

#### Here is where we change the CSV to a TXT file. It is taking a user input for the file name input and output. You could do it the following ways:
#### (1) Have the user pass in the input and output names from the command line
#### (1) Hard code in the file name input and output
#### (2) Make a variable at the top for the file input and output name and call that variable
#### (3) Have it pass in the file input and output names from the bash script

#### Method (1)
#### SEE File.py FOR THIS EXAMPLE

#### Method (2)
#### SEE File.py FOR THIS EXAMPLE 

#### Method (3)                                                                                                                                                                                     #### SEE File.py FOR THIS EXAMPLE

#### Method (4)
import csv
with open(g.txtFile, "w") as my_output_file:
    with open(g.csvFile, "r") as my_input_file:
      [ my_output_file.write(" ".join(row)+'\n') for row in csv.reader(my_input_file)]
    my_output_file.close()
 
