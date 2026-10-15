foreach n {17 51} {
  set d [load_file "n${n}_eml.plt" -name "temporal${n}"]
  export_variables -dataset $d -filename "n${n}_temporal_sensors.csv" -overwrite
}
puts "TEMPORAL_EXPORT_COMPLETED"
