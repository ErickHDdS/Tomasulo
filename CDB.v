module CDB (clock);
  
  input clock;
  
  wire [15:0]R1, R2, R3, R4, R5, R6, R7, dataCDBOut, nextInstruction, instOut, instAtual, RegOut;
  wire nextInstructionEnable, done, disponibilidade;
  
  reg [2:0]dataAddress;
  reg writeEnable;
  reg [15:0]dataCDBIn;
  reg [15:0]mem[63:0];

  initial begin
	  writeEnable = 0;
	  dataAddress = 0;
  end

  FilaInstrucao fila(clock, nextInstructionEnable, nextInstruction, disponibilidade); //fila de instrucoes
  
  mux CDBmux(R1, R2, R3, R4, R5, R6, R7, instOut[9:7], RegOut);
  
  estacaoReserva controleFuncional(nextInstruction, clock, nextInstructionEnable, R1, R2, R3, R4, R5, R6, R7,instOutEnable, instAtual, done, dataCDBOut, disponibilidade, instOut); //estacao de reserva
  
  BancoRegistradores bancoRegistradores(clock, dataCDBIn, dataAddress, writeEnable, R1, R2, R3, R4, R5, R6, R7); //registradores propriamente ditos
  
  always @(posedge done)
  begin
	if(instOut[3:0] == 4'b0000 || instOut[3:0] == 4'b0001 || instOut[3:0] == 4'b0100 || instOut[3:0] == 4'b0101) //add, sub, mul e div
	begin	
		dataCDBIn = dataCDBOut;
		dataAddress = instOut[12:10];
		writeEnable = 1'b1;
	end
  end

endmodule