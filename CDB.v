module CDB(clock);
  
  input clock;
  
  wire [15:0]R1, R2, R3, R4, R5, R6, R7, CDBOut, instructionNext, inst, instAtual, RegOut;
  wire instructionNextUsando, done, disponibilidade;
  
  reg [2:0]address;
  reg wEnable;
  reg [15:0]CDBIn;
  reg [15:0]mem[63:0];

  initial 
  begin
		address = 0;
	   wEnable = 0;
  end

  // Fila de instrucao 
  FilaInstrucao fila(clock, instructionNextUsando, instructionNext, disponibilidade);
  
  mux CDBmux(R1, R2, R3, R4, R5, R6, R7, inst[9:7], RegOut);
  
  // Estacao de reserva 
  estacaoReserva controleFuncional(instructionNext, clock, instructionNextUsando, R1, R2, R3, R4, R5, R6, R7,instOutEnable, instAtual, done, CDBOut, disponibilidade, inst);
  
  // Banco de registradores
  BancoRegistradores bancoRegistradores(clock, CDBIn, address, wEnable, R1, R2, R3, R4, R5, R6, R7); 
  
  always @(posedge done)
  begin
	if(inst[3:0] == 4'b0000 || inst[3:0] == 4'b0001 || inst[3:0] == 4'b0100 || inst[3:0] == 4'b0101) //add, sub, mul e div
	begin	
		CDBIn = CDBOut;
		address = inst[12:10];
		wEnable = 1'b1;
	end
  end

endmodule