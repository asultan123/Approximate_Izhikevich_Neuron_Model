proc vsimulink {args} {
  lappend sllibarg -foreign \{simlinkserver \{C:/Program Files/MATLAB/R2016a/toolbox/edalink/extensions/modelsim/windows32/liblfmhdls_gcc421vc9.dll\}
  if {[catch {lsearch -exact $args -socket} idx]==0  && $idx >= 0} {
    set socket [lindex $args [expr {$idx + 1}]]
    set args [lreplace $args $idx [expr {$idx + 1}]]
    append socketarg " \; -socket " "$socket"
    lappend sllibarg $socketarg
  }
  set runmode "Batch"
  if { $runmode == "Batch" || $runmode == "Batch with Xterm"} {
    lappend sllibarg " \; -batch"
  }
  lappend sllibarg \}
  set args [linsert $args 0 vsim]
  lappend args [join $sllibarg]
  uplevel 1 [join $args]
}
proc vsimmatlab {args} {
  lappend mllibarg -foreign \{matlabclient \{C:/Program Files/MATLAB/R2016a/toolbox/edalink/extensions/modelsim/windows32/liblfmhdlc_gcc421vc9.dll\}
  lappend mllibarg \}
  lappend mlinput 
  lappend mlinput [join $args]
  lappend mlinput [join $mllibarg]
   set mlinput [linsert $mlinput 0 vsim]
  uplevel 1 [join $mlinput]
}
proc wrapverilog {args} {

  error "wrapverilog has been removed. HDL Verifier now supports Verilog models directly, without requiring a VHDL wrapper."}

proc vsimmatlabsysobj {args} {
  lappend sllibarg -foreign \{matlabsysobjserver \{C:/Program Files/MATLAB/R2016a/toolbox/edalink/extensions/modelsim/windows32/liblfmhdls_gcc421vc9.dll\}
  if {[catch {lsearch -exact $args -socket} idx]==0  && $idx >= 0} {
    set socket [lindex $args [expr {$idx + 1}]]
    set args [lreplace $args $idx [expr {$idx + 1}]]
    append socketarg " \; -socket " "$socket"
    lappend sllibarg $socketarg
  }
  set runmode "Batch"
  if { $runmode == "Batch" || $runmode == "Batch with Xterm"} {
    lappend sllibarg " \; -batch"
  }
  lappend sllibarg \}
  set args [linsert $args 0 vsim]
  lappend args [join $sllibarg]
  uplevel 1 [join $args]
}
vsimmatlabsysobj squaring_circuit_8bit -t 1ns ;
add wave squaring_circuit_8bit/*;

