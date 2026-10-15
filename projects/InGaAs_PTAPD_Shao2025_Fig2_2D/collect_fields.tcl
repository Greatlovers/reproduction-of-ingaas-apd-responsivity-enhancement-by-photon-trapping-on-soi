foreach n {6 52} {
  set d [load_file "n${n}_field_eml.tdr" -name "nativefield${n}"]
  puts "DATASETS $d [list_datasets]"
  set p [create_plot -dataset $d -name "fieldplot${n}"]
  set formula {<RealElectricFieldX>*<RealElectricFieldX> + <RealElectricFieldY>*<RealElectricFieldY> + <RealElectricFieldZ>*<RealElectricFieldZ> + <ImagElectricFieldX>*<ImagElectricFieldX> + <ImagElectricFieldY>*<ImagElectricFieldY> + <ImagElectricFieldZ>*<ImagElectricFieldZ>}
  create_field -plot $p -name I2 -function $formula
  create_field -plot $p -name I2inplane -function {<RealElectricFieldX>*<RealElectricFieldX> + <RealElectricFieldY>*<RealElectricFieldY> + <ImagElectricFieldX>*<ImagElectricFieldX> + <ImagElectricFieldY>*<ImagElectricFieldY>}
  set mn [calculate_field_value -plot $p -field I2 -min]
  set mx [calculate_field_value -plot $p -field I2 -max -ranges {-0.9375 0.9375 -0.7 0.0}]
  set total [integrate_field -plot $p -field I2]
  set inplane [integrate_field -plot $p -field I2inplane]
  set meta [open "n${n}_field_meta.txt" w]
  puts $meta "min $mn"
  puts $meta "max_III_V $mx"
  puts $meta "integral_I2 $total"
  puts $meta "integral_I2_inplane $inplane"
  close $meta
  set f [open "n${n}_field_samples.csv" w]
  puts $f "x_nm,z_nm,I2"
  for {set j 0} {$j <= 56} {incr j} {
    set z [expr {12.5*$j}]
    set yy [expr {-$z/1000.0}]
    for {set i 0} {$i <= 150} {incr i} {
      set x [expr {-937.5+12.5*$i}]
      set xx [expr {$x/1000.0}]
      if {$i == 0} {set xx [expr {$xx+1e-9}]}
      if {$i == 150} {set xx [expr {$xx-1e-9}]}
      set v [probe_field -plot $p -field I2 -coord [list $xx $yy]]
      puts $f [format "%.8g,%.8g,%.17g" $x $z $v]
    }
  }
  close $f
  puts "SHAO_FIELD_EXPORT $n $mn $mx $total $inplane"
  remove_plots $p
}
puts "SHAO_FIG2_NATIVE_FIELD_EXPORT_COMPLETED"
