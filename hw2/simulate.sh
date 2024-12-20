#!/bin/bash

# https://itsembedded.com/dhd/vivado_sim_1/

DESIGN=mult3detect

check_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed. Exiting."
        exit 1
    fi
}

cd sim

# Compilation
xvlog "../src/$DESIGN.v"
check_status "xvlog for $DESIGN.v"

xvlog -sv "../verif/tb_$DESIGN.sv"
check_status "xvlog for tb_$DESIGN.sv"

# Elaboration
xelab -debug typical -top "tb_$DESIGN" -snapshot my_tb_snap
check_status "xelab"

# Simulation
xsim my_tb_snap --tclbatch xsim_cfg.tcl
check_status "xsim"

# Open the wavefile in Vivado
xsim my_tb_snap.wdb -gui -tclbatch waveform.tcl
