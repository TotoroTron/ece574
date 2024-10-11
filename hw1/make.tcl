puts "starting..."
set hdl_dir "./path/to/hdl/files"
set top_module "name_of_top_module"

# close any open projects
close_project -quiet

link_design -part YOUR-PART-NAME-HERE

# read hdl
read_verilog [glob -dir $hdl_dir *.v]
# read_verilog -sc [glob -dir $hdl_dir *.sv]
# read_vhdl [glob -dir hdl_dir *.vhd]

# read xdc file
read_xdc name_of_your_xdc.xdc

# synthesize you can add extra flags if necessary 
# i.e. -mode out_of_context
synth_design -top $top_module 

# place and route AKA "implement design" in GUI
opt_design
place_design

# after placing you may want to explore phys_opt_design
# if you are failing timing
# phys_opt_design

route_design

# save a checkpoint to reload project later
# take existing design and dump it to a file so you can pick up where you 
# left off (save a project in none project mode)
write_checkpoint -force $top.dcp

report_utlization -hierarchical -file hierarchical_utilization_report.txt
report_timing_summary -file timing_simmary.txt

# if you need to write a bitstream
# write_bitstream -force $top.bit

puts "finished"
