# GUI for LCMsim v3

## Test the GUI
- Download the zipped repository and extract
- Edit gui_and_cases\cases\test_GUI.jl: 
```
#start this file in folder with pwd()=LCMsim_GUI
i_batch=0
i_model=3
i_mesh=1
mypath=joinpath(pwd(),"gui_and_cases\\cases")
repositorypath=joinpath(pwd(),"..\\LCMsim_v3.jl")
guipath=joinpath(pwd(),"gui_and_cases\\gui")

include(joinpath(guipath,"lcmsim_v2_gui_gtk4.jl"))
```

i_batch=0 (take simulation and part parameters from csv-files) or 1 (simulation and part parameters input in GUI)

i_model=2 (RTM) or 3 (VARI)

i_mesh=1 (*.dat, NASTRAN) or 2 (*.inp, ABAQUS)

mypath is the path to this the test_GUI.jl file

repositorypath is the path to the LCMsim repository 

guipath is the pass to the GUI folder

The current path settings assume that a Julia terminal is opened, the pwd() is the top level of the extracted GUI repository, i.e. contains the docs folder, the gui_and_cases folder and the LICENSE file. Then in the terminal include("gui_and_cases\\cases\\test_GUI.jl") is executed. 


## General instruction for using LCMsim_v2/v3
See https://lcmsim.github.io/LCMsim_GUI_v3/build/
