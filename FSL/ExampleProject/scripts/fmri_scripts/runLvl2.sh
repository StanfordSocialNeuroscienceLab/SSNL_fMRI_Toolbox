#!/bin/bash

# YC and Erika, 10/7/16
# This script runs the second level (i.e. individual participants, all runs) analysis
# Assumes the first level analyses (i.e. individual runs) have been completed
# Also assumes that you have the relevant template file (e.g., 2nd_lvl_Xreg.fsf)

# Tells sherlock to run FSL in parallel (submit the analyses as "jobs")
export FSLPARALLEL=slurm

############ Set Parameters (here are the things you change) ############
# Set your path name.#
# This should be a folder in your *personal* (i.e. not lab and not YC's :p) scratch space. 
# It is where your data, scripts, results live
this_path=[NAME OF YOUR PATH] #e.g., "/scratch/users/ycleong/MotPer_fMRI/results/fmri/" 

# Enter your subject number
subjNo=("2013" "2015" "2016" "2017")

# The name of the contrast you want to examine
# Note that there must be the folder with the same name in "scripts/regressors"
# This script will generate design (.fsf files) in the folder "scripts/design/[name of design]"
# The outputs of your analyses will be in results/[name of design]
# See file structure on SSNL_fMRI_Toolbox wiki for how to organize your files
design="CoopComp_Event" #[replace with name of your design]

# no. of regressors. This is important because different templates (.fsf files) are associated with different number of regressors.
reg=3
############ End Set Parameters ############

# Loop over subjects, one subject at a time
for subjID in "${subjNo[@]}"
 	do
    
    ### Here, we edit the template for this subject, using the sed command to find and replace ###
    \cp templates/2nd_lvl_${reg}reg.fsf ../design/$design/subj${subjID}_2ndLvl.fsf #Make a copy for each run

    #Finds "ChangeMyPath" and replace with thisPath
    sed -i -e 's/ChangeMyPath/'$this_path'/' ../design/$design/subj${subjID}_task_run${r}.fsf

    # Finds "ChangeMySubject" and replace with the Subject ID
    sed -i -e 's/ChangeMySubj/'${subjID}'/' ../design/$design/subj${subjID}_2ndLvl.fsf  #Swap "ChangeMyRun" with run number
    
    # Finds "ChangeMyDesign" and replace with number of design
    sed -i -e 's/ChangeMyDesign/'${design}'/' ../design/$design/subj${subjID}_2ndLvl.fsf  
    
    # Tell you which subject you are running
     echo Running Subj ${subjID}
     
    # RUN! 
    feat ../design/$design/subj${subjID}_2ndLvl.fsf &
    
    # Arbitarily wait for 5 seconds in case sherlock scheduler is busy and kills your job before it submits. 
    sleep 5s
    
done
