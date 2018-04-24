#退出当前仿真
#quit -sim

vlib work

#编译修改后的文件
vlog "../Src/*.v"
vlog "../Sim/*.v"

#开始仿真
vsim -voptargs=+acc work.TB_Sdram_Top
#添加指定信号
#添加顶层所有的信号

# Set the window types
# 打开波形窗口
view wave
view structure
# 打开信号窗口
view signals

# 添加波形模板
add wave -divider {TB_Sdram_Top}
add wave TB_Sdram_Top/*

add wave -divider {Sdram_Top}
add wave TB_Sdram_Top/Sdram_Top_inst/*

#add wave -divider {Sdram_Init}
#add wave TB_Sdram_Top/Sdram_Top_inst/Sdram_Init_inst/*

#add wave -divider {Sdram_Refresh}
#add wave TB_Sdram_Top/Sdram_Top_inst/Sdram_Refresh_inst/*

add wave -divider {Sdram_Write}
add wave TB_Sdram_Top/Sdram_Top_inst/Sdram_Write_inst/*

add wave -divider {Sdram_Read}
add wave TB_Sdram_Top/Sdram_Top_inst/Sdram_Read_inst/*

.main clear

#运行xxms
run 300us

