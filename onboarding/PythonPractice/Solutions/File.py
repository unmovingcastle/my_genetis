import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import csv

#### This version of the code is without passing variables through from the bash script. Please see FileEx2.py for version where all directories, files, and variables are passed from bash script 
#### Both are valid ways of coding; however, if you are writing software that depend on inputs and outputs from other software, you will want to go with FileEx2.py coding methods!
#### Good luck!

#### Variables
startingLine= 4            ## This tells us what line in our CSV file to start saving as a list. Remember it saves each line from here until the end as a separate list.
XScale= 10                 ## This will be used to scale our X entries of our CSV file after they are converted to an array!
YScale= 2                  ## This will be used to scale our Y entries of our CSV file after they are converted to an array!  
csvFile = '/users/PAS0654/osu9348/Python_Practice/CSV/real_cool_document.csv'      ## Name of our .csv file BEFORE we convert it (and location).                              
txtFile = '/users/PAS0654/osu9348/Python_Practice/Solutions/real_cool_document.txt'      ## Name of our .txt file after we convert it (and location).

#### This part of the program will read in the contents from our csv file, and then output those contents to the terminal. 
with open(csvFile) as cool_doc:
  cool_contents = cool_doc.read()
print("This is what is in your CSV file:")
print("---------------------------------------------------------------------------------")
print("---------------------------------------------------------------------------------")
print(cool_contents)

#### First, grab each line of the real_cool_document.csv as one element in a 1D list. We can then later sort through them to decide which ones we want.
#### Note that this way of reading in the file is if you do not want the file loctation to be a variable.                                                                                
DataRaw =[]
with open(csvFile, "r") as DataFile:
        DataRaw=DataFile.readlines()

#### This is reading in the revelant lines. We tell it that our first revelant line (ie startingLine) is the 6th line (remember that we always start counting at 0).
#### We then read in from the 6th line to the last line (ie length of DataRaw). 
DataRawOnlyNumb =[]       # This is declaring that we are making an list (but not what's in it yet)

#### In this for loop we are doing a split -- ie telling this to save each element broken by a comma as two different entries in the array. 
for i in range(startingLine, len(DataRaw)): 
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
plt.plot(Data.T[0]*XScale, Data.T[1]*YScale, label = ScaledName, marker = 'o', linestyle='')        # Plotting the X and Y data scaled by the variables XScale and YScale.  
plt.legend(fontsize = 20)
plt.savefig('MYPLOT.png')                                                                           # Saves the plot as this name in the same directory as File.py exists.
plt.show()                                                                                          # You must always have this line of your plot will not display.

#### Here is where we change the CSV to a TXT file. It is taking a user input for the file name input and output. You could do it the following ways:
#### (1) Have the user pass in the input and output names from the command line
#### (2) Hard code in the file name input and output
#### (3) Make a variable at the top for the file input and output name and call that variable
#### (4) Have it pass in the file input and output names from the bash script

#### Method (1)
#import csv
#csv_file = input('Enter the name of your input file:')
#txt_file = input('Enter the name of your output file: ')
#with open(txt_file, "w") as my_output_file:
#    with open(csv_file, "r") as my_input_file:
#        [ my_output_file.write(" ".join(row)+'\n') for row in csv.reader(my_input_file)]
#    my_output_file.close()

#### Method (2)
#import csv
#with open('/users/PAS0654/osu9348/Python_Practice/real_cool_document.txt', "w") as my_output_file:
#    with open('/users/PAS0654/osu9348/Python_Practice/real_cool_document.csv', "r") as my_input_file:
#      [ my_output_file.write(" ".join(row)+'\n') for row in csv.reader(my_input_file)]
#    my_output_file.close()


#### Method (3)
import csv
with open(txtFile, "w") as my_output_file:
    with open(csvFile, "r") as my_input_file:
      [ my_output_file.write(" ".join(row)+'\n') for row in csv.reader(my_input_file)]
    my_output_file.close()

#### Method (4)
#### SEE FileEx2.py FOR THIS EXAMPLE!
