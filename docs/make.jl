import Pkg; Pkg.add("Documenter")
push!(LOAD_PATH,"../src/")
using Documenter 

makedocs(sitename="LCMsim v3"
         )