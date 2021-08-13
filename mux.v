module mux(R1, R2, R3, R4, R5, R6, R7, RegAddr, RegOut);

	input [15:0]R1, R2, R3, R4, R5, R6, R7;
	input [2:0]RegAddr;
	output reg [15:0]RegOut;

  always@(*)
  begin
    case(RegAddr)
      3'b001: RegOut <= R1;
      3'b010: RegOut <= R2;
      3'b011: RegOut <= R3;
      3'b100: RegOut <= R4;
      3'b101: RegOut <= R5;
      3'b110: RegOut <= R6;
      3'b111: RegOut <= R7;
    endcase
  end

endmodule