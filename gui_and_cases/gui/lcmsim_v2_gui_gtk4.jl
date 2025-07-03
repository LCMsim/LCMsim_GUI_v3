using Gtk4Makie; using Gtk4
using GtkObservables
using HDF5
using JLD2
using GeometryBasics
using NativeFileDialog
using LinearAlgebra

#uncomment next line for testing purpose only
#i_batch=1;i_model=3;i_mesh=1;mypath="D:\\work\\github\\LCMsim_GUI_v3\\gui_and_cases\\cases";repositorypath="D:\\work\\github\\LCMsim_v3.jl";guipath="D:\\work\\github\\lcmsim_gui_v3\\gui_and_cases\\gui"

    @info "i_batch = $i_batch"
    @info "i_model = $i_model"
    @info "i_mesh = $i_mesh"    
    @info "path = " * mypath
    @info "repository path = " * repositorypath
	@info "gui path = " * guipath
    jlpath=joinpath(repositorypath,"src","LCMsim_v2.jl")
    include(jlpath)
    using .LCMsim_v2

    #screen = Gtk4Makie.GTKScreen(size=(1200, 800),title="LCMsim v2")
    screen = Gtk4Makie.GTKScreen(title="LCMsim v2")
    filename=joinpath(guipath,"figures","start.jld2")
    @load filename xyz N cgammavec minval maxval
    p1=display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
    ax1=current_axis()  #perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
    fig1=current_figure()
    ax1.show_axis=false
    
    
    h=grid(screen)
    g=Gtk4.GtkGrid()
  


    sm=GtkButton("Select mesh file");pm=GtkButton("Plot mesh");ps=GtkButton("Plot sets")
    if i_mesh==1
        mf=GtkEntry(); set_gtk_property!(mf,:text,joinpath(mypath,"casefiles","mesh.dat"));
    elseif i_mesh==2
        mf=GtkEntry(); set_gtk_property!(mf,:text,joinpath(mypath,"casefiles","mesh.inp"));
    end
    mf1=GtkEntry(); set_gtk_property!(mf1,:text,"0");
    mf2=GtkEntry(); set_gtk_property!(mf2,:text,"");set_gtk_property!(mf2,:editable,false)
    choices = ["Mesh",  "Thickness", "Porosity", "Permeability", "Alpha" ]
    mf3 = GtkDropDown(choices)
    mf3.selected = 0
    signal_connect(mf3, "notify::selected") do widget, others...
    idx11 = mf3.selected
    end


    r=GtkEntry(); set_gtk_property!(r,:text,"0.01")
    sel=GtkButton("Select inlet ports");
    t=GtkEntry(); set_gtk_property!(t,:text,"200")
    tend=GtkEntry(); set_gtk_property!(tend,:text,"0");set_gtk_property!(tend,:editable,false)
    ss=GtkButton("Start simulation");cs=GtkButton("Continue simulation")
    si=GtkButton("Start interactive");ci=GtkButton("Continue interactive");
    pr=GtkButton("Plot results");pr1=GtkEntry(); set_gtk_property!(pr1,:text,"1");pf1=Gtk4.GtkScale(:h, 0:16);
    pf=GtkEntry();set_gtk_property!(pf,:text,"Plot filling");set_gtk_property!(pf,:editable,false)
    pr2=GtkEntry(); set_gtk_property!(pr2,:text,"");set_gtk_property!(pr2,:editable,false)
    if i_model==3
        choices = ["Filling factor",  "Pressure", "Mass density", "Velocity magnitude","Thickness"]
    else
        choices = ["Filling factor",  "Pressure", "Mass density", "Velocity magnitude"]
    end
    pr3 = GtkDropDown(choices)
    pr3.selected = 0
    signal_connect(pr3, "notify::selected") do widget, others...
    idx12 = pr3.selected
    end
    ra=Gtk4.GtkCheckButton("Results available"); set_gtk_property!(ra,:active,false);
    in1=GtkButton("Select part file")
    in1a=GtkButton("Select sim file")
    in3=GtkButton("Run with input files")
    in2=GtkEntry(); set_gtk_property!(in2,:text,joinpath(mypath,"casefiles","part_description.csv"));
    in2a=GtkEntry(); set_gtk_property!(in2a,:text,joinpath(mypath,"casefiles","simulation_params.csv"));

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
    p0_10=GtkEntry(); set_gtk_property!(p0_10,:text,"0.7")  
    p0_11=GtkEntry(); set_gtk_property!(p0_11,:text,"100000")
    p0_12=GtkEntry(); set_gtk_property!(p0_12,:text,"0.0")  
    p0_13=GtkEntry(); set_gtk_property!(p0_13,:text,"3e-10")
    p0_14=GtkEntry(); set_gtk_property!(p0_14,:text,"0.0")  
    p0_15=GtkEntry(); set_gtk_property!(p0_15,:text,"0.7")  
    p0_16=GtkEntry(); set_gtk_property!(p0_16,:text,"3e-10")
    p0_17=GtkEntry(); set_gtk_property!(p0_17,:text,"3e-10")
    p1_1=GtkEntry(); set_gtk_property!(p1_1,:text,"0.003")
    p1_2=GtkEntry(); set_gtk_property!(p1_2,:text,"0.7")
    p1_3=GtkEntry(); set_gtk_property!(p1_3,:text,"3e-10")
    p1_4=GtkEntry(); set_gtk_property!(p1_4,:text,"1")
    p1_5=GtkEntry(); set_gtk_property!(p1_5,:text,"1")
    p1_6=GtkEntry(); set_gtk_property!(p1_6,:text,"0")
    p1_7=GtkEntry(); set_gtk_property!(p1_7,:text,"0")
    p1_8=GtkEntry(); set_gtk_property!(p1_8,:text,"0.7")
    p1_9=GtkEntry(); set_gtk_property!(p1_9,:text,"60000")
    p1_10=GtkEntry(); set_gtk_property!(p1_10,:text,"0.7")  
    p1_11=GtkEntry(); set_gtk_property!(p1_11,:text,"100000")
    p1_12=GtkEntry(); set_gtk_property!(p1_12,:text,"0.0")  
    p1_13=GtkEntry(); set_gtk_property!(p1_13,:text,"3e-10")
    p1_14=GtkEntry(); set_gtk_property!(p1_14,:text,"0.0")  
    p1_15=GtkEntry(); set_gtk_property!(p1_15,:text,"0.7")  
    p1_16=GtkEntry(); set_gtk_property!(p1_16,:text,"3e-10")
    p1_17=GtkEntry(); set_gtk_property!(p1_17,:text,"3e-10")
    p2_1=GtkEntry(); set_gtk_property!(p2_1,:text,"0.003")
    p2_2=GtkEntry(); set_gtk_property!(p2_2,:text,"0.7")
    p2_3=GtkEntry(); set_gtk_property!(p2_3,:text,"3e-10")
    p2_4=GtkEntry(); set_gtk_property!(p2_4,:text,"1")
    p2_5=GtkEntry(); set_gtk_property!(p2_5,:text,"1")
    p2_6=GtkEntry(); set_gtk_property!(p2_6,:text,"0")
    p2_7=GtkEntry(); set_gtk_property!(p2_7,:text,"0")
    p2_8=GtkEntry(); set_gtk_property!(p2_8,:text,"0.7")
    p2_9=GtkEntry(); set_gtk_property!(p2_9,:text,"60000")
    p2_10=GtkEntry(); set_gtk_property!(p2_10,:text,"0.7")  
    p2_11=GtkEntry(); set_gtk_property!(p2_11,:text,"100000")
    p2_12=GtkEntry(); set_gtk_property!(p2_12,:text,"0.0")  
    p2_13=GtkEntry(); set_gtk_property!(p2_13,:text,"3e-10")
    p2_14=GtkEntry(); set_gtk_property!(p2_14,:text,"0.0")  
    p2_15=GtkEntry(); set_gtk_property!(p2_15,:text,"0.7")  
    p2_16=GtkEntry(); set_gtk_property!(p2_16,:text,"3e-10")
    p2_17=GtkEntry(); set_gtk_property!(p2_17,:text,"3e-10")
    p3_1=GtkEntry(); set_gtk_property!(p3_1,:text,"0.003")
    p3_2=GtkEntry(); set_gtk_property!(p3_2,:text,"0.7")
    p3_3=GtkEntry(); set_gtk_property!(p3_3,:text,"3e-10")
    p3_4=GtkEntry(); set_gtk_property!(p3_4,:text,"1")
    p3_5=GtkEntry(); set_gtk_property!(p3_5,:text,"1")
    p3_6=GtkEntry(); set_gtk_property!(p3_6,:text,"0")
    p3_7=GtkEntry(); set_gtk_property!(p3_7,:text,"0")
    p3_8=GtkEntry(); set_gtk_property!(p3_8,:text,"0.7")
    p3_9=GtkEntry(); set_gtk_property!(p3_9,:text,"60000")
    p3_10=GtkEntry(); set_gtk_property!(p3_10,:text,"0.7")  
    p3_11=GtkEntry(); set_gtk_property!(p3_11,:text,"100000")
    p3_12=GtkEntry(); set_gtk_property!(p3_12,:text,"0.0")  
    p3_13=GtkEntry(); set_gtk_property!(p3_13,:text,"3e-10")
    p3_14=GtkEntry(); set_gtk_property!(p3_14,:text,"0.0")  
    p3_15=GtkEntry(); set_gtk_property!(p3_15,:text,"0.7")  
    p3_16=GtkEntry(); set_gtk_property!(p3_16,:text,"3e-10")
    p3_17=GtkEntry(); set_gtk_property!(p3_17,:text,"3e-10")
    p4_1=GtkEntry(); set_gtk_property!(p4_1,:text,"0.003")
    p4_2=GtkEntry(); set_gtk_property!(p4_2,:text,"0.7")
    p4_3=GtkEntry(); set_gtk_property!(p4_3,:text,"3e-10")
    p4_4=GtkEntry(); set_gtk_property!(p4_4,:text,"1")
    p4_5=GtkEntry(); set_gtk_property!(p4_5,:text,"1")
    p4_6=GtkEntry(); set_gtk_property!(p4_6,:text,"0")
    p4_7=GtkEntry(); set_gtk_property!(p4_7,:text,"0")
    p4_8=GtkEntry(); set_gtk_property!(p4_8,:text,"0.7")
    p4_9=GtkEntry(); set_gtk_property!(p4_9,:text,"60000")
    p4_10=GtkEntry(); set_gtk_property!(p4_10,:text,"0.7")  
    p4_11=GtkEntry(); set_gtk_property!(p4_11,:text,"100000")
    p4_12=GtkEntry(); set_gtk_property!(p4_12,:text,"0.0")  
    p4_13=GtkEntry(); set_gtk_property!(p4_13,:text,"3e-10")
    p4_14=GtkEntry(); set_gtk_property!(p4_14,:text,"0.0")  
    p4_15=GtkEntry(); set_gtk_property!(p4_15,:text,"0.7")  
    p4_16=GtkEntry(); set_gtk_property!(p4_16,:text,"3e-10")
    p4_17=GtkEntry(); set_gtk_property!(p4_17,:text,"3e-10")

    a0_1=GtkButton("Assign direction");
    a1_1=GtkButton("Assign direction");
    a2_1=GtkButton("Assign direction");
    a3_1=GtkButton("Assign direction");
    a4_1=GtkButton("Assign direction");
    dir=GtkEntry(); set_gtk_property!(dir,:text,"1.00, 0.00, 0.00");set_gtk_property!(dir,:editable,false)
    seldir=GtkButton("Select direction");
    r1=GtkButton("Zoom to fit");
    r2=GtkButton("Plot axes");

    choices = ["Ignore",  "Pressure inlet", "Pressure outlet", "Patch" ]
    f1 = GtkDropDown(choices)
    f1.selected = 1
    signal_connect(f1, "notify::selected") do widget, others...
    idx1 = f1.selected
    end
    f2 = GtkDropDown(choices)
    f2.selected = 0
    signal_connect(f2, "notify::selected") do widget, others...
    idx2 = f2.selected
    end
    f3 = GtkDropDown(choices)
    f3.selected = 0
    signal_connect(f3, "notify::selected") do widget, others...
    idx3 = f3.selected
    end
    f4 = GtkDropDown(choices)
    f4.selected = 0
    signal_connect(f4, "notify::selected") do widget, others...
    idx4 = f4.selected
    end

    choices_advanced = ["Fast",  "Standard", "Accurate" ]
    f11 = GtkDropDown(choices_advanced)
    f11.selected = 1
    signal_connect(f11, "notify::selected") do widget, others...
    idx11 = f11.selected
    end

    im=Gtk4.GtkImage(joinpath(guipath,"figures","square_100x100px.png"))
    im1=Gtk4.GtkImage(joinpath(guipath,"figures","square_100x100px.png"))
    im2=Gtk4.GtkImage(joinpath(guipath,"figures","square_100x100px.png"))
    im3=Gtk4.GtkImage(joinpath(guipath,"figures","square_100x100px.png"))
    im4=Gtk4.GtkImage(joinpath(guipath,"figures","square_100x100px.png"))
    q=GtkButton("Quit")

                                                                                g[6,1]=q
                                                                                g[6,2]=im3
    if i_batch==0
    g[1,3]=sm;g[2,3] = mf; g[3,3] = ps;  g[4,3] = pm;  g[5,3] = r1; 
                                         g[4,4] = mf3; g[5,4] = r2; 
                                         g[4,5] = mf2;  
                                                       g[5,6] = im;
    g[1,7]=r;g[2,7]=sel;   
    g[1,8]=t;g[2,8]=ss;g[3,8]=cs;                                               g[6,8]=f11
             g[2,9]=si;g[3,9]=ci;
    g[1,10]=ra; g[2,10]=pr;g[3,10]=pf1;
               g[2,11]=pr3;g[3,11]=tend;
                                                        g[5,12] = im1;
                                         
    if i_model==1 || i_model==2 || i_model==3
                                     g[3,22] = f1;   g[4,22] = f2;   g[5,22] = f3;   g[6,22] = f4;  
    g[1,23] = par_0; g[2,23] = p0_1; g[3,23] = p1_1; g[4,23] = p2_1; g[5,23] = p3_1; g[6,23] = p4_1; 
    g[1,24] = par_1; g[2,24] = p0_2; g[3,24] = p1_2; g[4,24] = p2_2; g[5,24] = p3_2; g[6,24] = p4_2; 
    g[1,25] = par_2; g[2,25] = p0_3; g[3,25] = p1_3; g[4,25] = p2_3; g[5,25] = p3_3; g[6,25] = p4_3; 
    g[1,26] = par_3; g[2,26] = p0_4; g[3,26] = p1_4; g[4,26] = p2_4; g[5,26] = p3_4; g[6,26] = p4_4; 
    g[1,27] = par_4; g[2,27] = p0_5; g[3,27] = p1_5; g[4,27] = p2_5; g[5,27] = p3_5; g[6,27] = p4_5; 
    g[1,28] = par_5; g[2,28] = p0_6; g[3,28] = p1_6; g[4,28] = p2_6; g[5,28] = p3_6; g[6,28] = p4_6;      
                     g[2,29] = p0_7; g[3,29] = p1_7; g[4,29] = p2_7; g[5,29] = p3_7; g[6,29] = p4_7;   
    end   
    if i_model==3                    
                     g[2,30] = p0_8;  g[3,30] = p1_8;  g[4,30] = p2_8;  g[5,30] = p3_8;  g[6,30] = p4_8; 
                     g[2,31] = p0_9;  g[3,31] = p1_9;  g[4,31] = p2_9;  g[5,31] = p3_9;  g[6,31] = p4_9; 
                     g[2,32] = p0_10; g[3,32] = p1_10; g[4,32] = p2_10; g[5,32] = p3_10; g[6,32] = p4_10; 
                     g[2,33] = p0_11; g[3,33] = p1_11; g[4,33] = p2_11; g[5,33] = p3_11; g[6,33] = p4_11; 
                     g[2,34] = p0_12; g[3,34] = p1_12; g[4,34] = p2_12; g[5,34] = p3_12; g[6,34] = p4_12; 
                     g[2,35] = p0_13; g[3,35] = p1_13; g[4,35] = p2_13; g[5,35] = p3_13; g[6,35] = p4_13; 
                     g[2,36] = p0_14; g[3,36] = p1_14; g[4,36] = p2_14; g[5,36] = p3_14; g[6,36] = p4_14; 
                     g[2,37] = p0_15; g[3,37] = p1_15; g[4,37] = p2_15; g[5,37] = p3_15; g[6,37] = p4_15; 
                     g[2,38] = p0_16; g[3,38] = p1_16; g[4,38] = p2_16; g[5,38] = p3_16; g[6,38] = p4_16; 
                     g[2,39] = p0_17; g[3,39] = p1_17; g[4,39] = p2_17; g[5,39] = p3_17; g[6,39] = p4_17; 
    end
                                                                     #g[5,40] = im2;
    g[1,41]=seldir;  g[2,41] = a0_1; g[3,41] = a1_1; g[4,41] = a2_1; g[5,41] = a3_1; g[6,41] = a4_1; 
    g[1,42]=dir;
    elseif i_batch==1
        g[1,2] = in1;   g[2,2] = in2;  
        g[1,3] = in1a;  g[2,3] = in2a;
        g[1,4]=sm;g[2,4] = mf; g[3,4] = ps;  g[4,4] = pm;  
        g[4,5] = mf3;  
        g[4,6] = mf2;  
        g[4,7] = im;
        g[1,8] = par_0; g[2,8] = t;  g[3,8] = in3;                             g[6,8]=f11
        g[1,9]=ra; g[2,9]=pr;g[3,9]=pf1;
               g[2,10]=pr3;g[3,10]=tend;
    end
    
    g.column_homogeneous = true
    #@info "g="*string(g)
    h[2,1]=g

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
    function pm_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        #if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        #if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        #if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        #if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        str1_1 = get_gtk_property(mf1,:text,String); 
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        #coloring of mesh: 0..none, 1..thickness, 2..porosity, 3..permeability, 4..alpha
        i_var_in=mf3.selected
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
                push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
                if i_var==0
                    push!(notusedsets, "2")
                    push!(notusedsets, "3")
                    push!(notusedsets, "4")
                    push!(notusedsets, "5")
                    push!(notusedsets, "6")
                else
                    push!(notusedsets, "6")                
                    if patchtype1val==0 || patchtype1val==1 || patchtype1val==3
                        push!(notusedsets, "2")
                    else
                        patchtype="patch"
                        push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","1e5"))
                    end
                    if patchtype2val==0 || patchtype2val==1 || patchtype2val==3
                        push!(notusedsets, "3")
                    else
                        patchtype="patch"
                        push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","1e5"))
                    end
                    if patchtype3val==0 || patchtype3val==1 || patchtype3val==3
                        push!(notusedsets, "4")
                    else
                        patchtype="patch"
                        push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","1e5"))
                    end
                    if patchtype4val==0 || patchtype4val==1 || patchtype4val==3
                        push!(notusedsets, "5")
                    else
                        patchtype="patch"
                        push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","1e5"))
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

            filename_parts=splitpath(meshfile)
            _psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"_pset.csv")
            __psetfile=joinpath( joinpath(filename_parts[1:end-1]) ,"__pset.csv")
            if isfile(_psetfile)
                mv(_psetfile,__psetfile,force=true) 
            end
        end

        savepath = mypath   
        t_max = parse(Float64,get_gtk_property(t,:text,String))  #100.
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
        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype,i_advanced)
            
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
            
            gammas = [read_dataset(meshfile["/" * state], "gamma_out") for state in states]
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
            
            points1::Vector{Point3f} = []
            for gid in 1:M        
                    xvec1[gid]=grid[gid, 1]
                    yvec1[gid]=grid[gid, 2]
                    zvec1[gid]=grid[gid, 3]
            end
            points1=rand(Point3f, length(xvec1))
            for i in 1:length(xvec1)
                points1[i]=Point3f(xvec1[i],yvec1[i],zvec1[i])
            end
        
            maxval=maximum(cgammavec[:])
            minval=minimum(cgammavec[:])
            deltaval=max(maxval-minval,0.1*(abs(maxval)))
            maxval=maxval+deltaval
            minval=minval-deltaval
            

            #resolution_val = 800  #1200
            #fig=Figure(size=(resolution_val, resolution_val))
            #ax1 = Axis3(fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
            #p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
            ##if i_var>=1
            ##    Colorbar(fig, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(minval,maxval));  
            ##end
            #display(fig)

            empty!(ax1) 
            if i_var==0
                #set_gtk_property!(mf2,:text, string("Bounding box = ", string(round(deltax*100)/100)," x ",string(round(deltay*100)/100)," x ",string(round(deltaz*100)/100)     ) )
                set_gtk_property!(mf2,:text, string( string(round(deltax*100)/100)," x ",string(round(deltay*100)/100)," x ",string(round(deltaz*100)/100)     ) )
                p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=:white, strokewidth=1,colorrange=(minval,maxval))
            elseif i_var==1
                p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
            elseif i_var==2
                p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
            elseif i_var==3
                p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
            elseif i_var==4
                p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
            end
            fig1=current_figure();
            [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
            if i_var>=1                
                col1=Colorbar(fig1, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(minval,maxval));  
            end
       
        end
        rm(hdf_path)       
    end
    function ps_clicked(w)
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if i_model==3
            str19a = get_gtk_property(p0_10,:text,String); str19b = get_gtk_property(p0_11,:text,String); str19c = get_gtk_property(p0_12,:text,String); str19d = get_gtk_property(p0_13,:text,String); str19e = get_gtk_property(p0_14,:text,String); str19f = get_gtk_property(p0_15,:text,String); str19g = get_gtk_property(p0_16,:text,String); str19h = get_gtk_property(p0_17,:text,String); 
            str29a = get_gtk_property(p1_10,:text,String); str29b = get_gtk_property(p1_11,:text,String); str29c = get_gtk_property(p1_12,:text,String); str29d = get_gtk_property(p1_13,:text,String); str29e = get_gtk_property(p1_14,:text,String); str29f = get_gtk_property(p1_15,:text,String); str29g = get_gtk_property(p1_16,:text,String); str29h = get_gtk_property(p1_17,:text,String); 
            str39a = get_gtk_property(p2_10,:text,String); str39b = get_gtk_property(p2_11,:text,String); str39c = get_gtk_property(p2_12,:text,String); str39d = get_gtk_property(p2_13,:text,String); str39e = get_gtk_property(p2_14,:text,String); str39f = get_gtk_property(p2_15,:text,String); str39g = get_gtk_property(p2_16,:text,String); str39h = get_gtk_property(p2_17,:text,String); 
            str49a = get_gtk_property(p3_10,:text,String); str49b = get_gtk_property(p3_11,:text,String); str49c = get_gtk_property(p3_12,:text,String); str49d = get_gtk_property(p3_13,:text,String); str49e = get_gtk_property(p3_14,:text,String); str49f = get_gtk_property(p3_15,:text,String); str49g = get_gtk_property(p3_16,:text,String); str49h = get_gtk_property(p3_17,:text,String); 
            str59a = get_gtk_property(p4_10,:text,String); str59b = get_gtk_property(p4_11,:text,String); str59c = get_gtk_property(p4_12,:text,String); str59d = get_gtk_property(p4_13,:text,String); str59e = get_gtk_property(p4_14,:text,String); str59f = get_gtk_property(p4_15,:text,String); str59g = get_gtk_property(p4_16,:text,String); str59h = get_gtk_property(p4_17,:text,String); 
        end
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

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
            if i_model==1 || i_model==2 || i_model==3
                push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
                if i_model==1 || i_model==2
                    push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
                elseif i_model==3
                    push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19,",",str19a,",",str19b,",",str19c,",",str19d,",",str19e,",",str19f,",",str19g,",",str19h))
                end
                if patchtype1val==0
                    push!(notusedsets, "2")
                else
                    if patchtype1val==1
                        patchtype="inlet"
                        str21=str11
                        if i_model==3; str29e=str19e; end
                    elseif patchtype1val==2
                        patchtype="patch"
                    elseif patchtype1val==3
                        patchtype="outlet"
                    end
                    if i_model==1 || i_model==2
                        push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","0.5e5",",",str22,",","1e5",",","0.0",",",str23,",","0.0",",",str22,",",str23,",",str23))
                    elseif i_model==3
                        push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29,",",str29a,",",str29b,",",str29c,",",str29d,",",str29e,",",str29f,",",str29g,",",str29h))
                    end
                end
                if patchtype2val==0
                    push!(notusedsets, "3")
                else
                    if patchtype2val==1
                        patchtype="inlet"
                        str31=str11
                        if i_model==3; str39e=str19e; end
                    elseif patchtype2val==2
                        patchtype="patch"
                    elseif patchtype2val==3
                        patchtype="outlet"
                    end
                    if i_model==1 || i_model==2
                        push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","0.5e5",",",str32,",","1e5",",","0.0",",",str33,",","0.0",",",str32,",",str33,",",str33))
                    elseif i_model==3
                        push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39,",",str39a,",",str39b,",",str39c,",",str39d,",",str39e,",",str39f,",",str39g,",",str39h))
                    end
                end
                if patchtype3val==0
                    push!(notusedsets, "4")
                else
                    if patchtype3val==1
                        patchtype="inlet"
                        str41=str11
                        if i_model==3; str49e=str19e; end
                    elseif patchtype3val==2
                        patchtype="patch"
                    elseif patchtype3val==3
                        patchtype="outlet"
                    end
                    if i_model==1 || i_model==2
                        push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","0.5e5",",",str42,",","1e5",",","0.0",",",str43,",","0.0",",",str42,",",str43,",",str43))
                    elseif i_model==3
                        push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49,",",str49a,",",str49b,",",str49c,",",str49d,",",str49e,",",str49f,",",str49g,",",str49h))
                    end
                end
                if patchtype4val==0
                    push!(notusedsets, "5")
                else
                    if patchtype4val==1
                        patchtype="inlet"
                        str51=str11
                        if i_model==3; str59e=str19e; end
                    elseif patchtype4val==2
                        patchtype="patch"
                    elseif patchtype4val==3
                        patchtype="outlet"
                    end
                    if i_model==1 || i_model==2
                        push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","0.5e5",",",str52,",","1e5",",","0.0",",",str53,",","0.0",",",str52,",",str53,",",str53))
                    elseif i_model==3
                        push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59,",",str59a,",",str59b,",",str59c,",",str59d,",",str59e,",",str59f,",",str59g,",",str59h))
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
        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype,i_advanced)
        
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
            
            gammas = [read_dataset(meshfile["/" * state], "gamma_out") for state in states]
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

            points1::Vector{Point3f} = []
            for gid in 1:M        
                    xvec1[gid]=grid[gid, 1]
                    yvec1[gid]=grid[gid, 2]
                    zvec1[gid]=grid[gid, 3]
            end
            points1=rand(Point3f, length(xvec1))
            for i in 1:length(xvec1)
                points1[i]=Point3f(xvec1[i],yvec1[i],zvec1[i])
            end

            maxval=maximum(cgammavec[:])
            minval=minimum(cgammavec[:])
            deltaval=max(maxval-minval,0.1*(abs(maxval)))
            maxval=maxval+deltaval
            minval=minval-deltaval        
            resolution_val = 800  #1200
            empty!(ax1)    
            p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(1,5))
            fig1=current_figure();
            [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
            col1=Colorbar(fig1, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(1,5));  
                  
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
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        str1_1 = get_gtk_property(mf1,:text,String); 
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        #coloring of mesh: 0..none, 1..thickness, 2..porosity, 3..permeability, 4..alpha
        i_var=0


        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
            push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            push!(notusedsets, "2")
            push!(notusedsets, "3")
            push!(notusedsets, "4")
            push!(notusedsets, "5")
			push!(notusedsets, "6")
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

        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype,i_advanced)
        
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
            
            gammas = [read_dataset(meshfile["/" * state], "gamma_out") for state in states]

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

            points1::Vector{Point3f} = []
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
            points1=rand(Point3f, length(xvec2))
            for i in 1:length(xvec2)
                points1[i]=Point3f(xvec2[i],yvec2[i],zvec2[i])
            end

            positions = Observable(points1) 
            inletpos_xyz=Array{Float64}[]

            resolution_val = 800 
            markersizeval=20 
            empty!(ax1)    
            p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=:white, strokewidth=1,colorrange=(0,1))
            fig2=scatter!(positions,markersize=markersizeval,color = :blue)
			fig1=current_figure();
            [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]

            on(events(fig2).mousebutton, priority = 2) do event
                if event.button == Mouse.left && event.action == Mouse.press
                    if Keyboard.p in events(fig2).keyboardstate
                        plt, i = pick(fig2,events(fig2).mouseposition[])
                        if plt == fig2  #p2
                            t_div=10000;
                            xpos=positions[][i][1];
                            ypos=positions[][i][2];
                            zpos=positions[][i][3];
                            inletpos_xyz=push!(inletpos_xyz,[xpos ypos zpos])
                            textpos=string( string(round(t_div*xpos)/t_div) , "," , string(round(t_div*ypos)/t_div) , "," , string(round(t_div*zpos)/t_div)  )
                            t1=text!(ax1,textpos,position = (xpos,ypos,zpos) ) 
                            wfn = open(writefilename,"a")  
                            println(wfn,textpos)
                            close(wfn)
                            scatter!(Point3f(xpos,ypos,zpos),markersize=2*markersizeval,color = :black)
                            return Consume(true)
                        end
                    end
                end
                return Consume(false)
            end
            
        end
        rm(hdf_path)
    end
    function ss_clicked(w)
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if i_model==3
            str19a = get_gtk_property(p0_10,:text,String); str19b = get_gtk_property(p0_11,:text,String); str19c = get_gtk_property(p0_12,:text,String); str19d = get_gtk_property(p0_13,:text,String); str19e = get_gtk_property(p0_14,:text,String); str19f = get_gtk_property(p0_15,:text,String); str19g = get_gtk_property(p0_16,:text,String); str19h = get_gtk_property(p0_17,:text,String); 
            str29a = get_gtk_property(p1_10,:text,String); str29b = get_gtk_property(p1_11,:text,String); str29c = get_gtk_property(p1_12,:text,String); str29d = get_gtk_property(p1_13,:text,String); str29e = get_gtk_property(p1_14,:text,String); str29f = get_gtk_property(p1_15,:text,String); str29g = get_gtk_property(p1_16,:text,String); str29h = get_gtk_property(p1_17,:text,String); 
            str39a = get_gtk_property(p2_10,:text,String); str39b = get_gtk_property(p2_11,:text,String); str39c = get_gtk_property(p2_12,:text,String); str39d = get_gtk_property(p2_13,:text,String); str39e = get_gtk_property(p2_14,:text,String); str39f = get_gtk_property(p2_15,:text,String); str39g = get_gtk_property(p2_16,:text,String); str39h = get_gtk_property(p2_17,:text,String); 
            str49a = get_gtk_property(p3_10,:text,String); str49b = get_gtk_property(p3_11,:text,String); str49c = get_gtk_property(p3_12,:text,String); str49d = get_gtk_property(p3_13,:text,String); str49e = get_gtk_property(p3_14,:text,String); str49f = get_gtk_property(p3_15,:text,String); str49g = get_gtk_property(p3_16,:text,String); str49h = get_gtk_property(p3_17,:text,String); 
            str59a = get_gtk_property(p4_10,:text,String); str59b = get_gtk_property(p4_11,:text,String); str59c = get_gtk_property(p4_12,:text,String); str59d = get_gtk_property(p4_13,:text,String); str59e = get_gtk_property(p4_14,:text,String); str59f = get_gtk_property(p4_15,:text,String); str59g = get_gtk_property(p4_16,:text,String); str59h = get_gtk_property(p4_17,:text,String); 
        end
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()        
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19,",",str19a,",",str19b,",",str19c,",",str19d,",",str19e,",",str19f,",",str19g,",",str19h))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                    str21=str11
                    if i_model==3; str29e=str19e; end
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","0.5e5",",",str22,",","1e5",",","0.0",",",str23,",","0.0",",",str22,",",str23,",",str23))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29,",",str29a,",",str29b,",",str29c,",",str29d,",",str29e,",",str29f,",",str29g,",",str29h))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                    str31=str11
                    if i_model==3; str39e=str19e; end
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","0.5e5",",",str32,",","1e5",",","0.0",",",str33,",","0.0",",",str32,",",str33,",",str33))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39,",",str39a,",",str39b,",",str39c,",",str39d,",",str39e,",",str39f,",",str39g,",",str39h))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                    str41=str11
                    if i_model==3; str49e=str19e; end
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","0.5e5",",",str42,",","1e5",",","0.0",",",str43,",","0.0",",",str42,",",str43,",",str43))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49,",",str49a,",",str49b,",",str49c,",",str49d,",",str49e,",",str49f,",",str49g,",",str49h))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                    str51=str11
                    if i_model==3; str59e=str19e; end
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","0.5e5",",",str52,",","1e5",",","0.0",",",str53,",","0.0",",",str52,",",str53,",",str53))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59,",",str59a,",",str59b,",",str59c,",",str59d,",",str59e,",",str59f,",",str59g,",",str59h))
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

        LCMsim_v2.create_and_solve(savepath,meshfile,partfile,simfile,modeltype,i_advanced,t_max,t_step,LCMsim_v2.verbose,true,true)
        
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
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if i_model==3
            str19a = get_gtk_property(p0_10,:text,String); str19b = get_gtk_property(p0_11,:text,String); str19c = get_gtk_property(p0_12,:text,String); str19d = get_gtk_property(p0_13,:text,String); str19e = get_gtk_property(p0_14,:text,String); str19f = get_gtk_property(p0_15,:text,String); str19g = get_gtk_property(p0_16,:text,String); str19h = get_gtk_property(p0_17,:text,String); 
            str29a = get_gtk_property(p1_10,:text,String); str29b = get_gtk_property(p1_11,:text,String); str29c = get_gtk_property(p1_12,:text,String); str29d = get_gtk_property(p1_13,:text,String); str29e = get_gtk_property(p1_14,:text,String); str29f = get_gtk_property(p1_15,:text,String); str29g = get_gtk_property(p1_16,:text,String); str29h = get_gtk_property(p1_17,:text,String); 
            str39a = get_gtk_property(p2_10,:text,String); str39b = get_gtk_property(p2_11,:text,String); str39c = get_gtk_property(p2_12,:text,String); str39d = get_gtk_property(p2_13,:text,String); str39e = get_gtk_property(p2_14,:text,String); str39f = get_gtk_property(p2_15,:text,String); str39g = get_gtk_property(p2_16,:text,String); str39h = get_gtk_property(p2_17,:text,String); 
            str49a = get_gtk_property(p3_10,:text,String); str49b = get_gtk_property(p3_11,:text,String); str49c = get_gtk_property(p3_12,:text,String); str49d = get_gtk_property(p3_13,:text,String); str49e = get_gtk_property(p3_14,:text,String); str49f = get_gtk_property(p3_15,:text,String); str49g = get_gtk_property(p3_16,:text,String); str49h = get_gtk_property(p3_17,:text,String); 
            str59a = get_gtk_property(p4_10,:text,String); str59b = get_gtk_property(p4_11,:text,String); str59c = get_gtk_property(p4_12,:text,String); str59d = get_gtk_property(p4_13,:text,String); str59e = get_gtk_property(p4_14,:text,String); str59f = get_gtk_property(p4_15,:text,String); str59g = get_gtk_property(p4_16,:text,String); str59h = get_gtk_property(p4_17,:text,String); 
        end
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(1); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()        
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19,",",str19a,",",str19b,",",str19c,",",str19d,",",str19e,",",str19f,",",str19g,",",str19h))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                    str21=str11
                    if i_model==3; str29e=str19e; end
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","0.5e5",",",str22,",","1e5",",","0.0",",",str23,",","0.0",",",str22,",",str23,",",str23))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29,",",str29a,",",str29b,",",str29c,",",str29d,",",str29e,",",str29f,",",str29g,",",str29h))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                    str31=str11
                    if i_model==3; str39e=str19e; end
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","0.5e5",",",str32,",","1e5",",","0.0",",",str33,",","0.0",",",str32,",",str33,",",str33))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39,",",str39a,",",str39b,",",str39c,",",str39d,",",str39e,",",str39f,",",str39g,",",str39h))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                    str41=str11
                    if i_model==3; str49e=str19e; end
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","0.5e5",",",str42,",","1e5",",","0.0",",",str43,",","0.0",",",str42,",",str43,",",str43))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49,",",str49a,",",str49b,",",str49c,",",str49d,",",str49e,",",str49f,",",str49g,",",str49h))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                    str51=str11
                    if i_model==3; str59e=str19e; end
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","0.5e5",",",str52,",","1e5",",","0.0",",",str53,",","0.0",",",str52,",",str53,",",str53))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59,",",str59a,",",str59b,",",str59c,",",str59d,",",str59e,",",str59f,",",str59g,",",str59h))
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
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if i_model==3
            str19a = get_gtk_property(p0_10,:text,String); str19b = get_gtk_property(p0_11,:text,String); str19c = get_gtk_property(p0_12,:text,String); str19d = get_gtk_property(p0_13,:text,String); str19e = get_gtk_property(p0_14,:text,String); str19f = get_gtk_property(p0_15,:text,String); str19g = get_gtk_property(p0_16,:text,String); str19h = get_gtk_property(p0_17,:text,String); 
            str29a = get_gtk_property(p1_10,:text,String); str29b = get_gtk_property(p1_11,:text,String); str29c = get_gtk_property(p1_12,:text,String); str29d = get_gtk_property(p1_13,:text,String); str29e = get_gtk_property(p1_14,:text,String); str29f = get_gtk_property(p1_15,:text,String); str29g = get_gtk_property(p1_16,:text,String); str29h = get_gtk_property(p1_17,:text,String); 
            str39a = get_gtk_property(p2_10,:text,String); str39b = get_gtk_property(p2_11,:text,String); str39c = get_gtk_property(p2_12,:text,String); str39d = get_gtk_property(p2_13,:text,String); str39e = get_gtk_property(p2_14,:text,String); str39f = get_gtk_property(p2_15,:text,String); str39g = get_gtk_property(p2_16,:text,String); str39h = get_gtk_property(p2_17,:text,String); 
            str49a = get_gtk_property(p3_10,:text,String); str49b = get_gtk_property(p3_11,:text,String); str49c = get_gtk_property(p3_12,:text,String); str49d = get_gtk_property(p3_13,:text,String); str49e = get_gtk_property(p3_14,:text,String); str49f = get_gtk_property(p3_15,:text,String); str49g = get_gtk_property(p3_16,:text,String); str49h = get_gtk_property(p3_17,:text,String); 
            str59a = get_gtk_property(p4_10,:text,String); str59b = get_gtk_property(p4_11,:text,String); str59c = get_gtk_property(p4_12,:text,String); str59d = get_gtk_property(p4_13,:text,String); str59e = get_gtk_property(p4_14,:text,String); str59f = get_gtk_property(p4_15,:text,String); str59g = get_gtk_property(p4_16,:text,String); str59h = get_gtk_property(p4_17,:text,String); 
        end
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        if patchtype1val==1;
		    #f1.selected = 0
		    patchtype1val=Int64(0)
	    end
		if patchtype2val==1;
		    #f2.selected = 0
		    patchtype2val=Int64(0)
	    end
		if patchtype3val==1;
		    #f3.selected = 0
		    patchtype3val=Int64(0)
	    end
		if patchtype4val==1;
		    #f4.selected = 0
		    patchtype4val=Int64(0)
	    end

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19,",",str19a,",",str19b,",",str19c,",",str19d,",",str19e,",",str19f,",",str19g,",",str19h))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                    str21=str11
                    if i_model==3; str29e=str19e; end
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","0.5e5",",",str22,",","1e5",",","0.0",",",str23,",","0.0",",",str22,",",str23,",",str23))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29,",",str29a,",",str29b,",",str29c,",",str29d,",",str29e,",",str29f,",",str29g,",",str29h))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                    str31=str11
                    if i_model==3; str39e=str19e; end
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","0.5e5",",",str32,",","1e5",",","0.0",",",str33,",","0.0",",",str32,",",str33,",",str33))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39,",",str39a,",",str39b,",",str39c,",",str39d,",",str39e,",",str39f,",",str39g,",",str39h))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                    str41=str11
                    if i_model==3; str49e=str19e; end
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","0.5e5",",",str42,",","1e5",",","0.0",",",str43,",","0.0",",",str42,",",str43,",",str43))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49,",",str49a,",",str49b,",",str49c,",",str49d,",",str49e,",",str49f,",",str49g,",",str49h))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                    str51=str11
                    if i_model==3; str59e=str19e; end
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","0.5e5",",",str52,",","1e5",",","0.0",",",str53,",","0.0",",",str52,",",str53,",",str53))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59,",",str59a,",",str59b,",",str59c,",",str59d,",",str59e,",",str59f,",",str59g,",",str59h))
                end
            end            
            if i_model==1 || i_model==2
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            elseif i_model==3
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19,",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
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

        LCMsim_v2.create_and_solve(savepath,meshfile,partfile,simfile,modeltype,i_advanced,t_max,t_step,LCMsim_v2.verbose,true,true)
        
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
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if i_model==3
            str19a = get_gtk_property(p0_10,:text,String); str19b = get_gtk_property(p0_11,:text,String); str19c = get_gtk_property(p0_12,:text,String); str19d = get_gtk_property(p0_13,:text,String); str19e = get_gtk_property(p0_14,:text,String); str19f = get_gtk_property(p0_15,:text,String); str19g = get_gtk_property(p0_16,:text,String); str19h = get_gtk_property(p0_17,:text,String); 
            str29a = get_gtk_property(p1_10,:text,String); str29b = get_gtk_property(p1_11,:text,String); str29c = get_gtk_property(p1_12,:text,String); str29d = get_gtk_property(p1_13,:text,String); str29e = get_gtk_property(p1_14,:text,String); str29f = get_gtk_property(p1_15,:text,String); str29g = get_gtk_property(p1_16,:text,String); str29h = get_gtk_property(p1_17,:text,String); 
            str39a = get_gtk_property(p2_10,:text,String); str39b = get_gtk_property(p2_11,:text,String); str39c = get_gtk_property(p2_12,:text,String); str39d = get_gtk_property(p2_13,:text,String); str39e = get_gtk_property(p2_14,:text,String); str39f = get_gtk_property(p2_15,:text,String); str39g = get_gtk_property(p2_16,:text,String); str39h = get_gtk_property(p2_17,:text,String); 
            str49a = get_gtk_property(p3_10,:text,String); str49b = get_gtk_property(p3_11,:text,String); str49c = get_gtk_property(p3_12,:text,String); str49d = get_gtk_property(p3_13,:text,String); str49e = get_gtk_property(p3_14,:text,String); str49f = get_gtk_property(p3_15,:text,String); str49g = get_gtk_property(p3_16,:text,String); str49h = get_gtk_property(p3_17,:text,String); 
            str59a = get_gtk_property(p4_10,:text,String); str59b = get_gtk_property(p4_11,:text,String); str59c = get_gtk_property(p4_12,:text,String); str59d = get_gtk_property(p4_13,:text,String); str59e = get_gtk_property(p4_14,:text,String); str59f = get_gtk_property(p4_15,:text,String); str59g = get_gtk_property(p4_16,:text,String); str59h = get_gtk_property(p4_17,:text,String); 
        end
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(1); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        if patchtype1val==1;
		    #f1.selected = 0
		    patchtype1val=Int64(0)
	    end
		if patchtype2val==1;
		    #f2.selected = 0
		    patchtype2val=Int64(0)
	    end
		if patchtype3val==1;
		    #f3.selected = 0
		    patchtype3val=Int64(0)
	    end
		if patchtype4val==1;
		    #f4.selected = 0
		    patchtype4val=Int64(0)
	    end
		
        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
            if i_model==1 || i_model==2
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            elseif i_model==3
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19,",",str19a,",",str19b,",",str19c,",",str19d,",",str19e,",",str19f,",",str19g,",",str19h))
            end
            if patchtype1val==0
                push!(notusedsets, "2")
            else
                if patchtype1val==1
                    patchtype="inlet"
                    str21=str11
                    if i_model==3; str29e=str19e; end
                elseif patchtype1val==2
                    patchtype="patch"
                elseif patchtype1val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str22,",","0.5e5",",",str22,",","1e5",",","0.0",",",str23,",","0.0",",",str22,",",str23,",",str23))
                elseif i_model==3
                    push!(lines,string("patch1,", patchtype,",2,",str21,",",str22,",0.0,",str23,",0.0,",str24,",",str25,",",str26,",",str27,",",str28,",",str29,",",str29a,",",str29b,",",str29c,",",str29d,",",str29e,",",str29f,",",str29g,",",str29h))
                end
            end
            if patchtype2val==0
                push!(notusedsets, "3")
            else
                if patchtype2val==1
                    patchtype="inlet"
                    str31=str11
                    if i_model==3; str39e=str19e; end
                elseif patchtype2val==2
                    patchtype="patch"
                elseif patchtype2val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str32,",","0.5e5",",",str32,",","1e5",",","0.0",",",str33,",","0.0",",",str32,",",str33,",",str33))
                elseif i_model==3
                    push!(lines,string("patch2,", patchtype,",3,",str31,",",str32,",0.0,",str33,",0.0,",str34,",",str35,",",str36,",",str37,",",str38,",",str39,",",str39a,",",str39b,",",str39c,",",str39d,",",str39e,",",str39f,",",str39g,",",str39h))
                end
            end
            if patchtype3val==0
                push!(notusedsets, "4")
            else
                if patchtype3val==1
                    patchtype="inlet"
                    str41=str11
                    if i_model==3; str49e=str19e; end
                elseif patchtype3val==2
                    patchtype="patch"
                elseif patchtype3val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str42,",","0.5e5",",",str42,",","1e5",",","0.0",",",str43,",","0.0",",",str42,",",str43,",",str43))
                elseif i_model==3
                    push!(lines,string("patch3,", patchtype,",4,",str41,",",str42,",0.0,",str43,",0.0,",str44,",",str45,",",str46,",",str47,",",str48,",",str49,",",str49a,",",str49b,",",str49c,",",str49d,",",str49e,",",str49f,",",str49g,",",str49h))
                end
            end
            if patchtype4val==0
                push!(notusedsets, "5")
            else
                if patchtype4val==1
                    patchtype="inlet"
                    str51=str11
                    if i_model==3; str59e=str19e; end
                elseif patchtype4val==2
                    patchtype="patch"
                elseif patchtype4val==3
                    patchtype="outlet"
                end
                if i_model==1 || i_model==2
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str52,",","0.5e5",",",str52,",","1e5",",","0.0",",",str53,",","0.0",",",str52,",",str53,",",str53))
                elseif i_model==3
                    push!(lines,string("patch4,", patchtype,",5,",str51,",",str52,",0.0,",str53,",0.0,",str54,",",str55,",",str56,",",str57,",",str58,",",str59,",",str59a,",",str59b,",",str59c,",",str59d,",",str59e,",",str59f,",",str59g,",",str59h))
                end
            end            
            if i_model==1 || i_model==2
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            elseif i_model==3
                push!(lines,string("interactive_inlet,inlet,6,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str18,",",str19,",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
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
        if ra.active==true
            i_model=parse(Int,get_gtk_property(par_0,:text,String))
            i_var_in=pr3.selected

            #coloring of mesh: 0..gamma_out, 1..p, 2..rho, 3..sqrt(u^2+v^2), 4..h_out if i_model==3
            if i_model==3
                if i_var_in>=0 && i_var_in<=4
                    i_var=i_var_in
                else
                    i_var=0
                end 
            else
                if i_var_in>=0 && i_var_in<=3
                    i_var=i_var_in
                else
                    i_var=0
                end 
            end

            savepath = mypath

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
                
                if i_var==0
                    gammas = [read_dataset(meshfile["/" * state], "gamma_out") for state in states]
                elseif i_var==1
                    gammas = [read_dataset(meshfile["/" * state], "p") for state in states]
                elseif i_var==2
                    gammas = [read_dataset(meshfile["/" * state], "rho") for state in states]
                elseif i_var==3
                    gammas = [read_dataset(meshfile["/" * state], "u") for state in states]
                    gammas1 = [read_dataset(meshfile["/" * state], "u") for state in states]
                    gammas2 = [read_dataset(meshfile["/" * state], "v") for state in states]
                    for tid in 1:length(gammas1)
                        for cid in 1:N
                            gammas[tid][cid]=sqrt( gammas1[tid][cid]^2 + gammas2[tid][cid]^2 )
                        end
                    end
                elseif i_var==4
                    gammas = [read_dataset(meshfile["/" * state], "h_out") for state in states]
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

                maxval=maximum(cgammavec[:])
                minval=minimum(cgammavec[:])
                deltaval=max(maxval-minval,0.1*(abs(maxval)))
                maxval=maxval+deltaval
                minval=minval-deltaval

                ax1=current_axis()
                if i_var==0
                    empty!(ax1)
                    p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(0,1))
                    fig1=current_figure(); [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
                    col1=Colorbar(fig1, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(0,1));  
                    set_gtk_property!(pr2,:text,"Gamma")
                elseif i_var==1
                    empty!(ax1)
                    p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1)
                    fig1=current_figure(); [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
                    set_gtk_property!(pr2,:text,"Pressure")
                elseif i_var==2
                    empty!(ax1)
                    p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1)
                    fig1=current_figure(); [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
                    set_gtk_property!(pr2,:text,"Mass density")
                elseif i_var==3
                    empty!(ax1)
                    p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
                    fig1=current_figure(); [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
                    set_gtk_property!(pr2,:text,"Velocity magnitude")
                elseif i_var==4
                    inds=findall(>(0.), cgammavec)
                    maxval=maximum(cgammavec[inds])
                    minval=minimum(cgammavec[inds])
                    @info "minval = $minval"
                    @info "maxval = $maxval"
                    empty!(ax1)
                    p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
                    fig1=current_figure(); [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]       
                    col1=Colorbar(fig1, colormap = :viridis,  vertical=true, height=Relative(0.75),colorrange=(minval,maxval));  
                end
                
            end
        end

    end
    signal_connect(pf1, "value-changed") do widget, others...
        if ra.active==true
            #println("Value changed")
            value = Int(round(Gtk4.value(pf1)))
            #println(string(value))
    
            i_model=parse(Int,get_gtk_property(par_0,:text,String))
            savepath = mypath
    
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
                
                gammas = [read_dataset(meshfile["/" * state], "gamma_out") for state in states]
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

                if ind0>=1 && value==0
                    cgammavec=cgammavec0
                    tvalue=times[ind0]
                else
                    cgammavec=cgammavec1
                    tvalue=times[ind1]
                end
                if value==1
                    cgammavec=cgammavec1
                    tvalue=times[ind1]
                elseif value==2
                    cgammavec=cgammavec2
                    tvalue=times[ind2]
                elseif value==3
                    cgammavec=cgammavec3
                    tvalue=times[ind3]
                elseif value==4
                    cgammavec=cgammavec4
                    tvalue=times[ind4]
                elseif value==5
                    cgammavec=cgammavec5
                    tvalue=times[ind5]
                elseif value==6
                    cgammavec=cgammavec6
                    tvalue=times[ind6]
                elseif value==7
                    cgammavec=cgammavec7                    
                    tvalue=times[ind7]
                elseif value==8
                    cgammavec=cgammavec8
                    tvalue=times[ind8]
                elseif value==9
                    cgammavec=cgammavec9
                    tvalue=times[ind9]
                elseif value==10
                    cgammavec=cgammavec10
                    tvalue=times[ind10]
                elseif value==11
                    cgammavec=cgammavec11
                    tvalue=times[ind11]
                elseif value==12
                    cgammavec=cgammavec12
                    tvalue=times[ind12]
                elseif value==13
                    cgammavec=cgammavec13
                    tvalue=times[ind13]
                elseif value==14
                    cgammavec=cgammavec14
                    tvalue=times[ind14]
                elseif value==15
                    cgammavec=cgammavec15
                    tvalue=times[ind15]
                elseif value==16
                    cgammavec=cgammavec16
                    tvalue=times[ind16]
                end             
                empty!(ax1)    
                p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))                
                fig1=current_figure(); [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
                col1=Colorbar(fig1, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(0,1));   
                set_gtk_property!(tend,:text,string(round(tvalue*100)/100))
            end
    
        end
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
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end
        
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

        LCMsim_v2.create_and_solve(savepath,meshfile,partfile,simfile,modeltype,i_advanced,t_max,t_step,LCMsim_v2.verbose,true,true)
    end
    function a0_1_clicked(w)
        str = get_gtk_property(dir,:text,String); 
        str1=split(str,",")
        set_gtk_property!(p0_5,:text,strip(str1[1]));
        set_gtk_property!(p0_6,:text,strip(str1[2]));
        set_gtk_property!(p0_7,:text,strip(str1[3]));
    end
    function a1_1_clicked(w)
        str = get_gtk_property(dir,:text,String); 
        str1=split(str,",")
        set_gtk_property!(p1_5,:text,strip(str1[1]));
        set_gtk_property!(p1_6,:text,strip(str1[2]));
        set_gtk_property!(p1_7,:text,strip(str1[3]));
    end
    function a2_1_clicked(w)
        str = get_gtk_property(dir,:text,String); 
        str1=split(str,",")
        set_gtk_property!(p2_5,:text,strip(str1[1]));
        set_gtk_property!(p2_6,:text,strip(str1[2]));
        set_gtk_property!(p2_7,:text,strip(str1[3]));
    end
    function a3_1_clicked(w)
        str = get_gtk_property(dir,:text,String); 
        str1=split(str,",")
        set_gtk_property!(p3_5,:text,strip(str1[1]));
        set_gtk_property!(p3_6,:text,strip(str1[2]));
        set_gtk_property!(p3_7,:text,strip(str1[3]));
    end
    function a4_1_clicked(w)
        str = get_gtk_property(dir,:text,String); 
        str1=split(str,",")
        set_gtk_property!(p4_5,:text,strip(str1[1]));
        set_gtk_property!(p4_6,:text,strip(str1[2]));
        set_gtk_property!(p4_7,:text,strip(str1[3]));
    end
    function seldir_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        str1_1 = get_gtk_property(mf1,:text,String); 
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        #coloring of mesh: 0..none, 1..thickness, 2..porosity, 3..permeability, 4..alpha
        i_var=0

        partfile = joinpath(mypath,"_part_description.csv")
        writefilename=partfile
        touch(writefilename)
        wfn = open(writefilename,"w")  
        lines=String[]
        notusedsets = Vector{String}()
        i_model=parse(Int,get_gtk_property(par_0,:text,String))  #2
        if i_model==1 || i_model==2 || i_model==3
            push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
            push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
            push!(notusedsets, "2")
            push!(notusedsets, "3")
            push!(notusedsets, "4")
            push!(notusedsets, "5")
			push!(notusedsets, "6")
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

        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype,i_advanced)
        
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
            
            gammas = [read_dataset(meshfile["/" * state], "gamma_out") for state in states]

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

            points1::Vector{Point3f} = []
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
            points1=rand(Point3f, length(xvec2))
            for i in 1:length(xvec2)
                points1[i]=Point3f(xvec2[i],yvec2[i],zvec2[i])
            end

            positions = Observable(points1) 
            inletpos_xyz=Array{Float64}[]

            resolution_val = 800 
            markersizeval=20 
            empty!(ax1)    
            p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=:white, strokewidth=1,colorrange=(0,1))
            fig2=scatter!(positions,markersize=markersizeval,color = :blue)
            vec=[1 0 0];
			fig1=current_figure();
            [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]

            on(events(fig2).mousebutton, priority = 2) do event
                if length(inletpos_xyz)<=1
                    if event.button == Mouse.left && event.action == Mouse.press
                        if Keyboard.p in events(fig2).keyboardstate
                            plt, i = pick(fig2,events(fig2).mouseposition[])
                            if plt == fig2  #p2
                                t_div=100;
                                xpos=positions[][i][1];
                                ypos=positions[][i][2];
                                zpos=positions[][i][3];
                                inletpos_xyz=push!(inletpos_xyz,[xpos ypos zpos])
                                textpos=string( string(round(t_div*xpos)/t_div) , "," , string(round(t_div*ypos)/t_div) , "," , string(round(t_div*zpos)/t_div)  )
                                t1=text!(ax1,textpos,position = (xpos,ypos,zpos) ) 
                                scatter!(Point3f(xpos,ypos,zpos),markersize=2*markersizeval,color = :black)
                                if length(inletpos_xyz)==2
                                    vec=[inletpos_xyz[2][1]-inletpos_xyz[1][1] inletpos_xyz[2][2]-inletpos_xyz[1][2] inletpos_xyz[2][3]-inletpos_xyz[1][3]]
                                    vec1=vec/sqrt(dot(vec,vec))
                                    str=string( string( round(vec1[1]*100)/100 ), ", ",  string( round(vec1[2]*100)/100 ), ", ", string( round(vec1[3]*100)/100 ) )
                                    set_gtk_property!(dir,:text,str)
                                end
                            end
                        end
                    end
                    return Consume(false)
                end
            end
            
        end
        rm(hdf_path)
    end
    function r1_clicked(w)
        ax1=current_axis()
        center!(ax1.scene)
    end
    function r2_clicked(w)
        str0 = get_gtk_property(par_0,:text,String); 
        str1 = get_gtk_property(mf,:text,String); str2 = get_gtk_property(t,:text,String); str3 = get_gtk_property(par_3,:text,String); str4 = get_gtk_property(par_1,:text,String); str5 = get_gtk_property(par_2,:text,String); str6 = get_gtk_property(par_4,:text,String); str7 = get_gtk_property(par_5,:text,String);
        str11 = get_gtk_property(p0_1,:text,String); str12 = get_gtk_property(p0_2,:text,String); str13 = get_gtk_property(p0_3,:text,String); str14 = get_gtk_property(p0_4,:text,String); str15 = get_gtk_property(p0_5,:text,String); str16 = get_gtk_property(p0_6,:text,String); str17 = get_gtk_property(p0_7,:text,String); str18 = get_gtk_property(p0_8,:text,String); str19 = get_gtk_property(p0_9,:text,String);
        str21 = get_gtk_property(p1_1,:text,String); str22 = get_gtk_property(p1_2,:text,String); str23 = get_gtk_property(p1_3,:text,String); str24 = get_gtk_property(p1_4,:text,String); str25 = get_gtk_property(p1_5,:text,String); str26 = get_gtk_property(p1_6,:text,String); str27 = get_gtk_property(p1_7,:text,String); str28 = get_gtk_property(p1_8,:text,String); str29 = get_gtk_property(p1_9,:text,String);
        str31 = get_gtk_property(p2_1,:text,String); str32 = get_gtk_property(p2_2,:text,String); str33 = get_gtk_property(p2_3,:text,String); str34 = get_gtk_property(p2_4,:text,String); str35 = get_gtk_property(p2_5,:text,String); str36 = get_gtk_property(p2_6,:text,String); str37 = get_gtk_property(p2_7,:text,String); str38 = get_gtk_property(p2_8,:text,String); str39 = get_gtk_property(p2_9,:text,String);
        str41 = get_gtk_property(p3_1,:text,String); str42 = get_gtk_property(p3_2,:text,String); str43 = get_gtk_property(p3_3,:text,String); str44 = get_gtk_property(p3_4,:text,String); str45 = get_gtk_property(p3_5,:text,String); str46 = get_gtk_property(p3_6,:text,String); str47 = get_gtk_property(p3_7,:text,String); str48 = get_gtk_property(p3_8,:text,String); str49 = get_gtk_property(p3_9,:text,String);
        str51 = get_gtk_property(p4_1,:text,String); str52 = get_gtk_property(p4_2,:text,String); str53 = get_gtk_property(p4_3,:text,String); str54 = get_gtk_property(p4_4,:text,String); str55 = get_gtk_property(p4_5,:text,String); str56 = get_gtk_property(p4_6,:text,String); str57 = get_gtk_property(p4_7,:text,String); str58 = get_gtk_property(p4_8,:text,String); str59 = get_gtk_property(p4_9,:text,String);
        if f1.selected==0; patchtype1val=Int64(0); elseif f1.selected==1; patchtype1val=Int64(1); elseif f1.selected==2; patchtype1val=Int64(3); elseif f1.selected==3; patchtype1val=Int64(2); end
        if f2.selected==0; patchtype2val=Int64(0); elseif f2.selected==1; patchtype2val=Int64(1); elseif f2.selected==2; patchtype2val=Int64(3); elseif f2.selected==3; patchtype2val=Int64(2); end
        if f3.selected==0; patchtype3val=Int64(0); elseif f3.selected==1; patchtype3val=Int64(1); elseif f3.selected==2; patchtype3val=Int64(3); elseif f3.selected==3; patchtype3val=Int64(2); end
        if f4.selected==0; patchtype4val=Int64(0); elseif f4.selected==1; patchtype4val=Int64(1); elseif f4.selected==2; patchtype4val=Int64(3); elseif f4.selected==3; patchtype4val=Int64(2); end
        #if [get_gtk_property(b,:active,Bool) for b in r1] == [true, false, false, false]; patchtype1val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, true, false, false]; patchtype1val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, true, false]; patchtype1val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r1] == [false, false, false, true]; patchtype1val=Int64(2); end;
        #if [get_gtk_property(b,:active,Bool) for b in r2] == [true, false, false, false]; patchtype2val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, true, false, false]; patchtype2val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, true, false]; patchtype2val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r2] == [false, false, false, true]; patchtype2val=Int64(2); end;
        #if [get_gtk_property(b,:active,Bool) for b in r3] == [true, false, false, false]; patchtype3val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, true, false, false]; patchtype3val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, true, false]; patchtype3val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r3] == [false, false, false, true]; patchtype3val=Int64(2); end;
        #if [get_gtk_property(b,:active,Bool) for b in r4] == [true, false, false, false]; patchtype4val=Int64(0);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, true, false, false]; patchtype4val=Int64(1);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, true, false]; patchtype4val=Int64(3);    elseif [get_gtk_property(b,:active,Bool) for b in r4] == [false, false, false, true]; patchtype4val=Int64(2); end;
        str61 = get_gtk_property(r,:text,String)
        restartval=Int64(0); interactiveval=Int64(0); noutval=Int64(16); 
        modelval=parse(Int64,str0);
        str1_1 = get_gtk_property(mf1,:text,String); 
        if f11.selected==0; i_advanced=Int64(0); elseif f11.selected==1; i_advanced=Int64(1); elseif f11.selected==2; i_advanced=Int64(2); end

        #coloring of mesh: 0..none, 1..thickness, 2..porosity, 3..permeability, 4..alpha
        i_var_in=mf3.selected
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
                push!(lines,"name,type,part_id,thickness,porosity,porosity_noise,permeability,permeability_noise,alpha,refdir1,refdir2,refdir3,porosity_1,p_1,porosity_2,p_2,n_CK,permeability_Z,thickness_DM,porosity_DM,permeability_DM,permeability_DM_Z")
                push!(lines,string("base,base,1,",str11,",",str12,",0.0,",str13,",0.0,",str14,",",str15,",",str16,",",str17,",",str12,",","0.5e5",",",str12,",","1e5",",","0.0",",",str13,",","0.0",",",str12,",",str13,",",str13))
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
        case=LCMsim_v2.create(meshfile,partfile,simfile,modeltype,i_advanced)
            
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
        
        deltax=0.0
        deltay=0.0
        deltaz=0.0
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
            
            gammas = [read_dataset(meshfile["/" * state], "gamma_out") for state in states]
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
        end
        rm(hdf_path)       

        arrow_lengthscale=0.1*max(deltax,deltay,deltaz)
        arrow_linewidth=arrow_lengthscale*0.1
        arrow_arrowsize=2*arrow_linewidth

        CS_x=arrows!([0],[0],[0],[1],[0],[0],color=:red,linewidth = arrow_linewidth,arrowsize=arrow_arrowsize,lengthscale=arrow_lengthscale)
        CS_y=arrows!([0],[0],[0],[0],[1],[0],color=:green,linewidth = arrow_linewidth,arrowsize=arrow_arrowsize,lengthscale=arrow_lengthscale)
        CS_z=arrows!([0],[0],[0],[0],[0],[1],color=:blue,linewidth = arrow_linewidth,arrowsize=arrow_arrowsize,lengthscale=arrow_lengthscale)

    end
    function q_clicked(w)
        exit()
    end

    #callbacks
    signal_connect(sm_clicked,sm,"clicked")
    signal_connect(ps_clicked,ps,"clicked")
    signal_connect(pm_clicked,pm,"clicked")
    signal_connect(sel_clicked,sel,"clicked")
    signal_connect(ss_clicked,ss,"clicked")
    signal_connect(cs_clicked,cs,"clicked")
    signal_connect(si_clicked,si,"clicked")
    signal_connect(ci_clicked,ci,"clicked")
    signal_connect(pr_clicked,pr,"clicked")  
    signal_connect(in1_clicked,in1,"clicked")
    signal_connect(in1a_clicked,in1a,"clicked")
    signal_connect(in3_clicked,in3,"clicked")
    signal_connect(a0_1_clicked,a0_1,"clicked")
    signal_connect(a1_1_clicked,a1_1,"clicked")
    signal_connect(a2_1_clicked,a2_1,"clicked")
    signal_connect(a3_1_clicked,a3_1,"clicked")
    signal_connect(a4_1_clicked,a4_1,"clicked")
    signal_connect(seldir_clicked,seldir,"clicked")
    signal_connect(r1_clicked,r1,"clicked")
    signal_connect(r2_clicked,r2,"clicked")
    signal_connect(q_clicked,q,"clicked")

