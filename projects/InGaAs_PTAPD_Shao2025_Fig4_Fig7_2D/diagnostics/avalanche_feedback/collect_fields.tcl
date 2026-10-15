
foreach n {8 15} {
  set d [load_file "n${n}_IV_n${n}_des.plt" -name "iv${n}"]
  export_variables -dataset $d -filename "n${n}_IV.csv" -overwrite
  set d [load_file "n${n}_endpoint_des.tdr" -name "f${n}"]
  set p [create_plot -dataset $d]
  set f [open "n${n}_field_grid.csv" w]
  puts $f "x_nm,z_nm,E_V_cm"
  for {set j 0} {$j<=100} {incr j} {
    set z [expr {0.001+6.99998*$j}]
    for {set i 0} {$i<=120} {incr i} {
      set x [expr {-937.499+15.6249833333*$i}]
      set v [probe_field -plot $p -field "Abs(ElectricField-V)" -coord [list [expr {$x/1000.0}] [expr {-$z/1000.0}]]]
      puts $f [format "%.8g,%.8g,%.17g" $x $z $v]
    }
  }
  close $f
  remove_plots $p
  puts "FEEDBACK_FIELD_EXPORTED $n"
}
puts "FEEDBACK_EXPORT_COMPLETED"
