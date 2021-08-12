module FPregisters(clock, dataIn, dataAddress, writeEnable, R1, R2, R3, R4, R5, R6, R7);
	output reg[15:0]R1; //registrador 1
	output reg[15:0]R2; //registrador 2
	output reg[15:0]R3; //registrador 3
	output reg[15:0]R4; //registrador 4
	output reg[15:0]R5; //registrador 5
	output reg[15:0]R6; //registrador 6
	output reg[15:0]R7; //registrador 7

	initial begin
	  R1 = 1;
	  R2 = 1;
	  R3 = 1;
	  R4 = 2;
	  R5 = 0;
	  R6 = 1;
	  R7 = 0;
	end

	input clock;
	input [15:0]dataIn; //dado a ser escrito em um registrador
	input writeEnable; //habilita escrita
	input [2:0]dataAddress; //informa qual reg vai ser alterado

	always@(posedge clock)
	begin
		if(writeEnable==1'b1)
		begin
		  if(dataAddress == 3'b001)//escreve em R1
			 R1 = dataIn;
		  else
			 if(dataAddress == 3'b010)//escreve em R2
				R2 = dataIn;
			 else
				if(dataAddress == 3'b011)//escreve em R3
				  R3 = dataIn;
				else
				  if(dataAddress == 3'b100)//escreve em R4
					 R4 = dataIn;
				  else
					 if(dataAddress == 3'b101)//escreve em R5
						R5 = dataIn;
			  else
						if(dataAddress == 3'b110)//escreve em R6
						  R6 = dataIn;
						else
						  if(dataAddress == 3'b111)//escreve em R7
							 R7 = dataIn;
		end
			

	end

endmodule