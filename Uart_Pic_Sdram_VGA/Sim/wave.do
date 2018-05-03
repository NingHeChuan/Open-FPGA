#退出当前仿真
#quit -sim

vlib work

#编译修改后的文件
vlog "../sim/altera_lib/*.v"
vlog "../Src/*.v"
vlog "../Sim/*.v"

#开始仿真
vsim -voptargs=+acc work.TB_Uart_Pic_Sdram_VGA
#添加指定信号
#添加顶层所有的信号

# Set the window types
# 打开波形窗口
view wave
view structure
# 打开信号窗口
view signals

# 添加波形模板
add wave -divider {TB_Uart_Pic_Sdram_VGA}
add wave TB_Uart_Pic_Sdram_VGA/*

add wave -divider {Uart_Pic_Sdram_VGA}
add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/*

add wave -divider {UART_Byte_Tx}
add wave TB_Uart_Pic_Sdram_VGA/uut_UART_Byte_Tx/*

add wave -divider {Sdram_Top}
add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/*

# add wave -divider {sdram_model_plus}
# add wave TB_Uart_Pic_Sdram_VGA/sdram_model_plus_inst/*

add wave -divider {Uart_Byte_Rx}
add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Uart_Byte_Rx_inst/*



# add wave -divider {Sdram_Init}
# add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/Sdram_Init_inst/*

add wave -divider {Sdram_Write}
add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/Sdram_Write_inst/*

add wave -divider {Auto_Write_Read}
add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/Auto_Write_Read_inst/*


add wave -divider {dfifo_16x512}
add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/Auto_Write_Read_inst/wfifo_16x512_inst/*

add wave -divider {dfifo_16x512}
add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/Auto_Write_Read_inst/rfifo_16x512_inst/*

# add wave -divider {Sdram_Refresh}
# add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/Sdram_Refresh_inst/*


 add wave -divider {Sdram_Read}
 add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/Sdram_Top_inst/Sdram_Read_inst/*
 
  add wave -divider {VGA_Dispaly}
 add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/VGA_Dispaly_inst/*
 
  add wave -divider {VGA_Drive}
 add wave TB_Uart_Pic_Sdram_VGA/Uart_Pic_Sdram_VGA_inst/VGA_Drive_inst/*

.main clear

#运行xxms
run 2ms
run 50us

