onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/clk
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/rst_n
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/eeprom_config_data
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/i2c_start
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/i2c_sdat
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/i2c_sclk
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/i2c_done
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/i2c_rd_data
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/wr_device_addr
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/rd_device_addr
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/reg_addr1
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/reg_addr2
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM} /TB_I2C_Ctrl_EEPROM/wr_data
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/clk
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/rst_n
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/eeprom_config_data
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/i2c_start
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} -color Yellow /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/i2c_sdat
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} -color Yellow /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/i2c_sclk
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} -color Yellow /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/transfer_en
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} -color Yellow /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/capture_en
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/i2c_done
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/i2c_rd_data
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} -radix unsigned /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/pre_state
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} -radix unsigned /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/next_state
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/i2c_sdat_r
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/bir_en
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/i2c_sclk_r
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/sclk_cnt
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/tran_cnt
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/reg_addr1
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/reg_addr2
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/wr_data
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/wr_ack1
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/wr_ack2
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/wr_ack3
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/wr_ack4
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst} /TB_I2C_Ctrl_EEPROM/I2C_Ctrl_EEPROM_inst/rd_ack1
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/scl
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/sda
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/out_flag
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/address
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/memory_buf
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/sda_buf
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/shift
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/addr_byte_h
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/addr_byte_l
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/ctrl_byte
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/State
add wave -noupdate -expand -label sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/Group1 -group {Region: sim:/TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst} /TB_I2C_Ctrl_EEPROM/EEPROM_AT24C64_inst/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {2317809 ps} 0}
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
WaveRestoreZoom {0 ps} {210 us}
