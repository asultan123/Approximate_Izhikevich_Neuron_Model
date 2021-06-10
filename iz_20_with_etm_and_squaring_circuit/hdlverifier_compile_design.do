# Create design library
vlib work
# Create and open project
project new . compile_project
project open compile_project
# Add source files to project
project addfile "C:/Users/USER/Documents/One Lab/temp/root/Reduced_Models/iz_20_with_etm_and_squaring_circuit/CSA_3-2.v"
project addfile "C:/Users/USER/Documents/One Lab/temp/root/Reduced_Models/iz_20_with_etm_and_squaring_circuit/CSA_22.v"
project addfile "C:/Users/USER/Documents/One Lab/temp/root/Reduced_Models/iz_20_with_etm_and_squaring_circuit/RCA.v"
project addfile "C:/Users/USER/Documents/One Lab/temp/root/Reduced_Models/iz_20_with_etm_and_squaring_circuit/squaring_circuit_8bit.v"
# Calculate compilation order
project calculateorder
set compcmd [project compileall -n]
# Close project
project close
# Compile all files and report error
if [catch {eval $compcmd}] {
    exit -code 1
}
