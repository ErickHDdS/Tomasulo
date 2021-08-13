module FPregisters(clock, dataIn, dataAddress, writeEnable, R1, R2, R3, R4, R5, R6, R7);
	output reg[15:0]R1,R2,R3,R4,R5,R6,R7; 

	initial begin
	  R1 = 1; R2 = 1; R3 = 1; R4 = 2; R5 = 0; R6 = 1; R7 = 0;
	end

	input clock;
	input [15:0]dataIn; 					//dado a ser escrito no registrador
	input writeEnable; 					//escrita habilatada
	input [2:0]dataAddress; 			//endereco de qual registrador sera alterado

	always@(posedge clock)
	begin
		if(writeEnable==1'b1)
		begin
		  if(dataAddress == 3'b001)
			 R1 = dataIn;
		  if(dataAddress == 3'b010)
			 R2 = dataIn;
		  if(dataAddress == 3'b011)
			 R3 = dataIn;
		  if(dataAddress == 3'b100)
			 R4 = dataIn;
		  if(dataAddress == 3'b101)
			 R5 = dataIn;
		  if(dataAddress == 3'b110)
			 R6 = dataIn;
		  if(dataAddress == 3'b111)
			 R7 = dataIn;
		end
	end
endmodule