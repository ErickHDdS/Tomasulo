module IQ(Clock, Reset, Run, enableOut, instructionOut, done, disponivel);
  
  input Clock, Reset, Run, done, disponivel;
  reg Adderin, Adderin2, LDin, SDin, LDin2, SDin2;
  reg [15:0]PC1[63:0]; //Armazena a lista de isntrucoes
  reg [15:0]cr;
  
  reg[15:0] i;

  output reg enableOut;
  output reg[15:0]instructionOut;
  
  wire [15:0] R0, R1, R2, R3, R4, R5, R6;
  
  initial
	begin //Fila de Instrucoes
		i = 0;
		PC1[0]=16'b0000110010100000; //ADD R3, R1, R2
		PC1[1]=16'b0001010110010001; //SUB R5, R3, R1
		PC1[2]=16'b0000010110100000; //ADD R1, R3, R2
		PC1[3]=16'b0000011000100001; //SUB R1, R4, R2
		PC1[4]=16'b0000001000010010; //LD R1, 0 (R4)
		PC1[5]=16'b0000010011000001; //SUB R1, R1, R4
		PC1[6]=16'b0000001000010011; //SD R1, 0 (R4)
		PC1[7]=16'b0000001000100010; //LD R2, 0 (R4)
		PC1[8]=16'b0000000110010010; //LD R1, 0 (R3)
		PC1[9]=16'b0000100101010001; //SUB R2, R2, R5
	end

	
	always @ (posedge Clock)
	begin
	  if (Reset == 1'b0 && Run == 1'b1)
	  begin
	  	if(disponivel == 1'b1)
		begin
			instructionOut = PC1[i];
			enableOut = 1;
			i = i + 1;
			
		end
	  end
	end
	
  
endmodule