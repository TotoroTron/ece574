PROJ_DIR="/home/bcheng/workspace/dev/ece574/hw4"
RTL_TCL="$PROJ_DIR/rtl.tcl"

echo "Running Vivado RTL synthesis..."
vivado -mode batch -source $RTL_TCL -nolog -nojournal
echo "Vivado synthesis completed. Starting GUI."
