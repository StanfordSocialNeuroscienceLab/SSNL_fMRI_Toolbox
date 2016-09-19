#!/bin/bash

export FSLPARALLEL=slurm

design="CoopComp_Event"
output="CoopComp"
cope="cope2.feat"

\cp templates/3rd_lvl.fsf ../design/$design/3rd_lvl.fsf #Make a copy for each run

sed -i -e 's/ChangeMyDesign/'${design}'/' ../design/$design/3rd_lvl.fsf  #Swap Design
sed -i -e 's/ChangeMyOutcome/'${output}'/' ../design/$design/3rd_lvl.fsf  #Swap Output
sed -i -e 's/ChangeMyCope/'${cope}'/' ../design/$design/3rd_lvl.fsf  #Swap Output


#\rm ../design/$design/*-e #Remove excess schmutz
feat ../design/$design/3rd_lvl.fsf &
    
echo Running $design

