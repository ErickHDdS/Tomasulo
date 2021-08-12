module mux(R1, R2, R3, R4, R5, R6, R7, Raddr, Rout);
input [15:0]R1, R2, R3, R4, R5, R6, R7;
input [2:0]Raddr;
output reg [15:0]Rout;

  always@(*)
  begin
    case(Raddr)
      3'b001: Rout <= R1;
      3'b010: Rout <= R2;
      3'b011: Rout <= R3;
      3'b100: Rout <= R4;
      3'b101: Rout <= R5;
      3'b110: Rout <= R6;
      3'b111: Rout <= R7;
    endcase
  end

endmodule