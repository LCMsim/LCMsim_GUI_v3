#include packages
using Gtk
using GLMakie
using Makie
using NativeFileDialog
using Gtk.ShortNames, Gtk.GConstants, Gtk.Graphics
using GeometryBasics
using HDF5

#for testing purpose only
i_batch=0;i_model=2;i_mesh=1;mypath="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\cases";repositorypath="D:\\work\\github\\LCMsim_v2.jl";guipath="D:\\work\\github\\lcmsim_gui\\gui_and_cases\\gui"

    @info "i_batch = $i_batch"
    @info "i_model = $i_model"
    @info "i_mesh = $i_mesh"    
    @info "path = " * mypath
    @info "repository path = " * repositorypath
	@info "gui path = " * guipath
    jlpath=joinpath(repositorypath,"src","LCMsim_v2.jl")
    include(jlpath)
    using .LCMsim_v2

    #one Gtk window
    win = GtkWindow("LCMsim"); 

    #define buttons
    sm=GtkButton("Select mesh file");pm=GtkButton("Plot mesh");ps=GtkButton("Plot sets")
    ss=GtkButton("Start simulation");cs=GtkButton("Continue simulation")
    sel=GtkButton("Select inlet port"); si=GtkButton("Start interactive");ci=GtkButton("Continue interactive");
    sr=GtkButton("Select results file");pr=GtkButton("Plot results")
    po=GtkButton("Plot overview")
    pf=GtkButton("Plot filling")
    q=GtkButton("Quit")
    h=GtkButton("Help")
    in1=GtkButton("Select part file")
    in1a=GtkButton("Select sim file")
    in3=GtkButton("Run with input files")

    #define input fields
    in2=GtkEntry(); set_gtk_property!(in2,:text,joinpath(mypath,"casefiles","part_description.csv"));
    in2a=GtkEntry(); set_gtk_property!(in2a,:text,joinpath(mypath,"casefiles","simulation_params.csv"));
    if i_mesh==1
        mf=GtkEntry(); set_gtk_property!(mf,:text,joinpath(mypath,"casefiles","mesh.dat"));
    elseif i_mesh==2
        mf=GtkEntry(); set_gtk_property!(mf,:text,joinpath(mypath,"casefiles","mesh.inp"));
    end
    mf1=GtkEntry(); set_gtk_property!(mf1,:text,"0");
    pr1=GtkEntry(); set_gtk_property!(pr1,:text,"1");
    t=GtkEntry(); set_gtk_property!(t,:text,"200")
    rf=GtkEntry(); set_gtk_property!(rf,:text,joinpath(mypath,"data.jld2"))
    r=GtkEntry(); set_gtk_property!(r,:text,"0.01")
    p1_0=GtkEntry(); set_gtk_property!(p1_0,:text,"Set 1");GAccessor.editable(GtkEditable(p1_0),false) 
    p2_0=GtkEntry(); set_gtk_property!(p2_0,:text,"Set 2");GAccessor.editable(GtkEditable(p2_0),false) 
    p3_0=GtkEntry(); set_gtk_property!(p3_0,:text,"Set 3");GAccessor.editable(GtkEditable(p3_0),false) 
    p4_0=GtkEntry(); set_gtk_property!(p4_0,:text,"Set 4");GAccessor.editable(GtkEditable(p4_0),false) 
    par_0=GtkEntry(); set_gtk_property!(par_0,:text,string(i_model))  #par_0=GtkEntry(); set_gtk_property!(par_0,:text,"1")
                      set_gtk_property!(par_0,:editable,false)
    par_1=GtkEntry(); set_gtk_property!(par_1,:text,"135000")
    par_2=GtkEntry(); set_gtk_property!(par_2,:text,"100000")
    par_3=GtkEntry(); set_gtk_property!(par_3,:text,"0.06")
    par_4=GtkEntry(); set_gtk_property!(par_4,:text,"1.225")
    par_5=GtkEntry(); set_gtk_property!(par_5,:text,"960")
    p0_1=GtkEntry(); set_gtk_property!(p0_1,:text,"0.003")
    p0_2=GtkEntry(); set_gtk_property!(p0_2,:text,"0.7")
    p0_3=GtkEntry(); set_gtk_property!(p0_3,:text,"3e-10")
    p0_4=GtkEntry(); set_gtk_property!(p0_4,:text,"1")
    p0_5=GtkEntry(); set_gtk_property!(p0_5,:text,"1")
    p0_6=GtkEntry(); set_gtk_property!(p0_6,:text,"0")
    p0_7=GtkEntry(); set_gtk_property!(p0_7,:text,"0")
    p0_8=GtkEntry(); set_gtk_property!(p0_8,:text,"0.7")
    p0_9=GtkEntry(); set_gtk_property!(p0_9,:text,"60000")
    p1_1=GtkEntry(); set_gtk_property!(p1_1,:text,"0.003")
    p1_2=GtkEntry(); set_gtk_property!(p1_2,:text,"0.7")
    p1_3=GtkEntry(); set_gtk_property!(p1_3,:text,"3e-10")
    p1_4=GtkEntry(); set_gtk_property!(p1_4,:text,"1")
    p1_5=GtkEntry(); set_gtk_property!(p1_5,:text,"1")
    p1_6=GtkEntry(); set_gtk_property!(p1_6,:text,"0")
    p1_7=GtkEntry(); set_gtk_property!(p1_7,:text,"0")
    p1_8=GtkEntry(); set_gtk_property!(p1_8,:text,"0.7")
    p1_9=GtkEntry(); set_gtk_property!(p1_9,:text,"60000")
    p2_1=GtkEntry(); set_gtk_property!(p2_1,:text,"0.003")
    p2_2=GtkEntry(); set_gtk_property!(p2_2,:text,"0.7")
    p2_3=GtkEntry(); set_gtk_property!(p2_3,:text,"3e-10")
    p2_4=GtkEntry(); set_gtk_property!(p2_4,:text,"1")
    p2_5=GtkEntry(); set_gtk_property!(p2_5,:text,"1")
    p2_6=GtkEntry(); set_gtk_property!(p2_6,:text,"0")
    p2_7=GtkEntry(); set_gtk_property!(p2_7,:text,"0")
    p2_8=GtkEntry(); set_gtk_property!(p2_8,:text,"0.7")
    p2_9=GtkEntry(); set_gtk_property!(p2_9,:text,"60000")
    p3_1=GtkEntry(); set_gtk_property!(p3_1,:text,"0.003")
    p3_2=GtkEntry(); set_gtk_property!(p3_2,:text,"0.7")
    p3_3=GtkEntry(); set_gtk_property!(p3_3,:text,"3e-10")
    p3_4=GtkEntry(); set_gtk_property!(p3_4,:text,"1")
    p3_5=GtkEntry(); set_gtk_property!(p3_5,:text,"1")
    p3_6=GtkEntry(); set_gtk_property!(p3_6,:text,"0")
    p3_7=GtkEntry(); set_gtk_property!(p3_7,:text,"0")
    p3_8=GtkEntry(); set_gtk_property!(p3_8,:text,"0.7")
    p3_9=GtkEntry(); set_gtk_property!(p3_9,:text,"60000")
    p4_1=GtkEntry(); set_gtk_property!(p4_1,:text,"0.003")
    p4_2=GtkEntry(); set_gtk_property!(p4_2,:text,"0.7")
    p4_3=GtkEntry(); set_gtk_property!(p4_3,:text,"3e-10")
    p4_4=GtkEntry(); set_gtk_property!(p4_4,:text,"1")
    p4_5=GtkEntry(); set_gtk_property!(p4_5,:text,"1")
    p4_6=GtkEntry(); set_gtk_property!(p4_6,:text,"0")
    p4_7=GtkEntry(); set_gtk_property!(p4_7,:text,"0")
    p4_8=GtkEntry(); set_gtk_property!(p4_8,:text,"0.7")
    p4_9=GtkEntry(); set_gtk_property!(p4_9,:text,"60000")

    #define radio buttons
    choices = ["Ignore",  "Pressure inlet", "Pressure outlet", "Patch" ]
    f1 = Gtk.GtkBox(:v);
    r1 = Vector{RadioButton}(undef, 4)
    r1[1] = RadioButton(choices[1]);                   push!(f1,r1[1])
    r1[2] = RadioButton(r1[1],choices[2],active=true); push!(f1,r1[2])
    r1[3] = RadioButton(r1[2],choices[3]);             push!(f1,r1[3])
    r1[4] = RadioButton(r1[3],choices[4]);             push!(f1,r1[4])
    f2 = Gtk.GtkBox(:v);
    r2 = Vector{RadioButton}(undef, 4)
    r2[1] = RadioButton(choices[1],active=true); push!(f2,r2[1])
    r2[2] = RadioButton(r2[1],choices[2]);       push!(f2,r2[2])
    r2[3] = RadioButton(r2[2],choices[3]);       push!(f2,r2[3])
    r2[4] = RadioButton(r2[3],choices[4]);       push!(f2,r2[4])
    f3 = Gtk.GtkBox(:v);
    r3 = Vector{RadioButton}(undef, 4)
    r3[1] = RadioButton(choices[1],active=true); push!(f3,r3[1])
    r3[2] = RadioButton(r3[1],choices[2]);       push!(f3,r3[2])
    r3[3] = RadioButton(r3[2],choices[3]);       push!(f3,r3[3])
    r3[4] = RadioButton(r3[3],choices[4]);       push!(f3,r3[4])
    f4 = Gtk.GtkBox(:v);
    r4 = Vector{RadioButton}(undef, 4)
    r4[1] = RadioButton(choices[1],active=true); push!(f4,r4[1])
    r4[2] = RadioButton(r4[1],choices[2]);       push!(f4,r4[2])
    r4[3] = RadioButton(r4[2],choices[3]);       push!(f4,r4[3])
    r4[4] = RadioButton(r4[3],choices[4]);       push!(f4,r4[4])

    #define logo
    im=Gtk.GtkImage(joinpath(guipath,"figures","rtmsim_logo2_h200px_grey.png"))

    #assembly elements in grid pattern    
    g = GtkGrid()    #Cartesian coordinates, g[column,row]
    set_gtk_property!(g, :column_spacing, 5) 
    set_gtk_property!(g, :row_spacing, 5) 
    if i_batch==0
             
                                
        
                                         g[3,2] = f1;   g[4,2] = f2;   g[5,2] = f3;   g[6,2] = f4;   #g[7:10,1:2] = im;
        g[1,3] = par_0; g[2,3] = p0_1; g[3,3] = p1_1; g[4,3] = p2_1; g[5,3] = p3_1; g[6,3] = p4_1; 
        g[1,4] = par_1; g[2,4] = p0_2; g[3,4] = p1_2; g[4,4] = p2_2; g[5,4] = p3_2; g[6,4] = p4_2; 
        g[1,5] = par_2; g[2,5] = p0_3; g[3,5] = p1_3; g[4,5] = p2_3; g[5,5] = p3_3; g[6,5] = p4_3; 
        g[1,6] = par_3; g[2,6] = p0_4; g[3,6] = p1_4; g[4,6] = p2_4; g[5,6] = p3_4; g[6,6] = p4_4; 
        g[1,7] = par_4; g[2,7] = p0_5; g[3,7] = p1_5; g[4,7] = p2_5; g[5,7] = p3_5; g[6,7] = p4_5; 
        g[1,8] = par_5; g[2,8] = p0_6; g[3,8] = p1_6; g[4,8] = p2_6; g[5,8] = p3_6; g[6,8] = p4_6;      
                        g[2,9] = p0_7; g[3,9] = p1_7; g[4,9] = p2_7; g[5,9] = p3_7; g[6,9] = p4_7;      
        if i_model==1 || i_model==2 || i_model==3
                                                                                                     g[7:10,14] = im;
        g[1,15]=sm; g[2,15] = mf; g[3,15] = ps;  g[4,15] = pm;  
                                                 g[4,16] = mf1;
        g[1,17] = r;  g[2,17] = sel;
        g[1,18] = t;  g[2,18] = ss;  g[3,18] = cs;  
                      g[2,19] = si;  g[3,19] = ci;    
                      g[2,20] = po; g[3,20] = pf; g[4,20] = pr;                                       g[10,20] = q; 
                                               g[4,21] = pr1;                                         #g[10,21] = h; 

        end
        if i_model==3                    
                        g[2,10] = p0_8; g[3,10] = p1_8; g[4,10] = p2_8; g[5,10] = p3_8; g[6,10] = p4_8; 
                        g[2,11] = p0_9; g[3,11] = p1_9; g[4,11] = p2_9; g[5,11] = p3_9; g[6,11] = p4_9; 
        end
    else
        g[1,1] = in1;   g[2,1] = in2;  
        g[1,2] = in1a;  g[2,2] = in2a;
        g[1,3]=sm;      g[2,3] = mf;   g[3,3] = ps;  g[4,3] = pm;  
                                                     g[4,4] = mf1;
                                                                                               g[7:10,5] = im; 
        g[1,6] = par_0; g[2,6] = t;  g[3,6] = in3;   
                                     g[3,7] = po; g[4,7] = pf; g[5,7] = pr;                                                     g[10,7] = q; 
                                                               g[5,8] = pr1; 
    end
    
    
    push!(win, g)

    #callback functions
    function sm_clicked(w)
        if i_mesh==1
            str = pick_file(mypath,filterlist="dat");
        elseif i_mesh==2
            str = pick_file(mypath,filterlist="inp");
        end
        #str = pick_file(mypath,filterlist="dat,inp");
        set_gtk_property!(mf,:text,str);
    end
    function sr_clicked(w)
        str = pick_file(mypath,filterlist="jld2");
        set_gtk_property!(rf,:text,str);
    end
    function pm_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        str1_1 = get_gtk_property(mf1,:text,String); 

        #coloring of mesh: 0..none, 1..thickness, 2..porosity, 3..permeability, 4..alpha
        i_var_in=parse(Int,str1_1)
        if i_var_in>=0 && i_var_in<=4
            i_var=i_var_in
        else
            i_var=0
        end 

        if i_batch==1
            meshfile=get_gtk_property(mf,:text,String);
            partfile=get_gtk_property(in2,:text,String);
            simfile=get_gtk_property(in2a,:text,String);
            meshfilename_parts=splitpath(meshfile)
            meshfilename_parts[end]="_" * meshfilename_parts[end]
            writefilename=joinpath(meshfilename_parts)
            _meshfile=writefilename
            if isfile(_meshfile)
                rm(_meshfile)
            end
            filename_parts=splitpath(meshfile)
            _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
            __psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"__pset.csv")
            if isfile(_psetfile)
                mv(_psetfile,__psetfile,force=true) 
            end
        else
            partfile = joinpath(mypath,"_part_description.csv")
            writefilename=partfile
            touch(writefilename)
            wfn = open(writefilename,"w")  
            lines=String[]
            notusedsets = Vector{String}()
            i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
            if i_model==1 || i_model==2 || i_model==3
                push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1")
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
                #if patchtype1val==0
                    push!(notusedsets, "2")
                #else
                #    if patchtype1val==1
                #        patchtype="inlet"
                #    elseif patchtype1val==2
                #        patchtype="patch"
                #    elseif patchtype1val==3
                #        patchtype="outlet"
                #    end
                #    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                #end
                #if patchtype2val==0
                    push!(notusedsets, "3")
                #else
                #    if patchtype2val==1
                #        patchtype="inlet"
                #    elseif patchtype2val==2
                #        patchtype="patch"
                #    elseif patchtype2val==3
                #        patchtype="outlet"
                #    end
                #    push!(lines,string("patch2,", patchtype,",3,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                #end
                #if patchtype3val==0
                    push!(notusedsets, "4")
                #else
                #    if patchtype3val==1
                #        patchtype="inlet"
                #    elseif patchtype3val==2
                #        patchtype="patch"
                #    elseif patchtype3val==3
                #        patchtype="outlet"
                #    end
                #    push!(lines,string("patch3,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
                #end
                #if patchtype4val==0
                    push!(notusedsets, "5")
                #else
                #    if patchtype4val==1
                #        patchtype="inlet"
                #    elseif patchtype4val==2
                #        patchtype="patch"
                #    elseif patchtype4val==3
                #        patchtype="outlet"
                #    end
                #    push!(lines,string("patch4,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
                #end
            end
            for line in lines
                println(wfn,line)
            end
            close(wfn)

            meshfile = str1
            meshfilename_parts=splitpath(meshfile)
            meshfilename_parts[end]="_" * meshfilename_parts[end]
            writefilename=joinpath(meshfilename_parts)
            _meshfile=writefilename
            len_out=length(notusedsets)
            notusedsets_out=String[]        
            if len_out>=1
                touch(writefilename)
                wfn = open(writefilename,"w")  
                for i_out in 1:len_out
                    if i_out==1
                        notusedsets_out=notusedsets[i_out]
                    else
                        notusedsets_out=notusedsets_out * "," * notusedsets[i_out] 
                    end
                end
                println(wfn,notusedsets_out)
                close(wfn)
            else
                if isfile(writefilename)
                    rm(writefilename)
                end
            end       

            simfile = joinpath(mypath,"_simulation_params.csv")
            writefilename=simfile
            touch(writefilename)
            wfn = open(writefilename,"w")  
            lines=String[]
            if i_model==1 || i_model==2 || i_model==3
                push!(lines,"p_ref,rho_ref,gamma,mu_resin,p_a,p_init,rho_0_air,rho_0_oil")
                push!(lines,string("1.01325e5,1.225,1.4,",str3,",",str4,",",str5,",",str6,",",str7))
            end
            for line in lines
                println(wfn,line)
            end
            close(wfn)

            filename_parts=splitpath(meshfile)
            _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
            __psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"__pset.csv")
            if isfile(_psetfile)
                mv(_psetfile,__psetfile,force=true) 
            end
        end

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        t_step = t_max/4
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  
        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype)
            
        if i_batch==0
            if isfile(_meshfile)
                rm(_meshfile)
            end
            if isfile(partfile)
                rm(partfile)
            end
            if isfile(simfile)
                rm(simfile)
            end
            if isfile(__psetfile)
                mv(__psetfile,_psetfile,force=true) 
            end
        elseif i_batch==1
            if isfile(__psetfile)
                mv(__psetfile,_psetfile,force=true) 
            end
        end


        hdf_path=joinpath(mypath,"_data.h5")
        LCMsim_v2.save_plottable_mesh(case.mesh, hdf_path)
        LCMsim_v2.save_state(case.state, hdf_path)
            
        polys::Vector{Polygon} = []
        gamma::Vector{Float64} = []
        
               
        h5open(hdf_path, "r") do meshfile
        
            grid = read_dataset(meshfile["/mesh"], "vertices")
            cells = read_dataset(meshfile["/mesh"], "cells")
            N = size(cells)[1]
            M = size(grid)[1]
            xvec=Array{Float64}(undef, 3, N)
            yvec=Array{Float64}(undef, 3, N)
            zvec=Array{Float64}(undef, 3, N)            
            xvec1=Array{Float64}(undef, M)
            yvec1=Array{Float64}(undef, M)
            zvec1=Array{Float64}(undef, M)
            cgammavec=Array{Float64}(undef, 3, N)
            cgammavec_bw=Array{Float64}(undef, 3, N)
        
        
            for cid in 1:N
                points::Vector{Point2f} = []
                for j in 1:3
                    gid = cells[cid, j]
                    x = grid[gid, 1]
                    y = grid[gid, 2]
                    z = grid[gid, 3]
                    push!(points, Point2f(x, y))            
                    xvec[j,cid]=x
                    yvec[j,cid]=y
                    zvec[j,cid]=z
                    cgammavec[j,cid]=1.0
                    cgammavec_bw[j,cid]=1.0
                end
                push!(polys, Polygon(points))
            end
            xyz = reshape([xvec[:] yvec[:] zvec[:]]', :)
        
            states = keys(meshfile["/"])
            states = filter(s -> s[1:3] == "sta", states)
            
            gammas = [read_dataset(meshfile["/" * state], "gamma") for state in states]
            #gammas = [read_dataset(meshfile["/" * state], "p") for state in states]
        
            if i_var==0
                gamma = read_dataset(meshfile["properties"], "thickness")
                gamma = gamma*0.0  #uniform color
            elseif i_var==1
                gamma = read_dataset(meshfile["properties"], "thickness")
            elseif i_var==2
                gamma = read_dataset(meshfile["properties"], "porosity")
            elseif i_var==3
                gamma = read_dataset(meshfile["properties"], "permeability")
            elseif i_var==4
                gamma = read_dataset(meshfile["properties"], "alpha")
            end
        
            cgammasvec=Array{Float64}(undef, 3, N)
            cgammasvec_bw=Array{Float64}(undef, 3, N)
            for cid in 1:N
                for j in 1:3
                    cgammavec[j,cid]=gamma[cid]
                    cgammavec_bw[j,cid]=gamma[cid]
                end
            end
            
            #bounding box
            deltax=maximum(xvec)-minimum(xvec)
            deltay=maximum(yvec)-minimum(yvec)
            deltaz=maximum(zvec)-minimum(zvec)
            mindelta=min(deltax,deltay,deltaz)
            maxdelta=max(deltax,deltay,deltaz)
            if mindelta<maxdelta*0.001
                eps_delta=maxdelta*0.001
            else
                eps_delta=0
            end 
            ax=(deltax+eps_delta)/(mindelta+eps_delta)
            ay=(deltay+eps_delta)/(mindelta+eps_delta)
            az=(deltaz+eps_delta)/(mindelta+eps_delta)
            
            points1::Vector{Point3f0} = []
            for gid in 1:M        
                    xvec1[gid]=grid[gid, 1]
                    yvec1[gid]=grid[gid, 2]
                    zvec1[gid]=grid[gid, 3]
            end
            points1=rand(Point3f0, length(xvec1))
            for i in 1:length(xvec1)
                points1[i]=Point3f0(xvec1[i],yvec1[i],zvec1[i])
            end
        
            maxval=maximum(cgammavec[:])
            minval=minimum(cgammavec[:])
            deltaval=max(maxval-minval,0.1*(abs(maxval)))
            maxval=maxval+deltaval
            minval=minval-deltaval
            resolution_val = 800  #1200
            fig = Figure(size=(resolution_val, resolution_val))
            ax1 = Axis3(fig[1, 1]; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
            p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
            if i_var>=1
                Colorbar(fig, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(minval,maxval));  
            end
            
            display(fig)
        
        end
        rm(hdf_path)       
    end
    function ps_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);

        if i_batch==1            
            meshfile=get_gtk_property(mf,:text,String);
            partfile=get_gtk_property(in2,:text,String);
            simfile=get_gtk_property(in2a,:text,String);
            meshfilename_parts=splitpath(meshfile)
            meshfilename_parts[end]="_" * meshfilename_parts[end]
            writefilename=joinpath(meshfilename_parts)
            _meshfile=writefilename
            if isfile(_meshfile)
                rm(_meshfile)
            end
            filename_parts=splitpath(meshfile)
            _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
            __psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"__pset.csv")
            if isfile(_psetfile)
                mv(_psetfile,__psetfile,force=true) 
            end
        else
            partfile = joinpath(mypath,"_part_description.csv")
            writefilename=partfile
            touch(writefilename)
            wfn = open(writefilename,"w")  
            lines=String[]
            notusedsets = Vector{String}()
            i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
            if i_model==1 || i_model==2 || i_model==3
                push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1")
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
                if patchtype1val==0
                    push!(notusedsets, "2")
                else
                    if patchtype1val==1
                        patchtype="inlet"
                    elseif patchtype1val==2
                        patchtype="patch"
                    elseif patchtype1val==3
                        patchtype="outlet"
                    end
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                end
                if patchtype2val==0
                    push!(notusedsets, "3")
                else
                    if patchtype2val==1
                        patchtype="inlet"
                    elseif patchtype2val==2
                        patchtype="patch"
                    elseif patchtype2val==3
                        patchtype="outlet"
                    end
                    push!(lines,string("patch2,", patchtype,",3,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                end
                if patchtype3val==0
                    push!(notusedsets, "4")
                else
                    if patchtype3val==1
                        patchtype="inlet"
                    elseif patchtype3val==2
                        patchtype="patch"
                    elseif patchtype3val==3
                        patchtype="outlet"
                    end
                    push!(lines,string("patch3,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
                end
                if patchtype4val==0
                    push!(notusedsets, "5")
                else
                    if patchtype4val==1
                        patchtype="inlet"
                    elseif patchtype4val==2
                        patchtype="patch"
                    elseif patchtype4val==3
                        patchtype="outlet"
                    end
                    push!(lines,string("patch4,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
                end
            end
            for line in lines
                println(wfn,line)
            end
            close(wfn)

            meshfile = str1
            meshfilename_parts=splitpath(meshfile)
            meshfilename_parts[end]="_" * meshfilename_parts[end]
            writefilename=joinpath(meshfilename_parts)
            _meshfile=writefilename
            len_out=length(notusedsets)
            notusedsets_out=String[]        
            if len_out>=1
                touch(writefilename)
                wfn = open(writefilename,"w")  
                for i_out in 1:len_out
                    if i_out==1
                        notusedsets_out=notusedsets[i_out]
                    else
                        notusedsets_out=notusedsets_out * "," * notusedsets[i_out] 
                    end
                end
                println(wfn,notusedsets_out)
                close(wfn)
            else
                if isfile(writefilename)
                    rm(writefilename)
                end
            end       

            simfile = joinpath(mypath,"_simulation_params.csv")
            writefilename=simfile
            touch(writefilename)
            wfn = open(writefilename,"w")  
            lines=String[]
            if i_model==1 || i_model==2 || i_model==3
                push!(lines,"p_ref,rho_ref,gamma,mu_resin,p_a,p_init,rho_0_air,rho_0_oil")
                push!(lines,string("1.01325e5,1.225,1.4,",str3,",",str4,",",str5,",",str6,",",str7))
            end
            for line in lines
                println(wfn,line)
            end
            close(wfn)

            filename_parts=splitpath(meshfile)
            _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
            __psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"__pset.csv")
            if isfile(_psetfile)
                mv(_psetfile,__psetfile,force=true) 
            end
        end

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        t_step = t_max/4
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  
        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype)
        
        if i_batch==0
            if isfile(_meshfile)
                rm(_meshfile)
            end
            if isfile(partfile)
                rm(partfile)
            end
            if isfile(simfile)
                rm(simfile)
            end
            if isfile(__psetfile)
                mv(__psetfile,_psetfile,force=true) 
            end
        elseif i_batch==1
            if isfile(__psetfile)
                mv(__psetfile,_psetfile,force=true) 
            end
        end

        hdf_path=joinpath(mypath,"_data.h5")
        LCMsim_v2.save_plottable_mesh(case.mesh, hdf_path)
        LCMsim_v2.save_state(case.state, hdf_path)
            
        polys::Vector{Polygon} = []
        gamma::Vector{Float64} = []
        
               
        h5open(hdf_path, "r") do meshfile
        
            grid = read_dataset(meshfile["/mesh"], "vertices")
            cells = read_dataset(meshfile["/mesh"], "cells")
            N = size(cells)[1]
            M = size(grid)[1]
            xvec=Array{Float64}(undef, 3, N)
            yvec=Array{Float64}(undef, 3, N)
            zvec=Array{Float64}(undef, 3, N)            
            xvec1=Array{Float64}(undef, M)
            yvec1=Array{Float64}(undef, M)
            zvec1=Array{Float64}(undef, M)
            cgammavec=Array{Float64}(undef, 3, N)
            cgammavec_bw=Array{Float64}(undef, 3, N)
        
        
            for cid in 1:N
                points::Vector{Point2f} = []
                for j in 1:3
                    gid = cells[cid, j]
                    x = grid[gid, 1]
                    y = grid[gid, 2]
                    z = grid[gid, 3]
                    push!(points, Point2f(x, y))            
                    xvec[j,cid]=x
                    yvec[j,cid]=y
                    zvec[j,cid]=z
                    cgammavec[j,cid]=1.0
                    cgammavec_bw[j,cid]=1.0
                end
                push!(polys, Polygon(points))
            end
            xyz = reshape([xvec[:] yvec[:] zvec[:]]', :)
        
            states = keys(meshfile["/"])
            states = filter(s -> s[1:3] == "sta", states)
            
            gammas = [read_dataset(meshfile["/" * state], "gamma") for state in states]
            #gammas = [read_dataset(meshfile["/" * state], "p") for state in states]
        
            #gamma = read_dataset(meshfile["properties"], "volume")
            gamma = read_dataset(meshfile["properties"], "part_id")
        
            for cid in 1:N
                for j in 1:3
                    cgammavec[j,cid]=gamma[cid]
                    cgammavec_bw[j,cid]=gamma[cid]
                end
            end
            
            #bounding box
            deltax=maximum(xvec)-minimum(xvec)
            deltay=maximum(yvec)-minimum(yvec)
            deltaz=maximum(zvec)-minimum(zvec)
            mindelta=min(deltax,deltay,deltaz)
            maxdelta=max(deltax,deltay,deltaz)
            if mindelta<maxdelta*0.001
                eps_delta=maxdelta*0.001
            else
                eps_delta=0
            end 
            ax=(deltax+eps_delta)/(mindelta+eps_delta)
            ay=(deltay+eps_delta)/(mindelta+eps_delta)
            az=(deltaz+eps_delta)/(mindelta+eps_delta)

            points1::Vector{Point3f0} = []
            for gid in 1:M        
                    xvec1[gid]=grid[gid, 1]
                    yvec1[gid]=grid[gid, 2]
                    zvec1[gid]=grid[gid, 3]
            end
            points1=rand(Point3f0, length(xvec1))
            for i in 1:length(xvec1)
                points1[i]=Point3f0(xvec1[i],yvec1[i],zvec1[i])
            end

            maxval=maximum(cgammavec[:])
            minval=minimum(cgammavec[:])
            deltaval=max(maxval-minval,0.1*(abs(maxval)))
            maxval=maxval+deltaval
            minval=minval-deltaval        
            resolution_val = 800  #1200
            fig = Figure(size=(resolution_val, resolution_val))
            ax1 = Axis3(fig[1, 1]; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
            p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(1,5))
            Colorbar(fig, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(1,5));  
            hidedecorations!(ax1);hidespines!(ax1) 
            
            display(fig)        
        end
        rm(hdf_path)       
    end
    function sel_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        str1_1 = get_gtk_property(mf1,:text,String); 

        #coloring of mesh: 0..none, 1..thickness, 2..porosity, 3..permeability, 4..alpha
        i_var_in=parse(Int,str1_1)
        if i_var_in>=0 && i_var_in<=4
            i_var=i_var_in
        else
            i_var=0
        end 

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1")
            push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                push!(lines,string("patch2,", patchtype,",3,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                push!(lines,string("patch3,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                push!(lines,string("patch4,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
            end
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        meshfile = str1
        meshfilename_parts=splitpath(meshfile)
        meshfilename_parts[end]="_" * meshfilename_parts[end]
        writefilename=joinpath(meshfilename_parts)
        _meshfile=writefilename
        len_out=length(notusedsets)
        notusedsets_out=String[]        
        if len_out>=1
            touch(writefilename)
            wfn = open(writefilename,"w")  
            for i_out in 1:len_out
                if i_out==1
                    notusedsets_out=notusedsets[i_out]
                else
                    notusedsets_out=notusedsets_out * "," * notusedsets[i_out] 
                end
            end
            println(wfn,notusedsets_out)
            close(wfn)
        else
            if isfile(writefilename)
                rm(writefilename)
            end
        end       

        simfile = joinpath(mypath,"_simulation_params.csv")
        writefilename=simfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"p_ref,rho_ref,gamma,mu_resin,p_a,p_init,rho_0_air,rho_0_oil")
            push!(lines,string("1.01325e5,1.225,1.4,",str3,",",str4,",",str5,",",str6,",",str7))
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        t_step = t_max/4
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  

        filename_parts=splitpath(meshfile)
        _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
        if isfile(_psetfile)
            rm(_psetfile)
        end

        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype)
        
        if isfile(_meshfile)
            rm(_meshfile)
        end
        if isfile(partfile)
            rm(partfile)
        end
        if isfile(simfile)
            rm(simfile)
        end

        hdf_path=joinpath(mypath,"_data.h5")
        LCMsim_v2.save_plottable_mesh(case.mesh, hdf_path)
        LCMsim_v2.save_state(case.state, hdf_path)

        filename_parts=splitpath(meshfile)
        _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
        writefilename=_psetfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        println(wfn,str61)
        close(wfn)

        polys::Vector{Polygon} = []
        gamma::Vector{Float64} = []

        h5open(hdf_path, "r") do meshfile

            grid = read_dataset(meshfile["/mesh"], "vertices")
            cells = read_dataset(meshfile["/mesh"], "cells")
            N = size(cells)[1]
            M = size(grid)[1]
            xvec=Array{Float64}(undef, 3, N)
            yvec=Array{Float64}(undef, 3, N)
            zvec=Array{Float64}(undef, 3, N)
            xvec1=Array{Float64}(undef, M)
            yvec1=Array{Float64}(undef, M)
            zvec1=Array{Float64}(undef, M)
            xvec2=Array{Float64}(undef, N)
            yvec2=Array{Float64}(undef, N)
            zvec2=Array{Float64}(undef, N)
            cgammavec=Array{Float64}(undef, 3, N)
            cgammavec_bw=Array{Float64}(undef, 3, N)


            for cid in 1:N
                points::Vector{Point2f} = []
                for j in 1:3
                    gid = cells[cid, j]
                    x = grid[gid, 1]
                    y = grid[gid, 2]
                    z = grid[gid, 3]
                    push!(points, Point2f(x, y))            
                    xvec[j,cid]=x
                    yvec[j,cid]=y
                    zvec[j,cid]=z
                    cgammavec[j,cid]=1.0
                    cgammavec_bw[j,cid]=1.0
                end
                push!(polys, Polygon(points))
            end
            xyz = reshape([xvec[:] yvec[:] zvec[:]]', :)

            states = keys(meshfile["/"])
            states = filter(s -> s[1:3] == "sta", states)
            
            gammas = [read_dataset(meshfile["/" * state], "gamma") for state in states]

            gamma = read_dataset(meshfile["properties"], "part_id")
            gamma = gamma*0.

            cgammasvec=Array{Float64}(undef, 3, N,length(gammas))
            cgammasvec_bw=Array{Float64}(undef, 3, N,length(gammas))
            for tid in 1:length(gammas)
                for cid in 1:N
                    for j in 1:3
                        cgammasvec[j,cid,tid]=gammas[tid][cid]
                        if cgammasvec[j,cid,tid]>=0.8;
                            cgammasvec_bw[j,cid,tid]=1.0
                        else
                            cgammasvec_bw[j,cid,tid]=0.0
                        end
                    end
                end
            end
            cgammavec=cgammasvec[:,:,length(gammas)]
            cgammavec_bw=cgammasvec_bw[:,:,length(gammas)]

            times = [read_attribute(meshfile["/" * state], "t") for state in states]
            
            #bounding box
            deltax=maximum(xvec)-minimum(xvec)
            deltay=maximum(yvec)-minimum(yvec)
            deltaz=maximum(zvec)-minimum(zvec)
            mindelta=min(deltax,deltay,deltaz)
            maxdelta=max(deltax,deltay,deltaz)
            if mindelta<maxdelta*0.001
                eps_delta=maxdelta*0.001
            else
                eps_delta=0
            end 
            ax=(deltax+eps_delta)/(mindelta+eps_delta)
            ay=(deltay+eps_delta)/(mindelta+eps_delta)
            az=(deltaz+eps_delta)/(mindelta+eps_delta)

            points1::Vector{Point3f0} = []
            #use cell centers instead
            for cid in 1:N
                xvec2[cid]=0.
                yvec2[cid]=0.
                zvec2[cid]=0.
                for j in 1:3
                    gid = cells[cid, j]
                    x = grid[gid, 1]
                    y = grid[gid, 2]
                    z = grid[gid, 3]
                    xvec2[cid]=xvec2[cid]+0.3333*x
                    yvec2[cid]=yvec2[cid]+0.3333*y
                    zvec2[cid]=zvec2[cid]+0.3333*z
                end
            end
            points1=rand(Point3f0, length(xvec2))
            for i in 1:length(xvec2)
                points1[i]=Point3f0(xvec2[i],yvec2[i],zvec2[i])
            end

            positions = Observable(points1) 
            inletpos_xyz=Array{Float64}[]

            resolution_val = 800 
            markersizeval=20 
            fig = Figure()
            ax1 = Axis3(fig[1, 1]; aspect=(ax,ay,az), perspectiveness=0.5,viewmode = :fitzoom,title="Select inlets with p + LMB")
            p=scatter!(ax1, positions,markersize=markersizeval)
            hidedecorations!(ax1);
            hidespines!(ax1) 

            on(events(fig).mousebutton, priority = 2) do event
                if event.button == Mouse.left && event.action == Mouse.press
                    if Keyboard.p in events(fig).keyboardstate
                        plt, i = pick(fig.scene,events(fig).mouseposition[])
                        if plt == p
                            #@load filename inletpos_xyz
                            t_div=100;
                            xpos=positions[][i][1];
                            ypos=positions[][i][2];
                            zpos=positions[][i][3];
                            #inletpos_xyz=vcat(inletpos_xyz,[xpos ypos zpos]);
                            inletpos_xyz=push!(inletpos_xyz,[xpos ypos zpos])
                            #@save filename inletpos_xyz
                            textpos=string( string(round(t_div*xpos)/t_div) , "," , string(round(t_div*ypos)/t_div) , "," , string(round(t_div*zpos)/t_div)  )
                            t1=text!(ax1,textpos,position = (xpos,ypos,zpos) ) 
                            wfn = open(writefilename,"a")  
                            println(wfn,textpos)
                            close(wfn)
                            scatter!(Point3f0(xpos,ypos,zpos),markersize=2*markersizeval,color = :black)
                            return Consume(true)
                        end
                    end
                end
                return Consume(false)
            end

            display(fig)       
        end
        rm(hdf_path)
    end
    function ss_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str38))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str48))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59))
                end
            end
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        meshfile = str1
        meshfilename_parts=splitpath(meshfile)
        meshfilename_parts[end]="_" * meshfilename_parts[end]
        writefilename=joinpath(meshfilename_parts)
        _meshfile=writefilename
        len_out=length(notusedsets)
        notusedsets_out=String[]        
        if len_out>=1
            touch(writefilename)
            wfn = open(writefilename,"w")  
            for i_out in 1:len_out
                if i_out==1
                    notusedsets_out=notusedsets[i_out]
                else
                    notusedsets_out=notusedsets_out * "," * notusedsets[i_out] 
                end
            end
            println(wfn,notusedsets_out)
            close(wfn)
        else
            if isfile(writefilename)
                rm(writefilename)
            end
        end       

        simfile = joinpath(mypath,"_simulation_params.csv")
        writefilename=simfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"p_ref,rho_ref,gamma,mu_resin,p_a,p_init,rho_0_air,rho_0_oil")
            push!(lines,string("1.01325e5,1.225,1.4,",str3,",",str4,",",str5,",",str6,",",str7))
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        t_step = t_max/16
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  

        filename_parts=splitpath(meshfile)
        _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
        if isfile(_psetfile)
            rm(_psetfile)
        end

        LCMsim_v2.create_and_solve(savepath,meshfile,partfile,simfile,modeltype,t_max,t_step,LCMsim_v2.verbose,true,true)
        
        if isfile(_meshfile)
            rm(_meshfile)
        end
        if isfile(partfile)
            rm(partfile)
        end
        if isfile(simfile)
            rm(simfile)
        end
    end
    function cs_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(1); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59))
                end
            end
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        meshfile = str1
        meshfilename_parts=splitpath(meshfile)
        meshfilename_parts[end]="_" * meshfilename_parts[end]
        writefilename=joinpath(meshfilename_parts)
        _meshfile=writefilename
        len_out=length(notusedsets)
        notusedsets_out=String[]        
        if len_out>=1
            touch(writefilename)
            wfn = open(writefilename,"w")  
            for i_out in 1:len_out
                if i_out==1
                    notusedsets_out=notusedsets[i_out]
                else
                    notusedsets_out=notusedsets_out * "," * notusedsets[i_out] 
                end
            end
            println(wfn,notusedsets_out)
            close(wfn)
        else
            if isfile(writefilename)
                rm(writefilename)
            end
        end       

        simfile = joinpath(mypath,"_simulation_params.csv")
        writefilename=simfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"p_ref,rho_ref,gamma,mu_resin,p_a,p_init,rho_0_air,rho_0_oil")
            push!(lines,string("1.01325e5,1.225,1.4,",str3,",",str4,",",str5,",",str6,",",str7))
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  

        filename_parts=splitpath(meshfile)
        _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
        if isfile(_psetfile)
            rm(_psetfile)
        end

        sourcepath=joinpath(savepath,"data.jld2")
        output_intervals=16
        LCMsim_v2.continue_and_solve(sourcepath,savepath,meshfile,partfile,simfile,modeltype,t_max,output_intervals,LCMsim_v2.verbose,true,true)
        
        if isfile(_meshfile)
            rm(_meshfile)
        end
        if isfile(partfile)
            rm(partfile)
        end
        if isfile(simfile)
            rm(simfile)
        end
    end
    function si_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59))
                end
            end
            if i_model==1 || i_model==2
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
            elseif i_model==3
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19))
            end
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        meshfile = str1
        meshfilename_parts=splitpath(meshfile)
        meshfilename_parts[end]="_" * meshfilename_parts[end]
        writefilename=joinpath(meshfilename_parts)
        _meshfile=writefilename
        len_out=length(notusedsets)
        notusedsets_out=String[]        
        if len_out>=1
            touch(writefilename)
            wfn = open(writefilename,"w")  
            for i_out in 1:len_out
                if i_out==1
                    notusedsets_out=notusedsets[i_out]
                else
                    notusedsets_out=notusedsets_out * "," * notusedsets[i_out] 
                end
            end
            println(wfn,notusedsets_out)
            close(wfn)
        else
            if isfile(writefilename)
                rm(writefilename)
            end
        end       

        simfile = joinpath(mypath,"_simulation_params.csv")
        writefilename=simfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"p_ref,rho_ref,gamma,mu_resin,p_a,p_init,rho_0_air,rho_0_oil")
            push!(lines,string("1.01325e5,1.225,1.4,",str3,",",str4,",",str5,",",str6,",",str7))
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        t_step = t_max/16
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  

        LCMsim_v2.create_and_solve(savepath,meshfile,partfile,simfile,modeltype,t_max,t_step,LCMsim_v2.verbose,true,true)
        
        if isfile(_meshfile)
            rm(_meshfile)
        end
        if isfile(partfile)
            rm(partfile)
        end
        if isfile(simfile)
            rm(simfile)
        end
    end
    function ci_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(1); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",4,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",5,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","1e5"))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59))
                end
            end
            if i_model==1 || i_model==2
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","1e5"))
            elseif i_model==3
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19))
            end
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        meshfile = str1
        meshfilename_parts=splitpath(meshfile)
        meshfilename_parts[end]="_" * meshfilename_parts[end]
        writefilename=joinpath(meshfilename_parts)
        _meshfile=writefilename
        len_out=length(notusedsets)
        notusedsets_out=String[]        
        if len_out>=1
            touch(writefilename)
            wfn = open(writefilename,"w")  
            for i_out in 1:len_out
                if i_out==1
                    notusedsets_out=notusedsets[i_out]
                else
                    notusedsets_out=notusedsets_out * "," * notusedsets[i_out] 
                end
            end
            println(wfn,notusedsets_out)
            close(wfn)
        else
            if isfile(writefilename)
                rm(writefilename)
            end
        end       

        simfile = joinpath(mypath,"_simulation_params.csv")
        writefilename=simfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"p_ref,rho_ref,gamma,mu_resin,p_a,p_init,rho_0_air,rho_0_oil")
            push!(lines,string("1.01325e5,1.225,1.4,",str3,",",str4,",",str5,",",str6,",",str7))
        end
        for line in lines
            println(wfn,line)
        end
        close(wfn)

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  

        sourcepath=joinpath(savepath,"data.jld2")
        output_intervals=16
        LCMsim_v2.continue_and_solve(sourcepath,savepath,meshfile,partfile,simfile,modeltype,t_max,output_intervals,LCMsim_v2.verbose,true,true)
        
        if isfile(_meshfile)
            rm(_meshfile)
        end
        if isfile(partfile)
            rm(partfile)
        end
        if isfile(simfile)
            rm(simfile)
        end
    end
    function pr_clicked(w)
        i_model=parse(Int,get_gtk_property(par_0,:text,String))
        i_var_in=parse(Int,get_gtk_property(pr1,:text,String)); 

        #coloring of mesh: 1..gamma, 2..p, 3..rho, 4..sqrt(u^2+v^2)
        if i_var_in>=1 && i_var_in<=4
            i_var=i_var_in
        else
            i_var=1
        end 

        savepath = mypath

        GLMakie.activate!()

        polys::Vector{Polygon} = []
        gamma::Vector{Float64} = []

        h5open(joinpath(savepath,"data.h5"), "r") do meshfile

            grid = read_dataset(meshfile["/mesh"], "vertices")
            cells = read_dataset(meshfile["/mesh"], "cells")
            N = size(cells)[1]
            xvec=Array{Float64}(undef, 3, N)
            yvec=Array{Float64}(undef, 3, N)
            zvec=Array{Float64}(undef, 3, N)
            cgammavec=Array{Float64}(undef, 3, N)
            cgammavec_bw=Array{Float64}(undef, 3, N)


            for cid in 1:N
                points::Vector{Point2f} = []
                for j in 1:3
                    gid = cells[cid, j]
                    x = grid[gid, 1]
                    y = grid[gid, 2]
                    z = grid[gid, 3]
                    push!(points, Point2f(x, y))            
                    xvec[j,cid]=x
                    yvec[j,cid]=y
                    zvec[j,cid]=z
                    cgammavec[j,cid]=1.0
                    cgammavec_bw[j,cid]=1.0
                end
                push!(polys, Polygon(points))
            end
            xyz = reshape([xvec[:] yvec[:] zvec[:]]', :)

            states = keys(meshfile["/"])
            states = filter(s -> s[1:3] == "sta", states)
            
            if i_var==1
                gammas = [read_dataset(meshfile["/" * state], "gamma") for state in states]
            elseif i_var==2
                gammas = [read_dataset(meshfile["/" * state], "p") for state in states]
            elseif i_var==3
                gammas = [read_dataset(meshfile["/" * state], "rho") for state in states]
            elseif i_var==4
                gammas = [read_dataset(meshfile["/" * state], "u") for state in states]
                gammas1 = [read_dataset(meshfile["/" * state], "u") for state in states]
                gammas2 = [read_dataset(meshfile["/" * state], "v") for state in states]
                for tid in 1:length(gammas1)
                    for cid in 1:N
                        gammas[tid][cid]=sqrt( gammas1[tid][cid]^2 + gammas2[tid][cid]^2 )
                    end
                end
            end
            #gammas = [read_dataset(meshfile["/" * state], "p") for state in states]

            gamma = read_dataset(meshfile["properties"], "thickness")

            cgammasvec=Array{Float64}(undef, 3, N,length(gammas))
            cgammasvec_bw=Array{Float64}(undef, 3, N,length(gammas))
            for tid in 1:length(gammas)
                for cid in 1:N
                    for j in 1:3
                        cgammasvec[j,cid,tid]=gammas[tid][cid]

                        #if cgammasvec[j,cid,tid]>=960;
                        #    cgammasvec[j,cid,tid]=960
                        #end

                        if cgammasvec[j,cid,tid]>=0.8;
                            cgammasvec_bw[j,cid,tid]=1.0
                        else
                            cgammasvec_bw[j,cid,tid]=0.0
                        end
                    end
                end
            end
            cgammavec=cgammasvec[:,:,length(gammas)]
            cgammavec_bw=cgammasvec_bw[:,:,length(gammas)]

            times = [read_attribute(meshfile["/" * state], "t") for state in states]
            
            #bounding box
            deltax=maximum(xvec)-minimum(xvec)
            deltay=maximum(yvec)-minimum(yvec)
            deltaz=maximum(zvec)-minimum(zvec)
            mindelta=min(deltax,deltay,deltaz)
            maxdelta=max(deltax,deltay,deltaz)
            if mindelta<maxdelta*0.001
                eps_delta=maxdelta*0.001
            else
                eps_delta=0
            end 
            ax=(deltax+eps_delta)/(mindelta+eps_delta)
            ay=(deltay+eps_delta)/(mindelta+eps_delta)
            az=(deltaz+eps_delta)/(mindelta+eps_delta)

            resolution_val = 800  #1200
            fig = Figure(size=(resolution_val, resolution_val))            

            ax1 = Axis3(fig[1, 1]; aspect=(ax,ay,az), perspectiveness=0.5,viewmode = :fitzoom)
            if i_var==1
                ax1.title="Filling factor"
                p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(0,1))
            elseif i_var==2
                ax1.title="Pressure"
                p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec[:], strokewidth=1)  #, colorrange=(0,1))
            elseif i_var==3
                ax1.title="Mass density"
                p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec[:], strokewidth=1)  #, colorrange=(0,1))
            elseif i_var==4
                ax1.title="Velocity magnitude"
                p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec[:], strokewidth=1)  #, colorrange=(0,1))
            end            
            hidedecorations!(ax1);
            hidespines!(ax1) 

            display(fig)

        end


    end
    function po_clicked(w)
        i_model=parse(Int,get_gtk_property(par_0,:text,String))
        savepath = mypath
        GLMakie.activate!()

        polys::Vector{Polygon} = []
        gamma::Vector{Float64} = []

        h5open(joinpath(savepath,"data.h5"), "r") do meshfile
            grid = read_dataset(meshfile["/mesh"], "vertices")
            cells = read_dataset(meshfile["/mesh"], "cells")
            N = size(cells)[1]
            xvec=Array{Float64}(undef, 3, N)
            yvec=Array{Float64}(undef, 3, N)
            zvec=Array{Float64}(undef, 3, N)
            cgammavec=Array{Float64}(undef, 3, N)
            cgammavec_bw=Array{Float64}(undef, 3, N)
        
            for cid in 1:N
                points::Vector{Point2f} = []
                for j in 1:3
                    gid = cells[cid, j]
                    x = grid[gid, 1]
                    y = grid[gid, 2]
                    z = grid[gid, 3]
                    push!(points, Point2f(x, y))            
                    xvec[j,cid]=x
                    yvec[j,cid]=y
                    zvec[j,cid]=z
                    cgammavec[j,cid]=1.0
                    cgammavec_bw[j,cid]=1.0
                end
                push!(polys, Polygon(points))
            end
            xyz = reshape([xvec[:] yvec[:] zvec[:]]', :)
        
            states = keys(meshfile["/"])
            states = filter(s -> s[1:3] == "sta", states)
            
            gammas = [read_dataset(meshfile["/" * state], "gamma") for state in states]
            gamma = read_dataset(meshfile["properties"], "type")
        
            cgammasvec=Array{Float64}(undef, 3, N,length(gammas))
            cgammasvec_bw=Array{Float64}(undef, 3, N,length(gammas))
            for tid in 1:length(gammas)
                for cid in 1:N
                    for j in 1:3
                        cgammasvec[j,cid,tid]=gammas[tid][cid]
                        if gamma[cid]==-1 || gamma[cid]==-2;  #different color for inlet and outlet
                            cgammasvec[j,cid,tid]=0.95
                        end
                        if i_model==1
                            if cgammasvec[j,cid,tid]>=0.8;
                                cgammasvec[j,cid,tid]=1.0
                            else
                                cgammasvec[j,cid,tid]=0.0
                            end
                        end
                    end
                end
            end
            cgammavec=cgammasvec[:,:,length(gammas)]
            cgammavec_bw=cgammasvec_bw[:,:,length(gammas)]
        
            cgammavec1=cgammasvec[:,:,length(gammas)]
            cgammavec2=cgammasvec[:,:,length(gammas)]
            cgammavec3=cgammasvec[:,:,length(gammas)]
            cgammavec4=cgammasvec[:,:,length(gammas)]
        
            times = [read_attribute(meshfile["/" * state], "t") for state in states]
        
        
            time1=Float64(0.0)
            time2=Float64(0.0)
            time3=Float64(0.0)
            time4=Float64(0.0)
        
            #bounding box
            deltax=maximum(xvec)-minimum(xvec)
            deltay=maximum(yvec)-minimum(yvec)
            deltaz=maximum(zvec)-minimum(zvec)
            mindelta=min(deltax,deltay,deltaz)
            maxdelta=max(deltax,deltay,deltaz)
            if mindelta<maxdelta*0.001
                eps_delta=maxdelta*0.001
            else
                eps_delta=0
            end 
            ax=(deltax+eps_delta)/(mindelta+eps_delta)
            ay=(deltay+eps_delta)/(mindelta+eps_delta)
            az=(deltaz+eps_delta)/(mindelta+eps_delta)
        
        
            ind4=length(times)
            ind3=ind4-4
            ind2=ind4-8
            ind1=ind4-12

            time1=times[ind1]
            time2=times[ind2]
            time3=times[ind3]
            time4=times[ind4]

            cgammavec1=cgammasvec[:,:,ind1]
            cgammavec2=cgammasvec[:,:,ind2]
            cgammavec3=cgammasvec[:,:,ind3]
            cgammavec4=cgammasvec[:,:,ind4]
        
            resolution_val=300;
            fig = Figure(size=(4*resolution_val, resolution_val))
            ax1 = Axis3(fig[1, 1]; aspect=(ax,ay,az), perspectiveness=0.5,viewmode = :fitzoom,title=string("Filling factor at t=", string(round(time1)) ,"s"))
            p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec1[:], strokewidth=1,colorrange=(0,1))  
            hidedecorations!(ax1); hidespines!(ax1) 
            ax1 = Axis3(fig[1, 2]; aspect=(ax,ay,az), perspectiveness=0.5,viewmode = :fitzoom,title=string("Filling factor at t=", string(round(time2)) ,"s"))
            p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec2[:], strokewidth=1,colorrange=(0,1))  
            hidedecorations!(ax1); hidespines!(ax1) 
            ax1 = Axis3(fig[1, 3]; aspect=(ax,ay,az), perspectiveness=0.5,viewmode = :fitzoom,title=string("Filling factor at t=", string(round(time3)) ,"s"))
            p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec3[:], strokewidth=1,colorrange=(0,1))  
            hidedecorations!(ax1); hidespines!(ax1) 
            ax1 = Axis3(fig[1, 4]; aspect=(ax,ay,az), perspectiveness=0.5,viewmode = :fitzoom,title=string("Filling factor at t=", string(round(time4)) ,"s"))
            p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec4[:], strokewidth=1,colorrange=(0,1))  
            hidedecorations!(ax1); hidespines!(ax1) 
        
            display(fig)
        end
    end
    function pf_clicked(w)
        i_model=parse(Int,get_gtk_property(par_0,:text,String))
        savepath = mypath
        GLMakie.activate!()

        polys::Vector{Polygon} = []
        gamma::Vector{Float64} = []

        h5open(joinpath(savepath,"data.h5"), "r") do meshfile
            grid = read_dataset(meshfile["/mesh"], "vertices")
            cells = read_dataset(meshfile["/mesh"], "cells")
            N = size(cells)[1]
            xvec=Array{Float64}(undef, 3, N)
            yvec=Array{Float64}(undef, 3, N)
            zvec=Array{Float64}(undef, 3, N)
            cgammavec=Array{Float64}(undef, 3, N)
            cgammavec_bw=Array{Float64}(undef, 3, N)
        
            for cid in 1:N
                points::Vector{Point2f} = []
                for j in 1:3
                    gid = cells[cid, j]
                    x = grid[gid, 1]
                    y = grid[gid, 2]
                    z = grid[gid, 3]
                    push!(points, Point2f(x, y))            
                    xvec[j,cid]=x
                    yvec[j,cid]=y
                    zvec[j,cid]=z
                    cgammavec[j,cid]=1.0
                    cgammavec_bw[j,cid]=1.0
                end
                push!(polys, Polygon(points))
            end
            xyz = reshape([xvec[:] yvec[:] zvec[:]]', :)
        
            states = keys(meshfile["/"])
            states = filter(s -> s[1:3] == "sta", states)
            
            gammas = [read_dataset(meshfile["/" * state], "gamma") for state in states]
            gamma = read_dataset(meshfile["properties"], "type")
        
            cgammasvec=Array{Float64}(undef, 3, N,length(gammas))
            cgammasvec_bw=Array{Float64}(undef, 3, N,length(gammas))
            for tid in 1:length(gammas)
                for cid in 1:N
                    for j in 1:3
                        cgammasvec[j,cid,tid]=gammas[tid][cid]
                        if gamma[cid]==-1 || gamma[cid]==-2;  #different color for inlet and outlet
                            cgammasvec[j,cid,tid]=0.95
                        end
                        if i_model==1
                            if cgammasvec[j,cid,tid]>=0.8;
                                cgammasvec[j,cid,tid]=1.0
                            else
                                cgammasvec[j,cid,tid]=0.0
                            end
                        end
                    end
                end
            end
            cgammavec=cgammasvec[:,:,length(gammas)]
            cgammavec_bw=cgammasvec_bw[:,:,length(gammas)]
        
            times = [read_attribute(meshfile["/" * state], "t") for state in states]
        
            #bounding box
            deltax=maximum(xvec)-minimum(xvec)
            deltay=maximum(yvec)-minimum(yvec)
            deltaz=maximum(zvec)-minimum(zvec)
            mindelta=min(deltax,deltay,deltaz)
            maxdelta=max(deltax,deltay,deltaz)
            if mindelta<maxdelta*0.001
                eps_delta=maxdelta*0.001
            else
                eps_delta=0
            end 
            ax=(deltax+eps_delta)/(mindelta+eps_delta)
            ay=(deltay+eps_delta)/(mindelta+eps_delta)
            az=(deltaz+eps_delta)/(mindelta+eps_delta)
        
            ind16=length(times)
            ind15=ind16-1
            ind14=ind16-2
            ind13=ind16-3
            ind12=ind16-4
            ind11=ind16-5
            ind10=ind16-6
            ind9=ind16-7
            ind8=ind16-8
            ind7=ind16-9
            ind6=ind16-10
            ind5=ind16-11
            ind4=ind16-12
            ind3=ind16-13
            ind2=ind16-14
            ind1=ind16-15
            ind0=ind16-16

            if ind0>=1
                time0=times[ind0]
            end
            time1=times[ind1]
            time2=times[ind2]
            time3=times[ind3]
            time4=times[ind4]
            time5=times[ind5]
            time6=times[ind6]
            time7=times[ind7]
            time8=times[ind8]
            time9=times[ind9]
            time10=times[ind10]
            time11=times[ind11]
            time12=times[ind12]
            time13=times[ind13]
            time14=times[ind14]
            time15=times[ind15]
            time16=times[ind16]

            if ind0>=1
                cgammavec0=cgammavec[:,:,ind0]
            end
            cgammavec1=cgammasvec[:,:,ind1]
            cgammavec2=cgammasvec[:,:,ind2]
            cgammavec3=cgammasvec[:,:,ind3]
            cgammavec4=cgammasvec[:,:,ind4]
            cgammavec5=cgammasvec[:,:,ind5]
            cgammavec6=cgammasvec[:,:,ind6]
            cgammavec7=cgammasvec[:,:,ind7]
            cgammavec8=cgammasvec[:,:,ind8]
            cgammavec9=cgammasvec[:,:,ind9]
            cgammavec10=cgammasvec[:,:,ind10]
            cgammavec11=cgammasvec[:,:,ind11]
            cgammavec12=cgammasvec[:,:,ind12]
            cgammavec13=cgammasvec[:,:,ind13]
            cgammavec14=cgammasvec[:,:,ind14]
            cgammavec15=cgammasvec[:,:,ind15]
            cgammavec16=cgammasvec[:,:,ind16]    
        
            if ind0>=1
                time_vector=times[ind0:ind16]
                cgammavec0=cgammasvec[:,:,ind0]
            else
                time_vector=times[ind1:ind16]
            end
            n_pics=length(time_vector)

            resolution_val=800
            fig = Figure(size=(resolution_val, resolution_val))   
            ax1 = Axis3(fig[1, 1]; aspect=(ax,ay,az), perspectiveness=0.5,viewmode = :fitzoom,title=string("Filling factor at t=", string(round(time_vector[1])) ,"s"))
            p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec1[:], strokewidth=1)  
            hidedecorations!(ax1)
            hidespines!(ax1) 
            sl_t = Slider(fig[2, 1], range = time_vector[1]:  (time_vector[end]-time_vector[1])/(n_pics-1) :time_vector[end], startvalue =  time_vector[1] )

            point = lift(sl_t.value) do x    
                time_val=x
                (tval, tind)=findmin(abs.(time_vector.-x))
                time_val=time_vector[tind]
                
                empty!(ax1)  #empty!(ax1.scene)
                #von oben runten und mit else tind==0??
                len=length(time_vector)
                if tind==len
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec16[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-1
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec15[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-2
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec14[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-3
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec13[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-4
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec12[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-5
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec11[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-6
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec10[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-7
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec9[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-8
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec8[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-9
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec7[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-10
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec6[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-11
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec5[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-12
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec4[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-13
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec3[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-14
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec2[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-15
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec1[:], strokewidth=1,colorrange=(0,1)) 
                elseif tind==len-16
                    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec0[:], strokewidth=1,colorrange=(0,1)) 
                end

                #if tind==1;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec1[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==2;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec2[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==3;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec3[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==4;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec4[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==5;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec5[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==6;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec6[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==7;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec7[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==8;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec8[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==9;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec9[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==10;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec10[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==11;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec11[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==12;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec12[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==13;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec13[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==14;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec14[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==15;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec15[:], strokewidth=1,colorrange=(0,1))  
                #elseif tind==16;
                #    p1=poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:length(xvec), TriangleFace); color=cgammavec16[:], strokewidth=1,colorrange=(0,1))  
                #end
                
                ax1.title=string("Filling factor at t=", string(round(time_vector[tind])) ,"s")   
                hidedecorations!(ax1)
                hidespines!(ax1) 
                display(fig)
            end

        end

    end
    function q_clicked(w)
        #GLMakie.destroy!(GLMakie.global_gl_screen())
        Gtk.destroy(win)
    end
    function h_clicked(w)        
        i=Gtk.GtkImage(joinpath(guipath,"figures","lcmsim_help_small.png"))
        w=GtkWindow(i,"Help");
        show(i);
    end
    function in1_clicked(w)
        str = pick_file(mypath,filterlist="csv");
        set_gtk_property!(in2,:text,str);
    end
    function in1a_clicked(w)
        str = pick_file(mypath,filterlist="csv");
        set_gtk_property!(in2a,:text,str);
    end
    function in3_clicked(w)
        savepath = mypath   #with trailing /
        meshfile = get_gtk_property(mf,:text,String)
        partfile = get_gtk_property(in2,:text,String)
        simfile = get_gtk_property(in2a,:text,String) 
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
        t_step = t_max/16
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model == 1
            modeltype = LCMsim_v2.model_1
        elseif i_model == 2         
            modeltype = LCMsim_v2.model_2
        else
            modeltype = LCMsim_v2.model_3
        end  
        
        filename_parts=splitpath(meshfile)
        _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
        if isfile(_psetfile)
            rm(_psetfile)
        end
        meshfilename_parts=splitpath(meshfile)
        meshfilename_parts[end]="_" * meshfilename_parts[end]
        writefilename=joinpath(meshfilename_parts)
        _meshfile=writefilename
        if isfile(_meshfile)
            rm(_meshfile)
        end

        LCMsim_v2.create_and_solve(savepath,meshfile,partfile,simfile,modeltype,t_max,t_step,LCMsim_v2.verbose,true,true)
    end

    #callbacks
    signal_connect(sm_clicked,sm,"clicked")
    signal_connect(sr_clicked,sr,"clicked")
    signal_connect(pm_clicked,pm,"clicked")
    signal_connect(ps_clicked,ps,"clicked")
    signal_connect(ss_clicked,ss,"clicked");
    signal_connect(cs_clicked,cs,"clicked")
    signal_connect(sel_clicked,sel,"clicked")
    signal_connect(si_clicked,si,"clicked");
    signal_connect(ci_clicked,ci,"clicked")
    signal_connect(pr_clicked,pr,"clicked")
    signal_connect(po_clicked,po,"clicked")
    signal_connect(pf_clicked,pf,"clicked")
    signal_connect(q_clicked,q,"clicked")
    signal_connect(h_clicked,h,"clicked")
    signal_connect(in1_clicked,in1,"clicked")
    signal_connect(in1a_clicked,in1a,"clicked")
    signal_connect(in3_clicked,in3,"clicked")


    #show GUI
    showall(win);
    if !isinteractive()
        c = Condition()
        signal_connect(win, :destroy) do widget
            notify(c)
        end
        wait(c)
    end