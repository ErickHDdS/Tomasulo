module estacaoReserva(instruction, Clock, Adderin, R1, R2, R3, R4, R5, R6, R7, instOutEnable, instOut, done, dout, disponivel, doneInst);

  input[15:0] R1, R2, R3, R4, R5, R6, R7; 						
  input Clock, Adderin; 												
  input [15:0] instruction; 											
  reg [7:0] Busy; 														
  output reg instOutEnable;
  output reg [15:0]instOut;
  reg [2:0]Qj[7:0]; 														
  reg [2:0]Qk[7:0]; 														
  reg [15:0] OP [7:0]; 													
  output wire done; 														
  output wire [15:0]dout; 												

  reg [2:0]registerStatus[7:0]; 										

  reg [2:0]instructionCodeIn; 										
  wire [2:0]instructionCodeOut; 										

  reg [2:0] verifyWire; 												
  integer i,j, PARA, PARAPORFAVOR, PARACHIQJ, PARACHIQK;
  
  wire[15:0]reg1;															
  wire[15:0]reg2;															
  output wire[15:0]doneInst;
  wire disponivelUF;
  
  output disponivel;
  assign disponivel = ~Busy[1] | ~Busy[2] | ~Busy[3] | ~Busy[4] | ~Busy[5] | ~Busy[6] | ~Busy[7]; 

  initial
  begin
	  registerStatus[0] = 0; 
	  registerStatus[1] = 0;  
	  registerStatus[2] = 0;  
	  registerStatus[3] = 0;  
	  registerStatus[4] = 0;  
	  registerStatus[5] = 0;  
	  registerStatus[6] = 0;  
	  registerStatus[7] = 0;  
		
	  Busy[0]=1;
	  Busy[1]=0;
	  Busy[2]=0;
	  Busy[3]=0;
	  Busy[4]=0;
	  Busy[5]=0;
	  Busy[6]=0;
	  Busy[7]=0;
	  
	  verifyWire = 0;

  end

	mux SelecR1(R1, R2, R3, R4, R5, R6, R7, instOut[6:4], reg1);
   mux SelecR2(R1, R2, R3, R4, R5, R6, R7, instOut[9:7], reg2);
	
   UnidadeFuncional UnFuncional(Clock, instOut, instOutEnable, instructionCodeIn, instructionCodeOut, done, doneInst, dout, disponivelUF, reg1, reg2);
  
  
   //POR QUE VOCE NÃO QUER FUNCIONAR??????????/
   //O QUE FOI QUE EU TE FIZ ????????????????
  
  
   always @ (posedge Clock)
	begin
		 instOut = 1'b0;
		 instOutEnable = 1'b0;
		 PARA=0;
		 PARAPORFAVOR = 2;
		 PARACHIQJ = 0;
		 PARACHIQK = 0;
		 if(Adderin == 1'b1)
		 begin
			for(j=1; j<=7; j = j + 1) 
				begin
				if(PARA == 0) 
					begin
						if(Busy[j]==1'b0 )
						begin
							 Busy[j]=1;
							 OP[j][15:0] = instruction[15:0]; //guarda a instrucao inteira
							 if(OP[j][3:0]==4'b0000 || OP[j][3:0]==4'b0001 || OP[j][3:0]==4'b0100 || OP[j][3:0]==4'b0101)
							 begin //add e sub
								Qj[j] = registerStatus[instruction[9:7]]; //TA DANDO ERRADO AQUI
								Qk[j] = registerStatus[instruction[6:4]]; //Rx
								registerStatus[instruction[12:10]] = j; //Rz
							 end
							PARA =1;
						end
				   end
			   end
		 end
		
		if(1)
		begin
			PARAPORFAVOR = 2;
			for(i=7; i>=0; i=i-1) 
			begin	
			  if(Qj[i]== 3'b000 && Qk[i]== 3'b000 && Busy[i]==1 && PARAPORFAVOR == 2) 
				begin //encontrar inst pronta
					verifyWire = i; //marca a linha
					instructionCodeIn = i;
					PARAPORFAVOR = 5;
				end
				else
					PARAPORFAVOR = 2;
			end
		end
		
	
	  if(done==1)
	  begin
		  Busy[instructionCodeOut] = 0; //linha foi desocupada
		  PARACHIQJ = 0;
		  for(i=0; i<=7; i=i+1)
		  begin
			 if(Qj[i]==3'b011 || Qj[i]==3'b001  && PARACHIQJ == 0)//ISSO NAO DEVERIA TA AQUI, TA ERRADO E NÃO SEI CONSERTAR
				begin
					registerStatus[i]=0;
					Qj[i]=3'b000;
					PARACHIQJ = 1;
				end
			 else if(Qk[i]==3'b011)
				begin
					registerStatus[i]=0;
					Qk[i]=3'b000;
				end
		  end 
	  end

		if(verifyWire != 0 && disponivelUF)
		begin
		  instOutEnable = 1'b1;
		  instOut = OP[verifyWire];
		end
	end
endmodule






/*
module estacaoReserva(instruction, Clock, Adderin, R1, R2, R3, R4, R5, R6, R7, instOutEnable, instOut, done, dout, disponivel, doneInst);

  input[15:0] R1, R2, R3, R4, R5, R6, R7; 						
  input Clock, Adderin; 												
  input [15:0] instruction; 											
  reg [7:0] Busy; 														
  output reg instOutEnable;
  output reg [15:0]instOut;
  reg [2:0]Qj[7:0]; 														
  reg [2:0]Qk[7:0]; 														
  reg [15:0] OP [7:0]; 													
  output wire done; 														
  output wire [15:0]dout; 												

  reg [2:0]registerStatus[7:0]; 										

  reg [2:0]instructionCodeIn; 										
  wire [2:0]instructionCodeOut; 										

  reg [2:0] verifyWire; 												
  integer i,j, PARA, PARAPORFAVOR, PARACHIQJ, PARACHIQK;
  
  wire[15:0]reg1;															
  wire[15:0]reg2;															
  output wire[15:0]doneInst;
  wire disponivelUF;
  
  output disponivel;
  assign disponivel = ~Busy[1] | ~Busy[2] | ~Busy[3] | ~Busy[4] | ~Busy[5] | ~Busy[6] | ~Busy[7]; 

   initial
  begin
	  registerStatus[0] = 0; 
	  registerStatus[1] = 0;  
	  registerStatus[2] = 0;  
	  registerStatus[3] = 0;  
	  registerStatus[4] = 0;  
	  registerStatus[5] = 0;  
	  registerStatus[6] = 0;  
	  registerStatus[7] = 0;  
		
	  Busy[0]=1;
	  Busy[1]=0;
	  Busy[2]=0;
	  Busy[3]=0;
	  Busy[4]=0;
	  Busy[5]=0;
	  Busy[6]=0;
	  Busy[7]=0;
	  
	  verifyWire = 0;

  end

	mux SelecR1(R1, R2, R3, R4, R5, R6, R7, instOut[6:4], reg1);
   mux SelecR2(R1, R2, R3, R4, R5, R6, R7, instOut[9:7], reg2);
	
   UnidadeFuncional UnFuncional(Clock, instOut, instOutEnable, instructionCodeIn, instructionCodeOut, done, doneInst, dout, disponivelUF, reg1, reg2);
  
  reg break1 = 0;
  reg break2 = 0;
  
  always @ (posedge Clock)
  begin
    instOut = 1'b0;
    instOutEnable = 1'b0;

    if(Adderin == 1'b1)
    begin
		for(i=1; i<=7; i = i + 1) 
		begin
			if(Busy[i]==1'b0 && break1 != 1)
			begin
				 Busy[i]=1;
				 OP[i][15:0] = instruction[15:0]; 
				 if(OP[i][3:0]==4'b0000 || OP[i][3:0]==4'b0001 || OP[i][3:0]==4'b0100 || OP[i][3:0]==4'b010)
				 begin 
					Qj[i] = registerStatus[instruction[9:7]]; 
					Qk[i] = registerStatus[instruction[6:4]]; 
					registerStatus[instruction[12:10]] = i; 
				 end
			 break2 = 1;
			end
		end
    end

	for(i=7; i>=0; i=i-1) begin
	  if(Qj[i]== 3'b000 && Qk[i]== 3'b000 && Busy[i]==1 && break2 != 0) 
	  begin 
		verifyWire = i; 
		instructionCodeIn = i;
		break2 = 1; 
	  end
	end
	
  if(done==1)
  begin
	  Busy[instructionCodeOut] = 0; 
	  for(i=7; i>0; i=i-1)begin
		 if(Qj[i]==instOut[12:10])
			begin
				registerStatus[i]=0;
				Qj[i]=3'b000;
			end
		 if(Qk[i]==instOut[12:10])
			begin
				registerStatus[i]=0;
				Qk[i]=3'b000;
			end
	  end
  end
	if(verifyWire != 0 && disponivelUF)
	begin
	  instOutEnable = 1'b1;
     instOut = OP[verifyWire];
	end
end
endmodule*/
