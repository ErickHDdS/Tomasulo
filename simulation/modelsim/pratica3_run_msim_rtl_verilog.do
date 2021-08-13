transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC\ II/Pratica\ III/Tomasulo {C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC II/Pratica III/Tomasulo/CDB.v}
vlog -vlog01compat -work work +incdir+C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC\ II/Pratica\ III/Tomasulo {C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC II/Pratica III/Tomasulo/UnidadeFuncional.v}
vlog -vlog01compat -work work +incdir+C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC\ II/Pratica\ III/Tomasulo {C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC II/Pratica III/Tomasulo/mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC\ II/Pratica\ III/Tomasulo {C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC II/Pratica III/Tomasulo/pratica3.v}
vlog -vlog01compat -work work +incdir+C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC\ II/Pratica\ III/Tomasulo {C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC II/Pratica III/Tomasulo/filainstrucao.v}
vlog -vlog01compat -work work +incdir+C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC\ II/Pratica\ III/Tomasulo {C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC II/Pratica III/Tomasulo/estacaoreserva.v}
vlog -vlog01compat -work work +incdir+C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC\ II/Pratica\ III/Tomasulo {C:/Users/erick/OneDrive/Documentos/GitHub/Repositorios/LAOC II/Pratica III/Tomasulo/bancoregistradores.v}

