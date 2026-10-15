
foreach n {} {
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
  set f [open "n${n}_carrier_profile.csv" w]
  puts $f "x_um,z_um,E_V_cm,n_cm3,p_cm3,Eg_eV,doping_cm3"
  foreach x {0 0.3125} {
    foreach z {0.05 0.15 0.25 0.325 0.375 0.425 0.475 0.55 0.625 0.675} {
      if {$n!=9 && $x==0 && $z<0.22} {puts $f "$x,$z,nan,nan,nan,nan,nan";continue}
      set row [list $x $z]
      foreach field {Abs(ElectricField-V) eDensity hDensity BandGap DopingConcentration} {lappend row [probe_field -plot $p -field $field -coord [list $x [expr {-$z}]]]}
      puts $f [join $row ,]
    }
  }
  close $f
  remove_plots $p
  puts "FIELD_GRID_EXPORTED $n"
}
puts "FIELD_NATIVE_EXPORT_COMPLETED"
