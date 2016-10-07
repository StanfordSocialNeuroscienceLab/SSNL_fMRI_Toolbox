#!/bin/bash

# YC and Erika, 10/7/16
# This script runs the third level (i.e. all participants) analysis
# Assumes the second level analyses (i.e. individual runs) have been completed
# Also assumes that you have the relevant template file (e.g., 3rd_lvl.fsf)

# Tells sherlock to run FSL in parallel (submit the analyses as "jobs")
export FSLPARALLEL=slurm

############ Set Parameters (here are the things you change) ############
design="CoopComp_Event" #[replace with name of your design]
output="CoopComp" #[name of output]
cope="cope2.feat" #[contrast number for EV (regressor) you want to look at]

# Here, we edit the template for this group analysis
\cp templates/3rd_lvl.fsf ../design/$design/3rd_lvl.fsf 

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



