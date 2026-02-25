#start this file in folder with pwd()=LCMsim_GUI
i_batch=2 
i_model=2
i_mesh=3  #1
mypath=joinpath(pwd(),"gui_and_cases\\cases")
repositorypath=joinpath(pwd(),"..\\LCMsim_v3.jl")
guipath=joinpath(pwd(),"gui_and_cases\\gui")

include(joinpath(guipath,"lcmsim_v3_gui_gtk4.jl"))


