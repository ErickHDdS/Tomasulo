module UnidadeFuncional(clock, instruction, instructIn, instructionCodeIn, instructionCodeOut, done, currentInst, out, disponivelUF, R1, R2);

	input [2:0]instructionCodeIn;
	output reg[2:0]instructionCodeOut;
	input [15:0]instruction;
	input instructIn, clock;
	input [15:0] R1, R2;
	output reg done;
	output reg [15:0]out, currentInst;
	integer i;
	output reg disponivelUF;

	initial begin
		currentInst = 16'b0000000000001111;
		done = 0;
		disponivelUF = 1;
	end

	always @(posedge clock)
	begin
	  done=0;	
		
		if(instructIn == 1 && disponivelUF == 1)
		begin	
			disponivelUF = 0;
			currentInst = instruction;
			i = 0;
			instructionCodeOut = instructionCodeIn;
			case(instruction[3:0])
				4'b0000: out <= R2 + R1;
				4'b0001: out <= R2 - R1;
				4'b0100: out <= R2 * R1;
				4'b0101: out <= R2 / R1;
			endcase
		end
		else
			i = i + 1;

		// OPS: ADD E SUB
		if(currentInst[3:0] == 4'b0000 || currentInst[3:0] == 4'b0001) 
		begin
			if(i == 1)
				begin
				done = 1'b1;
				disponivelUF = 1;
				end
			end
		else 
		begin
		// OPS: MUL E DIV
		if(currentInst[3:0] == 4'b0100 || currentInst[3:0] == 4'b0101)
		begin
			if(i == 2)
					begin
					done = 1'b1;
					disponivelUF = 1;
				end
			end
		end
	end

endmodule