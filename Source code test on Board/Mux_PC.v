module Mux_PC(PC_out, PC_in_add4, PC_in_addim, Branch, Zero);

	output [31:0]PC_out;
	input [31:0]PC_in_add4,PC_in_addim;
	input Branch, Zero;
	
	assign PC_out = (Branch && Zero) ? PC_in_addim : PC_in_add4;
	
endmodule 	


