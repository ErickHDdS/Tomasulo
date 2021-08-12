module RSadders(instruction, Clock, Adderin, R1, R2, R3, R4, R5, R6, R7, instOutEnable, instOut, done, dout, disponivel, doneInst);

  input[15:0] R1, R2, R3, R4, R5, R6, R7; //registradores para enviar para a ULA
  input Clock, Adderin; //clock e controle de entrada de uma nova instrucao
  input [15:0] instruction; //recebe a instrucao
  reg [7:0] Busy; //1 quando a estacao de reserva e a unidade estiverem ocupadas
  output reg instOutEnable;
  output reg [15:0]instOut;
  reg [2:0] Name [7:0]; //guarda um apelido para a instrucao
  reg [2:0]Qj[7:0]; //operando fonte, 0= já disponíve
  reg [2:0]Qk[7:0]; //operando fonte, 0= já disponível
  reg [15:0] OP [7:0]; //operacao em si
  output wire done; //descobre quando o resultado ficou pronto
  output wire [15:0]dout; //guarda o resultado da instrucao

  reg [2:0]registerStatus[7:0]; //guarda o estado de cada registrador
	//0 = disponivel, valor = apelido da instrucao que ele aguarda

  reg [2:0]instructionCodeIn; //envia para a ULA a linha da inst
  wire [2:0]instructionCodeOut; //retorna a linha da inst para resolver Busy

  reg [2:0] verifyWire; //verifica a existencia de uma instrucao com os dois operadores prontos
  integer i;
  
  wire[15:0]reg1;//conecta mux a UF
  wire[15:0]reg2;//conecta mux a UF
  output wire[15:0]doneInst;
  wire disponivelUF;
  
  output disponivel;
  assign disponivel = ~Busy[1] | ~Busy[2] | ~Busy[3] | ~Busy[4] | ~Busy[5] | ~Busy[6] | ~Busy[7]; //marca quando algum fica disponivel

  initial
  begin
	registerStatus[0] = 0;  // 0 = disponivel
	registerStatus[1] = 0;  // 0 = disponivel
	registerStatus[2] = 0;  // 0 = disponivel
	registerStatus[3] = 0;  // 0 = disponivel
	registerStatus[4] = 0;  // 0 = disponivel
	registerStatus[5] = 0;  // 0 = disponivel
	registerStatus[6] = 0;  // 0 = disponivel
	registerStatus[7] = 0;  // 0 = disponivel
	
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
	
	
  UnidadeFuncional UF(Clock, instOut, instOutEnable, instructionCodeIn, instructionCodeOut, done, doneInst, dout, disponivelUF, reg1, reg2);
  
  reg break1 = 0;
  reg break2 = 0;
  
  always @ (posedge Clock)
  begin
    instOut = 1'b0;
    instOutEnable = 1'b0;

    if(Adderin == 1'b1)
    begin
	for(i=1; i<=7; i = i + 1) begin

	if(Busy[i]==1'b0 && break1 != 1)
	begin
	    Busy[i]=1;
      	    OP[i][15:0] = instruction[15:0]; //guarda a instrucao inteira
       	    if(OP[i][3:0]==4'b0000 || OP[i][3:0]==4'b0001 || OP[i][3:0]==4'b0100)
	    begin //add e sub
	    	Qj[i] = registerStatus[instruction[9:7]]; //guarda a dependencia de Ry
	    	Qk[i] = registerStatus[instruction[6:4]]; //guarda a dependencia de Rx
	    	registerStatus[instruction[12:10]] = i; //Rz passa a depender da nova instrucao
	    end
	    else
	    begin //ld e sd
	    	Qj[i] = registerStatus[instruction[9:7]]; //guarda a dependencia de Ry
	    	Qk[i] = 3'b000; //load e store só possuem um operador
	    	registerStatus[instruction[6:4]] = i; //Rx passa a depender da nova instrucao
	    end
	 break2 = 1;
	end//if Busy[i]==0

	end//for
    end// if Adderin == 1'b1


	//Always at clock

	for(i=7; i>=0; i=i-1) begin
		
	  if(Qj[i]== 3'b000 && Qk[i]== 3'b000 && Busy[i]==1 && break2 != 0) begin //encontrar inst pronta
		verifyWire = i; //marca a linha
		instructionCodeIn = i;
		break2 = 1; //break
	  end

	end
	
	
	
  if(done==1)
  begin
  Busy[instructionCodeOut] = 0; //linha foi desocupada
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
  
endmodule