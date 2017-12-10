@echo off
set xv_path=I:\\envirnment\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xsim Control_unit_tb_behav -key {Behavioral:sim_1:Functional:Control_unit_tb} -tclbatch Control_unit_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
