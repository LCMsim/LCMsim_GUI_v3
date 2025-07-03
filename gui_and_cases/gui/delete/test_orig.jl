using Gtk4Makie; using Gtk4
using GtkObservables
using JLD2
using GeometryBasics
using NativeFileDialog

i_plot=2 

if i_plot==2
    screen = Gtk4Makie.GTKScreen(size=(1200, 800),title="i_plot=2")
    #screen = Gtk4Makie.GTKScreen(title="i_plot=2")
    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    @load filename xyz N cgammavec minval maxval
    p1=display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
    ax1=current_axis()  #perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
    fig1=current_figure()    
    #col1=Colorbar(fig1, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(0,1));  
    
    
    sleep(2)
    [delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
    col1=Colorbar(fig1, colormap = :viridis,  vertical=true, height=Relative(0.5),colorrange=(0,19));  
    #[delete!(col1) for col1 in fig1.content if col1 isa Colorbar]
    
    h=grid(screen)


    
    g=Gtk4.GtkGrid()
    g[2,1]=GtkButton("t=0")
    g[2,2]=GtkButton("t=t/4")
    g[2,3]=GtkButton("t=t/2")
    g[2,4]=GtkButton("t=3/4*t")
    g[2,5]=GtkButton("t=t")
    g[2,6]=GtkButton("Picking")
    h[2,1]=g
    c = Gtk4.GtkScale(:h, 0:16) 
    c1=Gtk4.GtkCheckButton("Results available"); set_gtk_property!(c1,:active,false);
    g[3,7] = c1  
    g[2,7] = c   
    @info "c1.active=" * string(c1.active)
    
    sm=GtkButton("Select mesh file")
    g[3,1]=sm
    mf=GtkEntry(); set_gtk_property!(mf,:text,"filename");
    g[4,1]=mf

    signal_connect(g[2,7], "value-changed") do widget, others...
        if c1.active==true
            println("Value changed")
            value = round(Gtk4.value(g[2,7]))
            println(string(value))
            empty!(ax1)    
            filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
            @load filename xyz N cgammavec minval maxval
            p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*value/16, strokewidth=1,colorrange=(minval,maxval))
        end


    end
    function gen_cb(b)
        empty!(ax1)    
        #ax = Axis3(screen);  #fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*0, strokewidth=1,colorrange=(minval,maxval))
    end
    function gen_cb2(b)
        empty!(ax1)    
        #ax = Axis3(screen);  #fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*0.25, strokewidth=1,colorrange=(minval,maxval))
    end
    function gen_cb3(b)
        empty!(ax1)    
        #ax = Axis3(screen);  #fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*0.50, strokewidth=1,colorrange=(minval,maxval))
    end
    function gen_cb4(b)
        empty!(ax1)    
        #ax = Axis3(screen);  #fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*0.75, strokewidth=1,colorrange=(minval,maxval))
    end
    function gen_cb5(b)
        empty!(ax1)    
        #ax = Axis3(screen);  #fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*1.00, strokewidth=1,colorrange=(minval,maxval))
    end
    function gen_cb6(b)
        #filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        #@load filename xyz N cgammavec minval maxval
        #resolution_val = 800  #1200
        #screen = Gtk4Makie.GTKScreen(size=(1200, 800),title="3D plot")
        #display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
        #ax1=current_axis()

        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test1.jld2"  #delete
        @load filename points1 xvec2 yvec2 zvec2  #delete
        positions = Observable(points1) 
        inletpos_xyz=Array{Float64}[]
        resolution_val = 800 
        markersizeval=20 
        empty!(ax1)    
        fig2=scatter!(positions,markersize=markersizeval,color = :blue)
        @info "fig2 = " * string(fig2)

        on(events(fig2).mousebutton, priority = 2) do event
            if event.button == Mouse.left && event.action == Mouse.press
                if Keyboard.p in events(fig2).keyboardstate
                    plt, i = pick(fig2,events(fig2).mouseposition[])
                    @info "plt = " * string(plt)
                    @info "i = " * string(i)
                    if plt == fig2  #p2
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
                        #wfn = open(writefilename,"a")  
                        #println(wfn,textpos)
                        #close(wfn)
                        scatter!(Point3f0(xpos,ypos,zpos),markersize=2*markersizeval,color = :black)
                        return Consume(true)
                    end
                end
            end
            return Consume(false)
        end
    end
    function gen_m1(b)
        i_mesh=1
        mypath=pwd()
        if i_mesh==1
            str = pick_file(mypath,filterlist="dat");
        elseif i_mesh==2
            str = pick_file(mypath,filterlist="inp");
        end
        #str = pick_file(mypath,filterlist="dat,inp");
        set_gtk_property!(mf,:text,str);        
    end

    signal_connect(gen_cb, g[2,1],"clicked")
    signal_connect(gen_cb2,g[2,2],"clicked")
    signal_connect(gen_cb3,g[2,3],"clicked")
    signal_connect(gen_cb4,g[2,4],"clicked")
    signal_connect(gen_cb5,g[2,5],"clicked")
    signal_connect(gen_cb6,g[2,6],"clicked")
    signal_connect(gen_m1,sm,"clicked")
end