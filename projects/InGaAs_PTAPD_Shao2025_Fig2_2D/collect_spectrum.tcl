foreach n {6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55} {
  set d [load_file "n${n}_eml.plt" -name "spectrum${n}"]
  export_variables -dataset $d -filename "n${n}_sensors.csv" -overwrite
}
puts "SHAO_FIG2_SPECTRUM_SENSOR_EXPORT_COMPLETED"
