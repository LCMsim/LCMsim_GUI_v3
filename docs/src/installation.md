# Installation 

LCMsim v3 was developed for use with Windows 11. 

### Download
For running a LCMsim simulation with the GUI, download and extract the [LCMsim v3 repository](https://github.com/LCMsim/LCMsim_v3.jl) and the [LCMsim v3 GUI repository](https://github.com/LCMsim/LCMsim_GUI_v3). Relevant files and folders are shown in the following tree:

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

### Install Julia
Open the `LCMsim_v3.jl-main\install` folder in an explorer and double-click on `lcmsim_install_juliawithpackages.bat` to install Julia programming language with all required packages for LCMsim v3 or double-click on `lcmsim_install_onlypackages.bat` if Julia programming language is already installed on the computer and only the required packages for LCMsim v3 are missing.

### Launch the GUI - Method 1

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
If the folder structure and names are as shown above in the tree, relative paths are defined. Double-click on `lcmsim_launch.bat` to launch teh GUI:
- `mypath` is the path where this config file is
- `repositorypath` is the path to the LCMsim v3 folder which includes the `src`folder with the Julia files 
- `guipath` is the path to the LCMsim GUI folder which includes the Julia file for the GUI
- `i_batch=2` opens a GUI which takes a mesh file (for example `casefiles\mesh_0.dat`) and an input file (for example `casefiles\input_lcmsim_0.csv`) with all process and preform paramters as input. With `i_batch=1` one can run the [LCMsim test cases](https://github.com/LCMsim/LCMsim_v3.jl/tree/main?tab=readme-ov-file#test-cases) with a mesh file (for example `casefiles\mesh_0.dat`), a part description file (for example `casefiles\part_description_0.csv`) which specifies the preform patches and a simulation parameter file (for example `casefiles\simulation_params_0.csv`) which specifies the process parameters. 
- `i_model=2` is used for RTM and `i_model=3` for VARI filling simulations.
- `i_mesh=1` is used for NASTRAN mesh format with extension `*.dat`, `i_mesh=2` is used for ABAQUS mesh format (for example created with the freely available [PREPOMAX](https://prepomax.fs.um.si/)) with extension `*.inp`. 
The following code snippets show how the mesh format has look. Only first order triangular elements are supported at the moment. 
```
SET 1 = 1,2,3,4,5,6,
        7,8,9,10,11,12,
        13,14,15,16

GRID           1             0.0     0.0     0.0
GRID           3             0.3     0.3     0.0

CTRIA3         1       0      15       9      16
CTRIA3         2       0      16      10      19
```

```
*Node
1, 3.00000000E-001, -3.00000000E-001, 0.00000000E+000
2, 3.00000000E-001, 3.00000000E-001, 0.00000000E+000

*Element, Type=S3, Elset=Shell_part-1
1, 274, 419, 312
2, 141, 302, 142

*Elset, Elset=Element_Set-1
1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025, 1026, 1027, 1028,
1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 1156
```

### Launch the GUI - Method 2

Alternatively, a case folder can be created outside the installation files. Copy the `cases` folder somewhere on your data drive and optionally rename it to LCMsim_v3_cases. The you have to give absolute paths in the `lcmsim_launch.jl` file, for example:
```
i_batch=2
i_model=2
i_mesh=1
mypath=joinpath(pwd())
repositorypath="D:\\work\\LCMsim_v3\\LCMsim_v3.jl-main"
guipath="D:\\work\\LCMsim_v3\\LCMsim_GUI_v3-main\\gui_and_cases\\gui"

include(joinpath(guipath,"lcmsim_v3_gui_gtk4.jl"))
```
The double backslash `\\` is used here for Windows paths in Julia. 

### Launch the GUI - Method 3

If one wants a working directory which only includes the input files, the paths in the `lcmsim_launch.jl` file in the `LCMsim_GUI_v3-main\gui_and_cases\cases` folder must be changed for example: 
```
i_batch=2
i_model=2
i_mesh=1
mypath="D:\\work\\myworkingdirectory"
repositorypath="D:\\work\\LCMsim_v3\\LCMsim_v3.jl-main"
guipath="D:\\work\\LCMsim_v3\\LCMsim_GUI_v3-main\\gui_and_cases\\gui"

include(joinpath(guipath,"lcmsim_v3_gui_gtk4.jl"))
```
The double backslash `\\` is used here for Windows paths in Julia. Copy relevant input files from `LCMsim_GUI_v3-main\gui_and_cases\cases\casefiles` to this folder, for example `lcmsim_input_0.csv` and `mesh_0.dat`. One can create a shortcut to `LCMsim_GUI_v3-main\gui_and_cases\cases\lauch_lcmsim.bat` on the desktop and then launch LCMsim v3 by double-clicking on the desktop shortcut. To change the shortcut's icon, right-click the shortcut, select properties, go to the shortcut tab, click change icon, then browse to `LCMsim_GUI_v3-main\gui_and_cases\figuress` and select `LCMsim_logo.ico`.



