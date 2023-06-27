######################################################################################
# File: Latest_Asym_GA.py
#   This GA is adapted from CalPoly's hybrid roulette/ tournament method to work with
#   Ohio State's loop. 
#
# Programmer: David Liu
# 						Suren Gourapura
# 						Jason Yao (yao.966@osu.edu)
#
# Revision history:
# 	12/29/2018	Revised by Suren Gourapura to accept NPoP 
# 	06/25/2023	Started the translation from Latest_Asym_GA.cpp to python.
#
# Comments:
#
######################################################################################
import numpy as np
import random
import argparse
import pandas as pd

# note: the cpp-version passes a tensor and a vector by reference.
# Inputs for function dataRead: 
# varInput = tensor for variables to be read by the program (parent population)
# fitness = vector storing the fitness scores for each parent
def dataRead():
  print("this is the skeleton of dataRead()")
  # TODO: have this function take in varInput and fitness
def dataWrite():
  print("this is the skeleton of dataWrite") 

def checkConvergence():
  print("this is the skeleton of checkConvergence")

def roulette():
  print("this is the skeleton of roulette")

def new_roulette():
  print("this is the skeleton of new_roulette")

def tournament():
  print("this is the skeleton of tournament()")

def new_tournament():
  print("this is the skeleton of new_tournament")

def reproduction():
  print("this is the skeleton of reproduction")

def corssover():
  print("this is the skeleton of corssover")

def mutation():
  print("this is the skeleton of mutation")

def trial_mutation():
  print("this is the skeleton of trial_mutation")



#####################################################################################
# GLOBAL VARIABLES
######################################################################################
minimum_frequency = 0.08333
maximum_frequency = 1.0667
freq_step = 0.01667

# No const in python, so ALLCAPS instead as a reminder.
NSECTIONS = 1
NVARS = 3
PARENT_NO = 2
DNA_GARBAGE_END = 9
# NPOP
MUTABILITY = 0.6
TOURNEY_LOTTERY_SIZE = 4
CONVERGENCE =0.00

initial_mean_c1_g1 = 1.5
initial_std_dvn_c1_g1 = 0.75
initial_mean_c1_g2 = 50.0
initial_std_dvn_c1_g2 = 30.0

INITIAL_MEAN_C1_G3 = np.pi/24
INITIAL_STD_DVN_C1_G3 = np.pi/36
INITIAL_MEAN_CX_GY = 0.0
INITIAL_STD_DVN_CX_GY = 0.0
MUT_MODULATOR = 4.0

max_outer_radius = 7.5
max_radius = max_outer_radius
min_length = 37.5
max_length = 140
max_theta = np.arctan(max_outer_radius/min_length)
max_separation = 2.5
min_separation = 2.5

REPRODUCTION_PERCENT = 0.1
CROSSOVER_PERCENT = 0.7



#####################################################################################
# MAIN FUNCTION
######################################################################################
# Note: default seed is time
# random.seed(1) # for debugging
# usage: random.random()

# TODO: check if this file is actually needed
# with open("../Generation_Data/generators.csv", "w+") as gencsv:
#   gencsv.write("hello world")

parser = argparse.ArgumentParser()
parser.add_argument("start_cont", help="start/continue flag", type=str)
parser.add_argument("NPOP", help="number of individual per generation", type=int)
parser.add_argument("GEOSCALE_FACTOR", help="null", type=int)
parser.add_argument("reproduction_no", help="reproduction number", type=int)
parser.add_argument("crossover_no", help="crossover number", type=int)
parser.add_argument("ratio_int", help="used for TOURNEY_PROPORTION", type=int)
g = parser.parse_args()


''' Adjusting the antennas' dimensions and frequencies according to
the factor GEOSCALE_FACTOR. '''
# gene 1 (radius)
initial_mean_c1_g1 /= g.GEOSCALE_FACTOR
initial_std_dvn_c1_g1 /= g.GEOSCALE_FACTOR

# gene 2 (length)
initial_mean_c1_g2 /= g.GEOSCALE_FACTOR
initial_std_dvn_c1_g2 /= g.GEOSCALE_FACTOR

# gene 3 (theta)
# (gene 3 does not need to change;
#  the angle is the same when we scale down the radius and length by the same factor)

# Frequecies are scaled INVERSELY with the dimensions.
minimum_frequency *= g.GEOSCALE_FACTOR
maximum_frequency *= g.GEOSCALE_FACTOR
freq_step *= g.GEOSCALE_FACTOR


''' initializing tensors and vectors with zeros'''
freq_coeffs = round((maximum_frequency-minimum_frequency) / freq_step + 1);
freqVector = np.zeros(freq_coeffs)
varInput = np.zeros((g.NPOP,NSECTIONS,NVARS))
fitness = np.zeros(g.NPOP)
varOutput = np.zeros((g.NPOP,NSECTIONS,NVARS))


''' calculating and inputting frequencies now -- these are not used anywhere else'''
TOURNEY_PROPORTION = g.ratio_int / 10.0;
while(g.crossover_no%2 != 0):
  g.crossover_no -= 1

# Note: ".shape[0]" allows access to the number of rows, which is NPOP
pool_size = int(0.07 * varOutput.shape[0])
if(pool_size == 0): pool_size = 1

freqVector[0] = minimum_frequency
for i in range(1,freq_coeffs):
  freqVector[i] = minimum_frequency + (freq_step * i)

''' reading input arguments and parse in data from files'''
if(g.start_cont=="start"):
  limit = 7.5
  i=0
  while (i<g.NPOP):
    j=0
    while (j<NSECTIONS):
      k=0
      while (k<NVARS):

        if(k==0):
          r = np.random.uniform(0,max_radius)
          while(r<=0): 
            print("fucked up radius, regenerating...")
            r = np.random.uniform(0,max_radius)
          # That r=0 is never going to happen, but since the original c++ file has this,
          # I'll just keep it for consistency.
          varOutput[i][j][k]=r

        elif(k==1):
          l = np.random.uniform(min_length,max_length)
          varOutput[i][j][k]=l

        elif(k==2):
          a = np.random.uniform(0,max_theta)
          varOutput[i][j][k]=a
        k+=1 # end of inner most loop

      if (varOutput[i][j][0] + varOutput[i][j][1] * np.tan(varOutput[i][j][2]))\
      > max_outer_radius:
        j-=1 # too large, redo
      j+=1 # end of j-loop
    i+=1 # end of outer most loop

  print(varOutput[0][0][0] + varOutput[0][0][1] * np.tan(varOutput[0][0][2]))
  print(max_outer_radius)