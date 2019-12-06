file(REMOVE_RECURSE
  "config.json.o"
  "lib/libconfig_json_mandel_service.elf.bin.a"
  "lib/libconfig_json_mandel_service.elf.bin.pdb"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/config_json_mandel_service.elf.bin.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
