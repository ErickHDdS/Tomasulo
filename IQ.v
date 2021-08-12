module IQ(Clock, enableOut, instructionOut, done, disponivel);
  
  input Clock, done, disponivel;
  reg [15:0]PC1[63:0]; //Armazena a lista de isntrucoes
  
  reg[15:0] i;

  output reg enableOut;
  output reg[15:0]instructionOut;
 
  
  initial
	begin //Fila de Instrucoes
		i = 0;
		PC1[0]=16'b0000110010100000; //ADD R3, R1, R2
      PC1[1]=16'b0001010110010001; //SUB R5, R3, R1
      PC1[2]=16'b0001011001100000; //ADD R5, R4, R6 [3-5]
      PC1[3]=16'b0001101011000100; //MUL R6, R5,R4 [4-8]
      PC1[4]=16'b0000101010110100; //MUL R2, R5, R3 [5-10]
      PC1[5]=16'b0001101011000001; //SUB R6, R5, R4 [6-7]
      PC1[6]=16'b0001101011010000; //ADD R6, R5, R5 [7-8]
	end

	
	always @ (posedge Clock)
	begin
	  	if(disponivel == 1'b1)
		begin
			instructionOut = PC1[i];
			enableOut = 1;
			i = i + 1;
	  end
	end
	
  
endmodule