
set nodes {3 10 11 12 6 16 17 18 5 13 14 15}
foreach n $nodes {
  set d [load_file "n${n}_field_eml.tdr" -name "native${n}"]
  set p [create_plot -dataset $d -name "fieldplot${n}"]
  create_field -plot $p -name I2 -function {<RealElectricFieldX>*<RealElectricFieldX> + <RealElectricFieldY>*<RealElectricFieldY> + <RealElectricFieldZ>*<RealElectricFieldZ> + <ImagElectricFieldX>*<ImagElectricFieldX> + <ImagElectricFieldY>*<ImagElectricFieldY> + <ImagElectricFieldZ>*<ImagElectricFieldZ>}
  create_field -plot $p -name I2Real -function {<RealElectricFieldX>*<RealElectricFieldX> + <RealElectricFieldY>*<RealElectricFieldY> + <RealElectricFieldZ>*<RealElectricFieldZ>}
  create_field -plot $p -name I2InPlane -function {<RealElectricFieldX>*<RealElectricFieldX> + <RealElectricFieldY>*<RealElectricFieldY> + <ImagElectricFieldX>*<ImagElectricFieldX> + <ImagElectricFieldY>*<ImagElectricFieldY>}
  set mn [calculate_field_value -plot $p -field I2 -min]
  set mx [calculate_field_value -plot $p -field I2 -max -ranges {-0.3125 0.3125 -0.7 0.52}]
  set ip [calculate_field_value -plot $p -field I2InPlane -max]
  set meta [open "n${n}_field_meta.txt" w]
  puts $meta "min_I2 $mn"
  puts $meta "max_I2_central_frame $mx"
  puts $meta "max_I2_inplane $ip"
  close $meta
  set f [open "n${n}_field_samples.csv" w]
  puts $f "x_nm,z_nm,I2"
  for {set j 0} {$j <= 122} {incr j} {
    set z [expr {-520.0+10.0*$j}]
    set yy [expr {-$z/1000.0}]
    for {set i 0} {$i <= 125} {incr i} {
      set x [expr {-312.5+5.0*$i}]
      set xx [expr {$x/1000.0}]
      set v [probe_field -plot $p -field I2 -coord [list $xx $yy]]
      puts $f [format "%.8g,%.8g,%.17g" $x $z $v]
    }
  }
  close $f
  remove_plots $p
  set md [load_file "n${n}_eml.plt" -name "monitors${n}"]
  export_variables -dataset $md -filename "n${n}_monitors.csv" -overwrite
  puts "SHAO_FIG3_EXPORTED $n $mn $mx $ip"
}
puts "SHAO_FIG3_NATIVE_EXPORT_COMPLETED"
