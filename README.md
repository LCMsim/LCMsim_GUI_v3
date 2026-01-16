# GUI for LCMsim v3

## Installation
LCMsim v3 was developed for use with Windows 11. 

### Download
For running a LCMsim simulation with the GUI, download and extract the LCMsim_v3 repository (https://github.com/LCMsim/LCMsim_v3.jl) and this LCMsim_GUI_v3 repository (https://github.com/LCMsim/LCMsim_GUI_v3). Relevant files and folders are shown in the following tree:

```
LCMsim_v3
|
|----LCMsim_GUI_v3-main
|    |----docs
|    |----gui_and_cases
|    |    |----cases
|    |    |    |----casefiles
|    |    |    |    |----input_lcmsim_0.csv
|    |    |    |    |----mesh_0.dat
|    |    |    |    |----part_description_0.csv
|    |    |    |    |----simulation_params_0.csv
|    |    |    |     
|    |    |    |----lcmsim_launch.bat
|    |    |    |----lcmsim_launch.jl
|    |    |    
|    |    |----gui
|    |         |----lcmsim_v3_gui_gtk4.jl
|    |    
|    |----install
|    |    |----lcmsim_install.jl
|    |    |----lcmsim_install_juliawithpackages.bat
|    |    |----lcmsim_install_onlypackages.bat
|    |    
|    |----LICENSE
|    |----README.md
|    
|----LCMsim_v3.jl-main
|    |----src
|    |----test
|    |----LICENSE
|    |----README.md
|
```

### Instal Julia
Open the `LCMsim_v3.jl-main\install` folder in an explorer and double-click on `lcmsim_install_juliawithpackages.bat` to install Julia programming language with all required packages for LCMsim v3 or double-click on `lcmsim_install_onlypackages.bat` if Julia programming language is already installed on the computer and only the required packages for LCMsim v3 are missing.

### Launch the GUI

Open the `LCMsim_GUI_v3-main\gui_and_cases\cases` folder. This is the working directory where LCMsim v3 creates all files. Edit file `lcmsim_launch.jl`: 
```
i_batch=2
i_model=2
i_mesh=1
mypath=joinpath(pwd())
repositorypath="..\\..\\..\\LCMsim_v3.jl-main"
guipath="..\\gui"

include(joinpath(guipath,"lcmsim_v3_gui_gtk4.jl"))
```
If the folder structure and names are as shown above in the tree, relative paths are defined. Double-click on `lcmsim_launch.bat` to launch teh GUI. 


_batch=0 (take simulation and part parameters from csv-files) or 1 (simulation and part parameters input in GUI)

i_model=2 (RTM) or 3 (VARI)

i_mesh=1 (*.dat, NASTRAN) or 2 (*.inp, ABAQUS)

mypath is the path to this the test_GUI.jl file

repositorypath is the path to the LCMsim repository 

guipath is the pass to the GUI folder 



Alternatively, a case folder can be created outside the installation files. Copy the `cases` folder somewhere on your data drive and optionally rename it to LCMsim_v3_cases. The you have to give absolute paths in the `lcmsim_launch.jl` file, for example:
```
i_batch=2
i_model=2
i_mesh=1
mypath=joinpath(pwd())
repositorypath="D:\\work\\github\\LCMsim_v3.jl"
guipath="D:\\work\\github\\LCMsim_GUI_v3\\gui_and_cases\\gui"

include(joinpath(guipath,"lcmsim_v3_gui_gtk4.jl"))
```
The double backslash `\\` is used here for Windows paths in Julia.




## Open the GUI for testing purpose
- Download the zipped repository and extract
- Edit gui_and_cases\cases\test_GUI.jl: 
```
#start this file in folder with pwd()=LCMsim_GUI
i_batch=1
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

The current path settings assume that a Julia terminal is opened and the pwd() return the top level LCMsim_GUI_v2 of the extracted GUI repository, i.e. contains the docs folder, the gui_and_cases folder and the LICENSE file. Then in the terminal include("gui_and_cases\\cases\\test_GUI.jl") is executed. 

The LCMsim test cases (https://github.com/LCMsim/LCMsim_v3.jl/tree/main?tab=readme-ov-file#test-cases) are available. For example, in order to start the FPCM test case 31, one has to set i_batch=0, i_model=3, i_mesh=1. Then in the GUI select the mesh, part and simulation files with the names mesh_31.dat, part_description_31.csv and simulation_params_31.csv from the test folder in the LCMsim_v3 repository. Change simulation time to 30 and click on Run with input files. After the simulation is finished tick Results available and click Plot resutls.
![image](https://github.com/user-attachments/assets/6490f054-0899-4ad9-adef-4cb572b30714)


## General instruction for using the latest released version of LCMsim with GUI
See https://lcmsim.github.io/LCMsim_GUI_v3/build/ 
