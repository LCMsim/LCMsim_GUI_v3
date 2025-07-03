# Installation 

The intended operating system for LCMsim v3 is Windows. The software was extensively tested for Windows 10. In order to use LCMsim v3 for filling simulations perform the following steps:
- Download LCMsim v3: [Latest release](https://www.obertscheider.com/download/LCMsim_v3_latestrelease.zip)
- Extract, change to install folder and double click on the batch file to install the missing Julia packages (or alternatively install Julia and all the packages):
```@raw html
<img src="../assets/figures/fig_installation_001.png">
```
- Configure lcmsim_config.jl:
```
i_batch=0    #0..GUI for input files, 1..GUI with mask for parameter input 
i_model=2    #1..RTMsim model, 2..Default LCMsim model, 3..Pressure dependent porosity and permeability
i_mesh=2     #1..dat (NASTRAN), 2..inp (ABAQUS)
mypath=joinpath(pwd())
repositorypath="D:\\work\\LCMsim_v3_repositorydirectory\\LCMsim_v3.jl"    #Path to LCMsim_v3.jl folder
guipath="D:\\work\\LCMsim_v3_repositorydirectory\\LCMsim_GUI\\gui_and_cases\\gui"    #Path to gui folder
include(joinpath(guipath,"lcmsim_v3_gui_gtk4.jl"))
```
- Change to cases folder. Depending on the settings in the config file a different GUI opens. Launch the GUI in the cases folder by double clicking:
```@raw html
<img src="../assets/figures/fig_installation_002.png">
```
