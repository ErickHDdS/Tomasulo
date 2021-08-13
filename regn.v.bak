module regn(R, Rin, Clock, Q);
	parameter n = 16;
	input [n-1:0] R;
	input Rin, Clock;
	output reg [n-1:0] Q;
	
	initial
	begin
		Q <= 16'b0000000000000000;//inicia em 0
	end
	
	always @(posedge Clock)
		if (Rin)
			Q <= R;//escrita
endmodule