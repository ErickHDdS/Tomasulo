onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pratica3/clock
add wave -noupdate -radix unsigned /pratica3/cdb/R1
add wave -noupdate -radix unsigned /pratica3/cdb/R2
add wave -noupdate -radix unsigned /pratica3/cdb/R3
add wave -noupdate -radix unsigned /pratica3/cdb/R4
add wave -noupdate -radix unsigned /pratica3/cdb/R5
add wave -noupdate -radix unsigned /pratica3/cdb/R6
add wave -noupdate -radix unsigned /pratica3/cdb/R7
add wave -noupdate /pratica3/cdb/modOp/UF/i
add wave -noupdate /pratica3/cdb/dataCDBout
add wave -noupdate /pratica3/cdb/nextInstruction
add wave -noupdate /pratica3/cdb/instOut
add wave -noupdate /pratica3/cdb/currentInst
add wave -noupdate /pratica3/cdb/RegOut
add wave -noupdate /pratica3/cdb/nextInstructionEnable
add wave -noupdate /pratica3/cdb/done
add wave -noupdate /pratica3/cdb/disponivel
add wave -noupdate /pratica3/cdb/dataAddress
add wave -noupdate /pratica3/cdb/writeEnable
add wave -noupdate /pratica3/cdb/dataCDBin
add wave -noupdate /pratica3/cdb/mem
add wave -noupdate /pratica3/cdb/instOutEnable
add wave -noupdate /pratica3/cdb/modOp/Adderin
add wave -noupdate /pratica3/cdb/modOp/instruction
add wave -noupdate /pratica3/cdb/modOp/Busy
add wave -noupdate /pratica3/cdb/modOp/instOutEnable
add wave -noupdate /pratica3/cdb/modOp/instOut
add wave -noupdate -expand /pratica3/cdb/modOp/Qj
add wave -noupdate /pratica3/cdb/modOp/Qk
add wave -noupdate /pratica3/cdb/modOp/OP
add wave -noupdate /pratica3/cdb/modOp/done
add wave -noupdate /pratica3/cdb/modOp/dout
add wave -noupdate /pratica3/cdb/modOp/registerStatus
add wave -noupdate /pratica3/cdb/modOp/instructionCodeIn
add wave -noupdate /pratica3/cdb/modOp/instructionCodeOut
add wave -noupdate /pratica3/cdb/modOp/verifyWire
add wave -noupdate /pratica3/cdb/modOp/i
add wave -noupdate /pratica3/cdb/modOp/PARA
add wave -noupdate /pratica3/cdb/modOp/PARAPORFAVOR
add wave -noupdate /pratica3/cdb/modOp/reg1
add wave -noupdate /pratica3/cdb/modOp/reg2
add wave -noupdate /pratica3/cdb/modOp/doneInst
add wave -noupdate /pratica3/cdb/modOp/disponivelUF
add wave -noupdate /pratica3/cdb/modOp/disponivel
add wave -noupdate /pratica3/cdb/modOp/UF/instructionCodeIn
add wave -noupdate /pratica3/cdb/modOp/UF/instructionCodeOut
add wave -noupdate /pratica3/cdb/modOp/UF/instruction
add wave -noupdate /pratica3/cdb/modOp/UF/instructIn
add wave -noupdate /pratica3/cdb/modOp/UF/clock
add wave -noupdate /pratica3/cdb/modOp/UF/R1
add wave -noupdate /pratica3/cdb/modOp/UF/R2
add wave -noupdate /pratica3/cdb/modOp/UF/done
add wave -noupdate /pratica3/cdb/modOp/UF/out
add wave -noupdate /pratica3/cdb/modOp/UF/currentInst
add wave -noupdate /pratica3/cdb/modOp/UF/i
add wave -noupdate /pratica3/cdb/modOp/UF/disponivelUF
add wave -noupdate /pratica3/clock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2136 ps} 0}
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
WaveRestoreZoom {1600 ps} {2600 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000000ps sim:/pratica3/clock 
WaveCollapseAll -1
wave clipboard restore
