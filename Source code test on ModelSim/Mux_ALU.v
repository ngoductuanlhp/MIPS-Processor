module Mux_ALU(data_out, read_data2, sign_extend_data, ALUSrc);

	output [31:0]data_out;
	input [31:0]read_data2;
	input [31:0]sign_extend_data;
	input ALUSrc;
	
	assign data_out = (ALUSrc == 1'b0) ? read_data2 : sign_extend_data;

endmodule 