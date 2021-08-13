module UnidadeFuncional(clock, instruction, instructIn, instructionCodeIn, 
			instructionCodeOut, done, currentInst, dout, disponivelUF, reg1, reg2);

input [2:0]instructionCodeIn;
output reg[2:0]instructionCodeOut;
input [15:0]instruction;
input instructIn, clock;
input [15:0] reg1, reg2;
output reg done;
output reg [15:0]dout, currentInst;
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
			4'b0000: dout <= reg2 + reg1;
			4'b0001: dout <= reg2 - reg1;
			4'b0100: dout <= reg2 * reg1;
		//complete
		endcase
	end
	else
		i = i + 1;

	
	if(currentInst[3:0] == 4'b0000 || currentInst[3:0] == 4'b0001 ) //add, sub e mul
	begin
		if(i == 1)
			begin
			done = 1'b1;
			disponivelUF = 1;
			end
		end
	else //sd e ld
	begin
	if(currentInst[3:0] == 4'b0100 )
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