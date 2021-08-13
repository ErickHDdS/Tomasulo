module CDB (clock);
  
  input clock;
  
  wire [15:0]R1, R2, R3, R4, R5, R6, R7, dataCDBout, nextInstruction, instOut, currentInst, RegOut;
  wire nextInstructionEnable, done, disponivel;
  
  reg [2:0]dataAddress;
  reg writeEnable;
  reg [15:0]dataCDBin;


  reg [15:0]mem[63:0];
  
  //Inicializando variaveis
  initial begin
	  writeEnable = 0;
	  dataAddress = 0;
  end

  IQ fila(clock, nextInstructionEnable, nextInstruction, done, disponivel); //fila de instrucoes
  
  mux CDBmux(R1, R2, R3, R4, R5, R6, R7, instOut[9:7], RegOut);
  
  RSadders controleFuncional(nextInstruction, clock, nextInstructionEnable, R1, R2, R3, R4, R5, R6, R7,instOutEnable, currentInst, done, dataCDBout, disponivel, instOut); //estacao de reserva
  
  FPregisters bancoRegistradores(clock, dataCDBin, dataAddress, writeEnable, R1, R2, R3, R4, R5, R6, R7); //registradores propriamente ditos
  
  always @(posedge done)
  begin
	if(instOut[3:0] == 4'b0000 || instOut[3:0] == 4'b0001 || instOut[3:0] == 4'b0100 || instOut[3:0] == 4'b0101) //add, sub, mul e div
	begin	
		dataCDBin = dataCDBout;
		dataAddress = instOut[12:10];
		writeEnable = 1'b1;
	end
  end

endmodule