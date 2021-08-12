module CDB (clock, Reset, Run);
  
  /*
  * Tomsulo com instrucao de desvio e despache simples das instrucoes
  * Documentacao da Instrucao
  *
  * IMMEDIATE - Rx  - Ry  - OPCODE
  * 000000    - 000 - 000 - 0000
  *
  * INST  - OPCODE
  * ADD.D - 0000
  * SUB.D - 0001
  * L.D - 0010
  * S.D   - 0011
  */


  input clock;
  input Reset, Run;
  
  wire [15:0]R1, R2, R3, R4, R5, R6, R7, dataCDBout, nextInstruction, instOut, currentInst, Rout;
  wire nextInstructionEnable, done, disponivel;
  
  reg [2:0]dataAddress;
  reg writeEnable;
  reg [15:0]dataCDBin;


  reg [15:0]mem[63:0]; //Memoria principal  
  
  initial begin
	//IMPORTANTE INICIALIZAR VALORES
  writeEnable = 0;
  dataAddress = 0;
  end

  mux CDBmux(R1, R2, R3, R4, R5, R6, R7, instOut[9:7], Rout);
  
  FPregisters fpreg(clock, dataCDBin, dataAddress, writeEnable, R1, R2, R3, R4, R5, R6, R7); //registradores propriamente ditos
  
  IQ queue(clock, Reset, Run, nextInstructionEnable, nextInstruction, done, disponivel); //fila de instrucoes
  
  RSadders RSa1(nextInstruction, clock, nextInstructionEnable, R1, R2, R3, R4, R5, R6, R7,instOutEnable, currentInst, done, dataCDBout, disponivel, instOut); //estacao de reserva


  always @(posedge done)
  begin
	if(instOut[3:0] == 4'b0000 || instOut[3:0] == 4'b0001 || instOut[3:0] == 4'b0100) //add, sub e mul
	begin	
		dataCDBin = dataCDBout;
		dataAddress = instOut[12:10];
		writeEnable = 1'b1;
	end
	else
	begin
		if(instOut[3:0] == 4'b0010) //ld
		begin
			dataCDBin = mem[dataCDBout];
			dataAddress = instOut[6:4];
			writeEnable = 1'b1;
		end
		else
		begin
			if(instOut[3:0] == 4'b0011) //sd
			begin
				mem[dataCDBout] = Rout;
			end
		end
	end
  end

endmodule