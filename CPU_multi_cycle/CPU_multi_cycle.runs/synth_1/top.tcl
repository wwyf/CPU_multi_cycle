# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a35tcpg236-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/code/CPU_multi_cycle/CPU_multi_cycle/CPU_multi_cycle.cache/wt [current_project]
set_property parent.project_path D:/code/CPU_multi_cycle/CPU_multi_cycle/CPU_multi_cycle.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property vhdl_version vhdl_2k [current_fileset]
read_verilog -library xil_defaultlib {
  D:/code/CPU_multi_cycle/src/Control_unit/Next_state.v
  D:/code/CPU_multi_cycle/src/Control_unit/Get_output.v
  D:/code/CPU_multi_cycle/src/RegFile/RegFile.v
  D:/code/CPU_multi_cycle/src/PC.v
  D:/code/CPU_multi_cycle/src/mux4to1_5.v
  D:/code/CPU_multi_cycle/src/mux4to1_32.v
  D:/code/CPU_multi_cycle/src/mux2to1_32.v
  D:/code/CPU_multi_cycle/src/MultiReg_32.v
  D:/code/CPU_multi_cycle/src/Ins_Memory/IR.v
  D:/code/CPU_multi_cycle/src/Ins_Memory/Ins_Memory.v
  D:/code/CPU_multi_cycle/src/Extend.v
  D:/code/CPU_multi_cycle/src/Data_Memory/Data_Memory.v
  D:/code/CPU_multi_cycle/src/Control_unit/Control_unit.v
  D:/code/CPU_multi_cycle/src/ALU/ALU32.v
  D:/code/CPU_multi_cycle/src/CPU_top.v
  D:/code/CPU_multi_cycle/src/DEBUG/displayReg.v
  D:/code/CPU_multi_cycle/src/DEBUG/debouncing.v
  D:/code/CPU_multi_cycle/src/DEBUG/clkdiv_190hz.v
  D:/code/CPU_multi_cycle/src/top.v
}
read_xdc D:/code/CPU_multi_cycle/src/my.xdc
set_property used_in_implementation false [get_files D:/code/CPU_multi_cycle/src/my.xdc]

synth_design -top top -part xc7a35tcpg236-1
write_checkpoint -noxdef top.dcp
catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
