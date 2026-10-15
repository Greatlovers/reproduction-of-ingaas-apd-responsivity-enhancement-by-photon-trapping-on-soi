set d [load_file "n10_eml.plt" -name "op10"]
export_variables -dataset $d -filename "n10_sensors.csv" -overwrite
set d [load_file "n11_eml.plt" -name "op11"]
export_variables -dataset $d -filename "n11_sensors.csv" -overwrite
set d [load_file "n12_eml.plt" -name "op12"]
export_variables -dataset $d -filename "n12_sensors.csv" -overwrite
puts "OPTICAL_SENSORS_EXPORTED"
