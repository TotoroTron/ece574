# https://itsembedded.com/dhd/vivado_sim_1/

# Compilation
xvlog src/alu.v
xvlog -sv verif/tb_alu.sv

# Elaboration
xelab -debug typical -top tb_alu -snapshot my_tb_snap

# Simulation
xsim my_tb_snap -R
# -R means "run the sim until it finishes"
