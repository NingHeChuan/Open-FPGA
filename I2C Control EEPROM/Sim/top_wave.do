onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/clk
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/rst_n
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/i2c_sdat
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/i2c_sclk
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/out
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/dp
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/an
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/wr_en
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/rd_en
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/eeprom_config_data
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/i2c_start
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/i2c_done
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Group1 -group {Region: sim:/TB_Top/Top_inst} /TB_Top/Top_inst/i2c_rd_data
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/scl
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/sda
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/out_flag
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/address
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/memory_buf
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/sda_buf
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/shift
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/addr_byte_h
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/addr_byte_l
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/ctrl_byte
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/State
add wave -noupdate -expand -label sim:/TB_Top/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_Top/EEPROM_AT24C64_inst} /TB_Top/EEPROM_AT24C64_inst/i
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/clk
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/rst_n
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/wr_en
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/rd_en
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/i2c_done
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/i2c_start
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/eeprom_config_data
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/wr_device_addr
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/rd_device_addr
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/reg_addr1
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/reg_addr2
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/wr_data
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/wr_en_r
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/rd_en_r
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/wr_pose
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Ctrl_I2C_Op_inst} /TB_Top/Top_inst/Ctrl_I2C_Op_inst/rd_pose
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/clk
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/rst_n
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/eeprom_config_data
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/i2c_start
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/i2c_sdat
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/i2c_sclk
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/i2c_done
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/i2c_rd_data
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} -radix unsigned /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/pre_state
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} -radix unsigned /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/next_state
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} -color Yellow /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/i2c_sdat_r
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/bir_en
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/transfer_en
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/capture_en
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/i2c_sclk_r
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/sclk_cnt
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/tran_cnt
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/wr_device_addr
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/rd_device_addr
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/wr_rd_flag
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/reg_addr1
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/reg_addr2
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/wr_data
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/wr_ack1
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/wr_ack2
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/wr_ack3
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/wr_ack4
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst} /TB_Top/Top_inst/I2C_Ctrl_EEPROM_inst/rd_ack1
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/clk
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/rst_n
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/data_four
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/data_three
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/data_two
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/data_one
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/out
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/an
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/dp
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/aen
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/s
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/cnt
add wave -noupdate -expand -label sim:/TB_Top/Top_inst/Seven_Seg_Display_inst/Group1 -group {Region: sim:/TB_Top/Top_inst/Seven_Seg_Display_inst} /TB_Top/Top_inst/Seven_Seg_Display_inst/disp_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {185490000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {149166646 ps} {272743673 ps}
