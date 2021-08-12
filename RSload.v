module RSload(clock, instruction, instructionIn, registerStatusB0, registerStatusB1,
             registerStatusB2, registerStatusB3, done, doneInst, requestRegister,
             requestAddress, requestEnable, R1, R2, R3, R4, R5, R6, R7,
             registerStatusChange, registerStatusAddr, registerStatusEnable);


input [15:0]R1, R2, R3, R4, R5, R6, R7;
input clock, done;
input [15:0]instruction, doneInst;
input [7:0] registerStatusB0, registerStatusB1, registerStatusB2, registerStatusB3;
input instructionIn;
reg[3:0]loadOP[15:0];
reg[3:0]Qj[2:0];
reg[3:0]Busy;
integer i;

output reg [2:0]requestRegister;
output reg [15:0]requestAddress;
output reg requestEnable;
output reg [3:0]registerStatusChange;
output reg [7:0]registerStatusAddr;
output reg registerStatusEnable;


initial begin
  Busy[0]=0;
  Busy[1]=0;
  Busy[2]=0;
  Busy[3]=0;
end


always@(posedge clock)
begin
  requestEnable = 0;
  registerStatusEnable = 0;
  
  if(instructionIn == 1)
  begin
    for(i = 1; i < 4; i = i + 1)begin
      if(Busy[i]==0)
      begin
        loadOP[i]=instruction;
        Qj[i][0] = registerStatusB0[instruction[9:7]];
        Qj[i][1] = registerStatusB1[instruction[9:7]];
        Qj[i][2] = registerStatusB2[instruction[9:7]];
        Qj[i][3] = registerStatusB3[instruction[9:7]];
        
        registerStatusChange = {1'b1, i};
        registerStatusAddr = instruction[9:7];
        registerStatusEnable = 1;
        break;
      end
    end
  end
  
  for(i = 1; i < 4; i = i + 1)begin
    if(Qj[i] == 0)
    begin
      requestRegister = loadOP[i][6:4];
      Busy[i] = 0;
      requestEnable = 1;
      if(loadOP[i][9:7]==3'b001)
        requestAddress = R1;
      else
        if(loadOP[i][9:7]==3'b010)
          requestAddress = R2;
        else
          if(loadOP[i][9:7]==3'b011)
            requestAddress = R3;
          else
            if(loadOP[i][9:7]==3'b100)
              requestAddress = R4;
            else
              if(loadOP[i][9:7]==3'b101)
                requestAddress = R5;
              else
                if(loadOP[i][9:7]==3'b110)
                  requestAddress = R6;
                else
                  if(loadOP[i][9:7]==3'b111)
                    requestAddress = R7;
      
    end
  end
  
end

endmodule