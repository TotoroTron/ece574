#!/usr/bin/env bash
# ****************************************************************************
# Vivado (TM) v2023.2.2 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : AMD Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Thu Oct 10 15:45:28 EDT 2024
# SW Build 4126759 on Thu Feb  8 23:52:05 MST 2024
#
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
# elaborate design
echo "xelab --debug typical --relax --mt 8 -d "NO_OF_TRANSACTIONS=2000" -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot adder_4_bit_tb_top_behav xil_defaultlib.adder_4_bit_tb_top xil_defaultlib.glbl -log elaborate.log -L UVM -timescale 1ns/1ps"
xelab --debug typical --relax --mt 8 -d "NO_OF_TRANSACTIONS=2000" -L xil_defaultlib -L uvm -L unisims_ver -L unimacro_ver -L secureip --snapshot adder_4_bit_tb_top_behav xil_defaultlib.adder_4_bit_tb_top xil_defaultlib.glbl -log elaborate.log -L UVM -timescale 1ns/1ps
