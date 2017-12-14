@echo off
set xv_path=D:\\Xilinx\\Vivado\\2015.3\\bin
call %xv_path%/xelab  -wto e8d93131724a4dd89b92a0269d107853 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot top_tb_behav xil_defaultlib.top_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
