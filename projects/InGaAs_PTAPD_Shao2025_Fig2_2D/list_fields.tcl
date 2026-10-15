foreach n {6 52} {
  set d [load_file "n${n}_field_eml.tdr" -name "field${n}"]
  puts "FIELDS $n [list_fields -dataset $d]"
}
puts "SHAO_FIELD_LIST_COMPLETE"
