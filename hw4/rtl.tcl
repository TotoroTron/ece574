
set hwnum "hw4"
set root_dir "/home/bcheng/workspace/dev/ece574"
set src_dir "$root_dir/$hwnum/src"

# Read in source files
set src_files [glob -nocomplain -directory $src_dir *.v]
foreach file $src_files {
    puts "reading: $file"
    read_verilog $file
}

synth_design -mode out_of_context -part xc7z020clg400-1 -top top_level \
    -rtl -rtl_skip_mlo -name rtl_1

start_gui
