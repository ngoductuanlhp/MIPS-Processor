module Mux_Memory(reg_write_data, read_data, ALU_out, MemtoReg);
	output [31:0]reg_write_data;
	input [31:0]read_data, ALU_out;
	input MemtoReg;
	
	assign reg_write_data = (MemtoReg==1'b1) ? read_data : ALU_out;

endmodule 