foreach n {17 6 26 58 59 60} {
 set d [load_file "n${n}_eml.plt" -name "meshpreview${n}"]
 export_variables -dataset $d -filename "n${n}_meshpreview.csv" -overwrite
}
puts "MESH_PREVIEW_COMPLETE"
