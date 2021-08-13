module FilaInstrucao(clock, outLiberado, instructionOut, disponibilidade);
  
  input clock, disponibilidade;
  
  output reg outLiberado;
  output reg[15:0]instructionOut;
  
  reg [15:0]Instrucao[50:0];
  reg[15:0] i;

  initial
	begin 
		i = 0;
		//Fila de Instrucoes:
		//[000]offset [000]Rz [000]Rx [000]Ry [0000] opcode
		Instrucao[0]=16'b0000110010100000; //ADD R3, R1, R2
      Instrucao[1]=16'b0001010110010001; //SUB R5, R3, R1
      Instrucao[2]=16'b0001011001100000; //ADD R5, R4, R6 
      Instrucao[3]=16'b0001101011000100; //MUL R6, R5, R4 
      Instrucao[4]=16'b0000101010110100; //MUL R2, R5, R3 
      Instrucao[5]=16'b0001101011000001; //SUB R6, R5, R4 
      Instrucao[6]=16'b0001101011010000; //ADD R6, R5, R5 
	end

	always @ (posedge clock)
	begin
	  	if(disponibilidade == 1'b1)
		begin
			instructionOut = Instrucao[i];
			outLiberado = 1;
			i = i + 1;
	  end
	end
endmodule