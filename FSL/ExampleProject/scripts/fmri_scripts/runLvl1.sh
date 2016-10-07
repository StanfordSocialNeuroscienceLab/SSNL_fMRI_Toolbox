#!/bin/bash

# YC and Erika, 9/19/16
# This script runs the first level (i.e. individual runs of individual subjects) analysis.
# Assumes that anatomical file has been reoriented and skull-stripped, and the functional files have been reoriented.
# Also assumes that regressors are in Custom 3-Column Format, and have already format (# see make_fsf_regressors.m)
# Also assumes that you have the relevant tempalte file (e.g., 1st_lvl_X_reg.fsf)

# Tells sherlock to run FSL in parallel (submit the analyses as "jobs")
export FSLPARALLEL=slurm

############ Set Parameters (here are the things you change) ############
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

mkdir '../design/'$design  # Make design folder

# Loop over subjects, one subject at a time
for subjID in "${subjNo[@]}"
	do
    # Loop over runs, one subject at a time
    for r in 1 2 3 4
        do
        # Define path for nifti file for this run
        thisFile="../../data/fmri/$subjID/functional/run${r}.nii.gz"

        # get length (number of TRs) of file
        nvols=$(fslnvols $thisFile)

        # Create design file for this run
        \cp templates/1st_lvl_${reg}reg.fsf ../design/$design/subj${subjID}_task_run${r}.fsf

        ### Here, we edit the template for this run, using the sed command to find and replace ###
        #Finds "ChangeMySubject" and replace with the Subject ID
        sed -i -e 's/ChangeMySubj/'$subjID'/' ../design/$design/subj${subjID}_task_run${r}.fsf
        
        #Finds "ChangeMyRun" and replace with run number
        sed -i -e 's/ChangeMyRun/'$r'/' ../design/$design/subj${subjID}_task_run${r}.fsf      
        
        #Finds "ChangeMyDesign" and replace with number of design
        sed -i -e 's/ChangeMyDesign/'$design'/' ../design//$design/subj${subjID}_task_run${r}.fsf        
        
        #Finds "ChangeMyVolumes" and replace with number of volumes
        sed -i -e 's/ChangeMyVolumes/'$nvols'/' ../design//$design/subj${subjID}_task_run${r}.fsf
        
        #For now, we only change number, number of volumes, and design name. In the future, we can add in options to change other parameters, including:
        #   - Registration/Normalization method, Thresholding, Motion correction vs. no motion correction, smoothing kernal
        # If there is an option that you would like to see made availale, see "Contact" in wiki, or better still, make it, and send it to us.
        ### End Change Template ###

        # Tell you which subject, and which run you are running
        echo Running Subj $subjID run $r

        # RUN!
        feat ../design/$design/subj${subjID}_task_run${r}.fsf &

        # Arbitarily wait for 5 seconds in case sherlock scheduler is busy and kills your job before it submits. 
        sleep 5s
    done
done
