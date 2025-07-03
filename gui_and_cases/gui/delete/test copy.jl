using Gtk4Makie; using Gtk4
using GtkObservables
using JLD2
using GeometryBasics

#i_plot=31
i_plot=2

if i_plot==1
    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    @load filename xyz N cgammavec minval maxval
    resolution_val = 800  #1200
    fig=Figure(size=(resolution_val, resolution_val))
    ax1 = Axis3(fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
    p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
    display(fig)
elseif i_plot==2
    screen = Gtk4Makie.GTKScreen(size=(800, 800),title="i_plot=2")
    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    @load filename xyz N cgammavec minval maxval
    p1=display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
    ax=1;ay=1;az=1;
    ax1=current_axis()  #perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
    
    h=grid(screen)


    
    g=Gtk4.GtkGrid()
    g[2,1]=GtkButton("t=0")
    g[2,2]=GtkButton("t=t/4")
    g[2,3]=GtkButton("t=t/2")
    g[2,4]=GtkButton("t=3/4*t")
    g[2,5]=GtkButton("t=t")
    h[2,1]=g

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
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        resolution_val = 800  #1200
        screen = Gtk4Makie.GTKScreen(size=(1200, 800),title="3D plot")
        display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
        ax1=current_axis()
    end
    signal_connect(gen_cb, g[2,1],"clicked")
    signal_connect(gen_cb2,g[2,2],"clicked")
    signal_connect(gen_cb3,g[2,3],"clicked")
    signal_connect(gen_cb4,g[2,4],"clicked")
    signal_connect(gen_cb5,g[2,5],"clicked")
elseif i_plot==21
    #screen = Gtk4Makie.GTKScreen(size=(800, 800),title="10 random numbers")
    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    @load filename xyz N cgammavec minval maxval
    ax=1;ay=1;az=1;
    ax1=current_axis()  #perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
    win = GtkWindow("LCMsim",1200,800);     
    g = Gtk4.GtkGrid()
    g[1:2,1:10]=GtkMakieWidget()
    push!(g[1,1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
    g[1,11]=GtkButton("Generate new random plot")
    g[2,11]=GtkButton("Create 3D plot")
    g[3,1]=GtkButton("Nothing 1")
    g[3,2]=GtkButton("Nothing 2")
    g[3,3]=GtkButton("Nothing 3")
    g[3,4]=GtkButton("Nothing 4")
    g[3,5]=GtkButton("Nothing 5")

    g.column_homogeneous = true
    push!(win, g)

    function gen_cb(b)
        empty!(ax1)    
        #ax = Axis3(screen);  #fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval))
    end
    function gen_cb2(b)
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        resolution_val = 800  #1200
        screen = Gtk4Makie.GTKScreen(size=(1200, 800),title="3D plot")
        display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
        ax1=current_axis()
    end
    signal_connect(gen_cb,g[1,11],"clicked")
    signal_connect(gen_cb2,g[2,11],"clicked")
elseif i_plot==3
    win = GtkWindow("2 Makie widgets in one window", 1200, 600, true, false)
    p=GtkPaned(:h;position=600)
    p[1]=GtkMakieWidget()
    p[2]=GtkMakieWidget()
    win[]=p
    show(win)
    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    @load filename xyz N cgammavec minval maxval
    push!(p[1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
    push!(p[2],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))

elseif i_plot==31
    win = GtkWindow("2 Makie widgets in one window", 800, 600, true, false)
    p=GtkPaned(:h;position=600)
    w=GtkMakieWidget()
    p[1]=w
    

    g=Gtk4.GtkGrid()

    g[2,1]=GtkButton("t=0")
    g[2,2]=GtkButton("t=t/4")
    g[2,3]=GtkButton("t=t/2")
    g[2,4]=GtkButton("t=3/4*t")
    g[2,5]=GtkButton("t=t")
    g[2,6]=GtkButton("Plot")
    p[2]=g

    win[]=p
    show(win)
    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    @load filename xyz N cgammavec minval maxval
    push!(w,poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))

    function gen_cb(b)
        empty!(w)    
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        push!(w,poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*0, strokewidth=1,colorrange=(minval,maxval)))
    end
    function gen_cb2(b)
        empty!(ax1)    
        #ax = Axis3(screen);  #fig[1, 1])  #; perspectiveness=0.5, viewmode=:fitzoom,aspect=(ax,ay,az))
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        push!(w,poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*0.25, strokewidth=1,colorrange=(minval,maxval)))
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
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        resolution_val = 800  #1200
        screen = Gtk4Makie.GTKScreen(size=(1200, 800),title="3D plot")
        display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
        ax1=current_axis()
    end
    signal_connect(gen_cb, g[2,1],"clicked")
    signal_connect(gen_cb2,g[2,2],"clicked")
    signal_connect(gen_cb3,g[2,3],"clicked")
    signal_connect(gen_cb4,g[2,4],"clicked")
    signal_connect(gen_cb5,g[2,5],"clicked")
    signal_connect(gen_cb6,g[2,6],"clicked")












elseif i_plot==4

    
    #screen = Gtk4Makie.GTKScreen(size=(800, 800),title="10 random numbers")
    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    @load filename xyz N cgammavec minval maxval
    ax=1;ay=1;az=1;
    win = GtkWindow("LCMsim",1200,800);     
    g = Gtk4.GtkGrid()
    g[1,11]=GtkButton("Generate new random plot")
    g[2,11]=GtkButton("Create 3D plot")
    g[3,1]=GtkButton("Nothing 1")
    g[3,2]=GtkButton("Nothing 2")
    g[3,3]=GtkButton("Nothing 3")
    g[3,4]=GtkButton("Nothing 4")
    g[3,5]=GtkButton("Nothing 5")
    c = Gtk4.GtkScale(:h, 0:16) 
    g[3,11] = c   
    g1=GtkMakieWidget()    
    g[1:2,1:10]=g1
    ax1=current_axis()
    #p1=push!(g[1,1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(0,1)))
    #g.column_homogeneous = true
    push!(win, g)

    sleep(2)
    #filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    #@load filename xyz N cgammavec minval maxval
    cgammavec1=cgammavec*0
    cgammavec1=rand(1:100,length(cgammavec1))/100.
    
    p1=push!(g[1,1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec1[:], strokewidth=1,colorrange=(0,1)))

    g.column_homogeneous = true
    push!(win, g)




    signal_connect(g[3,11], "value-changed") do widget, others...
        println("Value changed")
        value = round(Gtk4.value(g[3,11]))
        println(string(value))

        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        g = Gtk4.GtkGrid()
        g1=GtkMakieWidget()    
        g[1:2,1:10]=g1
        ax1=current_axis()
        p1=push!(g[1,1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(0,1)))
        g[1,11]=GtkButton("Generate new random plot")
        g[2,11]=GtkButton("Create 3D plot")
        g[3,1]=GtkButton("Nothing 1")
        g[3,2]=GtkButton("Nothing 2")
        g[3,3]=GtkButton("Nothing 3")
        g[3,4]=GtkButton("Nothing 4")
        g[3,5]=GtkButton("Nothing 5")
        g[3,11] = Gtk4.GtkScale(:h, 0:16) 
        g.column_homogeneous = true
        push!(win, g)






    end
    function gen_cb(b)
        #empty!(ax1)  
        #filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        #@load filename xyz N cgammavec minval maxval
        #p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(0,1))
        
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval

        empty!(g[1,1])
        push!(g[1,1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(0,1)))
        push!(win, g)
    end
    function gen_cb31(b)  
        #empty!(g[1,1])
        #push!(win, g)
        
        empty!(g[1,1])
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        #xyz1=xyz*0;
        #xyz1=xyz*1.1
        #cgammavec1=cgammavec*0
        #cgammavec1=rand(1:100,length(cgammavec1))/100.
        p1=push!(g[1,1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec1[:], strokewidth=1))
        push!(win, g)




    end
    function gen_cb_mod(b)
        empty!(ax1)    
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        p1 = poly!(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:]*0, strokewidth=1,colorrange=(minval,maxval))
    end
    function gen_cb2(b)
        filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
        @load filename xyz N cgammavec minval maxval
        resolution_val = 800  #1200
        screen = Gtk4Makie.GTKScreen(size=(1200, 800),title="3D plot")
        display(screen, poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
        ax1=current_axis()
    end
    signal_connect(gen_cb,g[1,11],"clicked")
    signal_connect(gen_cb2,g[2,11],"clicked")
    signal_connect(gen_cb31,g[3,1],"clicked")
    #signal_connect(c, "value-changed") do widget, others...        
    #    println("Value changed")
    #    value = round(Gtk4.value(c))
    #    println(string(value))
    #    filename="D:\\work\\github\\LCMsim_GUI\\gui_and_cases\\gui\\test.jld2"
    #    @load filename xyz N cgammavec minval maxval
    #    #push!(g[1,1],poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
    #    #gen_cb_mod(value)
    #    
    #    empty!(g1)
    #    push!(g1,poly(connect(xyz, GeometryBasics.Point{3}), connect(1:3*N, TriangleFace); color=cgammavec[:], strokewidth=1,colorrange=(minval,maxval)))
    #end



end