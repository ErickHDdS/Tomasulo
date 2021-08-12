module parte3(clock, enable, done, regValue); 
	input clock, enable;
	output[15:0] regValue; 
	output  done; 
	
	Tomasulo tomasulo(clock, done, enable, regValue);		// regvalue viewer
endmodule


