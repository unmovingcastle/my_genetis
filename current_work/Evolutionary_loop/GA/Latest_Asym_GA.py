######################################################################################
# File: Latest_Asym_GA.py
#   This GA is adapted from CalPoly's hybrid roulette/ tournament method to work with
#   Ohio State's loop. 
#
# Programmer: David Liu
# 						Suren Gourapura
# 						Jason Yao (yao.966@osu.edu)
#
# Revisiion history:
# 	12/29/2018	Revised by Suren Gourapura to accept NPoP 
# 	06/25/2023	Started the translation from Latest_Asym_GA.cpp to python.
#
# Notes: 
#
######################################################################################
import numpy as np
import random
import argparse

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
parser.add_argument("start_cont", help="null", type=str)
parser.add_argument("NPOP", help="null", type=int)
parser.add_argument("GEOSCALE_FACTOR", help="null", type=int)
g = parser.parse_args()










