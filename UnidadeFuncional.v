module UnidadeFuncional(clock, instruction, iIn, instructionIn, instructionOut, done, InstAtual, out, disponivelUnidadeFuncional, R1, R2);

	input [2:0]instructionIn;
	input [15:0]instruction;
	input iIn, clock;
	input [15:0] R1, R2;
	
	output reg done;
	output reg [15:0]out, InstAtual;
	output reg[2:0]instructionOut;
	output reg disponivelUnidadeFuncional;

	integer Latencia;
	
	initial begin
		InstAtual = 16'b0000000000001111;
		done = 0;
		disponivelUnidadeFuncional = 1;
	end

	always @(posedge clock)
	begin
	  done=0;	
		if(iIn == 1 && disponivelUnidadeFuncional == 1)
		begin	
			disponivelUnidadeFuncional = 0;
			InstAtual = instruction;
			Latencia = 0;
			instructionOut = instructionIn;
			case(instruction[3:0])
				4'b0000: out <= R2 + R1;
				4'b0001: out <= R2 - R1;
				4'b0100: out <= R2 * R1;
				4'b0101: out <= R2 / R1;
			endcase
		end
		else
			Latencia = Latencia + 1;

		// OPS: ADD E SUB
		if(InstAtual[3:0] == 4'b0000 || InstAtual[3:0] == 4'b0001) 
		begin
			if(Latencia == 1)
				begin
				done = 1'b1;
				disponivelUnidadeFuncional = 1;
				end
			end
		else 
		begin
			// OPS: MUL E DIV
			if(InstAtual[3:0] == 4'b0100 || InstAtual[3:0] == 4'b0101)
			begin
				if(Latencia == 2)
				begin
					done = 1'b1;
					disponivelUnidadeFuncional = 1;
				end
			end
		end
	end

endmodule