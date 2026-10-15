
set f [open "surface_line_integrals.csv" w]
puts $f "node,stage,surface_pairs_s"
foreach n {39 50 44 53} {
  foreach tag {dark 1} {
    if {$tag=="dark"} {set file "n${n}_power_dark_des.tdr"} else {set file "n${n}_power${tag}_des.tdr"}
    set d [load_file $file -name "s${n}_${tag}"]
    set p [create_plot -dataset $d]
    set integral 0.0
    set eps 1e-6
    foreach c {-.625 0 .625} {
      foreach side {-1 1} {
        set old 0.0
        for {set j 0} {$j<=440} {incr j} {
          set z [expr {0.22*$j/440.0}]
          set r [expr {0.25-0.08*$z/0.22}]
          set x [expr {$c+$side*($r+$eps)}]
          if {$j==0} {set v 0.0} else {set v [probe_field -plot $p -field SurfaceRecombination -coord [list $x [expr {-$z}]]]}
          if {$j>0} {set integral [expr {$integral+0.5*($old+$v)*sqrt(0.22*0.22+0.08*0.08)/440.0}]}
          set old $v
        }
      }
      set old 0.0
      for {set j 0} {$j<=340} {incr j} {
        set x [expr {$c-0.17+0.34*$j/340.0}]
        set v [probe_field -plot $p -field SurfaceRecombination -coord [list $x [expr {-0.22-$eps}]]]
        if {$j>0} {set integral [expr {$integral+0.5*($old+$v)*0.34/340.0}]}
        set old $v
      }
    }
    puts $f "$n,$tag,[expr {$integral*1e-8}]"
    remove_plots $p
  }
}
close $f
puts "SURFACE_LINE_EXPORT_COMPLETED"
