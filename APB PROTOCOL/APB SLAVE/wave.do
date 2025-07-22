onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top/clk
add wave -noupdate /top/apb_if_inst/clk
add wave -noupdate /top/apb_if_inst/PRESET
add wave -noupdate /top/apb_if_inst/PADDR
add wave -noupdate /top/apb_if_inst/PSEL
add wave -noupdate /top/apb_if_inst/PWRITE
add wave -noupdate /top/apb_if_inst/PWDATA
add wave -noupdate /top/apb_if_inst/PENABLE
add wave -noupdate /top/apb_if_inst/PREADY
add wave -noupdate /top/apb_if_inst/PSLVERR
add wave -noupdate -radix unsigned /top/apb_if_inst/PRDATA
add wave -noupdate -radix unsigned -childformat {{{/top/dut/slave_memory[31]} -radix unsigned} {{/top/dut/slave_memory[30]} -radix unsigned} {{/top/dut/slave_memory[29]} -radix unsigned} {{/top/dut/slave_memory[28]} -radix unsigned} {{/top/dut/slave_memory[27]} -radix unsigned} {{/top/dut/slave_memory[26]} -radix unsigned} {{/top/dut/slave_memory[25]} -radix unsigned} {{/top/dut/slave_memory[24]} -radix unsigned} {{/top/dut/slave_memory[23]} -radix unsigned} {{/top/dut/slave_memory[22]} -radix unsigned} {{/top/dut/slave_memory[21]} -radix unsigned} {{/top/dut/slave_memory[20]} -radix unsigned} {{/top/dut/slave_memory[19]} -radix unsigned} {{/top/dut/slave_memory[18]} -radix unsigned} {{/top/dut/slave_memory[17]} -radix unsigned} {{/top/dut/slave_memory[16]} -radix unsigned} {{/top/dut/slave_memory[15]} -radix unsigned} {{/top/dut/slave_memory[14]} -radix unsigned} {{/top/dut/slave_memory[13]} -radix unsigned} {{/top/dut/slave_memory[12]} -radix unsigned} {{/top/dut/slave_memory[11]} -radix unsigned} {{/top/dut/slave_memory[10]} -radix unsigned} {{/top/dut/slave_memory[9]} -radix unsigned} {{/top/dut/slave_memory[8]} -radix unsigned} {{/top/dut/slave_memory[7]} -radix unsigned} {{/top/dut/slave_memory[6]} -radix unsigned} {{/top/dut/slave_memory[5]} -radix unsigned} {{/top/dut/slave_memory[4]} -radix unsigned} {{/top/dut/slave_memory[3]} -radix unsigned} {{/top/dut/slave_memory[2]} -radix unsigned} {{/top/dut/slave_memory[1]} -radix unsigned} {{/top/dut/slave_memory[0]} -radix unsigned}} -expand -subitemconfig {{/top/dut/slave_memory[31]} {-radix unsigned} {/top/dut/slave_memory[30]} {-radix unsigned} {/top/dut/slave_memory[29]} {-radix unsigned} {/top/dut/slave_memory[28]} {-radix unsigned} {/top/dut/slave_memory[27]} {-radix unsigned} {/top/dut/slave_memory[26]} {-radix unsigned} {/top/dut/slave_memory[25]} {-radix unsigned} {/top/dut/slave_memory[24]} {-radix unsigned} {/top/dut/slave_memory[23]} {-radix unsigned} {/top/dut/slave_memory[22]} {-radix unsigned} {/top/dut/slave_memory[21]} {-radix unsigned} {/top/dut/slave_memory[20]} {-radix unsigned} {/top/dut/slave_memory[19]} {-radix unsigned} {/top/dut/slave_memory[18]} {-radix unsigned} {/top/dut/slave_memory[17]} {-radix unsigned} {/top/dut/slave_memory[16]} {-radix unsigned} {/top/dut/slave_memory[15]} {-radix unsigned} {/top/dut/slave_memory[14]} {-radix unsigned} {/top/dut/slave_memory[13]} {-radix unsigned} {/top/dut/slave_memory[12]} {-radix unsigned} {/top/dut/slave_memory[11]} {-radix unsigned} {/top/dut/slave_memory[10]} {-radix unsigned} {/top/dut/slave_memory[9]} {-radix unsigned} {/top/dut/slave_memory[8]} {-radix unsigned} {/top/dut/slave_memory[7]} {-radix unsigned} {/top/dut/slave_memory[6]} {-radix unsigned} {/top/dut/slave_memory[5]} {-radix unsigned} {/top/dut/slave_memory[4]} {-radix unsigned} {/top/dut/slave_memory[3]} {-radix unsigned} {/top/dut/slave_memory[2]} {-radix unsigned} {/top/dut/slave_memory[1]} {-radix unsigned} {/top/dut/slave_memory[0]} {-radix unsigned}} /top/dut/slave_memory
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {315 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 185
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
configure wave -timelineunits ns
update
WaveRestoreZoom {261 ns} {439 ns}
