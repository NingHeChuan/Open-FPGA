
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name I2C_Ctrl_EEPROM -dir "H:/ISE/I2C Control EEPROM/Dev/planAhead_run_1" -part xc3s100ecp132-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "H:/ISE/I2C Control EEPROM/Dev/Top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {H:/ISE/I2C Control EEPROM/Dev} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "H:/ISE/I2C Control EEPROM/Src/Top.ucf" [current_fileset -constrset]
add_files [list {H:/ISE/I2C Control EEPROM/Src/Top.ucf}] -fileset [get_property constrset [current_run]]
link_design
