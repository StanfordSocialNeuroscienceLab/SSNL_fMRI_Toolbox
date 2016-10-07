#!/bin/bash

# YC and Erika, 10/7/16
# This script runs the third level (i.e. all participants) analysis
# Assumes the second level analyses (i.e. individual runs) have been completed
# Also assumes that you have the relevant template file (e.g., 3rd_lvl.fsf)

# Tells sherlock to run FSL in parallel (submit the analyses as "jobs")
export FSLPARALLEL=slurm

############ Set Parameters (here are the things you change) ############
# Set your path name.#
# This should be a folder in your *personal* (i.e. not lab and not YC's :p) scratch space. 
# It is where your data, scripts, results live
this_path=[NAME OF YOUR PATH] #e.g., "/scratch/users/ycleong/MotPer_fMRI/results/fmri/" 

design="CoopComp_Event" #[replace with name of your design]
output="CoopComp" #[name of output]
cope="cope2.feat" #[contrast number for EV (regressor) you want to look at]

# Here, we edit the template for this group analysis
\cp templates/3rd_lvl.fsf ../design/$design/3rd_lvl.fsf 

# Finds "ChangeMyPath" and replace with thisPath
sed -i -e 's/ChangeMyPath/'$this_path'/' ../design/$design/subj${subjID}_task_run${r}.fsf

# Finds "ChangeMyDesign" and replace with the Design Name
sed -i -e 's/ChangeMyDesign/'${design}'/' ../design/$design/3rd_lvl.fsf  

# Finds "ChangeMyOuput" and replace with output names
sed -i -e 's/ChangeMyOutput/'${output}'/' ../design/$design/3rd_lvl.fsf

# Finds "ChangeMyCope" and replace with the EV number
sed -i -e 's/ChangeMyCope/'${cope}'/' ../design/$design/3rd_lvl.fsf  #Swap Output

# Tell you which design you are running
echo Running $design

# RUN! 
feat ../design/$design/3rd_lvl.fsf &



