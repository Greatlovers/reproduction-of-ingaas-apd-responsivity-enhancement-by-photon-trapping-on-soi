
set f [open "rate_integrals.csv" w]
puts $f "node,stage,G_pairs_s,SRH_pairs_s,Auger_pairs_s,Radiative_pairs_s,AVA_pairs_s,Surface_native_integral,InGaAsG_pairs_s"
foreach n {33 47 39 50 44 53} {
  foreach tag {dark 0 1 2 3 4} {
    if {$tag=="dark"} {set file "n${n}_power_dark_des.tdr"} else {set file "n${n}_power${tag}_des.tdr"}
    set d [load_file $file -name "rates${n}_${tag}"]
    set p [create_plot -dataset $d]
    set row [list $n $tag]
    foreach field {OpticalGeneration srhRecombination AugerRecombination RadiativeRecombination ImpactIonization SurfaceRecombination} {
      lappend row [integrate_field -plot $p -field $field -materials {InGaAs InAlAs AlInGaAs}]
    }
    lappend row [integrate_field -plot $p -field OpticalGeneration -materials {InGaAs}]
    puts $f [join $row ,]
    remove_plots $p
  }
}
close $f
puts "RATE_CONSERVATION_EXPORT_COMPLETED"
