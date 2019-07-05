module Mux_Jump(PC_out,PC_jump,PC_other,Jump);

	output [31:0]PC_out;
	input [31:0]PC_jump,PC_other;
	input Jump;
	
	assign PC_out = (Jump==1'b1) ? PC_jump : PC_other;

endmodule 
