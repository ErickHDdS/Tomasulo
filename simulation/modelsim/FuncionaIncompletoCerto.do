onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pratica3/clock
add wave -noupdate -color Cyan /pratica3/cdb/controleFuncional/UnFuncional/Latencia
add wave -noupdate -color Yellow -radix unsigned /pratica3/cdb/R1
add wave -noupdate -color Magenta -radix unsigned /pratica3/cdb/R2
add wave -noupdate -color Turquoise -radix unsigned /pratica3/cdb/R3
add wave -noupdate -color White -radix unsigned /pratica3/cdb/R4
add wave -noupdate -color Yellow -radix unsigned /pratica3/cdb/R5
add wave -noupdate -color {Medium Orchid} -radix unsigned /pratica3/cdb/R6
add wave -noupdate -color Blue -radix unsigned /pratica3/cdb/R7
add wave -noupdate /pratica3/cdb/instAtual
add wave -noupdate /pratica3/cdb/nextInstruction
add wave -noupdate /pratica3/cdb/fila/Instrucao
add wave -noupdate /pratica3/cdb/instOut
add wave -noupdate /pratica3/cdb/nextInstructionEnable
add wave -noupdate /pratica3/cdb/controleFuncional/Qj
add wave -noupdate /pratica3/cdb/controleFuncional/Qk
add wave -noupdate /pratica3/cdb/controleFuncional/OP
add wave -noupdate /pratica3/clock
add wave -noupdate /pratica3/cdb/controleFuncional/verifyWire
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {324 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000000ps sim:/pratica3/clock 
WaveCollapseAll -1
wave clipboard restore
