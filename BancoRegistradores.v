module BancoRegistradores(clock, data, address, write, R1, R2, R3, R4, R5, R6, R7);
	output reg[15:0]R1,R2,R3,R4,R5,R6,R7; 

	initial begin
	  R1 = 1; R2 = 1; R3 = 1; R4 = 2; R5 = 0; R6 = 1; R7 = 0;
	end

	input clock;
	input [15:0]data; 					
	input write; 					
	input [2:0]address; 			

	always@(posedge clock)
	begin
		if(write==1'b1)
		begin
		  if(address == 3'b001)
			 R1 = data;
		  if(address == 3'b010)
			 R2 = data;
		  if(address == 3'b011)
			 R3 = data;
		  if(address == 3'b100)
			 R4 = data;
		  if(address == 3'b101)
			 R5 = data;
		  if(address == 3'b110)
			 R6 = data;
		  if(address == 3'b111)
			 R7 = data;
		end
	end
endmodule