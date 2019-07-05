module Add_PC(PC_in,PC_out);

	input [31:0]PC_in;
	output [31:0]PC_out;

	assign PC_out = PC_in+32'b100;
endmodule

