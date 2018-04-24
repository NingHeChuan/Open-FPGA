#退出当前仿真
#quit -sim

vlib work

#编译修改后的文件
vlog "../Src/*.v"
vlog "../Sim/*.v"
vlog "../Sim/altera_lib/*.v"

#开始仿真
vsim -voptargs=+acc work.TB_Sdram_Rx_Tx_Top


#添加指定信号
#添加顶层所有的信号

# Set the window types
# 打开波形窗口
view wave
view structure
# 打开信号窗口
view signals

# 添加波形模板
add wave -divider {TB_Sdram_Rx_Tx_Top}
add wave TB_Sdram_Rx_Tx_Top/*

 add wave -divider {Sdram_Tx_Rx_Top}
 add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/*
 
  add wave -divider {Uart_Byte_Tx_test}
 add wave TB_Sdram_Rx_Tx_Top/Uart_Byte_Tx_test_inst/*

add wave -divider {Sdram_Top}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/Sdram_Top_inst/*

add wave -divider {Uart_Byte_Rx}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/Uart_Byte_Rx_inst/*

add wave -divider {Cmd_Decode}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/Cmd_Decode_inst/*

add wave -divider {fifo8x16}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/wfifo8x16_inst/*

add wave -divider {fifo8x16}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/rfifo8x16_inst/*

add wave -divider {Uart_Byte_Tx}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst//Uart_Byte_Tx_inst/*

add wave -divider {Sdram_Write}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/Sdram_Top_inst/Sdram_Write_inst/*

add wave -divider {Sdram_Read}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/Sdram_Top_inst/Sdram_Read_inst/*

add wave -divider {Sdram_Refresh}
add wave TB_Sdram_Rx_Tx_Top/Sdram_Tx_Rx_Top_inst/Sdram_Top_inst/Sdram_Refresh_inst/*

.main clear

#运行xxms
run 1100us

