#!/bin/bash
export FSLPARALLEL=slurm

subjNo=("2013" "2015" "2016" "2017" "2018" "2019" "2020" "2021" "2022" "2024" "2026" "2027" "2028" "2029" "2030" "2031" "2032" "2033" "2034" "2035" "2036" "2037" "2038" "2039" "2040" "2041" "2042" "2043" "2044" "2045" "2046" "2047" "2048") 


design="CoopComp_Event"
reg=2

for subjID in "${subjNo[@]}"
 	do

    \cp templates/2nd_lvl_${reg}reg.fsf ../design/$design/subj${subjID}_2ndLvl.fsf #Make a copy for each run

    sed -i -e 's/ChangeMySubj/'${subjID}'/' ../design/$design/subj${subjID}_2ndLvl.fsf  #Swap "ChangeMyRun" with run number
    sed -i -e 's/ChangeMyDesign/'${design}'/' ../design/$design/subj${subjID}_2ndLvl.fsf  #Swap Design

    #\rm ../design/$design/*-e #Remove excess schmutz

    feat ../design/$design/subj${subjID}_2ndLvl.fsf &
    sleep 5s
    
    echo Running Subj ${subjID}
done
