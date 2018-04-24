#退出当前仿真
#quit -sim

vlib work

#编译修改后的文件
vlog "../Src/*.v"
vlog "../Sim/*.v"

#开始仿真
vsim -voptargs=+acc work.TB_Cmd_Decode
#添加指定信号
#添加顶层所有的信号

# Set the window types
# 打开波形窗口
view wave
view structure
# 打开信号窗口
view signals

# 添加波形模板
add wave -divider {TB_Cmd_Decode}
add wave TB_Cmd_Decode/*

add wave -divider {Cmd_Decode}
add wave TB_Cmd_Decode/Cmd_Decode_inst/*



.main clear

#运行xxms
run 1us

