module regn(Reg, RegIn, Clock, Q);
	input [15:0] Reg;
	input RegIn, Clock;
	output reg [15:0] Q;
	
	initial
	begin
		Q <= 16'b0000000000000000;
	end
	
	always @(posedge Clock)
		if (RegIn)
			Q <= Reg;
endmodule