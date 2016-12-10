# SSNL_fMRI_Toolbox

##### Tips on installing nipype locally 
Here I use the Enthought Canopy distribution of python. I assume the steps would be similar if you used anaconda or "regular" python that comes with your Mac.  
1. Open the editor --> Tools (top menu bar) --> Canopy Terminal  
2. Type in "sudo pip install nipype" (you should already have pip installed. I forgot how I did this, will edit once I remember)  
3. In the "Python" window of the editor, type in "import nipype"  
4. You are likely to get an error saying, "no module named XXX"  
5. Go back to the terminal and type "sudo pip install XXX", where XXX is the name of the module that is missing  
6. Keep doing this until you successfully import nipype.  

