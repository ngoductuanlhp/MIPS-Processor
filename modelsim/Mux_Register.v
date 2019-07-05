module Mux_Register(RegDst,rt_register, rd_register, write_register);

	input RegDst;
	input [4:0]rt_register,rd_register;
	output [4:0] write_register;

	assign write_register = (RegDst == 1'b1) ? rd_register : rt_register;

endmodule


