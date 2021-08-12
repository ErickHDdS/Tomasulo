module RSstore(clock, instruction, instructionIn, memoIn, memoAddr, registerStatusB0, registerStatusB1, registerStatusB2, registerStatusB3,
               requestRegister, requestAddress, requestEnable,
               R1, R2, R3, R4, R5, R6, R7);
               
input clock, instructionIn;
input [15:0]instruction, memoIn;
input [7:0] registerStatusB0, registerStatusB1, registerStatusB2, registerStatusB3;
input [15:0]R1, R2, R3, R4, R5, R6, R7;

integer i;

reg[3:0]storeOP[15:0];
output reg [15:0]memoAddr;
output reg [2:0]requestRegister;
output reg [15:0]requestAddress;
output reg requestEnable;

reg[3:0]Qj[3:0];
reg[3:0]Qk[3:0];
reg[3:0]Busy;

reg verifyWire;

initial begin
  Busy[0]=0;
  Busy[1]=0;
  Busy[2]=0;
  Busy[3]=0;
  verifyWire = 0;
end

always@(posedge clock)
begin
  
  if(instructionIn == 1)
  begin
    
    for(i=0; i <= 3; i = i +1)
    begin
     if(Busy[i] == 0)
       begin
         storeOP[i]=instruction;
         Qj[i][0] = registerStatusB0[instruction[9:7]];
         Qj[i][1] = registerStatusB1[instruction[9:7]];
         Qj[i][2] = registerStatusB2[instruction[9:7]];
         Qj[i][3] = registerStatusB3[instruction[9:7]];

         Qk[i][0] = registerStatusB0[instruction[6:4]];
         Qk[i][1] = registerStatusB1[instruction[6:4]];
         Qk[i][2] = registerStatusB2[instruction[6:4]];
         Qk[i][3] = registerStatusB3[instruction[6:4]];
         
         break;
       end
    end
    
    for(i=3; i>=0; i=i-1) 
    begin
	   if(Qj[i]== 4'b0000 && Qk[i]== 4'b0000) 
	   begin
		  verifyWire = i;
		  break;
	   end
	  end
	  
	  if(verifyWire != 0)
	  begin
	   requestRegister = storeOP[i][6:4];
     Busy[i] = 0;
     requestEnable = 1;
     
	   if(storeOP[i][9:7]==3'b001)
        requestAddress = R1;
      else
        if(storeOP[i][9:7]==3'b010)
          requestAddress = R2;
        else
          if(storeOP[i][9:7]==3'b011)
            requestAddress = R3;
          else
            if(storeOP[i][9:7]==3'b100)
              requestAddress = R4;
            else
              if(storeOP[i][9:7]==3'b101)
                requestAddress = R5;
              else
                if(storeOP[i][9:7]==3'b110)
                  requestAddress = R6;
                else
                  if(storeOP[i][9:7]==3'b111)
                    requestAddress = R7;

	  end
    
  end
  
end

endmodule