foreach n {17 51} {
  set d [load_file "n${n}_eml.plt" -name "fixed${n}"]
  export_variables -dataset $d -filename "n${n}_fixed_sensors.csv" -overwrite
}
puts "FIXED_TIME_EXPORT_COMPLETED"
