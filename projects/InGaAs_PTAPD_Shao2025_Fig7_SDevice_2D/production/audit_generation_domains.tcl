
set f [open "generation_domains.csv" w]
puts $f "node,region,bandgap_eV,photon_energy_eV,G_pairs_s"
foreach n {47 50 53} {
 set d [load_file "n${n}_power1_des.tdr" -name "g${n}"]
 set p [create_plot -dataset $d]
 if {$n==53} {set e [expr {1.2398419843320026/1.626}]} else {set e [expr {1.2398419843320026/1.550}]}
 for {set k 0} {$k<8} {incr k} {
   set z [expr {.35+.00625*($k+.5)}]
   set eg [probe_field -plot $p -field BandGap -coord [list .3125 [expr {-$z}]]]
   set G [integrate_field -plot $p -field OpticalGeneration -regions [list R.Grading${k}]]
   puts $f "$n,R.Grading${k},$eg,$e,$G"
 }
 foreach r {R.Charge R.Multiplier} {
   set G [integrate_field -plot $p -field OpticalGeneration -regions [list $r]]
   puts $f "$n,$r,1.48159457143,$e,$G"
 }
 remove_plots $p
}
close $f
puts "GENERATION_DOMAIN_AUDIT_COMPLETED"
