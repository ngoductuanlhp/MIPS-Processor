module LCDencoder(data_in,data_out);
	
	input [3:0]data_in;
	output [8:0]data_out;
	
	assign data_out=(data_in<4'b1010) ? {5'b10011,data_in}:
													{6'b101000,data_in[2:0]-1'b1};
	
endmodule