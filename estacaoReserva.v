module estacaoReserva(instruction, Clock, enableInstr, R1, R2, R3, R4, R5, R6, R7, instOutEnable, instOut, done, dout, disponivel, doneInst);
	
   input[15:0] R1, R2, R3, R4, R5, R6, R7; 						
   input Clock, enableInstr; 												
   input [15:0] instruction; 											
  					
   reg [2:0]Qj[7:0]; 														
   reg [2:0]Qk[7:0]; 														
   reg [15:0] OP [7:0]; 		
	reg [2:0]regList[7:0]; 										
	reg [2:0]instrCodeIn; 	  
	reg [2:0] Wire; 	
	reg [7:0] Busy; 

	output reg instOutEnable;
	output reg [15:0]instOut;
  	output wire[15:0]doneInst;												
	output wire done; 														
	output wire [15:0]dout; 												
	output disponivel;
	
  	wire[15:0]reg1;															
	wire[15:0]reg2;															
	wire [2:0]instrCodeOut; 
	wire disponivelUF;								
	
	integer i,j, PARA, PARAPORFAVOR, PARACHIQJ, PARACHIQK;
	
	assign disponivel = ~Busy[1] | ~Busy[2] | ~Busy[3] | ~Busy[4] | ~Busy[5] | ~Busy[6] | ~Busy[7]; 

	initial
		begin
		  regList[0] = 0; 
		  regList[1] = 0;  
		  regList[2] = 0;  
		  regList[3] = 0;  
		  regList[4] = 0;  
		  regList[5] = 0;  
		  regList[6] = 0;  
		  regList[7] = 0;  
			
		  Busy[0]=1;
		  Busy[1]=0;
		  Busy[2]=0;
		  Busy[3]=0;
		  Busy[4]=0;
		  Busy[5]=0;
		  Busy[6]=0;
		  Busy[7]=0;
		  
		  Wire = 0;

	end
	  
   // pega os valores dos Rs que entram e coloca no reg1 ou reg2
	mux SelecR1(R1, R2, R3, R4, R5, R6, R7, instOut[6:4], reg1);	
   mux SelecR2(R1, R2, R3, R4, R5, R6, R7, instOut[9:7], reg2);
	
	// faz a operação
   UnidadeFuncional UnFuncional(Clock, instOut, instOutEnable, instrCodeIn, instrCodeOut, done, doneInst, dout, disponivelUF, reg1, reg2);
  
   always @ (posedge Clock)
	begin
		 instOut = 1'b0;
		 instOutEnable = 1'b0;
		 PARA=0;
		 PARAPORFAVOR = 2;
		 PARACHIQJ = 0;
		 PARACHIQK = 0;
		 if(enableInstr == 1'b1)
		 begin
			for(j=1; j<=7; j = j + 1) 										// pra cada instrução da fila
				begin
				if(PARA == 0) 
					begin
						if(Busy[j]==1'b0 )									// vejo se alguém tá desocupada
						begin
							 Busy[j]=1;											// ocupo ela
							 OP[j][15:0] = instruction[15:0]; 			//pega a instrução
							 if(OP[j][3:0]==4'b0000 || OP[j][3:0]==4'b0001 || OP[j][3:0]==4'b0100 || OP[j][3:0]==4'b0101)
							 begin 												//add e sub	-- isso ta aqui pq a gnt sonhou em fazer ld e st nao tiramos pq pode dar ruim
								Qj[j] = regList[instruction[9:7]]; 		//cata a dependencia do Ry
								Qk[j] = regList[instruction[6:4]]; 		// cata a dependencia do Rx
								regList[instruction[12:10]] = j; 		// cata a posição da instrução 
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
			begin: aaaaa
			  if(Qj[i]== 3'b000 && Qk[i]== 3'b000 && Busy[i]==1 && PARAPORFAVOR == 2) 
				begin 															// inst pronta
					Wire = i; 													//marca a linha
					instrCodeIn = i;											// manda a posição da inst pra UF
					PARAPORFAVOR = 5;
					disable aaaaa;
				end
				else
					PARAPORFAVOR = 2;
			end
		end
		
	  if(done==1)	 															// instrução ta saindo
	  begin
		  Busy[instrCodeOut] = 0; 											// desocupa a instrução que ta saindo
		  PARACHIQJ = 0;
		  for(i=0; i<=7; i=i+1)
		  begin
			 if(Qj[i]==3'b011 || Qj[i]==3'b001  && PARACHIQJ == 0)
				begin
					regList[i]=0;
					Qj[i]=3'b000;
					PARACHIQJ = 1;
				end
			 else if(Qk[i]==3'b011)
				begin
					regList[i]=0;
					Qk[i]=3'b000;
				end
		  end 
	  end
		
		// ali em cima a gnt limpa os rastros da inst e aqui em baixo a gnt manda ela pra fora
		if(Wire != 0 && disponivelUF)
		begin
		  instOutEnable = 1'b1;
		  instOut = OP[Wire];
		end
	end
endmodule






/*
module estacaoReserva(instruction, Clock, enableInstr, R1, R2, R3, R4, R5, R6, R7, instOutEnable, instOut, done, dout, disponivel, doneInst);

  input[15:0] R1, R2, R3, R4, R5, R6, R7; 						
  input Clock, enableInstr; 												
  input [15:0] instruction; 											
  reg [7:0] Busy; 														
  output reg instOutEnable;
  output reg [15:0]instOut;
  reg [2:0]Qj[7:0]; 														
  reg [2:0]Qk[7:0]; 														
  reg [15:0] OP [7:0]; 													
  output wire done; 														
  output wire [15:0]dout; 												

  reg [2:0]regList[7:0]; 										

  reg [2:0]instrCodeIn; 										
  wire [2:0]instrCodeOut; 										

  reg [2:0] Wire; 												
  integer i,j, PARA, PARAPORFAVOR, PARACHIQJ, PARACHIQK;
  
  wire[15:0]reg1;															
  wire[15:0]reg2;															
  output wire[15:0]doneInst;
  wire disponivelUF;
  
  output disponivel;
  assign disponivel = ~Busy[1] | ~Busy[2] | ~Busy[3] | ~Busy[4] | ~Busy[5] | ~Busy[6] | ~Busy[7]; 

   initial
  begin
	  regList[0] = 0; 
	  regList[1] = 0;  
	  regList[2] = 0;  
	  regList[3] = 0;  
	  regList[4] = 0;  
	  regList[5] = 0;  
	  regList[6] = 0;  
	  regList[7] = 0;  
		
	  Busy[0]=1;
	  Busy[1]=0;
	  Busy[2]=0;
	  Busy[3]=0;
	  Busy[4]=0;
	  Busy[5]=0;
	  Busy[6]=0;
	  Busy[7]=0;
	  
	  Wire = 0;

  end

	mux SelecR1(R1, R2, R3, R4, R5, R6, R7, instOut[6:4], reg1);
   mux SelecR2(R1, R2, R3, R4, R5, R6, R7, instOut[9:7], reg2);
	
   UnidadeFuncional UnFuncional(Clock, instOut, instOutEnable, instrCodeIn, instrCodeOut, done, doneInst, dout, disponivelUF, reg1, reg2);
  
  reg break1 = 0;
  reg break2 = 0;
  
  always @ (posedge Clock)
  begin
    instOut = 1'b0;
    instOutEnable = 1'b0;

    if(enableInstr == 1'b1)
    begin
		for(i=1; i<=7; i = i + 1) 
		begin
			if(Busy[i]==1'b0 && break1 != 1)
			begin
				 Busy[i]=1;
				 OP[i][15:0] = instruction[15:0]; 
				 if(OP[i][3:0]==4'b0000 || OP[i][3:0]==4'b0001 || OP[i][3:0]==4'b0100 || OP[i][3:0]==4'b010)
				 begin 
					Qj[i] = regList[instruction[9:7]]; 
					Qk[i] = regList[instruction[6:4]]; 
					regList[instruction[12:10]] = i; 
				 end
			 break2 = 1;
			end
		end
    end

	for(i=7; i>=0; i=i-1) begin
	  if(Qj[i]== 3'b000 && Qk[i]== 3'b000 && Busy[i]==1 && break2 != 0) 
	  begin 
		Wire = i; 
		instrCodeIn = i;
		break2 = 1; 
	  end
	end
	
  if(done==1)
  begin
	  Busy[instrCodeOut] = 0; 
	  for(i=7; i>0; i=i-1)begin
		 if(Qj[i]==instOut[12:10])
			begin
				regList[i]=0;
				Qj[i]=3'b000;
			end
		 if(Qk[i]==instOut[12:10])
			begin
				regList[i]=0;
				Qk[i]=3'b000;
			end
	  end
  end
	if(Wire != 0 && disponivelUF)
	begin
	  instOutEnable = 1'b1;
     instOut = OP[Wire];
	end
end
endmodule
*/