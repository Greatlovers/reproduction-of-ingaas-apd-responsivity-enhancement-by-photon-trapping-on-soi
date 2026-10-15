foreach n {6 52} {
  set d [load_file "n${n}_eml.plt" -name "pilot${n}"]
  export_variables -dataset $d -filename "n${n}_sensors.csv" -overwrite
}
puts "SHAO_FIG2_PILOT_SENSOR_EXPORT_COMPLETED"
