#start this file in folder with pwd()=LCMsim_GUI
i_batch=0
i_model=3
i_mesh=1
mypath=joinpath(pwd(),"gui_and_cases\\cases")
repositorypath=joinpath(pwd(),"..\\LCMsim_v2.jl")
guipath=joinpath(pwd(),"gui_and_cases\\gui")

include(joinpath(guipath,"lcmsim_v2_gui_gtk4.jl"))


