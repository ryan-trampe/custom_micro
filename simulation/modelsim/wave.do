onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cme341_microprocessor_tb/clk
add wave -noupdate -radix hexadecimal /cme341_microprocessor_tb/i_pins
add wave -noupdate /cme341_microprocessor_tb/reset
add wave -noupdate -color {Dark Olive Green} -radix hexadecimal /cme341_microprocessor_tb/pm_address
add wave -noupdate -color Red -radix hexadecimal /cme341_microprocessor_tb/pm_data
add wave -noupdate -color {Medium Blue} -radix hexadecimal /cme341_microprocessor_tb/data_bus
add wave -noupdate -radix hexadecimal /cme341_microprocessor_tb/o_reg
add wave -noupdate -radix hexadecimal /cme341_microprocessor_tb/source_select
add wave -noupdate -childformat {{{/cme341_microprocessor_tb/reg_enables[8]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[7]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[6]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[5]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[4]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[3]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[2]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[1]} -radix binary} {{/cme341_microprocessor_tb/reg_enables[0]} -radix binary}} -expand -subitemconfig {{/cme341_microprocessor_tb/reg_enables[8]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[7]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[6]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[5]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[4]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[3]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[2]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[1]} {-radix binary} {/cme341_microprocessor_tb/reg_enables[0]} {-radix binary}} /cme341_microprocessor_tb/reg_enables
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12690520 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {8531250 ps} {21656250 ps}
